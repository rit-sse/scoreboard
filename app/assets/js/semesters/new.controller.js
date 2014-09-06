(function(){
  angular
    .module('scoreboard.semesters')
    .controller('SemestersNewController', SemesterNewController);

  function SemesterNewController($scope, $state, Semester, flash) {
    $scope.semester = {};

    $scope.submit = function() {
      Semester.post({semester: $scope.semester}).then(success, error);
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
