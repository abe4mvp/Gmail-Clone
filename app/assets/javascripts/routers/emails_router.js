AbeMail.Routers.Emails = Backbone.Router.extend({

  routes: {
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
    var emailIndex = new AbeMail.Collections.Emails();
    emailIndex.fetch({
      url: 'messages/' + folderType,
      success: function (coll, resp) {
        var emailIndexView = new AbeMail.Views.EmailsIndex({
          collection: emailIndex
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
    this.$rootEl.html(newView.render().$el);
  }


});
