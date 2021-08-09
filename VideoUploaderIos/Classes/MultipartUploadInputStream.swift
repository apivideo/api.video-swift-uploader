//
//  MultipartUploadInputStream.swift
//  sdkApiVideo
//
//  Created by Romain Petit on 29/01/2021.
//  Copyright © 2021 Romain. All rights reserved.
//

import Foundation
class MultipartUploadInputStream: InputStream {
    let inputStreams: [InputStream]
    private var currentIndex: Int // index of the current stream (0: prefix, 1: file, 2: suffix)
    private var _streamStatus: Stream.Status
    private var _streamError: Error?
    private var _delegate: StreamDelegate?
    private var size: Int64 // the total size of the part (prefix size + chunk size + suffix size)
    private var boundary: String
    private var chunkStart: Int64 // position of the beginning of the chunk in the whole file
    private var chunkEnd: Int64 // position of the end of the chunk in the whole file
    private var consumedBytesInFileStream: Int64 = 0 // consumer bytes in file stream, ie skipped bytes + effectively read bytes
    private var semaphore: DispatchSemaphore; // semaphore to avoid uploading all the parts at the same time
    
    public func getSize() -> Int64 {
        return size
    }
    public func getBoundary() -> String {
        return boundary
    }
    init(inputStream: InputStream, fileName: String, partName: String, contentType: String, chunkStart: Int64, chunkEnd: Int64, semaphore: DispatchSemaphore, videoId: String?) {
        self.boundary = "Boundary-\(UUID().uuidString)";
        let prefixData = "--\(boundary)\r\nContent-Disposition: form-data; name=\"\(partName)\"; filename=\"\(fileName)\"\r\nContent-Type: \(contentType)\r\n\r\n".data(using: .utf8)!
        let postfixData = "\r\n--\(boundary)--\r\n".data(using: .utf8)!
        var streams = [
            InputStream(data: prefixData),
            inputStream,
            InputStream(data: postfixData),
        ]
        var additionnalSize: Int64 = 0;
        if(videoId != nil) {
            let prefixDataVideoId = "--\(boundary)\r\nContent-Disposition: form-data; name=\"videoId\"\r\n\r\n".data(using: .utf8)!
            let postfixDataVideoId = "\r\n--\(boundary)--\r\n".data(using: .utf8)!
            streams.append(InputStream(data: prefixDataVideoId));
            streams.append(InputStream(data: videoId!.data(using: .utf8)!));
            streams.append(InputStream(data: postfixDataVideoId));
            additionnalSize = Int64(prefixDataVideoId.count) + Int64(postfixDataVideoId.count) + Int64(videoId!.count)
        }
        self.size = Int64(prefixData.count) + Int64(postfixData.count) + (chunkEnd - chunkStart) + additionnalSize
        self.inputStreams = streams
        self.currentIndex = 0
        self._streamStatus = .notOpen
        self._streamError = nil
        self.chunkStart = chunkStart;
        self.chunkEnd = chunkEnd;
        self.semaphore = semaphore;
        super.init(data: Data())
    }
    override var streamStatus: Stream.Status {
        return _streamStatus
    }
    override var streamError: Error? {
        return _streamError
    }
    override var delegate: StreamDelegate? {
        get {
            return _delegate
        }
        set {
            _delegate = newValue
        }
    }
    override func read(_ buffer: UnsafeMutablePointer<UInt8>, maxLength: Int) -> Int {
        if _streamStatus == .closed{
            return 0
        }
        var totalNumberOfBytesRead = 0
        var bytesReadInCurrentStream = 0
        while totalNumberOfBytesRead < maxLength {
            // if we've handle the 3 streams, it's finished...
            if currentIndex == inputStreams.count {
                self.close()
                break
            }
            let currentInputStream = inputStreams[currentIndex]
            if currentInputStream.streamStatus != .open {
                currentInputStream.open()
            }
            // we've reach the current stream end, let's switch to the next stream
            if !currentInputStream.hasBytesAvailable {
                self.currentIndex += 1
                bytesReadInCurrentStream = 0
                continue
            }
            let remainingLength = maxLength - totalNumberOfBytesRead
            var toRead = remainingLength
            // currentIndex == 1 <=> the current stream is the file inputstream
            if(currentIndex == 1) {
                let bufferSize = 1024*1024
                let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
                // we skips the bytes before the chunk start by reading them & putting them in a useless buffer
                while(consumedBytesInFileStream < chunkStart) {
                    var toSkip = Int64(bufferSize)
                    if(chunkStart - consumedBytesInFileStream < bufferSize) {
                        toSkip = chunkStart - consumedBytesInFileStream
                    }
                    consumedBytesInFileStream += Int64(currentInputStream.read(buffer, maxLength: Int(toSkip)))
                }
                if(chunkEnd - consumedBytesInFileStream < toRead) {
                    toRead = Int(chunkEnd - consumedBytesInFileStream)
                }
            }
            // after skipping bytes there is no more data to read, let's handle the next stream
            if toRead == 0 {
                self.currentIndex += 1
                continue
            }
            // we effectively read the current stream
            let numberOfBytesRead = currentInputStream.read(&buffer[totalNumberOfBytesRead], maxLength: toRead)
            totalNumberOfBytesRead += numberOfBytesRead
            bytesReadInCurrentStream += numberOfBytesRead
            if currentIndex == 1 {
                consumedBytesInFileStream += Int64(numberOfBytesRead);
                // if skip bytes + effectively read bytes == chunk end, handle the next stream
                if consumedBytesInFileStream == chunkEnd {
                    self.currentIndex += 1
                    continue
                }
            }
            // we've read 0 bytes => the stream has been entirely read
            if numberOfBytesRead == 0 {
                self.currentIndex += 1
                continue
            }
            // we've read -1 bytes => there was an error reading the stream
            if numberOfBytesRead == -1 {
                self._streamError = currentInputStream.streamError
                self._streamStatus = .error
                return -1
            }
        }
        return totalNumberOfBytesRead
    }
    override func getBuffer(_ buffer: UnsafeMutablePointer<UnsafeMutablePointer<UInt8>?>, length len: UnsafeMutablePointer<Int>) -> Bool {
        return false
    }
    override var hasBytesAvailable: Bool {
        return true
    }
    override func open() {
        guard self._streamStatus == .open else {
            return
        }
        self._streamStatus = .open
    }
    override func close() {
        self._streamStatus = .closed
    }
    override func property(forKey key: Stream.PropertyKey) -> Any? {
        return nil
    }
    override func setProperty(_ property: Any?, forKey key: Stream.PropertyKey) -> Bool {
        return false
    }
    override func schedule(in aRunLoop: RunLoop, forMode mode: RunLoop.Mode) {
    }
    override func remove(from aRunLoop: RunLoop, forMode mode: RunLoop.Mode) {
    }
}
