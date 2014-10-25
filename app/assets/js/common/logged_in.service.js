(function(){
  angular
    .module('scoreboard')
    .factory('loggedIn', loggedIn);

  function loggedIn($q, $timeout, $http, $state, $rootScope, flash){
    return {
      loggedIn: function(){
        var deferred = $q.defer();
        $http.get('/scoreboard/api/logged_in').success(function(user){
          if (user.signed_in){
            $timeout(deferred.resolve, 0);
          }
          else {
            flash.danger.setMessage('You need to be logged in to view that');
            $timeout(function(){deferred.reject();}, 0);
            $state.go('scoreboard.login');
          }
        });
      },
      admin: function() {
        var deferred = $q.defer();
        $http.get('/scoreboard/api/logged_in').success(function(user){
          if (user.admin){
            $timeout(deferred.resolve, 0);
          }
          else {
            flash.danger.setMessage('You need to be a primary officer in to view that');
            $timeout(function(){deferred.reject();}, 0);
            $state.go('scoreboard.index');
          }
        });
      }
    };
  }
})();
