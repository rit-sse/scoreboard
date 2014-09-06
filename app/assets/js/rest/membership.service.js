(function(){
  angular
    .module('scoreboard.rest')
    .factory('Membership', Membership);

  function Membership(Restangular){
    return Restangular.service('memberships');
  }
})();
