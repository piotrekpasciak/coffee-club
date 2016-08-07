//= require app.js

angular.module("ccApp").controller("RankingController", [
    '$rootScope', '$scope', 'toaster', 'UserService',

    function($rootScope, $scope, toaster, UserService){

        function init(){
            UserService.getRankingAction();
        }

        init();
    }
]);