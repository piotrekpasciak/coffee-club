//= require app.js

angular.module('ccApp').service('UserService', function($http, $rootScope, toaster){

    this.getCurrentUser = function(){
        return $http.get('current-user.json');
    };

    this.getRanking = function(){
        return $http.get('ranking.json');
    };

    this.updateSubscription = function(){
        return $http.post('update-subscription.json');
    };

    this.getCurrentUserAction = function(){
        this.getCurrentUser().then(function(successResponse){
                $rootScope.current_user = successResponse.data.user;
            },
            function(errorResponse){
            }
        )
    };

    this.getRankingAction = function(){
        this.getRanking().then(function(successResponse){
                $rootScope.addicts = successResponse.data.addicts;
                $rootScope.managers = successResponse.data.managers;
            },
            function(errorResponse){
                toaster.pop("error", "Can't connect to server, please try later!");
            }
        )
    };

    this.updateSubscriptionAction = function(){
        this.updateSubscription().then(function(successResponse){
            $rootScope.current_user = successResponse.data.user;

            if(successResponse.data.user.newsletter){
                toaster.pop("success", "You have subscribed for newsletter!");
            }
            else{
                toaster.pop("warning", "You're no longer subscriber of newsletter!");
            }
        },
        function(errorResopnse){
            toaster.pop("error", "Can't connect to server, please try later!");
        })
    };
});