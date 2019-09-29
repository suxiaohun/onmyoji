var message_count = 0;
function subscript() {
    var obj = $("#chat_btn");
    var v1 = obj.attr("chat");
    // var v2 = obj.attr("sama");

    // if(v2==="1"){
    //     obj.removeAttr("sama");
    //     App.chat = App.cable.subscriptions.create("ChatChannel", {
    //         connected: function () {
    //             // Called when the subscription is ready for use on the server
    //             obj.attr("chat", "1");
    //             obj.css('background', 'yellowgreen');
    //             obj.html("connecting");
    //             $("#SendDataContainer").show();
    //             //notice all users "new user join in the chat"
    //             user_join();
    //         },
    //
    //         disconnected: function () {
    //             // Called when the subscription has been terminated by the server
    //         },
    //
    //         received: function (data) {
    //             var _msg = "<pre style='color:" + data.color + "'><b>" + data.user + ": </b>" + data.message + "</pre>";
    //             $('#LogContainer').append(_msg);
    //             var LogContainer = document.getElementById("LogContainer");
    //             LogContainer.scrollTop = LogContainer.scrollHeight;
    //
    //             // Called when there's incoming data on the websocket for this channel
    //         }
    //     });
    //     return false;
    // }


    if (v1 === "0") {

        // App.cable.open()

            App.chat = App.cable.subscriptions.create("ChatChannel", {
                connected: function () {
                    single_notify("已连接到服务器!",{ className:"success",autoHide: false,clickToHide: false});

                    // Called when the subscription is ready for use on the server
                    obj.attr("chat", "1");
                    obj.css('background', 'yellowgreen');
                    obj.html("已进入聊天室");
                    $("#SendDataContainer").show();
                    //notice all users "new user join in the chat"
                    user_join();
                },

                disconnected: function () {

                    single_notify("已掉线!",{ className:"error",autoHide: false,clickToHide: false});
                    // Called when the subscription has been terminated by the server
                },

                received: function (data) {
                    message_count+=1;
                    // var _msg = "<pre style='color:" + data.color + "'><b>" + data.user + ": </b>" + data.message + "</pre>";
                    // $('#LogContainer').append(_msg);

                    $('#LogContainer').append("<label class='drop' style='display: block;' for='_s"+message_count+"'>"+data.user+"</label>");
                    $('#LogContainer').append("<input id='_s"+message_count+"' type='checkbox' style='display: none'>");
                    var msg = "<span class='chat_span' style='color: "+data.color+"'>"+data.message+"</span>";

                    $('#LogContainer').append(msg);
                    var LogContainer = document.getElementById("LogContainer");
                    LogContainer.scrollTop = LogContainer.scrollHeight;

                    // Called when there's incoming data on the websocket for this channel
                }
            });

        // obj.attr("chat", "1");
        // obj.css('background', 'yellowgreen');
        // obj.html("connecting");
        // $("#SendDataContainer").show();
        // user_join();
    } else if (v1 === "1") {

        // alert(1);
        App.chat.unsubscribe();
        obj.attr("chat", "0");
        obj.css('background', 'rgb(221, 221, 221)');
        obj.html("已离开聊天室");
        $('.notifyjs-corner').empty();

        $("#SendDataContainer").hide();
        // count total online users
        user_leave();
    }
}

function send_message() {

    var obj = $("#DataToSend");
    // console.log(tinyMCE.get('DataToSend').getContent());
    // var msg = tinyMCE.get('DataToSend').getContent().replace(/(\s*$)/g, "");
    // var msg = tinyMCE.get('DataToSend').getContent().replace(/(&nbsp;)*/g, "").replace(/(<p>)*/g, "").replace(/<(\/)?p[^>]*>/g, "").replace(/(\s*$)/g, "");
    var msg = tinyMCE.get('DataToSend').getContent().replace(/<p>&nbsp;<\/p>/, "");


    if (msg==="") return false;

    tinyMCE.get('DataToSend').setContent('');
    App.chat.send({ color:"black", message: msg })

    // $.post('/messages', {msg: msg}, function (result) {
    //     $("#DataToSend").val('').focus();
    // })
}


function user_join() {
    // App.chat.send({ color:"blue", message: "msg" })
    $.get('/chat_rooms/join',{},function f() {

    })
}

function user_leave() {
    $.get('/chat_rooms/leave',{},function f() {

    })
}