(function(){
  angular
    .module('scoreboard.memberships')
    .controller('MembershipsApproveController', MembershipsApproveController);

  function MembershipsApproveController($scope, $http, $rootScope, Semester, flash) {
    $http.get('/scoreboard/api/admin/memberships')
      .success(function(data){
        $scope.memberships = data;
        _.map($scope.memberships, function(membership){
          membership.date = moment(membership.created_at).format('L');
        })
      });
    Semester.getList().then(function(data){
      $scope.semesters = data;
    });

    $scope.approve = function(element, index) {
      $http.put('/scoreboard/api/memberships/' + element.id + '.json', {approved: true})
        .success(success)
        .error(error);
      function success(data) {
        flash.success.setMessage(data.notice);
        $scope.memberships.splice(index, 1);
        $rootScope.$emit("event:angularFlash");
      }
      function error(data) {
        $scope.errors = data.errors;
      }
    }

    $scope.deny = function(element, index) {
      $http.put('/scoreboard/api/memberships/' + element.id + '.json', {approved: false})
        .success(success)
        .error(error);
      function success(data) {
        flash.success.setMessage(data.notice);
        $scope.memberships.splice(index, 1);
        $rootScope.$emit("event:angularFlash");
      }
      function error(data) {
        $scope.errors = data.errors;
      }
    }
  }
})();
