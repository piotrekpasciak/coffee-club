//= require app.js

angular.module('ccApp').controller('ShowController', [
    '$rootScope', '$scope', 'toaster', 'EventService', 'CommentService',

    function($rootScope, $scope, toaster, EventService, CommentService){

        var path = "home";

        $scope.options = EventService.options;

        $scope.comment = { text: "" };

        $scope.getNumber = function(num) {
            return new Array(num);
        };

        function reloadEvent() {
            var location = window.location.pathname.split('/');
            var id = location.pop();

            EventService.getEvent(id).then(function(successResponse) {
                $scope.event = successResponse.data.event;
                $scope.comments = successResponse.data.event.comments;

            }, function(errorResponse){
                toaster.pop("error", "Can't connect to server, please try later!");
            });
        }

        $scope.createComment = function (event) {
            CommentService.createComment(event.id, $scope.comment).then(function(successResponse) {
                    $scope.comment.text = "";
                    reloadEvent();
                    toaster.pop('success', "You have successfully created the comment!");

                }, function(errorResponse) {
                    if(errorResponse.status == 422){
                        $scope.errorMessage = errorResponse.data.message;

                        toaster.pop("warning", errorResponse.data.message);
                    }
                    else{
                        toaster.pop("error", "Can't connect to server, please try later!");
                    }
                });
        };

        $scope.joinEvent = function(event){
            EventService.joinEventAction(event, path);
            reloadEvent();
        };

        $scope.leaveEvent = function(event){
            EventService.leaveEventAction(event, path);
            reloadEvent();
        };

        $scope.completeEvent = function(event) {
            EventService.completeEventAction(event, path);
            reloadEvent();
        };

        $scope.confirmEvent = function(event) {
            EventService.confirmEventAction(event, path);
            reloadEvent();
        };

        $scope.expireEvent = function(event) {
            EventService.expireEventAction(event, path);
            reloadEvent();
        };

        $scope.extendEvent = function(event) {
            EventService.extendEventAction(event, path);
            reloadEvent();
        };

        function init(){
            reloadEvent();
        }

        init();
    }

]);