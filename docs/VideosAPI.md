# VideosAPI

All URIs are relative to *https://ws.api.video*

Method | HTTP request | Description
------------- | ------------- | -------------
[**uploadWithUploadToken**](VideosAPI.md#postupload) | **POST** /upload | Upload with an upload token
[**upload**](VideosAPI.md#postvideosvideoidsource) | **POST** /videos/{videoId}/source | Upload a video


# **uploadWithUploadToken**
```swift
    open class func uploadWithUploadToken(token: String, file: URL, completion: @escaping (_ data: Video?, _ error: Error?) -> Void)
```

Upload with an upload token

This method allows you to send a video using an upload token. Upload tokens are especially useful when the upload is done from the client side. If you want to upload a video from your server-side application, you'd better use the [standard upload method](#upload).


### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import ApiVideoUploader

let token = "token_example" // String | The unique identifier for the token you want to use to upload a video.
let file = URL(string: "https://example.com")! // URL | The path to the video you want to upload.

// Upload with an upload token
VideosAPI.uploadWithUploadToken(token: token, file: file) { (response, error) in
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
 **token** | **String** | The unique identifier for the token you want to use to upload a video. | 
 **file** | **URL** | The path to the video you want to upload. | 

### Return type

[**Video**](Video.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **upload**
```swift
    open class func upload(videoId: String, file: URL, completion: @escaping (_ data: Video?, _ error: Error?) -> Void)
```

Upload a video

To upload a video to the videoId you created. You can only upload your video to the videoId once.

We offer 2 types of upload: 
* Regular upload 
* Progressive upload
The latter allows you to split a video source into X chunks and send those chunks independently (concurrently or sequentially). The 2 main goals for our users are to
  * allow the upload of video sources > 200 MiB (200 MiB = the max. allowed file size for regular upload)
  * allow to send a video source "progressively", i.e., before before knowing the total size of the video.
  Once all chunks have been sent, they are reaggregated to one source file. The video source is considered as "completely sent" when the "last" chunk is sent (i.e., the chunk that "completes" the upload).



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import ApiVideoUploader

let videoId = "videoId_example" // String | Enter the videoId you want to use to upload your video.
let file = URL(string: "https://example.com")! // URL | The path to the video you would like to upload. The path must be local. If you want to use a video from an online source, you must use the \\\"/videos\\\" endpoint and add the \\\"source\\\" parameter when you create a new video.

// Upload a video
VideosAPI.upload(videoId: videoId, file: file) { (response, error) in
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
 **videoId** | **String** | Enter the videoId you want to use to upload your video. | 
 **file** | **URL** | The path to the video you would like to upload. The path must be local. If you want to use a video from an online source, you must use the \\\&quot;/videos\\\&quot; endpoint and add the \\\&quot;source\\\&quot; parameter when you create a new video. | 

### Return type

[**Video**](Video.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

