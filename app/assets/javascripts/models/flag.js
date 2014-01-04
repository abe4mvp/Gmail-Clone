AbeMail.Models.Flag = Backbone.Model.extend({
  urlRoot: "/flags",


  toggleAttr: function (type) {
    var flip = this.get(type) === true ? false : true;
    
    this.set(type, flip);

    return this;
  },


});
