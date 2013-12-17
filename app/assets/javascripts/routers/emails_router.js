AbeMail.Routers.Emails = Backbone.Router.extend({
  initialize: function () {
    // console.log(AbeMail.emails);
    // console.log(AbeMail.$mailBox);
  },

  routes: {
    'messages/sent': 'sent',
    'messages/inbox': 'inbox'
  },

  sent: function () {
    var emailIndex = new AbeMail.Collections.Emails();
    emailIndex.fetch({
      url: 'messages/sent',
      success: function (coll, resp) {
        var emailIndexView = new AbeMail.Views.EmailsIndex({
          collection: emailIndex
        });
        AbeMail.$mailBox.html(emailIndexView.render().$el);
      },
      error: function () {
        console.log('surprise mutha-fucka');
      }
    });
  }


});
