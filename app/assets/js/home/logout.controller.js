(function(){
  angular
    .module('scoreboard.home')
    .controller('LogoutController', LogoutController);

  function LogoutController($rootScope, $http, $state) {
    $rootScope.alerts = [];
    $http.post('/scoreboard/api/logout')
      .success(function(data){
        $rootScope.alerts.push({type: 'success', message: data.notice });
        $rootScope.signed_in = false;
        $state.go('scoreboard.index');
      });
  }
})();
