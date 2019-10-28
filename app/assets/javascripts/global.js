$(function () {

    $("a[rel=modal]").on("click", function (e) {
        e.preventDefault();
        var href = $(this).attr('href');

        openModal(href);
    });
});

function openModal(href) {
    var modalTitle = "loading",
        modalDialog = $("#linkModal");
    if (modalDialog.length == 0) {
        modalDialog = buildModal();
        $('body').append(modalDialog);
    } else {
        $(".modal-footer", modalDialog).html("");
    }
    $(".modal-header h3", modalDialog).text(modalTitle);
    modalDialog.html('');//清空原有内容，否则一闪而过体验不好
    modalDialog.modal('show');
    // return
    if (href.indexOf('#') == 0) {
        modalDialog.html($(href).html())
    } else {
        href += href.indexOf("?") > 0 ? "&_dom_id=null" : "?_dom_id=null";
        modalDialog.load(href);
    }
}

function buildModal() {
    return $('<div class="modal" id="linkModal" tabindex="-1" role="dialog" data-backdrop="static"></div>');
}
