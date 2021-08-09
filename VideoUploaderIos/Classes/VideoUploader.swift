import MobileCoreServices

public class VideoUploader {
    private var host: String
    private var userAgent: String
    private var chunkSize: Int
    
    private var token: String! = ""
    private var tokenType: String! = "Bearer"
    
    private static let DEFAULT_CHUNK_SIZE = 1024 * 1024 * 5;
    private static let DEFAULT_USER_AGENT = "api.video uploader (ios; v:0.0.1; )";
    
    public init(host: String? = nil, chunkSize: Int? = nil, userAgent: String? = nil){
        self.host = host ?? "ws.api.video";
        self.chunkSize = chunkSize ?? VideoUploader.DEFAULT_CHUNK_SIZE
        self.userAgent = userAgent ?? VideoUploader.DEFAULT_USER_AGENT
        
        if(self.chunkSize < VideoUploader.DEFAULT_CHUNK_SIZE) {
            print("Given chunk size is below the minimal allowed value. The default value will be used.");
            self.chunkSize = VideoUploader.DEFAULT_CHUNK_SIZE;
        }
    }
    
    public func uploadWithDelegatedToken(delegatedToken: String, fileName: String, filePath: String, url: URL, completion: @escaping (Dictionary<String, AnyObject>?, ApiError?) -> ()) {
        self.upload(apiPath: "https://\(self.host)/upload?token=\(delegatedToken)", bearerToken: nil, fileName: fileName, filePath: filePath, url: url, completion: completion);
    }
    
    public func uploadWithAuthentication(bearerToken: String, videoId: String, fileName: String, filePath: String, url: URL, completion: @escaping (Dictionary<String, AnyObject>?, ApiError?) -> ()) {
        self.upload(apiPath: "https://\(self.host)/videos/\(videoId)/source", bearerToken: bearerToken, fileName: fileName, filePath: filePath, url: url, completion: completion);
    }
  
    private func upload(apiPath: String, bearerToken: String?, fileName: String, filePath: String, url: URL, completion: @escaping (Dictionary<String, AnyObject>?, ApiError?) -> ()) {
        let fileSize = self.getFileSize(path: filePath)
        if(fileSize <= chunkSize) {
            self.uploadWithoutChunk(apiPath: apiPath, bearerToken: bearerToken, fileName: fileName, filePath: filePath, url: url, completion: completion)
        } else {
            self.uploadByChunk(apiPath: apiPath, bearerToken: bearerToken, fileName: fileName, filePath: filePath, url: url, completion: completion)
        }
    }
    
    public func uploadWithoutChunk(apiPath: String, bearerToken: String?, fileName: String, filePath: String, url: URL, completion: @escaping (Dictionary<String, AnyObject>?, ApiError?) -> ()) {

        let boundary = "Boundary-\(UUID().uuidString)";
        
        var urlRequest = URLRequest(url: URL(string: apiPath)!)
        urlRequest.setValue(self.userAgent, forHTTPHeaderField: "User-Agent")
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        if(bearerToken != nil) {
            urlRequest.setValue("Bearer \(bearerToken ?? "")", forHTTPHeaderField: "Authorization")
        }

        var body = Data()
        let data = (try? Data(contentsOf: url))!
        let mimetype = mimeType(for: filePath)
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"\(filePath)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: .utf8)!)
        body.append(data)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        urlRequest.httpBody = body
        
        
         let sessionConfig = URLSessionConfiguration.default
         sessionConfig.httpAdditionalHeaders = ["User-Agent": self.userAgent]
         
         let session = URLSession(configuration: sessionConfig)
        
        let semaphore = DispatchSemaphore(value: 0)
        
        TasksExecutor().execute(session: session, request: urlRequest){(json, apiError) in
            if(json != nil){
                completion(json, nil)
            }else{
                completion(nil, apiError)
            }
            semaphore.signal()
        }
        semaphore.wait()
    }
    
    private func uploadByChunk(apiPath: String, bearerToken: String?, fileName: String, filePath: String, url: URL, completion: @escaping (Dictionary<String, AnyObject>?, ApiError?) -> ()) {

        let data = try? Data(contentsOf: url)
        let fileSize = data!.count
        var video: Dictionary<String, AnyObject>?
        
        let semaphore = DispatchSemaphore(value: 0)
        var readBytes: Int = 0;
        var videoId: String?;
        
        let mimetype = mimeType(for: filePath)
        
        for offset in stride(from: 0, through: fileSize, by: chunkSize){
            let fileStream = InputStream(fileAtPath: filePath)!
            var chunkEnd = offset + chunkSize
            
            // if last chunk
            if(chunkEnd > fileSize){
                chunkEnd = fileSize
            }
            
            let multipartUploadInputStream = MultipartUploadInputStream(inputStream: fileStream, fileName: fileName, partName: "file", contentType: mimetype, chunkStart: Int64(offset), chunkEnd: Int64(chunkEnd), semaphore: semaphore, videoId: videoId)
            
            var urlRequest = URLRequest(url: URL(string: apiPath)!)
            urlRequest.setValue(self.userAgent, forHTTPHeaderField: "User-Agent")
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("multipart/form-data; boundary=\(multipartUploadInputStream.getBoundary())", forHTTPHeaderField: "Content-Type")
            if(bearerToken != nil) {
                urlRequest.setValue("Bearer \(bearerToken ?? "")", forHTTPHeaderField: "Authorization")
            }
            urlRequest.setValue("bytes \(offset)-\(chunkEnd-1)/\(Int64(fileSize))", forHTTPHeaderField: "Content-Range")
            urlRequest.setValue(String(multipartUploadInputStream.getSize()), forHTTPHeaderField: "Content-Length")
            urlRequest.httpBodyStream = multipartUploadInputStream
            
           
            let sessionConfig = URLSessionConfiguration.default
            sessionConfig.httpAdditionalHeaders = ["User-Agent": self.userAgent]
            
            let session = URLSession(configuration: sessionConfig)

            TasksExecutor().execute(session: session, request: urlRequest){(json, apiError) in
                if(json != nil){
                    readBytes = chunkEnd
                    video = json
                    if(videoId == nil) {
                        videoId = json?["videoId"] as? String
                    }
                    semaphore.signal()
                }else{
                    completion(nil, apiError)
                }
            }
            semaphore.wait()
            fileStream.close()
        }
        if(readBytes == fileSize){
            completion(video, nil)
        }
    }
    
    
    private func getFileSize(path: String) -> UInt64 {
        do {
            let attr = try FileManager.default.attributesOfItem(atPath: path)
            return attr[FileAttributeKey.size] as! UInt64
        } catch {
            print("Can't get file size: \(error)")
        }
        return 0
    }
    
    private func mimeType(for path: String) -> String {
        let url = URL(fileURLWithPath: path)
        let pathExtension = url.pathExtension
        
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }
    
    
}
