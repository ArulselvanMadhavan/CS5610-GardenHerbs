

$(function(){
$("input").focus();
$("input").keyup(function () {
    var movie = $(this).val();
    $.getJSON("http://www.omdbapi.com/?t=" + movie + "&r=json", function (data) {
        var poster = data.Poster;
        var title = data.Title;
        var year = data.Year;
        var rating = data.imdbRating;
        var actors = data.Actors;
        var plot = data.Plot;
        $("img").attr("src", poster);
        $("#title").text(title);
        $("#year").text(year);
        $("#rating").text(rating);
        $("#actors").text(actors);
        $("#plot").text(plot);
    });
});
});