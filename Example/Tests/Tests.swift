// https://github.com/Quick/Quick

import Quick
import Nimble
import VideoUploaderIos
 
class TableOfContentsSpec: QuickSpec {
    override func spec() {
        setenv("CFNETWORK_DIAGNOSTICS", "3", 1)
        
        describe("these will fail") {
            let uploader = VideoUploader()
            
            let filename = "574k.mp4"
            let bundle = Bundle(for: type(of: self))
            let filepath = bundle.path(forResource: "574k", ofType: "mp4")!
            let url = bundle.url(forResource: "574k", withExtension: "mp4")
             
            print(filepath)
            print(url)
            
            uploader.uploadWithDelegatedToken(delegatedToken: "to3JdOSDHqqrB5Cd9Fi5Vc1I", fileName: filename, filePath: filepath, url: url!) { json, error in
                print(error)
                print(json)
            }
            /*it("can do maths") {
                
                expect(1) == 2
            }

            it("can read") {
                expect("number") == "string"
            }

            it("will eventually fail") {
                expect("time").toEventually( equal("done") )
            }
            
            context("these will pass") {

                it("can do maths") {
                    expect(23) == 23
                }

                it("can read") {
                    expect("🐮") == "🐮"
                }

                it("will eventually pass") {
                    var time = "passing"

                    DispatchQueue.main.async {
                        time = "done"
                    }

                    waitUntil { done in
                        Thread.sleep(forTimeInterval: 0.5)
                        expect(time) == "done"

                        done()
                    }
                }
            }*/
        }
    }
}
