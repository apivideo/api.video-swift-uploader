<!--<documentation_excluded>-->
[![badge](https://img.shields.io/twitter/follow/api_video?style=social)](https://twitter.com/intent/follow?screen_name=api_video) &nbsp; [![badge](https://img.shields.io/github/stars/apivideo/api.video-swift-uploader?style=social)]() &nbsp; [![badge](https://img.shields.io/discourse/topics?server=https%3A%2F%2Fcommunity.api.video)](https://community.api.video)
![](https://github.com/apivideo/.github/blob/main/assets/apivideo_banner.png)
<h1 align="center">api.video Swift uploader</h1>

[api.video](https://api.video) is the video infrastructure for product builders. Lightning fast video APIs for integrating, scaling, and managing on-demand & low latency live streaming features in your app.

## Table of contents

- [Project description](#project-description)
- [Getting started](#getting-started)
  - [Installation](#installation)
    - [Carthage](#carthage)
    - [CocoaPods](#cocoaPods)
  - [Code sample](#code-sample)
- [Documentation](#documentation)
  - [API Endpoints](#api-endpoints)
    - [VideosAPI](#VideosAPI)
  - [Models](#models)
  - [Authorization](#documentation-for-authorization)
    - [API key](#api-key)
    - [Public endpoints](#public-endpoints)
- [Have you gotten use from this API client?](#have-you-gotten-use-from-this-api-client)
- [Contribution](#contribution)
<!--</documentation_excluded>-->
<!--<documentation_only>
---
title: Swift video uploader
meta: 
  description: The official Swift video uploader for api.video. [api.video](https://api.video/) is the video infrastructure for product builders. Lightning fast video APIs for integrating, scaling, and managing on-demand & low latency live streaming features in your app.
---

# api.video Swift video uploader

[api.video](https://api.video/) is the video infrastructure for product builders. Lightning fast video APIs for integrating, scaling, and managing on-demand & low latency live streaming features in your app.
</documentation_only>-->

## Project description

api.video's Swift video uploader for iOS, macOS and tvOS uploads videos to api.video using delegated upload token or API Key.

It allows you to upload videos in two ways:
- standard upload: to send a whole video file in one go
- progressive upload: to send a video file by chunks, without needing to know the final size of the video file

## Getting started

### Installation

#### Carthage

Specify it in your `Cartfile`:

```
github "apivideo/api.video-swift-uploader" ~> 1.2.3
```

Run `carthage update`

#### CocoaPods

Add `pod 'ApiVideoUploader', '1.2.3'` in your `Podfile`

Run `pod install`

## Code sample

Please follow the [installation](#installation) instruction and execute the following Swift code:
```swift
import ApiVideoUploader

// If you rather like to use the sandbox environment:
// ApiVideoUploader.basePath = Environment.sandbox.rawValue

try VideosAPI.uploadWithUploadToken(token: "MY_UPLOAD_TOKEN", file: url) { video, error in
    if let video = video {
        // Manage upload with upload token success here
    }
    if let error = error {
        // Manage upload with upload token error here
    }
}
```

## Documentation

### API Endpoints

All URIs are relative to *https://ws.api.video*


#### VideosAPI

##### Retrieve an instance of VideosAPI:

```swift
VideosAPI
```

##### Endpoints

Method | HTTP request | Description
------------- | ------------- | -------------
[**upload**](https://github.com/apivideo/api.video-swift-uploader/blob/main/docs/VideosAPI.md#upload) | **POST** `/videos/{videoId}/source` | Upload a video
[**uploadWithUploadToken**](https://github.com/apivideo/api.video-swift-uploader/blob/main/docs/VideosAPI.md#uploadWithUploadToken) | **POST** `/upload` | Upload with an delegated upload token



### Models

 - [AccessToken](https://github.com/apivideo/api.video-swift-uploader/blob/main/docs/AccessToken.md)
 - [AdditionalBadRequestErrors](https://github.com/apivideo/api.video-swift-uploader/blob/main/docs/AdditionalBadRequestErrors.md)
 - [AuthenticatePayload](https://github.com/apivideo/api.video-swift-uploader/blob/main/docs/AuthenticatePayload.md)
 - [BadRequest](https://github.com/apivideo/api.video-swift-uploader/blob/main/docs/BadRequest.md)
 - [Metadata](https://github.com/apivideo/api.video-swift-uploader/blob/main/docs/Metadata.md)
 - [NotFound](https://github.com/apivideo/api.video-swift-uploader/blob/main/docs/NotFound.md)
 - [RefreshTokenPayload](https://github.com/apivideo/api.video-swift-uploader/blob/main/docs/RefreshTokenPayload.md)
 - [TooManyRequests](https://github.com/apivideo/api.video-swift-uploader/blob/main/docs/TooManyRequests.md)
 - [Video](https://github.com/apivideo/api.video-swift-uploader/blob/main/docs/Video.md)
 - [VideoAssets](https://github.com/apivideo/api.video-swift-uploader/blob/main/docs/VideoAssets.md)
 - [VideoSource](https://github.com/apivideo/api.video-swift-uploader/blob/main/docs/VideoSource.md)
 - [VideoSourceLiveStream](https://github.com/apivideo/api.video-swift-uploader/blob/main/docs/VideoSourceLiveStream.md)
 - [VideoSourceLiveStreamLink](https://github.com/apivideo/api.video-swift-uploader/blob/main/docs/VideoSourceLiveStreamLink.md)


### Rate limiting

api.video implements rate limiting to ensure fair usage and stability of the service. The API provides the rate limit values in the response headers for any API requests you make. The /auth endpoint is the only route without rate limitation.

In this client, you can access these headers by using the methods with the `completion: @escaping (_ result: Swift.Result<Response<T>, ErrorResponse>) -> Void)` parameters. These methods return both the response body and the headers, allowing you to check the `X-RateLimit-Limit`, `X-RateLimit-Remaining`, and `X-RateLimit-Retry-After` headers to understand your current rate limit status.
Read more about these response headers in the [API reference](https://docs.api.video/reference#limitation).

```swift
try VideosAPI.uploadWithUploadToken(token: "MY_UPLOAD_TOKEN", file: url) { result in
    switch result {
    case .success(let response):
        print("X-RateLimit-Limit:  \(String(describing: response.header["X-RateLimit-Limit"]))")
        print("X-RateLimit-Remaining:  \(String(describing: response.header["X-RateLimit-Remaining"]))")
        print("X-RateLimit-Retry-After:  \(String(describing: response.header["X-RateLimit-Retry-After"]))")
    case .failure(_):
        break
    }
}
```

### Authorization

#### API key

Most endpoints required to be authenticated using the API key mechanism described in our [documentation](https://docs.api.video/reference#authentication).

You must NOT store your API key in your application code to prevent your API key from being exposed in your source code.
Only the [Public endpoints](#public-endpoints) can be called without authentication.
In the case, you want to call an endpoint that requires authentication, you will have to use a backend server. See [Security best practices](https://docs.api.video/sdks/security) for more details.

#### Public endpoints

Some endpoints don't require authentication. These one can be called without setting `ApiVideoUploader.apiKey`.

### Have you gotten use from this API client?

Please take a moment to leave a star on the client ⭐

This helps other users to find the clients and also helps us understand which clients are most popular. Thank you!

## Contribution

Since this API client is generated from an OpenAPI description, we cannot accept pull requests made directly to the repository. If you want to contribute, you can open a pull request on the repository of our [client generator](https://github.com/apivideo/api-client-generator). Otherwise, you can also simply open an issue detailing your need on this repository.
