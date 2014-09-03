(function(){
  angular
    .module('scoreboard.members', [])
    .config(config);

  function config($stateProvider){
    $stateProvider
    .state('scoreboard.members', {
      url: '/members',
      abstract: true,
      template: '<div ui-view />'
    })
    .state('scoreboard.members.show', {
      url: '/:dce?semester',
      templateUrl: '/scoreboard/templates/members/show',
      controller: 'MembersShowController'
    });
  }
})();
