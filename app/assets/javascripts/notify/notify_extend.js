//单一提示，会清除掉oldnotification
function single_notify(msg,data) {
    $('.notifyjs-corner').empty();
    $.notify(msg,data);
}