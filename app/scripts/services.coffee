'use strict'

### Sevices ###

service = angular.module('app.services', ['ngResource'])

service.factory 'version', -> "0.1"

service.factory 'Video', ($resource) ->
  $resource(
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

service.factory 'Stream', ($resource) ->
  $resource(
    '/Content/:endPoint',
    {},
    'query':
      method: 'GET',
      params:
        endPoint: 'GetLiveStreamList'
      isArray: false
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

service.factory 'StreamQuery', ($http) ->
  streamQuery = {}
  
  streamQuery.getList = () ->
    $http.get('Content/GetLiveStreamList',cache:false).then(
      (response) ->
        things = response.data.LiveStreamInfoList.LiveStreamInfos
        return list : things)
    
  streamQuery.fileNameExists = (name, list) ->
    matchStream
    for stream in list
      if stream.SourceFile.indexOf(name) isnt -1
        matchStream = stream
    matchStream
  streamQuery

