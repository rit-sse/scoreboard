(function(){
  angular
    .module('scoreboard.home')
    .controller('LoginController', LoginController);

  function LoginController($scope, $rootScope, $http, $state, flash){
    $scope.user = {};
    $scope.login = function() {
      $rootScope.alerts = [];
      $http.post('/scoreboard/api/auth', $scope.user)
        .success(function(data){
          flash.success.setMessage(data.notice);
          $rootScope.signed_in = true;
          $rootScope.admin = data.admin;
          $state.go('scoreboard.index');
        })
        .error(function(data){
          flash.danger.setMessage(data.notice);
          $rootScope.$emit("event:angularFlash");
        });
    }
  }
})();
