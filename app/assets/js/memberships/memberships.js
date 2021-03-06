(function(){
  angular
    .module('scoreboard.memberships', [])
    .config(config);

  function config($stateProvider) {
    $stateProvider
    .state('scoreboard.memberships', {
      url: '/memberships',
      abstract: true,
      template: '<div ui-view />'
    })
    .state('scoreboard.memberships.new', {
      url: '/new',
      templateUrl: '/scoreboard/templates/memberships/new',
      controller: 'MembershipsNewController',
      resolve: {
        loggedIn: function(loggedIn) {
          loggedIn.loggedIn();
        }
      }
    })
    .state('scoreboard.memberships.index', {
      url: '?unique&semester',
      templateUrl: '/scoreboard/templates/memberships/index',
      controller: 'MembershipsIndexController',
      resolve: {
        loggedIn: function(loggedIn) {
          loggedIn.loggedIn();
        }
      }
    })
    .state('scoreboard.memberships.authorize', {
      url: '/approve',
      templateUrl: '/scoreboard/templates/memberships/approve',
      controller: 'MembershipsApproveController',
      resolve: {
        loggedIn: function(loggedIn) {
          loggedIn.admin();
        }
      }
    });
  }
})();
