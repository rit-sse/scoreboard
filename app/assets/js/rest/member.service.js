(function(){
  angular
    .module('scoreboard.rest')
    .factory('Member', Member);

  function Member(Restangular){
    return Restangular.service('members');
  }
})();
