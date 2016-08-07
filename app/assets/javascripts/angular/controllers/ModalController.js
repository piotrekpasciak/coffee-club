//= require app.js

angular.module('ccApp').controller('ModalController', [
    '$rootScope', '$scope', '$modal', '$log', 'EventService',

    function($rootScope, $scope, $modal, $log, EventService) {

        $scope.open = function (size) {
            var modalInstance = $modal.open({
                animation: true,
                templateUrl: 'create_modal.html',
                controller: 'CreateEventModalController',
                size: size

            });

            modalInstance.result.then(function (selectedItem) {
                EventService.reloadOpenEvents();
                EventService.reloadMyEvents();
                $log.info('Event created at: ' + new Date());
            }, function () {
                $log.info('Modal dismissed at: ' + new Date());
            });
        };
    }
]);