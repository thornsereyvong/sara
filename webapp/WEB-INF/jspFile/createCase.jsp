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
		<h1>Create Case</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"> Create Case</a></li>
		</ol>
	</section>
<script type="text/javascript">

var app = angular.module('caseApp', ['oitozero.ngSweetAlert',]);
var self = this;
var username = "${SESSION}";
app.controller('caseController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){
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
							<div class="col-sm-6">
								<div class="col-sm-6">
									<label class="font-label">Status <span class="requrie">(Required)</span></label>
									<div class="form-group">
										<select class="form-control select2" name="ca_status" id="ca_status" style="width:100%">
											<option value="">-- SELECT Status --</option>
											<option ng-repeat="u in case_status" value="{{u.statusId}}">{{u.statusName}}</option> 
										</select>
									</div>
								</div>
								<div class="col-sm-6">
									<label class="font-label"> Type <span class="requrie">(Required)</span></label>
									<div class="form-group">
										<select class="form-control select2" name="ca_type" id="ca_type" style="width:100%">
											<option value="">-- SELECT Type --</option>
											<option ng-repeat="u in case_type" value="{{u.caseTypeId}}">{{u.caseTypeName}}</option> 
										</select>
									</div>
								</div>
								<div class="clearfix"></div>							
								<div class="col-sm-6">
									<label class="font-label">Priority <span class="requrie">(Required)</span></label>
									<div class="form-group">
										<select class="form-control select2" name="ca_priority" id="ca_priority" style="width:100%">
											<option value="">-- SELECT Priority --</option>
											<option ng-repeat="u in case_priority" value="{{u.priorityId}}">{{u.priorityName}}</option> 
										</select>
									</div>
								</div>													
								<div class="col-sm-6">
									<label class="font-label">Subject <span class="requrie">(Required)</span></label>
									<div class="form-group">
										<input type="text" class="form-control" id="ca_subject" name="ca_subject">
									</div>
								</div>	
							</div>
							<div class="col-sm-6">
								<div class="col-sm-6">
									<label class="font-label">Customer </label>
									<div class="form-group">
										<select class="form-control select2" name="ca_customer" id="ca_customer" style="width:100%">
											<option value="">-- SELECT Customer --</option>
											<option ng-repeat="u in customer" value="{{u.custId}}">{{u.custName}}</option>
										</select>
									</div>
								</div>
								<div class="col-sm-6">
									<label class="font-label">Contact </label>
									<div class="form-group">
										<select class="form-control select2" name="ca_contact" id="ca_contact" style="width:100%">
											<option value="">-- SELECT Contact --</option>
											<option ng-repeat="u in contact" value="{{u.conID}}">{{u.conFirstname}} {{u.conLastname}}</option>
										</select>
									</div>
								</div>
								
							</div>
							<div class="clearfix"></div>
							<div class="col-sm-12">
								<div class="col-sm-12">
									<label class="font-label">Description </label>
									<div class="form-group">
										<textarea  rows="4" cols="" name="ca_description" id="ca_description"
											class="form-control"></textarea>
									</div>
								</div>
								<div class="clearfix"></div>
								<div class="col-sm-12 ">
									<label class="font-label">Resolution </label>
									<div class="form-group">
										<textarea  rows="5" cols="" name="ca_resolution" id="ca_resolution" class="form-control"></textarea>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="clearfix"></div>
					<div class="col-sm-2"><h4>Other </h4></div>
					<div class="col-sm-12"><hr style="margin-top: 3px;" /></div>
					<div class="row">
						<div class="col-sm-12">
							<div class="col-sm-6">				
								<div class="col-sm-6">
									<label class="font-label">Assigned to  </label>
									<div class="form-group">
										<select class="form-control select2" name="ca_assignTo" id="ca_assignTo" style="width:100%">
											<option value="">-- SELECT Assign To --</option>
											<option ng-repeat="u in assignTo" value="{{u.userID}}">{{u.username}}</option>
										</select>
									</div>
								</div>
							</div>																		
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

