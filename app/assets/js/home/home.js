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
      controller: 'HomeController as home'
    });
  }
})();
