//= require app.js

angular.module("ccApp").filter("SecondsToMinutes", function() {
    return function(seconds) {
        if(isNaN(seconds)) return "0:00:00";

        var hours = Math.floor(seconds / 3600);
        var minutes = (Math.floor(seconds % 3600 / 60) < 10)? '0' + Math.floor(seconds % 3600 / 60) : Math.floor(seconds % 3600 / 60);
        seconds = (seconds % 60 < 10)? '0' + seconds % 60 : seconds % 60;
        return hours + ":" + minutes + ":" + seconds;
    };
});