AbeMail.Views.EmailsIndex = Backbone.View.extend({
  initialize: function () {
    var self = this;
    renderCallback = this.render.bind(this);
    this.bindSelectorFunctions();
    this.listenTo(AbeMail.emails, "remove", renderCallback);
  },

  template: JST['emails/index'],

  events: {
    "click .heart": "heart"
  },

  render: function () {
    var renderedContent = this.template({
      emails: this.collection
    });
	console.log("render")
    this.$el.html(renderedContent);

    return this;
  },



  heart: function (event) {
	
    var $heart = $(event.currentTarget);
    var rId =  $heart.closest('tr').attr('data-id');
    this._heart(rId);
  },
  
  _heart: function (id) {
      var message = AbeMail.emails.findWhere({id: parseInt(id)});
      message.get('flags').toggleAttr('heart').save({}, {
        success: function () {
          renderCallback();
        },
        error: function () {
          console.log('y u no like?')
        }
      });
  },
  
  toggleHeartSelected: function () {
	  this.updateSelected(this._heart)
  },
  

  bindSelectorFunctions: function() {
    $("body").off();
    var self = this;
    $("body").on("click","#trash",function(){
    	self.toggleTrashSelected();
    })
	$("body").on("click", "#heart", function () {
		self.toggleHeartSelected();
	})
	
	
  },

  toggleTrashSelected: function () {
    //// fixing this
    // var self = this;
 //    $(':checked').each(function (i) {
 //      var rId = $(this).closest('tr').attr('data-id');
 // 
 //      self._trash(rId);
 // 
 //    });
 
 	this.updateSelected(this._trash);
  },
  
  updateSelected: function (action) { // helper function that updates all the checked emails the specified function
    //// fixing this
    var self = this;
    $(':checked').each(function (i) {
      var rId = $(this).closest('tr').attr('data-id');

      action(rId);

    });
  },
  

  _trash: function (id) {
    var message = AbeMail.emails.findWhere({id: parseInt(id)});
    message.get('flags').toggleAttr('trashed').save({}, {
      success: function () {
        AbeMail.emails.remove(message);
      },
      error: function () {
        console.log('y u no trash?')
      }
    });
  },

  leave: function () {
    $("body").off()
  }

});
