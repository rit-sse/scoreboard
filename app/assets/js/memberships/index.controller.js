(function(){
  angular
    .module('scoreboard.memberships')
    .controller('MembershipsIndexController', MembershipsIndexController);

  function MembershipsIndexController($scope, $filter, $stateParams, Membership, Semester) {
    Membership.getList($stateParams).then(function(data){
      $scope.memberships = data;
      _.map($scope.memberships, function(membership){
        membership.date = moment(membership.created_at).format('L');
      })
    });

    Semester.getList().then(function(data){
      $scope.semesters = data;
    });
    $scope.order = 'created_at';
    $scope.reverse = false;

    $scope.sort = function(newCol) {
      if(newCol === $scope.order){
        $scope.reverse = !$scope.reverse;
      }else{
        $scope.reverse = false;
        $scope.order= newCol;
      }
    }
  }
})();
