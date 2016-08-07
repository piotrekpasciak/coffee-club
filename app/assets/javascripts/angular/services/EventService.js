//= require app.js

angular.module('ccApp').service('EventService', function($http, $rootScope, $timeout, toaster, StatisticService, UserAchievementService) {

    var self = this;

    this.options = [
        {name:'1 min', value: 1},
        {name:'5 min', value: 5},
        {name:'15 min', value: 15},
        {name:'30 min', value: 30},
        {name:'1 hr', value: 60},
        {name:'2 hr', value: 120}
    ];

    this.long_options = [
        {name:'1 minute', value: 1},
        {name:'5 minutes', value: 5},
        {name:'15 minutes', value: 15},
        {name:'30 minutes', value: 30},
        {name:'1 hour', value: 60},
        {name:'2 hours', value: 120}
    ];

    this.getEvent = function (id) {
        return $http.get('events/' + id + '.json');
    };

    this.joinEvent = function (id) {
        return $http.post('events/' + id + '/participations.json');
    };

    this.leaveEvent = function (id) {
        return $http.delete('events/' + id + '/leave.json');
    };

    this.confirmEvent = function (id) {
        return $http.post('events/' + id + '/confirm.json');
    };

    this.completeEvent = function (id) {
        return $http.post('events/' + id + '/complete.json');
    };

    this.expireEvent = function(id) {
        return $http.post('events/' + id + '/expire.json');
    };

    this.extendEvent = function(id, data) {
        return $http.post('events/' + id + '/extend.json', data);
    };

    this.openEvents = function() {
        return $http.get('?format=json');
    };

    this.openAndClosedEvents = function() {
        return $http.get('my-events.json');
    };

    this.createEvent = function (data) {
        return $http.post("events.json", data);
    };

    function updateEvent(id, newEvent){
        var element = _.find($rootScope.openEvents,function(e){
            return e.id == id
        });
        _.extend(element, newEvent);
    }

    function updateOpenEvent(id, newEvent){
        var element = _.find($rootScope.myOpenEvents,function(e){
            return e.id == id
        });
        _.extend(element, newEvent);
    }

    function updateClosedEvent(id, newEvent){
        var element = _.find($rootScope.myClosedEvents,function(e){
            return e.id == id
        });
        _.extend(element, newEvent);
    }

    function updateDoneEvent(id, newEvent){
        var element = _.find($rootScope.myDoneEvents,function(e){
            return e.id == id
        });
        _.extend(element, newEvent);
    }

    function updateExpiredEvent(id, newEvent){
        var element = _.find($rootScope.myExpiredEvents, function(e){
            return e.id == id
        });
        _.extend(element, newEvent);
    }

    this.getCoffeeCounters = function(){
        StatisticService.getCoffeeCounters().then(function(successResponse){
            $rootScope.coffeeStats = successResponse.data.stats;

        },function(errorResponse){
            toaster.pop("error", "Can't connect to server, please try later!");
        });
    };

    this.reloadOpenEvents = function() {
        this.openEvents().then(function(successResponse) {
            $rootScope.openEvents = successResponse.data;
        }, function(errorResponse){
            toaster.pop("error", "Can't connect to server, please try later!");
        });
    };

    this.reloadMyEvents = function() {
        this.openAndClosedEvents().then(function(successResponse) {
            var data = successResponse.data;
            $rootScope.myOpenEvents = [];
            $rootScope.myClosedEvents = [];
            $rootScope.myDoneEvents = [];
            $rootScope.myExpiredEvents = [];

            _.each(data, function(data){
                if(data.status == "open") $rootScope.myOpenEvents.push(data);
                else if(data.status == "closed") $rootScope.myClosedEvents.push(data);
                else if(data.status == "done") $rootScope.myDoneEvents.push(data);
                else if(data.status == "expired") $rootScope.myExpiredEvents.push(data);
            });

        }, function(errorResponse) {
            toaster.pop("error", "Can't connect to server, please try later!");
        });
    };

    this.joinEventAction = function(event, type) {
        if(event.participants_left == 1) {
            $timeout(function () {
                $rootScope.$emit('spinner-show', event.id);
            });
        }
        this.joinEvent(event.id).then(function(successResponse) {
                if(type == 'home'){
                    updateEvent(event.id, successResponse.data.event);
                }
                else if(type == 'my-events'){
                    updateOpenEvent(event.id, successResponse.data.event);
                }
                toaster.pop("success", "You have successfully joined the event!");
                $timeout(function() {
                    $rootScope.$emit('spinner-hide', event.id);
                });
            },
            function(errorResponse){
                if(errorResponse.status == 422){
                    toaster.pop("warning", errorResponse.data.message);
                }
                else{
                    toaster.pop("error", "Can't connect to server, please try later!");
                }
                $timeout(function() {
                    $rootScope.$emit('spinner-hide', event.id);
                });
            });
    };

    this.leaveEventAction = function(event, type) {
        this.leaveEvent(event.id).then(function(successResponse) {
            if(type == 'home'){
                updateEvent(event.id, successResponse.data.event);
            }
            else if(type == 'my-events'){
                updateOpenEvent(event.id, successResponse.data.event);
            }
            toaster.pop("success", "You have left event!");
        }, function(errorResponse){
            if(errorResponse.status == 422) {
                toaster.pop("warning", errorResponse.data.message);
            }
            else {
                toaster.pop("error", "Can't connect to server, please try later!");
            }
        });
    };

    this.completeEventAction = function(event, type, tab) {
        $timeout(function() {
            $rootScope.$emit('spinner-show', event.id);
        });
        this.completeEvent(event.id).then(function(successResponse) {
            if(type == 'home'){
                updateEvent(event.id, successResponse.data.event);
            }
            else if(type == 'my-events'){
                updateOpenEvent(event.id, successResponse.data.event);

                var newEvent = successResponse.data.event;
                $rootScope.myClosedEvents.push(newEvent);

                if(tab == "open"){
                    updateOpenEvent(event.id, newEvent);
                    event.is_disabled = true;
                }
                else if(tab == "expired"){
                    updateExpiredEvent(event.id, newEvent);
                    event.is_disabled = false;
                }

                $rootScope.icon = 'closed';
            }
            toaster.pop('success', "You have successfully completed the event!");
            $timeout(function() {
                $rootScope.$emit('spinner-hide', event.id);
            });
        }, function(errorResponse){
            if(errorResponse.status == 422) {
                toaster.pop("warning", errorResponse.data.message);
            }
            else {
                toaster.pop("error", "Can't connect to server, please try later!");
            }
            $timeout(function() {
                $rootScope.$emit('spinner-hide', event.id);
            });
        });
    };

    this.confirmEventAction = function(event, type, tab) {
        this.confirmEvent(event.id).then(function(successResponse) {

            var updated_event = successResponse.data.event.event;

            updated_event.path = event.path;

            var new_achievements = [];

            _.each(successResponse.data.achievements, function(element){
                new_achievements.push(element.achievement);
            });

            if(new_achievements.length > 0){
                $timeout(function() {
                    $rootScope.$emit('achievement-show', new_achievements);
                });
                UserAchievementService.updateUserAchievementsAction(new_achievements)
            }

            if(type == 'home'){
                updateEvent(event.id, updated_event);
            }
            else if(type == 'my-events'){
                updateOpenEvent(event.id, updated_event);
                var newEvent = updated_event;
                $rootScope.myDoneEvents.push(newEvent);

                if(tab == "open"){
                    updateOpenEvent(event.id, newEvent);
                    event.is_disabled = true;
                }
                else if(tab == "closed"){
                    updateClosedEvent(event.id, newEvent);
                    event.is_disabled = true;
                }
                else if(tab == "expired"){
                    updateExpiredEvent(event.id, newEvent);
                    event.is_disabled = false;
                }
                $rootScope.icon = "done";
            }
            self.getCoffeeCounters();

            toaster.pop("success", "You have successfully confirmed the event!");

        }, function(errorResponse){
            if(errorResponse.status == 422){
                toaster.pop("warning", errorResponse.data.message);
            }
            else {
                toaster.pop("error", "Can't connect to server, please try laster!");
            }
        });
    };

    this.expireEventAction = function(event, type) {

        $timeout(function() {
            $rootScope.$emit('spinner-show', event.id);
        });
        $timeout(function(){
            self.expireEvent(event.id).then(function(successResponse) {
                if(type == 'home'){
                    updateEvent(event.id, successResponse.data.event);
                }
                else if(type == 'my-events'){
                    updateOpenEvent(event.id, successResponse.data.event);
                    $rootScope.myExpiredEvents.push(successResponse.data.event);
                    $rootScope.icon = 'expired';
                }
                $timeout(function() {
                    $rootScope.$emit('spinner-hide', event.id);
                });
                toaster.pop("info", "Event of " + successResponse.data.event.owner + " has expired!");

            }, function(errorResponse) {
                toaster.pop("error", "Can't connect to server, please try later!");

                $timeout(function() {
                    $rootScope.$emit('spinner-hide', event.id);
                });
            });
        });

    };

    this.extendEventAction = function(event, type, tab) {
        var time_length = { time_length: event.time_length };
        $timeout(function() {
            $rootScope.$emit('spinner-show', event.id);
        });
        this.extendEvent(event.id, time_length).then(function(successResponse){
            if(type == 'home'){
                updateEvent(event.id, successResponse.data.event);
            }
            else if(type == 'my-events'){
                if(tab == "open"){
                    updateOpenEvent(event.id, successResponse.data.event);
                    event.is_disabled = false;
                }
                else if(tab == "expired"){
                    updateExpiredEvent(event.id, successResponse.data.event);
                    $rootScope.myOpenEvents.push(successResponse.data.event);
                    $rootScope.icon = 'open';
                    event.is_disabled = false;
                }
            }

            event.remaining_time = successResponse.data.event.remaining_time;
            $timeout(function(){
                $rootScope.$broadcast('timer-start');
            });

            toaster.pop("success", "You have successfully extended the event!");
            $timeout(function() {
                $rootScope.$emit('spinner-hide', event.id);
            });
        }, function(errorResponse){
            toaster.pop("error", "Can't connect to server, please try later!");
            $timeout(function() {
                $rootScope.$emit('spinner-hide', event.id);
            });
        });

    };

});
