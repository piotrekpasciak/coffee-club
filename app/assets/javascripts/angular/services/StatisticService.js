//= require app.js

angular.module('ccApp').service('StatisticService', function($http){

    this.getCoffeeCounters = function(id){
        return $http.get('coffee-counters.json');
    };

});