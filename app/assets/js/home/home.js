(function(){
  angular
    .module('scoreboard.home', [
      'ui.router'
    ])
    .config(config);

  function config($stateProvider){
    $stateProvider
    .state('scoreboard.index', {
      url: '',
      templateUrl: '/scoreboard/templates/home/index',
      controller: 'HomeController'
    })
    .state('scoreboard.login', {
      url: '/login',
      templateUrl: '/scoreboard/templates/home/login',
      controller: 'LoginController'
    });
  }
})();
