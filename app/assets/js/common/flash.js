/**!
 * @license angular-flash-pure v0.1.0
 * Copyright (c) 2014 Kristen Mills.
 * License: MIT
 */
(function() {
  angular.module('flash', []).factory("flash", function($rootScope) {
    var currentMessages, queues;
    queues = {
      info: [],
      success: [],
      warning: [],
      danger: []
    };
    currentMessages = {
      info: '',
      success: '',
      warning: '',
      danger: ''
    };
    $rootScope.$on("$locationChangeStart", function() {
      currentMessages.info = queues.info.shift() || "";
      currentMessages.success = queues.success.shift() || "";
      currentMessages.warning = queues.warning.shift() || "";
      return currentMessages.danger = queues.danger.shift() || "";
    });
    $rootScope.$on("event:angularFlash", function() {
      currentMessages.info = queues.info.shift() || "";
      currentMessages.success = queues.success.shift() || "";
      currentMessages.warning = queues.warning.shift() || "";
      return currentMessages.danger = queues.danger.shift() || "";
    });
    return {
      info: {
        setMessage: function(message) {
          return queues.info.push(message);
        },
        getMessage: function() {
          return currentMessages.info;
        }
      },
      success: {
        setMessage: function(message) {
          return queues.success.push(message);
        },
        getMessage: function() {
          return currentMessages.success;
        }
      },
      warning: {
        setMessage: function(message) {
          return queues.warning.push(message);
        },
        getMessage: function() {
          return currentMessages.warning;
        }
      },
      danger: {
        setMessage: function(message) {
          return queues.danger.push(message);
        },
        getMessage: function() {
          return currentMessages.danger;
        }
      }
    };
  }).directive('flashMessages', [
    'flash', function(flash) {
      return {
        restrict: 'E',
        templateUrl: '/scoreboard/templates/flash/flash',
        link: function(scope, elem, attrs) {
          return scope.flash = flash;
        }
      };
    }
  ]);
})();
