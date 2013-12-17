AbeMail.Views.EmailsIndex = Backbone.View.extend({

  template: JST['emails/index'],

  render: function () {
    var renderedContent = this.template({
      emails: this.collection
    });

    this.$el.html(renderedContent);

    return this;
  }

});
