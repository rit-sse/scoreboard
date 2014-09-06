(function(){
  angular
    .module('scoreboard.committees', [])
    .config(config);

  function config($stateProvider){
    $stateProvider
    .state('scoreboard.committees', {
      url: '/committees',
      abstract: true,
      template: '<div ui-view />'
    })
    .state('scoreboard.committees.new', {
      url: '/new',
      templateUrl: '/scoreboard/templates/committees/new',
      controller: 'CommitteesNewController',
      resolve: {
        loggedIn: function(loggedIn) {
          loggedIn.loggedIn();
        }
      }
    });
  }
})();
