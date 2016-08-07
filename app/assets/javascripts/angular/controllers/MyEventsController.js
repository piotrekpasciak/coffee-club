//= require app.js

angular.module('ccApp').controller('MyEventsController', [
    '$rootScope', '$scope', 'toaster', 'EventService', 'UserAchievementService',

    function($rootScope, $scope, toaster, EventService, UserAchievementService){

        var path = "my-events";

        $scope.options = EventService.options;

        $scope.tab = "open";
        $rootScope.icon = "";

        $scope.updateTab = function(status) {
            $scope.tab = status;
            if($scope.tab == $scope.icon) $rootScope.icon = "";
        };

        $scope.getNumber = function(num) {
            return new Array(num);
        };

        $scope.joinEvent = function(event) {
            EventService.joinEventAction(event, path);
        };

        $scope.leaveEvent = function(event) {
            EventService.leaveEventAction(event, path);
        };

        $scope.completeEvent = function(event, tab) {
            EventService.completeEventAction(event, path, tab);
        };

        $scope.confirmEvent = function(event, tab) {
            EventService.confirmEventAction(event, path, tab);
        };

        $scope.expireEvent = function(event) {
            EventService.expireEventAction(event, path);
        };

        $scope.extendEvent = function(event, tab) {
            EventService.extendEventAction(event, path, tab);
        };

        function init() {
            EventService.reloadMyEvents();
            UserAchievementService.getUserAchievementsAction();
        }

        init();
    }

]);