window.AbeMail = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    AbeMail.$mailBox = $('#mailbox')
    AbeMail.emails = new AbeMail.Collections.Emails();
    AbeMail.userId = $('#user_id').val();
    

    new AbeMail.Routers.Emails();


    Backbone.history.start();
  }
};

$(document).ready(function(){
  AbeMail.initialize();
});