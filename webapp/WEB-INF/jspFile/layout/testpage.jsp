<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
swal({ title: "Are you sure?", text: "You will not be able
	to recover this imaginary file!", type: "warning", showCancelButton:
	true, confirmButtonColor: "#DD6B55", confirmButtonText: "Yes, delete
	it!", cancelButtonText: "No, cancel plx!", closeOnConfirm: false,
	closeOnCancel: false }, function(isConfirm){ if (isConfirm) {
	swal("Deleted!", "Your imaginary file has been deleted.", "success"); }
	else { swal("Cancelled", "Your imaginary file is safe :)", "error"); }
	});



</body>
</html>