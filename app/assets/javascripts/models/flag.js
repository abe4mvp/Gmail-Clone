AbeMail.Models.Flag = Backbone.Model.extend({
  urlRoot: "/flags",


  toggleAttr: function (type) {
    console.log(type);
    console.log(this.get(type));
    var flip = this.get(type) === true ? false : true;
    console.log(flip);
    this.set(type, flip);
    console.log(this.get(type));
    return this;
  },


});
