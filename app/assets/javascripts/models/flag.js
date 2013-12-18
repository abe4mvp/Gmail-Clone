AbeMail.Models.Flag = Backbone.Model.extend({
  // urlRoot: "/flags",

  url: function () {
    return "/flags/" + this.get('id')
  },

  toggleHeart: function () {
    var flip = this.get('heart') === true ? false : true;
    this.set({heart: flip});
    return this;
  }


});
