/// <reference path="login.js" />
$(document).ready(function () {
    $('#login-trigger').click(function () {
        //slideToggle Function method - > Display or hide the matched elements with a sliding motion.
        $(this).next('#login-content').slideToggle(); 
        $(this).toggleClass('active');

        if ($(this).hasClass('active')) $(this).find('span').html('&#65514;')
        else $(this).find('span').html('&#65516;')
    })
});