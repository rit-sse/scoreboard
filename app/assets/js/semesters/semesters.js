(function(){
  angular
    .module('scoreboard.semesters', [])
    .config(config);

  function config($stateProvider) {
    $stateProvider
    .state('scoreboard.semester', {
      url: '/semester',
      abstract: true,
      template: '<div ui-view />'
    })
    .state('scoreboard.semester.new', {
      url: '/new',
      templateUrl: '/scoreboard/templates/memberships/index',
      controller: 'MembersShowController'
    });
  }
})();
