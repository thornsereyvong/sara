<%@page import="java.util.List"%>
<%@page import="com.app.entities.CrmUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>





	

</script>
<div class="content-wrapper" >
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>PERMISSION DENY</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> PERMISSION DENY</a></li>
		</ol>
	</section>


	<section class="content">

		<!-- Default box -->
		<div class="box">
			
			<div class="box-body">
			<div class="alert alert-warning" role="alert"><i class="glyphicon glyphicon-cog"></i> You have no permission to do this transaction. Please contact your administrator.</div>			
			</div>
			<!-- /.box-body -->
			<div class="box-footer"></div>
			<!-- /.box-footer-->
		</div>
		<!-- /.box -->


	</section>
	<!-- /.content -->


</div>


<!-- /.content-wrapper -->




<jsp:include page="${request.contextPath}/footer"></jsp:include>

