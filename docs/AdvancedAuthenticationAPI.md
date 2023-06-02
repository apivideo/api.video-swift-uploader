# AdvancedAuthenticationAPI

All URIs are relative to *https://ws.api.video*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authenticate**](AdvancedAuthenticationAPI.md#postauthapikey) | **POST** /auth/api-key | Get Bearer Token
[**refresh**](AdvancedAuthenticationAPI.md#postauthrefresh) | **POST** /auth/refresh | Refresh Bearer Token


# **authenticate**
```swift
    open class func authenticate(authenticatePayload: AuthenticatePayload, completion: @escaping (_ data: AccessToken?, _ error: Error?) -> Void)
```

Get Bearer Token

Returns a bearer token that can be used to authenticate other endpoint.  You can find the tutorial on using the disposable bearer token [here](https://docs.api.video/reference/disposable-bearer-token-authentication).


### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import ApiVideoUploader

let authenticatePayload = authenticate-payload(apiKey: "apiKey_example") // AuthenticatePayload | 

// Get Bearer Token
AdvancedAuthenticationAPI.authenticate(authenticatePayload: authenticatePayload) { (response, error) in
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

Refresh Bearer Token

Accepts the old bearer token and returns a new bearer token that can be used to authenticate other endpoint.  You can find the tutorial on using the disposable bearer token [here](https://docs.api.video/reference/disposable-bearer-token-authentication).


### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import ApiVideoUploader

let refreshTokenPayload = refresh-token-payload(refreshToken: "refreshToken_example") // RefreshTokenPayload | 

// Refresh Bearer Token
AdvancedAuthenticationAPI.refresh(refreshTokenPayload: refreshTokenPayload) { (response, error) in
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

