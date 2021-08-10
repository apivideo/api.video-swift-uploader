import XCTest
import VideoUploaderIos
 
class TableOfContentsSpec: XCTestCase {
    
    func getDelegatedToken() -> String? {
        let DELEGATED_TOKEN: String? = nil // YOUR DELEGATED UPLOAD TOKEN HERE
        return ProcessInfo.processInfo.environment["DELEGATED_TOKEN"] ?? DELEGATED_TOKEN;
    }
    
    func testSmallUploadSuccess() throws {
        let uploader = VideoUploader()
        
        let filename = "574k.mp4"
        let bundle = Bundle(for: type(of: self))
        let filepath = bundle.path(forResource: "574k", ofType: "mp4")!
        let url = bundle.url(forResource: "574k", withExtension: "mp4")
         
        uploader.uploadWithDelegatedToken(delegatedToken: self.getDelegatedToken()!, fileName: filename, filePath: filepath, url: url!) { json, error in
            XCTAssertNotNil(json)
            XCTAssertNil(error)
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
