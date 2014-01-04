window.AbeMail = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {

    AbeMail.$mailBox = $('#mailbox')
    AbeMail.emails = new AbeMail.Collections.Emails(JSON.parse($('#bootstrap-inbox').html()),{parse: true});
    AbeMail.userId = $('#user_id').val(); 
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

  var themes = ["default", "ocean", "titans"]
  var themeNum = 0;

  $('.header-wrap img').on('click', function () {
    $('body').removeClass();
    themeNum += 1;
    if (themeNum === themes.length ){
      themeNum = 0;
    }
    $('body').addClass(themes[themeNum]);


  })

});