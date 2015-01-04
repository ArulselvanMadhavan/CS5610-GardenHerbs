<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no, width=device-width" />
    <title>Rate the courses in NEU</title>
    <link rel="stylesheet" href="libs/bootstrap/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="libs/font-awesome/css/font-awesome.min.css" />
    <link rel="stylesheet" href="assets/css/style.css" />

</head>

<body data-ng-app="course-rate-app">

    <script type="text/javascript" src="libs/angular/angular.min.js"></script>
    <script type="text/javascript" src="libs/lodash/dist/lodash.min.js"></script>
    <script type="text/javascript" src="libs/underscore.string/dist/underscore.string.min.js"></script>
    <script type="text/javascript" src="app/app.js"></script>
    <script type="text/javascript" src="app/controller.js"></script>
    <script type="text/javascript" src="app/services.js"></script>
    <script type="text/javascript" src="app/filters.js"></script>
    <script type="text/javascript" src="app/directives.js"></script>

    <!-- Adding a Controller-->
    <div ng-controller="course-rate-ctrl">
        <div class="page-header">
            <h1>Rate the courses</h1>
            <table class="table table-striped table-condensed">
                <thead>
                    <tr>
                        <th>Courses</th>
                    </tr>
                </thead>
                <tbody>
                    <tr ng-repeat="course in courses">
                        <td>
                            <div class="pull-left">
                                <strong>{{course.number}}</strong><br />
                                <small>{{course.title}}</small>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>

        </div>
        <form role="form" data-ng-submit="addcourse(newcourse.number, addcourse.title)">
            <div class="row">
                <div class="col-sm-5">
                    <label class="sr-only" for="number">Number</label>
                     <input type="text" class="form-control" name="number" placeholder="Enter the Course number that you wanna add"
                           data-ng-model="newcourse.number" autofocus />
                         </div>  
                <div class="col-sm-5">
                     <input type="text" class="form-control" name="title" placeholder="Enter the name of the course that you wanna add"
                           data-ng-model="newcourse.title" />
                    </div>
                    <div class="col-sm-2">
                        <button type="submit" class="btn btn-default form-control">Add</button>
                </div>
            </div>
        </form>
    </div>
</body>
</html>
