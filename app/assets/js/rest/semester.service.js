(function(){
  angular
    .module('scoreboard.rest')
    .factory('Semester', Semester);

  function Semester(Restangular){
    return Restangular.service('semesters');
  }
})();
