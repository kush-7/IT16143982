<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<title>Health System</title>
	
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/croppie.js"></script>
    <link rel="stylesheet" href="assets/css/croppie.css" />

    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.js"></script>
	<style type="text/css">
        .my-error-class {
            color:red;
        }
        .my-valid-class {
            color:green;
        }
    </style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    	<div class="container">
	        <a class="navbar-brand" href="appointmentList.jsp">Health System</a>
	        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	            <span class="navbar-toggler-icon"></span>
	        </button>
	
	        <div class="collapse navbar-collapse" id="navbarSupportedContent">
	            <ul class="navbar-nav ml-auto">
	                <li class="nav-item">
	                    <a class="nav-link" href="logoutServlet">Logout</a>
	                </li>
	            </ul>
	
	        </div>
        </div>
	</nav>
    <div class="container">
		
<br>
<p></p>
		<main class="login-form">
	        <div class="row justify-content-center">
	            <div class="col-md-8">
	                <div class="card">
	                    <div class="card-header bg-dark text-light">Appointments</div>
	                    <div class="card-body">
	                        <form id="appointments">
	                            <div class="form-group row">
	                                <label for="email_address" class="col-md-4 col-form-label text-md-right">Patient Name</label>
	                                <div class="col-md-6">
	                                    <input type="text" id="name" class="form-control" name="name">
	                                </div>
	                            </div>
	                            
	                            <div class="form-group row">
	                                <label for="email_address" class="col-md-4 col-form-label text-md-right">Patient age</label>
	                                <div class="col-md-6">
	                                    <input type="number" id="age" class="form-control" name="age">
	                                </div>
	                            </div>
	                            
	                            <div class="form-group row">
	                                <label for="email_address" class="col-md-4 col-form-label text-md-right">Patient Gender</label>
	                                <div class="col-md-6">
	                                    <select name="gender" class="form-control" id="gender">
	                                		<option value="">Select</option>
	                                		<option value="Male">Male</option>
	                                		<option value="Female">Female</option>
	                                	</select>
	                                </div>
	                            </div>
	                            
	                            <div class="form-group row">
	                                <label for="email_address" class="col-md-4 col-form-label text-md-right">Doctor Name</label>
	                                <div class="col-md-6">
	                                	<select class="form-control" id="doctor" name="doctor">
	                                		<option value="">Select</option>
	                                		<option value="d1">doctor 1</option>
	                                	</select>
	                                </div>
	                            </div>
	                            
	                            <div class="form-group row">
	                                <label for="email_address" class="col-md-4 col-form-label text-md-right">Date</label>
	                                <div class="col-md-6">
	                                    <input type="date" id="date" class="form-control" name="date">
	                                </div>
	                            </div>
	                            
	                            <div class="form-group row">
	                                <label for="email_address" class="col-md-4 col-form-label text-md-right">Time</label>
	                                <div class="col-md-6">
	                                    <input type="time" id="time" class="form-control" name="time">
	                                </div>
	                            </div>
	                            
	                            <div class="form-group row">
	                                <label for="email_address" class="col-md-4 col-form-label text-md-right">Hospital</label>
	                                <div class="col-md-6">
	                                    <select class="form-control" id="hospital" name="hospital">
	                                		<option value="">Select</option>
	                                		<option value="h1">hospital 1</option>
	                                	</select>
	                                </div>
	                            </div>
	                            
	                            <div class="col-md-6 offset-md-4">
	                                <button type="submit" class="btn btn-success">
	                                    Add
	                                </button>
	                                <a href="appointmentList.jsp" class="btn btn-success">
	                                    List
	                                </a>
	                            </div>
	                    	</form>
	                    </div>
	                </div>
	            </div>
	        </div>
		</main>
	</div>

</body>
</html>
<script>

$(document).ready(function () {

    $("#appointments").validate({
        errorClass: "my-error-class",
        validClass: "my-valid-class",
        rules: {
        	name: "required",
        	hospital: "required",
        	doctor: "required",
            gender: "required",
            age: {
                number: true,
                required: true
            },
        	date: "required",
        	time: "required"
        },
        messages: {
        	name: "Patient Name Required!",
        	hospital: "Select Hospital Required!",
        	doctor: "Select Doctor Required!",
        	gender: "Gender Required!",
        	age: {
                number: "only numbers!",
                required: "Age Required!"
            },
        	date: "Date Required!",
        	time: "Time Required!"
        },
        submitHandler: function () {
            var datas = JSON.stringify({
                "name" : $('#name').val(),
                "hname" : $('#hospital').val(),
                "gender" : $('#gender').val(),
                "age" : $('#age').val(),
                "date" : $('#date').val(),
                "time" : $('#time').val(),
                "dname" : $('#doctor').val()
            });

            $.ajax({
                type: "POST",
                url: 'app/appointment',
                dataType : 'json',
				contentType : 'application/json',
				data: datas,
                success: function(data){
                	if(data['success']=="1"){
                		alert("Added Successfull!");
                        $("#appointments")[0].reset();
					}
                },
                failure: function(errMsg) {
                	alert("Connection Error!");
                }
            });
        }
    });

    $("#appointments").submit(function(e) {
        e.preventDefault();
    });

});

</script>