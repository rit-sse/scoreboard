(function(){
  angular
    .module('scoreboard.memberships')
    .controller('MembershipsNewController', MembershipsNewController);

  function MembershipsNewController($scope, $rootScope, $state, Membership, Committee, flash) {
    $scope.membership = {};
    $scope.member = {};

    Committee.getList().then(success);
    function success(data) {
      $scope.committees = data;
    }
    $scope.submit = function() {
      Membership.post({membership: $scope.membership, member: $scope.member}).then(success, error);
      function success(data) {
        flash.success.setMessage(data.notice);
        $state.go('scoreboard.index');
      }
      function error(response) {
        $scope.errors = response.data.errors;
      }
    }
  }
})();
