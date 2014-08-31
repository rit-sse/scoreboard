(function(){
  angular
    .module('scoreboard', [
      'ui.router',
      'scoreboard.home'
    ])
    .config(config);

  function config($stateProvider, $httpProvider, $locationProvider, $urlRouterProvider){
    var csrf = document.querySelector("meta[name=\"csrf-token\"]");
    if(csrf){
      var authToken = csrf.getAttribute("content");
    }
    $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken;
    $locationProvider.html5Mode(true);
    $urlRouterProvider.otherwise('/scoreboard');

    $stateProvider
    .state('scoreboard', {
      url: '/scoreboard',
      abstract: true,
      template: '<div ui-view />'
    });
  }
})();
