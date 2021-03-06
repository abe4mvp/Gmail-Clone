AbeMail.Views.EmailsIndex = Backbone.View.extend({
  initialize: function () {
    
    this.bindSelectorFunctions();

  },

  template: JST['emails/index'],


  render: function () {
    var renderedContent = this.template({
      emails: this.collection
    });
	console.log("render")
    this.$el.html(renderedContent);

    return this;
  },
  
  updateAll: function (attribute, successCallback, reRender) { // update the specified attribute for all selected emails, pass down the succcess callback 
    var self = this;
    $(':checked').each(function () {
      var rId = $(this).closest('tr').attr('data-id');

      self.updateIndividual(rId, successCallback, attribute);

    });
		
		if (reRender) this.render();
  },
  
  updateIndividual: function (id, successCallback, attribute) {
      var message = AbeMail.emails.findWhere({id: parseInt(id)});
      message.get('flags').toggleAttr(attribute).save({}, {
        
				success: successCallback(id, message),

        error: function () {
          console.log('error trying to change' + attribute + " for message #" + id)
        }
      });
  },
  
  bindSelectorFunctions: function() {
  	$("body").off();
		$("#mailbox").off();
    var self = this;
	
    $("body").on("click","#trash",function(){
    	self.toggleTrashSelected();
    });
	
		$("body").on("click", "#heart", function () {
			self.toggleHeartSelected();
		});
	
		$("body").on("click", "#read", function () {
			self.toggleReadSelected();
		});
	
		$("#mailbox").on("click", ".heart-box", function (event) {
		    var $heart = $(event.currentTarget);
		    var rId =  $heart.closest('tr').attr('data-id');
		    self.updateIndividual(rId, self.toggleHeart, "heart");
			});
	
     $("body").on("click", "#all", function () {
     		self.selectAll()
     });
		 
		 $("body").on("click", "#none", function () {
			 self.deselectAll();
		 });
  },

	selectAll: function () {
		$(":checkbox").prop("checked", true)
	},
	
	deselectAll: function () {
		$(":checkbox").prop("checked", false)
	},

	
	toggleHeart: function (id) {
		$("tr[data-id=" + id + "] .heart").toggleClass('red');
	},
  
  toggleHeartSelected: function () {

	  this.updateAll("heart", this.toggleHeart)
  },
  


  
  toggleReadSelected: function () {
		var success = function (id) {
			$("tr[data-id=" + id + "]").toggleClass('unread');
		}
	  this.updateAll("read", success);
  },

  

  toggleTrashSelected: function () {

		var success = function (id, message) {
			AbeMail.emails.remove(message);  
			
		}
		
	 	this.updateAll("trashed", success, true );
  },
  

  leave: function () {
    $("body").off()
  }

});
