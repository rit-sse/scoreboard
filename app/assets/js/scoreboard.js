(function(){
  angular
    .module('scoreboard', [
      'ui.router',
      'ui.bootstrap',
      'scoreboard.home',
      'spinner'
    ])
    .config(config)
    .run(run);

  function config($stateProvider, $httpProvider, $locationProvider, $urlRouterProvider){
    var csrf = document.querySelector("meta[name=\"csrf-token\"]");
    if(csrf){
      var authToken = csrf.getAttribute("content");
    }
    $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken;
    $locationProvider.html5Mode(true);
    $urlRouterProvider.otherwise('/scoreboard');
    $httpProvider.interceptors.push( 'loadingSpinnerInterceptor' )

    $stateProvider
    .state('scoreboard', {
      url: '/scoreboard',
      abstract: true,
      template: '<div ui-view />'
    });
  }

  function run($rootScope) {
    $rootScope.closeAlert = function(index) {
      $rootScope.alerts.splice(index, 1);
    };

    $rootScope.alerts = [];
  }
})();
