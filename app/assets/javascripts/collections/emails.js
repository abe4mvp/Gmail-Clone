AbeMail.Collections.Emails = Backbone.Collection.extend({

  model: AbeMail.Models.Email,
  parse: function (response) {
    response.forEach(function (model) {
      model.flags = new AbeMail.Models.Flag(model.flags[0])
    })

    return response;
  }


});
