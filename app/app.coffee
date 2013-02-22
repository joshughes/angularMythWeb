'use strict'

# Declare app level module which depends on filters, and services
App = angular.module('app', [
  'ngCookies'
  'ngResource'
  'app.controllers'
  'app.directives'
  'app.filters'
  'app.services'
])

App.config([
  '$routeProvider'
  '$locationProvider'

($routeProvider, $locationProvider, config) ->

  $routeProvider

    .when('/todo', {templateUrl: '/partials/todo.html'})
    .when('/video', {templateUrl: '/partials/video.html'})
    .when('/video/:videoId', {templateUrl: 'partials/video_detail.html'})
    .when('/recording', {templateUrl: 'partials/recording.html'})
    .when('/recording/:chanId/:startTime',
      {templateUrl: 'partials/recording_detail.html'})
    .when('/view2', {templateUrl: '/partials/partial2.html'})

    # Catch all
    .otherwise({redirectTo: '/todo'})

  # Without server side support html5 must be disabled.
  $locationProvider.html5Mode(false)
])