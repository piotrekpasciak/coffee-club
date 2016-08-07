//= require app.js

angular.module("ccApp").service("UserAchievementService", function($http, $rootScope, $timeout, toaster){

    var self = this;

    this.getUserAchievements = function(){
        return $http.get('user-achievements.json');
    };

    this.showUserAchievements = function(){
        return $http.get('show-user-achievements.json');
    };

    this.updateUserAchievements = function(userAchievements){
        return $http.post('update-user-achievements.json', userAchievements);
    };

    this.getUserAchievementsAction = function(){
        this.getUserAchievements().then(function(successResponse){
            $rootScope.myAchievements = successResponse.data.user_achievements;
        }, function(errorResponse){
            toaster.pop("error", "Can't connect to server, please try later!");
        });
    };

    this.showUserAchievementsAction = function(){
        this.showUserAchievements().then(function(successResponse){
            if(successResponse.data.user_achievements.length > 0){
                $timeout(function() {
                    $rootScope.$emit('achievement-show', successResponse.data.user_achievements);
                });
                self.updateUserAchievementsAction(successResponse.data.user_achievements);
            }
        }, function(errorResponse){
            toaster.pop("error", "Can't connect to server, please try later!");
        });
    };

    this.updateUserAchievementsAction = function(userAchievements){
        this.updateUserAchievements(userAchievements).then(function(successResponse){
        }, function(errorResponse){
            toaster.pop("error", "Can't connect to server, please try later!");
        });
    }

});
