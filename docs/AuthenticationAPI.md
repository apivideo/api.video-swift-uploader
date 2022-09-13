# AuthenticationAPI

All URIs are relative to *https://ws.api.video*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authenticate**](AuthenticationAPI.md#postauthapikey) | **POST** /auth/api-key | Advanced - Authenticate (1/2)
[**refresh**](AuthenticationAPI.md#postauthrefresh) | **POST** /auth/refresh | Advanced - Refresh token (2/2)


# **authenticate**
```swift
    open class func authenticate(authenticatePayload: AuthenticatePayload, completion: @escaping (_ data: AccessToken?, _ error: Error?) -> Void)
```

Advanced - Authenticate (1/2)

To get started, submit your API key in the body of your request. api.video returns an access token that is valid for one hour (3600 seconds). A refresh token is also returned. View a [tutorial](https://api.video/blog/tutorials/authentication-tutorial) on authentication. All tutorials using the [authentication endpoint](https://api.video/blog/endpoints/authenticate)


### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import ApiVideoUploader

let authenticatePayload = authenticate-payload(apiKey: "apiKey_example") // AuthenticatePayload | 

// Advanced - Authenticate (1/2)
AuthenticationAPI.authenticate(authenticatePayload: authenticatePayload) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authenticatePayload** | [**AuthenticatePayload**](AuthenticatePayload.md) |  | 

### Return type

[**AccessToken**](AccessToken.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **refresh**
```swift
    open class func refresh(refreshTokenPayload: RefreshTokenPayload, completion: @escaping (_ data: AccessToken?, _ error: Error?) -> Void)
```

Advanced - Refresh token (2/2)

Use the refresh endpoint with the refresh token you received when you first authenticated using the api-key endpoint. Send the refresh token in the body of your request. The api.video API returns a new access token that is valid for one hour (3600 seconds) and a new refresh token.  


### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import ApiVideoUploader

let refreshTokenPayload = refresh-token-payload(refreshToken: "refreshToken_example") // RefreshTokenPayload | 

// Advanced - Refresh token (2/2)
AuthenticationAPI.refresh(refreshTokenPayload: refreshTokenPayload) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **refreshTokenPayload** | [**RefreshTokenPayload**](RefreshTokenPayload.md) |  | 

### Return type

[**AccessToken**](AccessToken.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

