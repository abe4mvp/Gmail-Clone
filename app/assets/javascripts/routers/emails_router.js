AbeMail.Routers.Emails = Backbone.Router.extend({


  routes: {

    'messages/sent': 'sent',
    'messages/inbox': 'inbox',
    'messages/favorites': 'favorites',
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

  favorites: function () {
    this.getFolder('favorites')
  },

  trash: function () {
    this.getFolder('trash')
  },
	
	search: function () {
		this.getFoler('search')
	}


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
        console.log('mail box fetch error');
      }
    });

  },



  _swapView: function (newView) { //is this actually doing anything??
    this._currentView && this._currentView.remove();//
    this._currentView = newView;
    AbeMail.$mailBox.html(newView.render().$el);
  }


});
