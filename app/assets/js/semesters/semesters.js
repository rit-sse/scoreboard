(function(){
  angular
    .module('scoreboard.semesters', [])
    .config(config);

  function config($stateProvider, $datepickerProvider) {
    $stateProvider
    .state('scoreboard.semesters', {
      url: '/semesters',
      abstract: true,
      template: '<div ui-view />'
    })
    .state('scoreboard.semesters.new', {
      url: '/new',
      templateUrl: '/scoreboard/templates/semesters/new',
      controller: 'SemestersNewController'
    });

    angular.extend($datepickerProvider.defaults, {
      iconLeft: 'fa fa-chevron-left',
      iconRight: 'fa fa-chevron-right'
    });
  }
})();
