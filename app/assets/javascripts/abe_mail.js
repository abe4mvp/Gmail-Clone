window.AbeMail = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    alert('Hello from Backbone!');


    Backbone.history.start();
  }
};

$(document).ready(function(){
  AbeMail.initialize();
});
