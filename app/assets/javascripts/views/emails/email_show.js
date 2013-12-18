AbeMail.Views.EmailShow = Backbone.View.extend({
  template: JST['emails/show'],

  render: function () {
    var renderedContent = this.template({
      message: this.model
    });

    this.$el.html(renderedContent);

    return this;
  }

});