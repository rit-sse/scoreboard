(function(){
  angular
    .module('scoreboard.home')
    .controller('LoginController', LoginController);

  function LoginController($scope, $rootScope, $http, $state){
    $scope.user = {};
    $scope.login = function() {
      $rootScope.alerts = [];
      $http.post('/scoreboard/api/auth', $scope.user)
        .success(function(data){
          $rootScope.alerts.push({type: 'success', message: data.notice });
          $rootScope.signed_in = true;
          $state.go('scoreboard.index');
        })
        .error(function(data){
          console.log(data)
          $rootScope.alerts.push({type: 'danger', message: data.notice });
        });
    }
  }
})();
