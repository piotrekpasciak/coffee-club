//= require app.js

angular.module("ccApp").directive('spinner', function($rootScope){
    return{
        restrict: 'E',
        templateUrl: 'spinner.html',
        scope: { 'number' : '=' },
        link: function(scope, element, attrs){
            scope.visible = false;

            scope.$watch('number', function (number) {
                $rootScope.$on("spinner-show", function (event, data) {
                    if(number == data){
                        scope.visible = true;
                    }
                });

                $rootScope.$on("spinner-hide", function (event, data) {
                    if(number == data) {
                        scope.visible = false;
                    }
                })
            });
        }
    };
});