import XCTest
import VideoUploaderIos
 
class TableOfContentsSpec: XCTestCase {
    
    func getDelegatedToken() -> String? {
        let DELEGATED_TOKEN: String? = "to4EOdYrIQ7ttR3SEakOOHYt" // YOUR DELEGATED UPLOAD TOKEN HERE
        return ProcessInfo.processInfo.environment["DELEGATED_TOKEN"] ?? DELEGATED_TOKEN;
    }
    
    func testSmallUploadSuccess() throws {
        let uploader = VideoUploader(host: "ws.api.staging")
        
        let filename = "574k.mp4"
        let bundle = Bundle(for: type(of: self))
        let filepath = bundle.path(forResource: "574k", ofType: "mp4")!
        let url = bundle.url(forResource: "574k", withExtension: "mp4")
         
        uploader.uploadWithDelegatedToken(delegatedToken: self.getDelegatedToken()!, fileName: filename, filePath: filepath, url: url!) { json, error in
            XCTAssertNotNil(json)
            XCTAssertNil(error)
        }
    }
    
    func testPartsUploadSuccess() throws {
        let uploader = VideoUploader(host: "ws.api.staging")
        
        let filenameA = "10m.part.a.mp4"
        let bundleA = Bundle(for: type(of: self))
        let filepathA = bundleA.path(forResource: "10m.part.a", ofType: "mp4")!
        let urlA = bundleA.url(forResource: "10m.part.a", withExtension: "mp4")
        
        let filenameB = "10m.part.b.mp4"
        let bundleB = Bundle(for: type(of: self))
        let filepathB = bundleB.path(forResource: "10m.part.b", ofType: "mp4")!
        let urlB = bundleB.url(forResource: "10m.part.b", withExtension: "mp4")
        
        let filenameC = "10m.part.c.mp4"
        let bundleC = Bundle(for: type(of: self))
        let filepathC = bundleC.path(forResource: "10m.part.c", ofType: "mp4")!
        let urlC = bundleC.url(forResource: "10m.part.c", withExtension: "mp4")
         
        uploader.uploadPartWithDelegatedToken(delegatedToken: self.getDelegatedToken()!, videoId: nil, fileName: filenameA, filePath: filepathA, url: urlA!, byteStart: 1, isLast: false)  { json, error in
            
            let videoId = json?["videoId"] as? String
            
            uploader.uploadPartWithDelegatedToken(delegatedToken: self.getDelegatedToken()!, videoId: videoId, fileName: filenameB, filePath: filepathB, url: urlB!, byteStart: 2, isLast: false) { json, error in
            }
            uploader.uploadPartWithDelegatedToken(delegatedToken: self.getDelegatedToken()!, videoId: videoId, fileName: filenameC, filePath: filepathC, url: urlC!, byteStart: 3, isLast: true) { json, error in
                XCTAssertNotNil(json)
                XCTAssertNil(error)
            }
        }
        
    }
    
    func testLargeUploadSuccess() throws {
        let uploader = VideoUploader(chunkSize: 5*1024*1024)
        
        let filename = "10m.mp4"
        let bundle = Bundle(for: type(of: self))
        let filepath = bundle.path(forResource: "10m", ofType: "mp4")!
        let url = bundle.url(forResource: "10m", withExtension: "mp4")
         
        uploader.uploadWithDelegatedToken(delegatedToken: self.getDelegatedToken()!, fileName: filename, filePath: filepath, url: url!) { json, error in
            XCTAssertNotNil(json)
            XCTAssertNil(error)
        }
    }
}
