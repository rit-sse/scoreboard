(function(){
  angular
    .module('scoreboard.committees')
    .controller('CommitteesNewController', CommitteesNewController);

  function CommitteesNewController($scope, $rootScope, $state, Committee, flash) {
    $scope.committee = {};
    $scope.submit = function() {
      Committee.post({committee: $scope.committee}).then(success, error);
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
