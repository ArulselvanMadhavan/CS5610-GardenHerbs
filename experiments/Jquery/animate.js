$(document).ready(function () {
    $('.touch-area').width($(window).width());
    $('.touch-area').height(60);
    var index = 0;
    $('.touch-area').on('click', function (e) {

        //alert(e.pageX + ' , ' + e.pageY);
        var circle_ident = 'circle_' + index;
        var circle_ident_div = '<div class="circle ' + circle_ident + '"></div>'
        var dot_circle_ident = '.' + circle_ident;

        $('.touch-area').append(circle_ident_div); /* Append the circle div to the touch area div*/
        $(dot_circle_ident).offset({ top: e.pageY, left: e.pageX }); /*Get the co-ordinates of the click event and set it as the current co-ordinates of the circle*/
        $(dot_circle_ident).addClass('expandandfade'); /* Add the expand and fade class to the new created circle div element*/

        setTimeout(function () {
            $(dot_circle_ident).remove(); /* remove the created circle element after 1 sec */
        }, 1000);

        index++;
    });
});