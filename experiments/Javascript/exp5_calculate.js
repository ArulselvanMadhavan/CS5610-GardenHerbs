//var target_date = new Date("Aug 15, 2019").getTime();
function calculateRemainingtime() {
    var input = document.getElementById('due_date');
    var test_input = '<p>' + input + '</p>';
    document.getElementById('test') = test_input;


    // variables for time units
    var days, hours, minutes, seconds;

    // get tag element
    //var countdown = document.getElementById("countdown");

    // update the tag with id "countdown" every 1 second


    // find the amount of "seconds" between now and target
    var target_date = new Date(input).getTime();
    //var target_date = duedate.getTime();
    var current_date = new Date().getTime();
    var seconds_left = (target_date - current_date) / 1000;

    // do some time calculations
    days = parseInt(seconds_left / 86400);
    seconds_left = seconds_left % 86400;

    hours = parseInt(seconds_left / 3600);
    seconds_left = seconds_left % 3600;

    minutes = parseInt(seconds_left / 60);
    seconds = parseInt(seconds_left % 60);

    // format countdown string + set tag value
    var countdown = '<p>' + days + '</p>';

    document.getElementById('countdown').innerHTML = countdown;
    //return remainingtime;


}