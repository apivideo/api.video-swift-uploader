# Video

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**videoId** | **String** | The unique identifier of the video object. | 
**createdAt** | **Date** | When a video was created, presented in ISO-8601 format. | [optional] 
**title** | **String** | The title of the video content.  | [optional] 
**description** | **String** | A description for the video content.  | [optional] 
**publishedAt** | **String** | The date and time the API created the video. Date and time are provided using ISO-8601 UTC format. | [optional] 
**updatedAt** | **Date** | The date and time the video was updated. Date and time are provided using ISO-8601 UTC format. | [optional] 
**tags** | **[String]** | One array of tags (each tag is a string) in order to categorize a video. Tags may include spaces.   | [optional] 
**metadata** | [Metadata] | Metadata you can use to categorise and filter videos. Metadata is a list of dictionaries, where each dictionary represents a key value pair for categorising a video. [Dynamic Metadata](https://api.video/blog/endpoints/dynamic-metadata) allows you to define a key that allows any value pair.  | [optional] 
**source** | [**VideoSource**](VideoSource.md) |  | [optional] 
**assets** | [**VideoAssets**](VideoAssets.md) |  | [optional] 
**playerId** | **String** | The id of the player that will be applied on the video.  | [optional] 
**_public** | **Bool** | Defines if the content is publicly reachable or if a unique token is needed for each play session. Default is true. Tutorials on [private videos](https://api.video/blog/endpoints/private-videos).  | [optional] 
**panoramic** | **Bool** | Defines if video is panoramic.  | [optional] 
**mp4Support** | **Bool** | This lets you know whether mp4 is supported. If enabled, an mp4 URL will be provided in the response for the video.  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


