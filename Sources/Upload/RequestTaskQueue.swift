import Foundation
import Alamofire

public class RequestTaskQueue<T>: RequestTask {
    private let operationQueue: OperationQueue
    private var requestBuilders: [RequestBuilder<T>] = []

    private let _downloadProgress = Progress(totalUnitCount: 0)
    private let _uploadProgress = Progress(totalUnitCount: 0)

    internal init(queueLabel: String) {
        operationQueue = OperationQueue()
        operationQueue.name = "video.api.RequestQueue.\(queueLabel)"
        operationQueue.maxConcurrentOperationCount = 1
        super.init()
    }

    override public var uploadProgress: Progress {
        var completedUnitCount: Int64 = 0
        var totalUnitCount: Int64 = 0
        requestBuilders.forEach {
            if let progress = $0.requestTask.uploadProgress {
                completedUnitCount += progress.completedUnitCount
                totalUnitCount += progress.totalUnitCount
            }
        }

        _uploadProgress.totalUnitCount = totalUnitCount
        _uploadProgress.completedUnitCount = completedUnitCount
        return _uploadProgress
    }

    override public var downloadProgress: Progress {
        var completedUnitCount: Int64 = 0
        var totalUnitCount: Int64 = 0
        requestBuilders.forEach {
            if let progress = $0.requestTask.downloadProgress {
                completedUnitCount += progress.completedUnitCount
                totalUnitCount += progress.totalUnitCount
            }
        }

        _downloadProgress.totalUnitCount = totalUnitCount
        _downloadProgress.completedUnitCount = completedUnitCount
        return _downloadProgress
    }

    internal func willExecuteRequestBuilder(requestBuilder: RequestBuilder<T>) -> Void {
    }

    internal func execute(_ requestBuilder: RequestBuilder<T>,
                          apiResponseQueue: DispatchQueue = ApiVideoUploader.apiResponseQueue,
                          completion: @escaping (_ result: Swift.Result<Response<T>, ErrorResponse>) -> Void) -> Void {
        requestBuilders.append(requestBuilder)
        return operationQueue.addOperation(RequestOperation(requestBuilder: requestBuilder, apiResponseQueue: apiResponseQueue, willExecuteRequestBuilder: willExecuteRequestBuilder, completion: completion))
    }
    

    override public func cancel() {
        requestBuilders.forEach {
            $0.requestTask.cancel()
        }
        operationQueue.cancelAllOperations()
    }
}

final class RequestOperation<T>: Operation {
    private let requestBuilder: RequestBuilder<T>
    private let apiResponseQueue: DispatchQueue
    private let completion: (_ result: Swift.Result<Response<T>, ErrorResponse>) -> Void
    private let willExecuteRequestBuilder: (_: RequestBuilder<T>) -> Void
    private let group = DispatchGroup()

    init(requestBuilder: RequestBuilder<T>, apiResponseQueue: DispatchQueue, willExecuteRequestBuilder: @escaping (_: RequestBuilder<T>) -> Void, completion: @escaping (_ result: Swift.Result<Response<T>, ErrorResponse>) -> Void) {
        self.requestBuilder = requestBuilder
        self.apiResponseQueue = apiResponseQueue
        self.willExecuteRequestBuilder = willExecuteRequestBuilder
        self.completion = completion
        super.init()
    }
    
    override func main() {
        guard !isCancelled else {
            return
        }
        group.enter()

        self.willExecuteRequestBuilder(requestBuilder)
        requestBuilder.execute(apiResponseQueue) { result in
            self.completion(result)
            self.group.leave()
        }
        // Make task synchronous
        group.wait()
    }
}
