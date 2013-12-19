AbeMail.Routers.Emails = Backbone.Router.extend({

  routes: {
    "": 'inbox',
    'messages/sent': 'sent',
    'messages/inbox': 'inbox',
    'messages/favorited': 'favorited',
    'messages/trash': 'trash',
    'messages/:id': 'show'
  },

  show: function (id) {
    var self = this;

    var message = AbeMail.emails.findWhere({id: parseInt(id)});
    message.get('flags').save({read: true}, {
      success: function () {
        var emailShowView = new AbeMail.Views.EmailShow({
          model: message
        });

        AbeMail.$mailBox.html(self._swapView(emailShowView));
      },
      error: function () {
        console.log('y u no read?')
      }
    })
  },



  sent: function () {
    this.getFolder('sent')
  },

  inbox: function () {
    this.getFolder('inbox')
  },

  favorited: function () {
    this.getFolder('favorited')
  },

  trash: function () {
    this.getFolder('trash')
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
    this._currentView && this._currentView.remove(); // && this.cuurentView.leave
    this._currentView = newView;
    AbeMail.$mailBox.html(newView.render().$el);
  }


});
