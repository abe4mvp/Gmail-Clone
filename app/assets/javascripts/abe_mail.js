window.AbeMail = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {

    AbeMail.$mailBox = $('#mailbox')
    AbeMail.emails = new AbeMail.Collections.Emails(JSON.parse($('#bootstrap-inbox').html()),{parse: true});
    AbeMail.userId = $('#user_id').val(); // better way to do this?

    new AbeMail.Routers.Emails();


    Backbone.history.start();
  }
};

$(document).ready(function(){
  AbeMail.initialize();
});