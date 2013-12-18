AbeMail.Models.Flag = Backbone.Model.extend({
  urlRoot: "/flags",

  toggleHeart: function () {
    var flip = this.get('heart') === true ? false : true;
    this.set({heart: flip});
    return this;
  }


});
