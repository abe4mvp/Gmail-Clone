AbeMail.Routers.Emails = Backbone.Router.extend({

  routes: {
    "": 'inbox',
    'messages/sent': 'sent',
    'messages/inbox': 'inbox'
  },

  sent: function () {
    this.getFolder('sent')
  },

  inbox: function () {
    this.getFolder('inbox')
  },


  getFolder: function (folderType) {
    var self = this;
    AbeMail.emails.fetch({
      url: 'messages/' + folderType,
      success: function (coll, resp) {

        var emailIndexView = new AbeMail.Views.EmailsIndex({
          collection: AbeMail.emails
        });

        AbeMail.$mailBox.html(self._swapView(emailIndexView));
      },
      error: function () {
        console.log('surprise mutha-fucka');
      }
    });

  },

  _swapView: function (newView) {
    this._currentView && this._currentView.remove();
    this._currentView = newView;
    AbeMail.$mailBox.html(newView.render().$el);
  }


});
