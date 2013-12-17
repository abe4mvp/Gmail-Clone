AbeMail.Routers.Emails = Backbone.Router.extend({
  initialize: function () {
    console.log(AbeMail.emails)
    console.log(AbeMail.$mailBox)
  },

  events: {
    'user/:id/sent': 'sent',
    'user/:id/inbox': 'inbox'
  },

  sent: function () {

  }


});
