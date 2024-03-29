function subscript() {
    var obj = $("#chat_btn");
    var v1 = obj.attr("chat");

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
            },

            disconnected: function () {

                single_notify("已掉线!",{ className:"error",autoHide: false,clickToHide: false});
                // Called when the subscription has been terminated by the server
            },

            received: function (data) {
                message_count+=1;
                // var _msg = "<pre style='color:" + data.color + "'><b>" + data.user + ": </b>" + data.message + "</pre>";
                // $('#LogContainer').append(_msg);

                $('#LogContainer').append("<label class='drop' style='display: block;' for='_s"+message_count+"'>"+data.user.replace(/\s/g,"&nbsp;")+"</label>");
                $('#LogContainer').append("<input id='_s"+message_count+"' type='checkbox' style='display: none'>");
                var msg = "<span class='chat_span' style='color: "+data.color+"'>"+data.message+"</span>";

                $('#LogContainer').append(msg);
                var LogContainer = document.getElementById("LogContainer");
                LogContainer.scrollTop = LogContainer.scrollHeight;

                // Called when there's incoming data on the websocket for this channel
            }
        });

    } else if (v1 === "1") {

        // alert(1);
        App.chat.unsubscribe();
        obj.attr("chat", "0");
        obj.css('background', 'rgb(221, 221, 221)');
        obj.html("已离开聊天室");
        $('.notifyjs-corner').empty();

        $("#SendDataContainer").hide();
        // count total online users
    }
}

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

function unsubscribe_yys() {
    App.yys.unsubscribe();
    console.log('取消订阅')
}

function disconnect_yys() {
    App.cable.disconnect();
    console.log('断开链接')
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
    App.chat.send({color: "black", message: msg})
}


var message_count = 0;

function subscript_push() {

    App.chat = App.cable.subscriptions.create("PushChannel", {
        connected: function () {
            single_notify("已连接到服务器!", {className: "success", autoHide: false, clickToHide: false});
            // Called when the subscription is ready for use on the server
            var msg = "<div class='chat_span' style='color:blue'>" + "anonymous： 开始监听推送事件" + "</div>";
            $('#LogContainer').append(msg)
        },

        disconnected: function () {

            single_notify("已掉线!", {className: "error", autoHide: false, clickToHide: false});
            // Called when the subscription has been terminated by the server
        },

        received: function (data) {
            message_count += 1;

            $('#LogContainer').append("<label class='drop' style='display: block;' for='_s" + message_count + "'>" + data.user.replace(/\s/g, "&nbsp;") + "</label>");
            $('#LogContainer').append("<input id='_s" + message_count + "' type='checkbox' style='display: none'>");
            var msg = "<span class='chat_span' style='color: " + data.color + "'>" + data.message + "</span>";

            $('#LogContainer').append(msg);
            var LogContainer = document.getElementById("LogContainer");
            LogContainer.scrollTop = LogContainer.scrollHeight;

        }
    });
}