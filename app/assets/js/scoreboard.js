(function(){
  angular
    .module('scoreboard', [
      'ui.router',
      'ui.bootstrap',
      'flash',
      'spinner',
      'scoreboard.rest',
      'scoreboard.home',
      'scoreboard.committees',
      'scoreboard.memberships'
    ])
    .config(config)
    .run(run);

  function config($stateProvider, $httpProvider, $locationProvider, $urlRouterProvider){
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

  function run($rootScope, $http) {
    $http.get('/scoreboard/api/logged_in')
      .success(function(data){
        $rootScope.signed_in = data.signed_in;
      });
  }
})();
