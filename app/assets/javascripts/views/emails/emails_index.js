AbeMail.Views.EmailsIndex = Backbone.View.extend({
  initialize: function () {
    var self = this;
    var renderCallback = this.render.bind(this);
    this.listenTo(AbeMail.emails, 'change:flags', renderCallback); //not being triggered
  },

  template: JST['emails/index'],

  events: {
    "click .heart-box" : "heart"
  },

  render: function () {
    var renderedContent = this.template({
      emails: this.collection
    });

    this.$el.html(renderedContent);

    return this;
  },

  heart: function (event) {
    var rId =  $(event.target).closest('tr').attr('data-id');
    var model = AbeMail.emails.findWhere({id: parseInt(rId)});
    model.get('flags').toggleHeart().save();
  }

});
