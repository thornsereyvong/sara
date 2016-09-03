<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>




<style type="text/css">
.font-label {
	font-size: 13px;
	padding-top: 4px;
}


.input-group-btn select {
	border-color: #ccc;
	margin-top: 0px;
    margin-bottom: 0px;
    padding-top: 7px;
    padding-bottom: 7px;
}
.padding-right{
padding-right: 10px;
}

</style>

<div class="content-wrapper" ng-app="campaign" ng-controller="campController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Create Location</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Create Location</a></li>
		</ol>
	</section>


<script type="text/javascript">

var app = angular.module('campaign', ['oitozero.ngSweetAlert',]);
var self = this;
app.controller('campController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){


}]);



$(document).ready(function() {
	

	$("#btn_clear").click(function(){
		$("#form-contact").bootstrapValidator('resetForm', 'true');
		$('#form-contact')[0].reset();
	});
	
	$("#btn_save").click(function(){
		$("#form-contact").submit();
	});
	
	$('#form-contact').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			name: {
				validators: {
					notEmpty: {
						message: 'The location name ID is required and can not be empty!'
					}
				}
			}
		}
	}).on('success.form.bv', function(e) {
		
		
		
		var currentDate = new Date();
		var day = currentDate.getDate();
		var month = currentDate.getMonth() + 1;
		var year = currentDate.getFullYear();

		$.ajax({
			url : "${pageContext.request.contextPath}/event_location/add",
			type : "POST",
			data : JSON.stringify({
			     
			      "loName": $("#name").val(),
			      "loNo":  $("#no").val(),
			      "loStreet":  $("#street").val(),
			      "village":  $("#village").val(),
			      "loCommune":  $("#commune").val(),
			      "loDistrict":  $("#district").val(),
			      "loCity":  $("#city").val(),
			      "loState":  $("#state").val(),
			      "loCountry":  $("#country").val(),
			      "loCreateBy":  $.session.get("parentID"),
			      "loCreateDate": year+"-"+month+"-"+day,
			     
			    }),	
			beforeSend: function(xhr) {
					    xhr.setRequestHeader("Accept", "application/json");
					    xhr.setRequestHeader("Content-Type", "application/json");
					    },
			success:function(data){
					$("#form-contact").bootstrapValidator('resetForm', 'true');
					$('#form-contact')[0].reset();
					
					swal({
	            		title:"Success",
	            		text:"User have been created new Location!",
	            		type:"success",  
	            		timer: 2000,   
	            		showConfirmButton: false
        			});
				},
			error:function(){
				errorMessage();
				}
			});
		
	});	
	
});
</script>
	<section class="content">

		<!-- Default box -->
		
		<div class="box box-danger">
			<div class="box-header with-border">
				<h3 class="box-title">&nbsp;</h3>
				<div class="box-tools pull-right">
					<button class="btn btn-box-tool" data-widget="collapse"
						data-toggle="tooltip" title="Collapse">
						<i class="fa fa-minus"></i>
					</button>
					<button class="btn btn-box-tool" data-widget="remove"
						data-toggle="tooltip" title="Remove">
						<i class="fa fa-times"></i>
					</button>
				</div>
			</div>
			<div class="box-body">
		
			<form method="post" id="form-contact">
				
				<button type="button" class="btn btn-info btn-app" id="btn_save"> <i class="fa fa-save"></i> Save</button> 
				<a class="btn btn-info btn-app" id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
				<a class="btn btn-info btn-app" href="${pageContext.request.contextPath}/list-locations"> <i class="fa fa-reply"></i> Back </a>

				<div class="clearfix"></div>

				
				<div class="col-sm-12">
					<hr style="margin-top: 3px;" />
				</div>

			
				
				<div class="col-sm-2"><h4>Address </h4></div>
				
				<div class="col-sm-12">
						<hr style="margin-top: 3px;" />
				</div>
				
				<div class="col-sm-6">
					<div class="col-sm-2">
							<label class="font-label">* Location Name :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text"  class="form-control" id="name" name="name">
							</div>	
						</div>
						<div class="clearfix"></div>
					<div class="col-sm-2">
							<label class="font-label">No :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text"  class="form-control" id="no" name="no">
							</div>	
						</div>
					<div class="col-sm-2">
							<label class="font-label">Street :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text"  class="form-control" id="street" name="street">
							</div>	
						</div>
						<div class="col-sm-2">
							<label class="font-label">Village :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text"  class="form-control" id="village" name="village">
							</div>	
						</div>
						<div class="col-sm-2">
							<label class="font-label">Commune :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text"  class="form-control" id="commune" name="commune">
							</div>	
						</div>
						
						
						
				</div>
				<div class="col-sm-6">
						
						<div class="col-sm-2">
							<label class="font-label">District :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text"  class="form-control" id="district" name="district">
							</div>	
						</div>
						<div class="col-sm-2">
							<label class="font-label">City :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text"  class="form-control" id="city" name="city">
							</div>	
						</div>
						<div class="col-sm-2">
							<label class="font-label">State :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text"  class="form-control" id="state" name="state">
							</div>	
						</div>
						<div class="col-sm-2">
							<label class="font-label">Country :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text"  class="form-control" id="country" name="country">
							</div>	
						</div>
				</div>
				

			</form>
			</div>
			<!-- /.box-body -->
			<div class="box-footer">
				<div id="test_div"></div>
			</div>
			<!-- /.box-footer-->
		</div>
		
		<!-- /.box -->


	</section>
	<!-- /.content -->


</div>

<!-- /.content-wrapper -->




<jsp:include page="${request.contextPath}/footer"></jsp:include>

