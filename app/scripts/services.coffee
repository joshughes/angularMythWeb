'use strict'

### Sevices ###

service = angular.module('app.services', ['ngResource'])

service.factory 'version', -> "0.1"

service.factory 'Stream', ($resource) ->
  stream = $resource(
    '/Content/:endPoint',
    {},
    'query':
      method: 'GET',
      params:
        endPoint: 'GetLiveStreamList'
    'save':
      method: 'GET',
      params:
        endPoint: 'AddVideoLiveStream'
    'get':
      method: 'GET',
      params:
        endPoint: 'GetLiveStream'
    'delete':
      method: 'GET',
      params:
        endPoint: 'RemoveLiveStream')

  stream.fileStreamExists = (filename, list) ->
    matchStream
    for stream in list
      if stream.SourceFile.indexOf(name) isnt -1
        matchStream = stream
    matchStream

  stream

service.factory 'Video',['$resource', 'Stream', ($resource,Stream) ->
  videoService = $resource(
    '/Video/:endPoint',
    {},
    'query':
      method: 'GET',
      params:
        endPoint: 'GetVideoList'
    'get':
      method: 'GET'
      params:
        endPoint: 'GetVideo')
  videoService.stream = () ->
    console.log("Call")
    console.log(Stream.query( (response) ->
     console.log("Callback")
     console.log(response.LiveStreamInfoList.LiveStreamInfos)
     response))
    console.log("Above")

  videoService.getWithStreams = (videoList,response) ->
    @.query( (videoResp) ->
      videoHash = {}
      Stream.query( (streamResp) ->
        videoList = videoResp.VideoMetadataInfoList.VideoMetadataInfos
        streamList = streamResp.LiveStreamInfoList.LiveStreamInfos
        for stream in streamList
          for video in videoList
            if stream.SourceFile.indexOf(video.FileName) isnt -1
              console.log("Found Video")
              console.log(video.Id)
              videoHash[video.Id] = stream
        console.log(videoHash)
        response videoHash
        ))
  videoService]



service.factory 'StreamQuery', () ->
  streamQuery = {}
  streamQuery.fileNameExists = (name, list) ->
    matchStream
    for stream in list
      if stream.SourceFile.indexOf(name) isnt -1
        matchStream = stream
    matchStream
  streamQuery

