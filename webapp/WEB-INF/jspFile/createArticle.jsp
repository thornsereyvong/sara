<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>

<style>
.font-label {
	font-size: 13px;
	padding-top: 4px;
}
</style>
<div class="content-wrapper" ng-app="caseApp" ng-controller="caseController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Create Article</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"> Create Article</a></li>
		</ol>
	</section>
<script type="text/javascript">

var app = angular.module('caseApp', []);
var self = this;
var username = "${SESSION}";
app.controller('caseController',['$scope','$http',function($scope, $http){
	$scope.startupPage = function(){
		$http.get("${pageContext.request.contextPath}/case/startup/"+username).success(function(response){
			$scope.case_status = response.CASE_STATUS;
			$scope.case_type = response.CASE_TYPE;
			$scope.case_priority = response.CASE_PRIORITY;
			$scope.customer = response.CUSTOMERS;
			$scope.contact = response.CONTACTS;
			$scope.assignTo = response.ASSIGN_TO;	
			
		
			
		});
	};			
}]);
$(document).ready(function() {
	$("#btn_clear").click(function(){
		$("#ca_type").select2("val","");	
		$("#ca_status").select2("val","");
		$("#ca_priority").select2("val","");
		$("#ca_assignTo").select2("val","");
		$("#ca_customer").select2("val","");
		$("#ca_contact").select2("val","");      	
      	$("#form-case").bootstrapValidator('resetForm', 'true');
		$('#form-case')[0].reset();		
	});
	
	$("#btn_save").click(function(){
		$("#form-case").submit();
	});
	
	$('#form-case').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			ca_priority: {
				validators: {
					notEmpty: {
						message: 'The priority is required and can not be empty!'
					},
					stringLength: {
						max: 255,
						message: 'The name must be less than 255 characters long.'
					}
				}
			},
			
			ca_status: {
				validators: {
					notEmpty: {
						message: 'The status is required and can not be empty!'
					}
				}
			},
			ca_subject: {
				validators: {
					notEmpty: {
						message: 'The subject is required and can not be empty!'
					}
				}
			},
			ca_type: {
				validators: {
					notEmpty: {
						message: 'The type is required and can not be empty!'
					}
				}
			},
			ca_resolution: {
				validators: {
					stringLength: {
						max: 1000,
						message: 'The resolution must be less than 1000 characters long.'
					}
				}
			},
			ca_description: {
				validators: {
					stringLength: {
						max: 1000,
						message: 'The description must be less than 1000 characters long.'
					}
				}
			}
		}
	}).on('success.form.bv', function(e) {
		$.ajax({
			url : "${pageContext.request.contextPath}/case/add",
			type : "POST",
			data : JSON.stringify({
			      "status": getJsonById("statusId","ca_status","int"),
			      "type": getJsonById("caseTypeId","ca_type","int"),
			      "priority": getJsonById("priorityId","ca_priority","int"),
			      "customer": getJsonById("custID","ca_customer","str"),
			      "contact": getJsonById("conID","ca_contact","str"),
			      "subject": getValueStringById("ca_subject"),
			      "des": getValueStringById("ca_description"),
			      "resolution": getValueStringById("ca_resolution"),
			      "assignTo": getJsonById("userID","ca_assignTo","str"),
			      "createBy": $.session.get("parentID")
		    }),	
			beforeSend: function(xhr) {
			    xhr.setRequestHeader("Accept", "application/json");
			    xhr.setRequestHeader("Content-Type", "application/json");
		    },
			success:function(data){
				if(data.MESSAGE == "INSERTED"){
					$("#ca_type").select2("val","");	
					$("#ca_status").select2("val","");
					$("#ca_priority").select2("val","");
					$("#ca_assignTo").select2("val","");
					$("#ca_customer").select2("val","");
					$("#ca_contact").select2("val","");
			      	$("#form-case").bootstrapValidator('resetForm', 'true');
					$('#form-case')[0].reset();
					swal({
	            		title:"Success",
	            		text:"You have been created new Case!",
	            		type:"success",  
	            		timer: 2000,   
	            		showConfirmButton: false
        			});
				}else{
					alertMsgErrorSweet();	
				}
			},
			error:function(){
				alertMsgErrorSweet();				
			}
		});
	});		
});
</script>
	<section class="content">
		<div class="box box-danger">			
			<div class="box-body">			
				<form method="post" id="form-case" data-ng-init="startupPage()">
					
					<button type="button" class="btn btn-info btn-app" id="btn_save"> <i class="fa fa-save"></i> Save</button> 
					<a class="btn btn-info btn-app" id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
					<a class="btn btn-info btn-app" href="${pageContext.request.contextPath}/list-cases"> <i class="fa fa-reply"></i> Back </a>
	
					<div class="clearfix"></div>
					<div class="col-sm-2"><h4>Overview</h4></div>
					<div class="col-sm-12"><hr style="margin-top: 3px;" /></div>
					<div class="row">
						<div class="col-sm-12">
							<div class="col-sm-3">
								<label class="font-label">Subject <span class="requrie">(Required)</span></label>
								<div class="form-group">
									<input type="text" class="form-control" id="ca_subject" name="ca_subject">
								</div>
							</div>
							<div class="col-sm-3">
								<label class="font-label">Subject <span class="requrie">(Required)</span></label>
								<div class="form-group">
									<input type="text" class="form-control" id="ca_subject" name="ca_subject">
								</div>
							</div>
							<div class="col-sm-3">
								<label class="font-label">Subject <span class="requrie">(Required)</span></label>
								<div class="form-group">
									<input type="text" class="form-control" id="ca_subject" name="ca_subject">
								</div>
							</div>
							<div class="col-sm-3">
								<label class="font-label">Subject <span class="requrie">(Required)</span></label>
								<div class="form-group">
									<input type="text" class="form-control" id="ca_subject" name="ca_subject">
								</div>
							</div>
							<div class="clearfix"></div>
						</div>
					</div>
						
				</form>
			</div>
			<div class="box-footer"><div id="test_div"></div></div>
			<dis id="errors"></dis>
		</div>
	</section>
</div>
<jsp:include page="${request.contextPath}/footer"></jsp:include>

