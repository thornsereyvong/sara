<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Balancika | Login</title>
<link rel="SHORTCUT ICON" href="${pageContext.request.contextPath}/resources/images/favicon.png">
<!-- Tell the browser to be responsive to screen width -->
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<!-- Bootstrap 3.3.5 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/dist/css/AdminLTE.min.css">
<!-- iCheck -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/iCheck/square/blue.css">

</head>


<body class="hold-transition login-page">

<div style="" >
<div style="border:1px solid #B9292D;margin-bottom:10px;">
	
</div>
<div class="">

<div class="container" >
	<div class="col-sm-12 text-center">
		<%-- <img src="${pageContext.request.contextPath}/resources/images/logo.png" /> --%>
    </div>
    
    
</div>




</div><!-- Close hidden xs -->
</div>


<div class="login-box">
 <div class="login-logo">
 		<img src="${pageContext.request.contextPath}/resources/images/logo.png" />
        <p>Cambodia</p>
      </div>
  <div class="login-box-body" >
  
  
    <h3 class="login-box-msg">Login AME</h3 >
    
    <form  method="post" >
      <div class="form-group has-feedback">
        <input type="text" class="form-control" placeholder="Username" name="username" required>
         </div>
      <div class="form-group has-feedback">
        <input type="password" class="form-control" placeholder="Password" name="password" required>
         </div>
      <div class="form-group has-feedback">
        <select class="form-control">
        	<option>-- Select Company Name --</option>
           
        </select>
       </div>
      
      	<div class="row">
        	
            <div class="col-sm-4" style="float:right">
              <button type="submit" name="submit" class="btn btn-primary btn-block btn-flat">Sign In</button>
            </div>
       	</div>
    </form>
  </div>
  <img src="${pageContext.request.contextPath}/resources/images/shadow.png" style="width:100%;" />
  <!-- /.login-box-body --> 
</div>
<!-- /.login-box --> 


<div style="background:#fff" id="footer">
<div style="border:1px solid #B9292D;margin-bottom:10px;">
	
</div>
<div class="">

<div class="container" >
	
    <div class="col-sm-5 text-left" style="padding-top:10px;">
    	<p><i class="glyphicon glyphicon-home"></i> No. 105, St. 566, Sangkat Boeung Kak 2, Khan Toul Kork, Phnom Penh</p>
       	<p><i class="glyphicon glyphicon-phone"></i><abbr title="Phone">Tel:</abbr> +855 23 966 609</p>
        <p><i class="glyphicon glyphicon-phone"></i><abbr title="Phone">Tel:</abbr> +855 12 997 373</p>
        
    </div>
</div>

<div class="col-sm-12" style="background:url(${pageContext.request.contextPath}/resources/images/footerstyle-Recovered.jpg) no-repeat;">
  <div class="container">
  	
    <div class="col-sm-12 text-right" style="color:#fff;font-size:12px;">Copyright ©2015 Balancika (Cambodia). All rights reserved.</div>
  </div>
</div>


</div><!-- Close hidden xs -->
</div>
<!-- jQuery 2.1.4 --> 
<script src="${pageContext.request.contextPath}/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script> 
<!-- Bootstrap 3.3.5 --> 
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script> 
<!-- iCheck --> 
<script src="${pageContext.request.contextPath}/resources/plugins/iCheck/icheck.min.js"></script> 
<script>
      $(function () {
        $('input').iCheck({
          checkboxClass: 'icheckbox_square-blue',
          radioClass: 'iradio_square-blue',
          increaseArea: '20%' // optional
        });
      });
    </script>
      <script>

  $(document).ready(function() {

   var docHeight = $(window).height();
   var footerHeight = $('#footer').height();
   var footerTop = $('#footer').position().top + footerHeight;

   if (footerTop < docHeight) {

    //$('#footer').css('margin-top', 20+ (docHeight - footerTop) + 'px');
	$('#footer').css('margin-top', 120+(docHeight - footerTop) + 'px');
   }
  });
 </script>
</body>
</html>
