AbeMail.Views.EmailsIndex = Backbone.View.extend({
  initialize: function () {
    var self = this;
    var renderCallback = this.render.bind(this);

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
    message.get('flags').toggleHeart().save({}, {
      success: function () {
        $heart.toggleClass('red');
      },
      error: function () {
        console.log('y u no like?')
      }
    });
  }

});
