# Video

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**videoId** | **String** | The unique identifier of the video object. | 
**createdAt** | **Date** | When a video was created, presented in ATOM UTC format. | [optional] 
**title** | **String** | The title of the video content.  | [optional] 
**description** | **String** | A description for the video content.  | [optional] 
**publishedAt** | **Date** | The date and time the API created the video. Date and time are provided using ATOM UTC format. | [optional] 
**updatedAt** | **Date** | The date and time the video was updated. Date and time are provided using ATOM UTC format. | [optional] 
**discardedAt** | **Date** | The date and time the video was discarded. The API populates this field only if you have the Video Restore feature enabled and discard a video. Date and time are provided using ATOM UTC format. | [optional] 
**deletesAt** | **Date** | The date and time the video will be permanently deleted. The API populates this field only if you have the Video Restore feature enabled and discard a video. Discarded videos are pemanently deleted after 90 days. Date and time are provided using ATOM UTC format. | [optional] 
**discarded** | **Bool** | Returns &#x60;true&#x60; for videos you discarded when you have the Video Restore feature enabled. Returns &#x60;false&#x60; for every other video. | [optional] 
**language** | **String** | Returns the language of a video in [IETF language tag](https://en.wikipedia.org/wiki/IETF_language_tag) format. You can set the language during video creation via the API, otherwise it is detected automatically. | [optional] 
**languageOrigin** | **String** | Returns the origin of the last update on the video&#39;s &#x60;language&#x60; attribute.  - &#x60;api&#x60; means that the last update was requested from the API. - &#x60;auto&#x60; means that the last update was done automatically by the API. | [optional] 
**tags** | **[String]** | One array of tags (each tag is a string) in order to categorize a video. Tags may include spaces.   | [optional] 
**metadata** | [Metadata] | Metadata you can use to categorise and filter videos. Metadata is a list of dictionaries, where each dictionary represents a key value pair for categorising a video.  | [optional] 
**source** | [**VideoSource**](VideoSource.md) |  | [optional] 
**assets** | [**VideoAssets**](VideoAssets.md) |  | [optional] 
**playerId** | **String** | The id of the player that will be applied on the video.  | [optional] 
**_public** | **Bool** | Defines if the content is publicly reachable or if a unique token is needed for each play session. Default is true. Tutorials on [private videos](https://api.video/blog/endpoints/private-videos/).  | [optional] 
**panoramic** | **Bool** | Defines if video is panoramic.  | [optional] 
**mp4Support** | **Bool** | This lets you know whether mp4 is supported. If enabled, an mp4 URL will be provided in the response for the video.  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


