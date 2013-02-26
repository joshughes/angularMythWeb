'use strict'

### Controllers ###

angular.module('app.controllers', [])

.controller('AppCtrl', [
  '$scope'
  '$location'
  '$resource'
  '$rootScope'

($scope, $location, $resource, $rootScope) ->

  # Uses the url to determine if the selected
  # menu item should have the class active.
  $scope.$location = $location
  $scope.$watch('$location.path()', (path) ->
    $scope.activeNavId = path || '/'
  )

  # getClass compares the current url with the id.
  # If the current url starts with the id it returns 'active'
  # otherwise it will return '' an empty string. E.g.
  #
  #   # current url = '/products/1'
  #   getClass('/products') # returns 'active'
  #   getClass('/orders') # returns ''
  #
  $scope.getClass = (id) ->
    if $scope.activeNavId.substring(0, id.length) == id
      return 'active'
    else
      return ''
])

.controller('VideoCtrl', [
  '$scope','$resource', 'Video', 'Stream' , 'StreamQuery'

($scope, $resource, Video, Stream, StreamQuery) ->
  $scope.loading = false
  $scope.countDown = 10

  $scope.getList = () ->
    console.log("Get List Called")
    Stream.query( (response) ->
      console.log("Get List success")
      $scope.list = response.LiveStreamInfoList.LiveStreamInfos)
    $scope.list

  console.log($scope.getList())
  

  $scope.transcoding = (fileName) ->
    StreamQuery.fileNameExists(fileName,$scope.list)
  $scope.startStream = (id) ->
    Stream.save(Id: id,
      (response) ->
        console.log("Success Add"))
        
  $scope.deleteStream = (id) ->
    console.log("DELETE")
    Stream.delete(Id: id,
      (response) ->
        console.log("Success Delete"))
        

  $scope.videos = Video.query()
 
  $scope.streams = Stream.query()

  $scope.getStreams = () -> Video.getWithStreams($scope.videos,  (response) ->
    console.log("Response is")
    console.log(response)
    $scope.streamHash = response)

  $scope.getStreams()


  $scope.list = Video.stream( (response) ->
    console.log("Got here")
    consol.log($scope.videos)
    console.log("Videos")
    $scope.test= response
    console.log(reponse))


  timerID = setInterval( () ->
              if not $scope.loading
                if 0 is --$scope.countDown
                  console.log("timer done")
                  $scope.streams = Stream.query()
                  $scope.getStreams()
                  console.log($scope.list)
                  $scope.countDown  = 10
            ,1000)

])

.controller('VideoDetailCtrl', [
  '$scope','$resource','$routeParams', 'Video'

($scope, $resource, $routeParams, Video) ->
  Video.get(
    {Id: $routeParams.videoId},
    (data) ->
      $scope.video = data.VideoMetadataInfo
    (data) ->)
])

.controller('RecordingCtrl', [
  '$scope','$resource'

($scope, $resource) ->
  recordings = $resource '/Dvr/GetRecordedList'
  $scope.recordings = recordings.get()
])

.controller('RecordingDetailCtrl', [
  '$scope','$resource','$routeParams'

($scope, $resource, $routeParams) ->
  recorded = $resource '/Dvr/GetRecorded',
    StartTime: $routeParams.startTime
    ChanId: $routeParams.chanId

  recorded.get(
    {},
    (data) ->
      $scope.recorded = data.Program
    (data) ->)
])

.controller('TodoCtrl', [
  '$scope'

($scope) ->

  $scope.todos = [
    text: "learn angular"
    done: true
  ,
    text: "build an angular app"
    done: false
  ]

  $scope.addTodo = ->
    $scope.todos.push
      text: $scope.todoText
      done: false

    $scope.todoText = ""

  $scope.remaining = ->
    count = 0
    angular.forEach $scope.todos, (todo) ->
      count += (if todo.done then 0 else 1)

    count

  $scope.archive = ->
    oldTodos = $scope.todos
    $scope.todos = []
    angular.forEach oldTodos, (todo) ->
      $scope.todos.push todo  unless todo.done

])

