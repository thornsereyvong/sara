<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>

<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
    <!-- Morris.js charts -->
    <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script> -->
    <!--<script src="<?=$server?>admin/plugins/morris/morris.min.js"></script>
-->    <!-- Sparkline -->
 	
    <script src="${pageContext.request.contextPath}/resources/plugins/sparkline/jquery.sparkline.min.js"></script>
    <!-- jvectormap -->
    <script src="${pageContext.request.contextPath}/resources/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
    <!-- jQuery Knob Chart -->
    <script src="${pageContext.request.contextPath}/resources/plugins/knob/jquery.knob.js"></script>
    <!-- daterangepicker -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/plugins/daterangepicker/daterangepicker.js"></script>
    <!-- datepicker -->
    <script src="${pageContext.request.contextPath}/resources/plugins/datepicker/bootstrap-datepicker.js"></script>
    <!-- Bootstrap WYSIHTML5 -->
    <script src="${pageContext.request.contextPath}/resources/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
    <!-- Slimscroll -->
    <script src="${pageContext.request.contextPath}/resources/plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="${pageContext.request.contextPath}/resources/plugins/fastclick/fastclick.min.js"></script>
    <!-- AdminLTE App -->
    <script src="${pageContext.request.contextPath}/resources/dist/js/app.min.js"></script>
    <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
   <!-- <script src="<?=$server?>admin/dist/js/pages/dashboard.js"></script>-->
    <!-- AdminLTE for demo purposes -->
    <script src="${pageContext.request.contextPath}/resources/dist/js/demo.js"></script>


<script type="text/javascript">

function getUrlError(){
	var url  = window.location.href;
	var err = url.search("error");
	if(err > 1){
		$("#div_message").empty().append('<div class="alert alert-warning" role="alert">Warning ! Invalid Username Or Password.</div>');
	}
	
}

$(document).ready(function() {
	
	getUrlError();
	
	$('#form-login').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			crm_username: {
				validators: {
					notEmpty: {
						message: 'The username is required and can not be empty!'
					}
				}
			},
			crm_password: {
				validators: {
					notEmpty: {
						message: 'The password is required and can not be empty!'
					}
				}
			}
		}
	});
	
});

</script>
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
  
  
    <h3 class="login-box-msg">Login Campany</h3 >
    
    <div class="col-sm-12" id="div_message"></div>
	<div class="clearfix"></div>
    <form id="form-login" method="POST" action="${pageContext.request.contextPath}/login">
      <div class="form-group has-feedback">
        <input type="text" class="form-control" placeholder="Username" name="crm_username" id="username" required>
         </div>
      <div class="form-group has-feedback">
        <input type="password" class="form-control" placeholder="Password" name="crm_password" id="password" required>
         </div>
      <div class="form-group has-feedback">
        <select class="form-control">
        	<option>-- Select Campany --</option>
            <option>CCW</option>
        </select>
       </div>
      
      	<div class="row">
        	<div class="col-sm-8" style="padding-top:10px;">
                
            </div>	
            <div class="col-sm-4" style="float:right">
              <button type="submit" id="login" name="button" class="btn btn-primary btn-block btn-flat">Login</button>
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

<div class="" style="background:url(${pageContext.request.contextPath}/resources/images/footerstyle-Recovered.png) no-repeat;">
  <div class="container">
  	
    <div class="col-sm-12 text-right" style="color:#fff;font-size:12px;">Copyright ©2015 Balancika (Cambodia). All rights reserved.</div>
  </div>
</div>


</div><!-- Close hidden xs -->
</div>
 

      <script>

  $(document).ready(function() {

   var docHeight = $(window).height();
   var footerHeight = $('#footer').height();
   var footerTop = $('#footer').position().top + footerHeight;

   if (footerTop < docHeight) {

    //$('#footer').css('margin-top', 20+ (docHeight - footerTop) + 'px');
	$('#footer').css('margin-top', 119+(docHeight - footerTop) + 'px');
   }
  });
 </script>
</body>
</html>
