(function(){
  angular
    .module('scoreboard.home')
    .controller('HomeController', HomeController);

  function HomeController($http, $scope){
    $http.get('/scoreboard/api/high_scores')
      .success(function(data){
        $scope.members = [data.slice(0,10), data];
      });
    $scope.members_index = 0;
  }
})();
