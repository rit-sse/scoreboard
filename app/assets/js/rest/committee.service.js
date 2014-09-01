(function(){
  angular
    .module('scoreboard.rest')
    .factory('Committee', Committee);

  function Committee(Restangular){
    return Restangular.service('committees');
  }
})();
