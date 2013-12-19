AbeMail.Views.EmailsIndex = Backbone.View.extend({
  initialize: function () {
    console.log("init...")
    var self = this;
    renderCallback = this.render.bind(this);
    this.bindTrashSelected();
    this.listenTo(AbeMail.emails, "remove", renderCallback);
  },

  template: JST['emails/index'],

  events: {
    "click .heart": "heart"
  },

  render: function () {
    var renderedContent = this.template({
      emails: this.collection
    });

    this.$el.html(renderedContent);

    return this;
  },



  heart: function (event) {
    var $heart = $(event.currentTarget)
    var rId =  $heart.closest('tr').attr('data-id');
    var message = AbeMail.emails.findWhere({id: parseInt(rId)});
    message.get('flags').toggleAttr('heart').save({}, {
      success: function () {
        $heart.toggleClass('red');
      },
      error: function () {
        console.log('y u no like?')
      }
    });
  },

  bindTrashSelected: function() {
    $("body").off();
    var self = this;
    $("body").on("click","#trash",function(){
      self.trashSelected()
    })
  },

  trashSelected: function () {
    //// fixing this
    var self = this;
    $(':checked').each(function (i) {
      var rId = $(this).closest('tr').attr('data-id');

      self._trash(rId);

    });
  },

  _trash: function (id) {
    var message = AbeMail.emails.findWhere({id: parseInt(id)});
    message.get('flags').toggleAttr('trashed').save({}, {
      success: function () {
        AbeMail.emails.remove(message);
      },
      error: function () {
        console.log('y u no trash?')
      }
    });
  },

  leave: function () {
    $("body").off()
  }

});
