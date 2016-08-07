//= require app.js

angular.module('ccApp').controller('FooterController', [
    '$rootScope', '$scope', 'EventService', 'UserService',

    function($rootScope, $scope, EventService, UserService){

        $scope.updateSubscription = function(){
          UserService.updateSubscriptionAction();
        };

        function init(){
            UserService.getCurrentUserAction();
            EventService.getCoffeeCounters();
        }

        init();
    }

]);