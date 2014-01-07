$(document).ready(function(){

  $("form.new-chat").on("submit", function(){
		setTimeout(function(){
			$("#chat-text").val("");
		}
		,10)
		
   });

    

    var currentUser = $('#current-username')[0].innerText.replace(' ', '-');


    //send outgoing chat
    $('#contacts').on("click", "li", function (event) {
      var outgoingName = $(event.currentTarget)[0].innerText.replace(' ', '-');


      console.log("contact click call back being called")
      if ($('#contacts').hasClass('invisible') === false){
        $('#contacts').addClass('invisible');
      }

      $('#contacts').off(); 

      $('#chat_to')[0].value = outgoingName;
      $('#chat').removeClass('invisible');
			$('#chat-text').focus();

      //subscribe to your new chat
      var outchannel = pusher.subscribe(outgoingName);
      outchannel.bind('new_chat_message', function(data) {



        $("#chat-log").append(data);
        $("#chat-log").animate({ scrollTop: $('#chat-log').prop("scrollHeight") }, "slow");

        var $newewstChat =  $('#chat-log li:last-child')
        if ($newewstChat.hasClass(currentUser)){
          $newewstChat.removeClass(currentUser);
          $newewstChat.addClass('me');
        } else {
          $newewstChat.removeClass();
          $newewstChat.addClass('them')
        }
      });

    });


    //listen for incoming messages
    var mychannel = pusher.subscribe(currentUser);
    mychannel.bind('new_chat_message', function(data) {
      $('#chat_to')[0].value = currentUser;

      console.log("data")
      $('#chat').removeClass('invisible');


      if ($('#contacts').hasClass('invisible') === false){
        $('#contacts').addClass('invisible');
      }

      $("#chat-log").append(data);

			
       $("#chat-log").animate({ scrollTop: $('#chat-log').prop("scrollHeight") }, "slow");

      var $newewstChat =  $('#chat-log li:last-child')
      if ($newewstChat.hasClass(currentUser)){
        $newewstChat.removeClass(currentUser);
        $newewstChat.addClass('me');
      } else {
        $newewstChat.removeClass();
        $newewstChat.addClass('them')
      }


    });
});