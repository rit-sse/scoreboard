(function(){
  angular
    .module('scoreboard.rest', ['restangular'])
    .config(config);
  function config(RestangularProvider){
    RestangularProvider.setBaseUrl('/scoreboard/api');
  }
})();
