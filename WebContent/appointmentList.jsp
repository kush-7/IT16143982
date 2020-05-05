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
	 
    <style>

        .elementz {
            border:none;
            background-image:none;
            background-color:transparent;
            -webkit-box-shadow: none;
            -moz-box-shadow: none;
            box-shadow: none;
            outline: none;
            -webkit-appearance: none;
            color: #000;
        }

        /* The Modal (background) */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            padding-top: 100px; /* Location of the box */
            left: 0;
            top: 0;
            width: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0, 0, 0); /* Fallback color */
            background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
        }

        /* Modal Content */
        .modal-content1 {
            background-color: #fefefe;
            margin: auto;
            width: 40%;
            height: 80%;
            overflow-y: scroll;
            padding: 20px;
            border: 1px solid #888;
        }

        /* The Close Button */
        .close1 {
            color: #aaaaaa;
            float: right;
            margin-left: 95%;
            font-size: 28px;
            font-weight: bold;
        }

        .close1:hover,
        .close1:focus {
            color: #000;
            text-decoration: none;
            cursor: pointer;
        }

        .btn-file {
            position: relative;
            overflow: hidden;
        }
        .btn-file input[type=file] {
            position: absolute;
            top: 0;
            right: 0;
            min-width: 100%;
            min-height: 100%;
            font-size: 100px;
            text-align: right;
            filter: alpha(opacity=0);
            opacity: 0;
            outline: none;
            background: white;
            cursor: inherit;
            display: block;
        }

        #img-upload{
            width: 100%;
        }

        .my-error-class {
            color: red;
        }

        .my-valid-class {
            color: green;
        }
    </style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    	<div class="container">
	        <a class="navbar-brand" href="appointment.jsp">Health System</a>
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
	            <div class="col-md-10">
	                <div class="card">
	                    <div class="card-header bg-dark text-light">Visit List</div>
	                    <div class="card-body">
	                        <div class="p-1" id="usersDiv">
	                    	
	            			</div>
	                    </div>
	                </div>
	            </div>
	        </div>
		</main>
	</div>

</body>
</html>
<div id="popupEdit" class="modal">
    <div class="modal-content1" style="height: 70%">
        <span class="close">&times;</span>
        <br>
        <div class="col-md-12">
            <form  id="editForm">
                <input type="hidden" id="edit_id">
                <div class="form-group">
                    <label for="Email">Patient Name</label>
                    <input type="text" id="e_name" class="form-control" name="e_name">
                </div>
                <div class="form-group">
                    <label for="Email">Patient Age</label>
                    <input type="number" id="age" class="form-control" name="age">
                </div>
                <div class="form-group">
                    <label for="Email">Patient Gender</label>
                    <select name="gender" class="form-control" id="gender">
                   		<option value="">Select</option>
                   		<option value="Male">Male</option>
                   		<option value="Female">Female</option>
                   	</select>
                </div>
                <div class="form-group">
                    <label for="Email">Doctor Name</label>
                    <select class="form-control" id="doctor" name="doctor">
                  		<option value="">Select</option>
                  		<option value="d1">doctor 1</option>
                  	</select>
                </div>
                <div class="form-group">
                    <label for="Email">Date</label>
                    <input type="date" id="date" class="form-control" name="date">
                </div>
                <div class="form-group">
                    <label for="Email">Time</label>
                    <input type="time" id="time" class="form-control" name="time">
                </div>
                <div class="form-group">
                    <label for="Email">Hospital</label>
                   	<select class="form-control" id="hospital" name="hospital">
                   		<option value="">Select</option>
                   		<option value="h1">hospital 1</option>
                   	</select>
                </div>
                <input type="submit" value="Submit" class="btn btn-primary">
            </form>
        </div>
    </div>
</div>

<script>

    var popupEdit = document.getElementById("popupEdit");

    var span = document.getElementsByClassName("close")[0];

    span.onclick = function () {
        popupEdit.style.display = "none";
    }
    
    function deletes(id) {

    	$.ajax({
            type: "DELETE",
            url: "app/appointment",
            data: JSON.stringify({ 'id' : id}),
            dataType: "json",
			contentType : 'application/json',
            success: function(data){
            	if(data['success']=="1"){
            		alert("Delete Successfull!");
					reload();
				}else if(data['success']=="0"){
					alert("Delete Unsuccessful!");
				}
            },
            failure: function(errMsg) {
                alert('Error');
            }
        });

        
    }

    $(document).ready(function () {

        $("#editForm").validate({
            errorClass: "my-error-class",
            validClass: "my-valid-class",
            rules: {
            	e_name: "required",
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
            	e_name: "Patient Name Required!",
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
                    "id" : $('#edit_id').val(),
                    "name" : $('#e_name').val(),
                    "hname" : $('#hospital').val(),
                    "gender" : $('#gender').val(),
                    "age" : $('#age').val(),
                    "date" : $('#date').val(),
                    "time" : $('#time').val(),
                    "dname" : $('#doctor').val()
                });

                $.ajax({
                    type: "PUT",
                    url: 'app/appointment',
                    dataType : 'json',
    				contentType : 'application/json',
    				data: datas,
                    success: function(data){
                    	if(data['success']=="1"){
                    		alert("Edit Successfull!");
                            $("#editForm")[0].reset();
    						popupEdit.style.display = "none";
    						reload();
    					}else if(data['success']=="0"){
    						alert("Unsuccessful!");
    					}
                    },
                    failure: function(errMsg) {
                    	alert("Connection Error!");
                    }
                });
            }
        });

        $("#editForm").submit(function(e) {
            e.preventDefault();
        });

    });

    
    
    
    
    function reload(){
    	$.ajax({
            type: "GET",
            url: "app/appointment",
            success: function(data){
            	$("#usersDiv").html(data);
            },
            failure: function(errMsg) {
                alert('Error');
            }
        });
    }

    reload();
    
    
    
    
    
    
    
    
    
    
    
    
    
    function edit(id) {

    	$.ajax({
            type: "POST",
            url: "app/appointment/get",
            data: JSON.stringify({ 'id' : id}),
            dataType: "json",
			contentType : 'application/json',
            success: function(data){
                $(e_name).val(data['name']),
                $(gender).val(data['gender']),
                $(age).val(data['age']),
                $(hospital).val(data['hname']),
                $(time).val(data['time']),
                $(date).val(data['date']),
                $(edit_id).val(data['id']),
                $(doctor).val(data['dname']),
                popupEdit.style.display = "block";
            },
            failure: function(errMsg) {
                alert('Error');
            }
        });

        
    }
    
    
</script>