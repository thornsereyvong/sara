<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>




<style>
.font-label {
	font-size: 13px;
	padding-top: 4px;
}
</style>
<div class="content-wrapper" ng-app="campaign" ng-controller="campController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1> Update Customer</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Update Customer</a></li>
		</ol>
	</section>
<script type="text/javascript">

var app = angular.module('campaign', ['oitozero.ngSweetAlert',]);
var self = this;
app.controller('campController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){



}]);

function listindustry(indus){
	$.ajax({
		url: "${pageContext.request.contextPath}/industry/list",
		method: "GET",
		header: "application/json",
		success: function(data){
			var dataObject = data.DATA;
			 $("#c_industry").empty().append('<option value="">-- SELECT Industry --</option>');
			$.each(data.DATA, function(key, value){
				var div = "<option value='"+value.industID+"' >"+value.industName+"</option>";
				$("#c_industry").append(div);
			});  
			$("#c_industry").select2("val",indus);
			
			} 
		});
}

function listType(ty){
	$.ajax({
		url: "${pageContext.request.contextPath}/account_type/list",
		method: "GET",
		header: "application/json",
		success: function(data){
			var dataObject = data.DATA;
			 $("#c_type").empty().append('<option value="">-- SELECT Type --</option>');
			$.each(data.DATA, function(key, value){
				var div = "<option value='"+value.accountID+"' >"+value.accountName+"</option>";
				$("#c_type").append(div);
			});  
			$("#c_type").select2("val",ty);
			
			} 
		});
}

function listData(){

	var data = ${cust};
	var result = data.body.DATA;
	
	$("#cs_id").val(result.custID);
	$("#cs_name").val(result.custName);
    $("#c_tel1").val(result.custTel1);
    $("#c_tel2").val(result.custTel2);
    $("#c_fax").val(result.custFax);
    $("#c_email").val(result.custEmail);
    $("#c_website").val(result.custWebsite);
    $("#c_address").val(result.custAddress);
    $("#c_facebook").val(result.facebook);
    $("#c_line").val(result.line);
    $("#c_viber").val(result.viber);
    $("#c_whatapp").val(result.whatApp);

    if(result.industID == null || result.industID == ""){
    	listindustry("");
	}else{
		listindustry(result.industID.industID);
	}

    if(result.accountTypeID == null || result.accountTypeID == ""){
    	listType("");
	}else{
		listType(result.accountTypeID.accountID);
	}
    
  
}


$(document).ready(function() {
	$(".select2").select2();
	listData();
	$("#btn_clear").click(function(){
		$("#form-customer").bootstrapValidator('resetForm', 'true');
	});
	
	 $("#btn_save").click(function(){
		$("#form-customer").submit();
		
	});


		
		$('#form-customer').bootstrapValidator({
			message: 'This value is not valid',
			feedbackIcons: {
				valid: 'glyphicon glyphicon-ok',
				invalid: 'glyphicon glyphicon-remove',
				validating: 'glyphicon glyphicon-refresh'
			},
			fields: {
				cs_name: {
					validators: {
						notEmpty: {
							message: 'The Customer Name is required and can not be empty!'
						}
					}
				}
			}
		}).on('success.form.bv', function(e) {
			var industry = "";	
			if($("#c_industry").val()  != ""){
				industry = {"industID": $("#c_industry").val()};
			}else{
				industry = null;
			}

			var account = "";	
			if($("#c_type").val()  != ""){
				account = {"accountID": $("#c_type").val()};
			}else{
				account = null;
			}
			$.ajax({
				url : "${pageContext.request.contextPath}/customer/edit",
				type : "PUT",
				data : JSON.stringify({ 
					  "custID": $("#cs_id").val(),	
				      "custName": $("#cs_name").val(),
				      "custTel1": $("#c_tel1").val(),
				      "custTel2": $("#c_tel2").val(),
				      "custFax": $("#c_fax").val(),
				      "custEmail": $("#c_email").val(),
				      "custWebsite": $("#c_website").val(),
				      "custAddress": $("#c_address").val(),
				      "facebook": $("#c_facebook").val(),
				      "line": $("#c_line").val(),
				      "viber": $("#c_viber").val(),
				      "whatApp": $("#c_whatapp").val(),
				      "industID": industry,
					  "accountTypeID": account		
					}),
				beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
						    },
				success:function(data){
					
						$("#form-customer").bootstrapValidator('resetForm', 'true');
						$('#form-customer')[0].reset();
						$("#c_industry").select2("val","");
						$("#c_type").select2("val","");
						
						swal({
		            		title:"Success",
		            		text:"User have been Update new Customer!",
		            		type:"success",  
		            		timer: 2000,   
		            		showConfirmButton: false
	        			});
						setTimeout(function(){
							window.location.href = "${pageContext.request.contextPath}/list-customers";
						}, 2000);
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
			
			<form method="post" id="form-customer">
				
				<button type="button" class="btn btn-info btn-app" id="btn_save" > <i class="fa fa-save"></i> Save</button> 
				<a class="btn btn-info btn-app" id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
				<a class="btn btn-info btn-app"  href="${pageContext.request.contextPath}/list-customers"> <i class="fa fa-reply"></i> Back </a>

				<div class="clearfix"></div>

				<div class="col-sm-2">
					<h4>Overview</h4>
				</div>

				<div class="col-sm-12">
					<hr style="margin-top: 3px;" />
				</div>

				<div class="row">

					<div class="col-sm-6">

						
						<input type="hidden" id="cs_id" name="cs_id">
						<div class="col-sm-2">
							<label class="font-label">Name :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group" id="c_name">
								<input type="text" class="form-control" name="cs_name" id="cs_name">
							</div>
						</div>
						<div class="col-sm-2">
							<label class="font-label">Tel :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text" class="form-control" name="c_tel1" id="c_tel1">
							</div>
						</div>
						<div class="clearfix"></div>
						<div class="col-sm-2">
							<label class="font-label">Tel :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text" class="form-control" name="c_tel2" id="c_tel2">
							</div>
						</div>
						<div class="col-sm-2">
							<label class="font-label">Fax :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text" class="form-control" name="c_fax" id="c_fax">
							</div>
						</div>
						<div class="col-sm-2">
							<label class="font-label">Address :</label>
						</div>
						<div class="col-sm-10">
							<div class="form-group">
								<textarea style="height: 120px" rows="" cols="" name="c_address" id="c_address"	class="form-control"></textarea>
							</div>
						</div>
					</div>

					<div class="col-sm-6">

						<div class="col-sm-2">
							<label class="font-label">Email :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text" class="form-control" name="c_email" id="c_email">
							</div>
						</div>

						<div class="col-sm-2">
							<label class="font-label">Website :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text" class="form-control" name="c_website" id="c_website">
							</div>
						</div>

					</div>
					

					<div class="clearfix"></div>


				</div>
				
				<div class="clearfix"></div>
				
				<div class="col-sm-2"><h4>Other</h4></div>
				
				<div class="col-sm-12">
						<hr style="margin-top: 8px;"/>
				</div>
				
				<div class="col-sm-6">
				
					<div class="col-sm-2">
							<label class="font-label">Facebook:</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text" class="form-control" name="c_facebook" id="c_facebook">
							</div>
						</div>
						
					<div class="col-sm-2">
							<label class="font-label">Line:</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text" class="form-control" name="c_line" id="c_line">
							</div>
						</div>
						
						<div class="col-sm-2">
							<label class="font-label">Viber:</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text" class="form-control" name="c_viber" id="c_viber">
							</div>
						</div>
						
						<div class="col-sm-2">
							<label class="font-label">WhatApp:</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text" class="form-control" name="c_whatapp" id="c_whatapp">
							</div>
						</div>
				</div>
				
				<div class="col-sm-6">
				
					<div class="col-sm-2">
							<label class="font-label">Industry:</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<select class="form-control select2" name="c_industry" id="c_industry">
									<option value="">-- SELECT Industry</option>
									
								</select>
							</div>
						</div>
					<div class="col-sm-2">
							<label class="font-label">Type:</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<select class="form-control select2" name="c_type" id="c_type">
									<option value="">-- SELECT Type</option>
									
								</select>
							</div>
						</div>
						
				</div>

			</form>
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

