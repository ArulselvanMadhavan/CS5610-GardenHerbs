angular.module("course-rate-app.controllers", []).controller("course-rate-ctrl", function ($scope) {
    $scope.courses = [{
        number: "CS5610",
        title: "Web Development",
    }, {
        number: "CS5010",
        title: "Program Design Paradigm",
    }, {
        number: "CS6200",
        title: "Information Retrieval",
    }]
    $scope.newcourse = {};
    $scope.addcourse = function (number, title) {
        $scope.courses.push({
            number: number,
            title: title,
            score: 0
        });
       
        $scope.newcourse.title = "";
        $scope.newcourse.number = "";
    };
    $scope.deletecourse = function (idx) {
        $scope.courses.splice(idx, 1);
    };
    $scope.isEmpty = function (str) {
        return _.isBlank(str);
    };
    _.mixin(_.string.exports());
});