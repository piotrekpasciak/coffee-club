//= require app.js

angular.module('ccApp').service('CommentService', function($http, toaster) {

    this.createComment = function (id, data) {
        return $http.post('events/' + id + '/comments.json', data);
    };

    this.getComments = function(id) {
        return $http.get('events/' + id + "/comments.json");
    };

});