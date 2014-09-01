(function(){
  angular
    .module('scoreboard')
    .factory('loggedIn', loggedIn);

  function loggedIn($q, $timeout, $http, $state, $rootScope){
    return {
      loggedIn: function(){
        var deferred = $q.defer();
        $http.get('/scoreboard/api/logged_in').success(function(user){
          if (user.signed_in){
            $timeout(deferred.resolve, 0);
          }
          else {
            $rootScope = [];
            $rootScope.alerts.push({type: 'danger', message: 'You need to be logged in to view that'});
            $timeout(function(){deferred.reject();}, 0);
            $state.go('scoreboard.index');
          }
        });
      }
    };
  }
})();
