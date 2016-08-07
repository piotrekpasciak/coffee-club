//= require app.js

angular.module('ccApp').controller('HomeController', [
    '$rootScope', '$scope', 'toaster', 'EventService', 'UserAchievementService',

    function($rootScope, $scope, toaster, EventService, UserAchievementService){

        var path = "home";

        $scope.options = EventService.options;

        $scope.getNumber = function(num) {
            return new Array(num);
        };

        $scope.joinEvent = function(event){
            EventService.joinEventAction(event, path);
        };

        $scope.leaveEvent = function(event){
            EventService.leaveEventAction(event, path);
        };

        $scope.completeEvent = function(event) {
            EventService.completeEventAction(event, path);
        };

        $scope.confirmEvent = function(event) {
            EventService.confirmEventAction(event, path);
        };

        $scope.expireEvent = function(event) {
            EventService.expireEventAction(event, path);
        };

        $scope.extendEvent = function(event) {
            EventService.extendEventAction(event, path);
        };

        function init() {
            EventService.reloadOpenEvents();
            UserAchievementService.showUserAchievementsAction();
        }

        init();
    }

]);