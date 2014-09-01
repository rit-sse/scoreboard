(function(){
  angular.module('scoreboard')
    .controller('ToolbarController', ToolbarController);

  function ToolbarController($scope) {
    $scope.collapsed = true;
    $scope.logged_in_links = [
      {
        url: '/scoreboard/committees/new',
        content: 'Add Committee'
      },
      {
        url: '/scoreboard/semesters/new',
        content: 'Add Semester'
      },
      {
        url: '/scoreboard/memberships/new',
        content: 'Add Membership'
      },
      {
        url: '/scoreboard/memberships',
        content: 'Membership Lists'
      }
    ];
    $scope.logged_out_links = [
      {
        url: '/scorboard/login',
        content: 'Sign In',
        class: 'fa-sign-in'
      }
    ];
  }
})();
