(function(){
  angular
    .module('scoreboard.members')
    .controller('MembersShowController', MembersShowController);

  function MembersShowController($scope, $stateParams, Member, Semester, Membership){
    $scope.dce = $stateParams.dce;

    Member.one($stateParams.dce).get().then(function(data){
      $scope.member = data;
    });

    Membership.getList($stateParams).then(function(data){
      $scope.memberships = data;
      _.map($scope.memberships, function(membership){
        membership.date = moment(membership.created_at).format('L');
      });
    });

    Semester.getList().then(function(data){
      $scope.semesters = data;
    });
  }
})();
