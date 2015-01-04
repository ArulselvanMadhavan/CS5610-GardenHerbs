function calculateRemainingtime() {
    var input = document.getElementById('duedate').value;
    var days, hours, minutes, seconds;
    if (input.length <= 0)
        alert("Please enter a valid date");

    else {

        var duedate = new Date(input);
        var today = new Date();

        if (duedate <= today)
            alert("Due date already passed");
        else {

            setInterval(function () {

                var target_date = new Date(input).getTime();

                var current_date = new Date().getTime();
                var seconds_left = (target_date - current_date) / 1000;


                days = parseInt(seconds_left / 86400);
                seconds_left = seconds_left % 86400;

                hours = parseInt(seconds_left / 3600);
                seconds_left = seconds_left % 3600;

                minutes = parseInt(seconds_left / 60);
                seconds = parseInt(seconds_left % 60);


                var countdown = '<p><b>Time Remaining:</b>' + days + 'd ' + hours + 'h ' + minutes + 'm ' + seconds + 's ' + '</p>';
                document.getElementById('countdown').innerHTML = countdown;
            }, 1000);


        }
    }
}