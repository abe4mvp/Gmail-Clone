AbeMail.Collections.Emails = Backbone.Collection.extend({
  initialize: function (url_ext) {
    this.url += url_ext
  },
  model: AbeMail.Models.Email,
  url: '/users'

});
