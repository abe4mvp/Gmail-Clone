$(document).ready(function(){

  $("form.new-chat").on("ajax:success", function(event){
      this.reset();
      $('#chat').removeClass('invisible');

      console.log("ajax success being called")

      if ($('#contacts').hasClass('invisible') === false){
        $('#contacts').addClass('invisible');
      }

    });

    var pusher = new Pusher('<%= ENV["PUSHER_KEY"] %>');

    var currentUser = $('#current-username')[0].innerText.replace(' ', '-');


    //send outgoing chat
    $('#contacts').on("click", "li", function (event) {
      var outgoingName = $(event.currentTarget)[0].innerText.replace(' ', '-');


      console.log("contact click call back being called")
      if ($('#contacts').hasClass('invisible') === false){
        $('#contacts').addClass('invisible');
      }

      $('#contacts').off(); // turn off chat for now

      var namesArr = [outgoingName, currentUser];
      var namesJoined = namesArr.sort().join(';');



      $('#chat_to')[0].value = outgoingName;
      $('#chat').removeClass('invisible');

      //subscribe to your new chat
      var outchannel = pusher.subscribe(outgoingName);
      outchannel.bind('new_chat_message', function(data) {



        $("#chat-log").append(data);
        $("#chat-log").animate({ scrollTop: $('#chat-log').height() }, "slow");

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

      console.log("user subscribing to own channel")
      $('#chat').removeClass('invisible');

//       if (data.indexOf(me) === 4){
//         prefixed = data.replace(me, "me");
//       }
      if ($('#contacts').hasClass('invisible') === false){
        $('#contacts').addClass('invisible');
      }

      $("#chat-log").append(data);

      $("#chat-log").animate({ scrollTop: $('#chat-log').height() }, "slow");

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