//= require app.js

angular.module('ccApp').directive('achievement', function($rootScope){
    return{
        restrict: 'E',
        templateUrl: 'achievement.html',
        controller: function($scope, $element, $attrs){
            $scope.visible = false;

            $rootScope.$on('achievement-show', function(event, data){
                $scope.visible = true;
                $scope.achievements = data;
            });

            $rootScope.$on('achievement-hide', function(event, data){
                $scope.visible = false;
            });

            $scope.removeAchievement = function(achievement) {
                $scope.achievements = _.reject($scope.achievements, function(a){
                    return a.id == achievement.id;
                });
            }

        }
    }
});