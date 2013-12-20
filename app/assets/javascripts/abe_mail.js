window.AbeMail = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {

    AbeMail.$mailBox = $('#mailbox')
    AbeMail.emails = new AbeMail.Collections.Emails(JSON.parse($('#bootstrap-inbox').html()),{parse: true});
    AbeMail.userId = $('#user_id').val(); // better way to do this?
    var emailIndexView = new AbeMail.Views.EmailsIndex({
      collection: AbeMail.emails
    });

    AbeMail.$mailBox.html(emailIndexView.render().$el);

    new AbeMail.Routers.Emails();


    Backbone.history.start();
  }
};

$(document).ready(function(){
  AbeMail.initialize();

  $('.drag-me').draggable();

  $('#compose').on('click', function () {
    $('#new-email').toggleClass('invisible')
  });


  $('.header-wrap img').on('click', function () {
    $('body').toggleClass('ocean');
  })

});