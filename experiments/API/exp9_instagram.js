var limit = 4;
var setSize = "medium";

var instagram = function () {
    return {
        init: function () {
            instagram.loadImages();
        },
        loadImages: function () {
            var getImagesURL = "https://api.instagram.com/v1/tags/" + "books" + "/media/recent?client_id=5e71f907b7df4be5a4e57aa042f80259";
            $.ajax({
                type: "GET",
                dataType: "jsonp",
                cache: false,
                url: getImagesURL,
                success: function (data) {
                    for (var i = 0; i < limit ; i += 1) {
                        if (setSize == "small") {
                            var size = data.data[i].images.thumbnail.url;
                        } else if (setSize == "medium") {
                            var size = data.data[i].images.low_resolution.url;
                        } else {
                            var size = data.data[i].images.standard_resolution.url;
                        }
                        $(".instagram").append("<div  class='grid" + i + "'><a target='_blank' href='" + data.data[i].link + "'><img src='" + size + "' alt='" + data.data[i].caption.text + "'/><span>" + data.data[i].user.username + "</span></a></div>");
                    }
                }
            });
        }
    }
}();

$(document).ready(function () {
    instagram.init();

    $("#refresh").on("click", function () {
        $(".instagram").empty();
        instagram.init();
    });
});