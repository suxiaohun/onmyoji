function subscript_yys() {
    App.yys = App.cable.subscriptions.create('YysChannel', {
        connected: function () {
            // Called when the subscription is ready for use on the server
            // single_notify("已连接到服务器!", {className: "success", autoHide: false, clickToHide: false});
        },

        disconnected: function () {
            // Called when the subscription has been terminated by the server
            // single_notify("已掉线!", {className: "error", autoHide: false, clickToHide: false});
        },

        received: function (data) {
            // Called when there's incoming data on the websocket for this channel
            // single_notify(data.message, {className: "error", autoHide: false, clickToHide: false});
            console.log(data.message);
            $.notify(data.message, {className: "success", autoHide: false, clickToHide: true, position: 'left'});
        }
    });
}

function subscript_mitama() {
    var obj = $("#chat_btn");
    var v1 = obj.attr("chat");

    if (v1 === "0") {
        App.mitama = App.cable.subscriptions.create('MitamaChannel', {
            connected: function () {
                // Called when the subscription is ready for use on the server
                single_notify("已连接到服务器!", {className: "success", autoHide: false, clickToHide: false});

                obj.attr("chat", "1");
                obj.css('background', 'yellowgreen');
                obj.html("已进入聊天室");
                $("#SendDataContainer").show();
                //notice all users "new user join in the chat"
                App.mitama.send({user: '系统', color: "blue", message: $("#nick_name").html() + '进入聊天室'})
            },

            disconnected: function () {
                // Called when the subscription has been terminated by the server
                single_notify("已掉线!", {className: "error", autoHide: false, clickToHide: false});

            },

            received: function (data) {
                // Called when there's incoming data on the websocket for this channel
                var user = data.user.replace(/\s/g, "&nbsp;");
                if (user == $("#nick_name").html()) {
                    $('#LogContainer').append("<div class='drop-right'>" + user + "</div>");
                    var msg = "<span class='chat_span-right' style='color: " + data.color + "'>" + data.message + "</span>";
                } else {
                    $('#LogContainer').append("<div class='drop-left'>" + user + "</div>");
                    var msg = "<span class='chat_span-left' style='color: " + data.color + "'>" + data.message + "</span>";
                }
                $('#LogContainer').append(msg);
                var LogContainer = document.getElementById("LogContainer");
                LogContainer.scrollTop = LogContainer.scrollHeight;
            }
        });

    } else if (v1 === "1") {
        //notice all users "have user leave in the chat"
        console.log("leave");
        App.mitama.send({user: '系统', color: "grey", message: $("#nick_name").html() + '离开聊天室'});
        App.mitama.unsubscribe();
        obj.attr("chat", "0");
        obj.css('background', 'rgb(221, 221, 221)');
        obj.html("已离开聊天室");

        $('.notifyjs-corner').empty();

        $("#SendDataContainer").hide();
        // count total online users
    }
}

function send_message() {
    var content = tinyMCE.get('DataToSend').getContent();
    console.log(content);
    var msg = content.replace(/<p>&nbsp;<\/p>/g, "").replace(/\n$/g, '').replace(/<p>|<\/p>/g, "");
    console.log(msg);
    if (msg === "") {
        tinyMCE.get('DataToSend').setContent('');
        return false;
    }

    tinyMCE.get('DataToSend').setContent('');
    App.mitama.send({color: "black", message: msg})
}
