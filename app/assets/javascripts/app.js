//= require angular-animate
//= require angular-resource
//= require angularjs-toaster
//= require angular-ui-bootstrap
//= require angular-ui-bootstrap-tpls

//= require humanize-duration
//= require momentjs
//= require angular-timer

//= require angular-rails-templates
//= require_tree ../angular-templates

angular.module('ccApp', [

    'toaster',
    'ngAnimate',
    'ngResource',
    'ui.bootstrap',
    'templates',
    'timer'

    ]);
