(function(){
  angular.module('scoreboard')
    .controller('ToolbarController', ToolbarController);

  function ToolbarController($scope) {
    $scope.collapsed = true;
    $scope.logged_in_links = [
      {
        url: '/scoreboard/committees/new',
        content: 'Add Committee',
        class: 'fa-tag'
      },
      {
        url: '/scoreboard/semesters/new',
        content: 'Add Semester',
        class: 'fa-calendar'
      },
      {
        url: '/scoreboard/memberships/new',
        content: 'Add Membership',
        class: 'fa-user'
      },
      {
        url: '/scoreboard/memberships',
        content: 'Membership Lists',
        class: 'fa-users'
      }
    ];
    $scope.logged_out_links = [
      {
        url: '/scoreboard/login',
        content: 'Sign In',
        class: 'fa-sign-in'
      }
    ];
  }
})();
