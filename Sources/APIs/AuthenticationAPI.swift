//
// AuthenticationAPI.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

open class AuthenticationAPI {

    /**
     Authenticate
     
     - parameter authenticatePayload: (body)  
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects.
     */
    @discardableResult
    open class func authenticate(authenticatePayload: AuthenticatePayload, apiResponseQueue: DispatchQueue = ApiVideoUploader.apiResponseQueue, completion: @escaping ((_ data: AccessToken?, _ error: Error?) -> Void)) -> URLSessionTask? {
            return authenticateWithRequestBuilder(authenticatePayload: authenticatePayload).execute(apiResponseQueue) { result in
                switch result {
                case let .success(response):
                    completion(response.body, nil)
                case let .failure(error):
                    completion(nil, error)
                }
            }
    }


    /**
     Authenticate
     - POST /auth/api-key
     - To get started, submit your API key in the body of your request. api.video returns an access token that is valid for one hour (3600 seconds). A refresh token is also returned. View a [tutorial](https://api.video/blog/tutorials/authentication-tutorial) on authentication. All tutorials using the [authentication endpoint](https://api.video/blog/endpoints/authenticate)
     - parameter authenticatePayload: (body)  
     - returns: RequestBuilder<AccessToken> 
     */
    open class func authenticateWithRequestBuilder(authenticatePayload: AuthenticatePayload) -> RequestBuilder<AccessToken> {
        let localVariablePath = "/auth/api-key"
        let localVariableURLString = ApiVideoUploader.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: authenticatePayload)

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<AccessToken>.Type = ApiVideoUploader.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "POST", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters)
    }


    /**
     Refresh token
     
     - parameter refreshTokenPayload: (body)  
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects.
     */
    @discardableResult
    open class func refresh(refreshTokenPayload: RefreshTokenPayload, apiResponseQueue: DispatchQueue = ApiVideoUploader.apiResponseQueue, completion: @escaping ((_ data: AccessToken?, _ error: Error?) -> Void)) -> URLSessionTask? {
            return refreshWithRequestBuilder(refreshTokenPayload: refreshTokenPayload).execute(apiResponseQueue) { result in
                switch result {
                case let .success(response):
                    completion(response.body, nil)
                case let .failure(error):
                    completion(nil, error)
                }
            }
    }


    /**
     Refresh token
     - POST /auth/refresh
     - Use the refresh endpoint with the refresh token you received when you first authenticated using the api-key endpoint. Send the refresh token in the body of your request. The api.video API returns a new access token that is valid for one hour (3600 seconds) and a new refresh token.  
     - parameter refreshTokenPayload: (body)  
     - returns: RequestBuilder<AccessToken> 
     */
    open class func refreshWithRequestBuilder(refreshTokenPayload: RefreshTokenPayload) -> RequestBuilder<AccessToken> {
        let localVariablePath = "/auth/refresh"
        let localVariableURLString = ApiVideoUploader.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: refreshTokenPayload)

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<AccessToken>.Type = ApiVideoUploader.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "POST", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters)
    }

}