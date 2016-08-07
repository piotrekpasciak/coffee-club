//= require app.js

angular.module("ccApp").directive('peopleIcons', function(){
    return {
        restrict: 'E',
        scope: { 'amount' : '=' },
        link: function(scope, element, attrs) {
            scope.$watch('amount', function (amount) {
                $(element).append('<i class="fa fa-user person-icon-size black-icon"></i> ');
                _(amount).times(function(){
                    $(element).append('<i class="fa fa-user person-icon-size white-color"></i> ');
                });
            });
        }
    };
});