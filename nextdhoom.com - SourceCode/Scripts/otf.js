var getPage=function()
{
    var $a = $(this);
    var options = {
        url: $a.attr("href"),
        type: "get"
    };

    $.ajax(options).done(function (data) {
        var target = $a.parents("div.pagedList").attr("data-otf-target");
        $(target).replaceWith(data);
    });
    return false;
}
$(".table").one("click", ".pagedList a", getPage);