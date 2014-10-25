(function(){
  angular
    .module('scoreboard.home')
    .controller('LogoutController', LogoutController);

  function LogoutController($rootScope, $http, $state, flash) {
    $rootScope.alerts = [];
    $http.post('/scoreboard/api/logout')
      .success(function(data){
        flash.success.setMessage(data.notice);
        $rootScope.signed_in = false;
        $rootScope.admin = false;
        $state.go('scoreboard.index');
      });
  }
})();
