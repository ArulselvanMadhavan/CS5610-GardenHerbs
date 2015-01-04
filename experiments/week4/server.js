var express = require('express');
var mongojs = require('mongojs');
 var fileSystem = require('fs');
  var  path = require('path');

var connection_string = '127.0.0.1:27017';
// if OPENSHIFT env variables are present, use the available connection info:
if (process.env.OPENSHIFT_MONGODB_DB_PASSWORD) {
    connection_string = process.env.OPENSHIFT_MONGODB_DB_USERNAME + ":" +
    process.env.OPENSHIFT_MONGODB_DB_PASSWORD + "@" +
    process.env.OPENSHIFT_MONGODB_DB_HOST + ':' +
    process.env.OPENSHIFT_MONGODB_DB_PORT + '/' +
    process.env.OPENSHIFT_APP_NAME;
}
var db = mongojs('admin:P4RixTjlWRjy@cs5610-arulselv.rhcloud.com/rockmongo/cs5610', ["courses"]);

var app = express();       

app.use(express.static(__dirname + '/public'));
app.use(express.bodyParser());
app.get("/songs", function(request,response) {
	var songname = request.query.song
    var filePath = path.join(__dirname, songname);
    var stat = fileSystem.statSync(filePath);
    
    response.writeHead(200, {
        'Content-Type': 'audio/mpeg', 
        'Content-Length': stat.size
    });
    
    var readStream = fileSystem.createReadStream(filePath);
    readStream.on('data', function(data) {
        response.write(data);
    });
    
    readStream.on('end', function() {
        response.end();        
    });
});
app.get("/courselist", function (req, res) {

    var courses = [{
        number: "CS6140",
        title: "Machine learning",
    }, {
        number: "CS5800",
        title: "Algorithms",
    }, {
        number: "CS5500",
        title: "Computer Systems",
    }]
    res.json(courses);
});


app.get("/songlist", function (req, res) {

    var songs= [{
        name: "BILLE JEAN",
    }, 
    {
        number: "CS5800",
        title: "Algorithms",
    }, {
        number: "CS5500",
        title: "Computer Systems",
    }]
    res.json(songs);
});

app.post('/courselist', function (req, res) {
    var crs = req.body;
    console.log(crs);
    db.courses.insert(req.body, function (err, doc) {
        console.log(err);
        console.log(doc);
        res.json(err,doc);
    });
   
});
app.get('/someJson',function(req,res){

	res.json({hello:'world'});
});

app.get('/story.txt', function (req, res) {

    res.json({ hello: 'world' });
});

app.get('/getallEmployees',function(req,res){
	db.employees.find(function(err,data){
		res.json(data);
	});
});


app.get('/CreateEmployee',function(req,res){
	
	console.log(req.query);
	
var  myemp= {
	first: req.query.first,
	last: req.query.last,
	salary: req.query.salary
};

db.employees.insert(myemp,function(err,data){
	console.log(err);
	console.log(data);
	res.json(data);
});
	
});

 var ipaddress = process.env.OPENSHIFT_NODEJS_IP || "127.0.0.1";
 var port      = process.env.OPENSHIFT_NODEJS_PORT || 8080;




app.listen(port,ipaddress);