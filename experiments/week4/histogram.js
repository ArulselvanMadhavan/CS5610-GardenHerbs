var canvas = document.querySelector('canvas');
fitToContainer(canvas);

function fitToContainer(canvas){
  // Make it visually fill the positioned parent
  canvas.style.width ='100%';
  canvas.style.height='100%';
  // ...then set the internal size to match
  canvas.width  = canvas.offsetWidth;
  canvas.height = canvas.offsetHeight;
}

angular.module("app", []).controller("myctrl", function($scope) {
  
  $scope.input = true;
  $scope.showInput = function(b) {
    $scope.input = b;
  };
  
  $scope.data = '0, 2, 14, 6, 8';
  
  $scope.$watch( 'data', function() {
  
    var data = $scope.data.split(',');
    var labels = $scope.data.split(',');

    // The array is a string array, turning it to a float array.
    for (a in data) {
      data[a] = parseFloat(data[a], 10);
    };
  
    var data = {
      labels : labels,
      datasets : [{
        fillColor : "steelblue",
        data : data
      }]
    };

    //Get context with jQuery - using jQuery's .get() method.
    var ctx = $("#myChart").get(0).getContext("2d");
    //This will get the first returned node in the jQuery collection.
    var myNewChart = new Chart(ctx).Bar(data);
  });
});
