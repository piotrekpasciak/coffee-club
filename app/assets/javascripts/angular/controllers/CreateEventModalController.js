//= require app.js

angular.module('ccApp').controller('CreateEventModalController', ['$rootScope', '$scope', '$timeout', 'toaster', '$modalInstance', 'EventService',

    function ($rootScope, $scope, $timeout, toaster, $modalInstance, EventService) {

        $scope.options = EventService.long_options;
        $scope.option = $scope.options[3];

        $scope.event = { people_amount: 2, time_length: 30 };

        $scope.createEvent = function () {
            $timeout(function() {
                $rootScope.$emit('spinner-show', -1);
            });
            EventService.createEvent($scope.event).then(function(successResponse) {

                toaster.pop('success', "You have successfully created the event!");
                $timeout(function() {
                    $rootScope.$emit('spinner-hide', -1);
                });
                $modalInstance.close("Success");

            }, function(errorResponse) {
                if(errorResponse.status == 422){
                    $scope.errorMessages = errorResponse.data.message;

                    toaster.pop("warning", "Don't forget to fill all fields!");
                }
                else{
                    toaster.pop("error", "Can't connect to server, please try later!");
                }
                $timeout(function() {
                    $rootScope.$emit('spinner-hide', -1);
                });
            });
        };

        $scope.cancel = function () {
            $modalInstance.dismiss('cancel');
        };

    }
]);
