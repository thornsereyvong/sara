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
<div class="content-wrapper" ng-app="campaign" ng-controller="campController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Update Case</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li><a href="#"> Update Case</a></li>
		</ol>
	</section>
<script type="text/javascript">

var app = angular.module('campaign', ['oitozero.ngSweetAlert',]);
var self = this;
app.controller('campController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){

		
}]);

function listStatusID(userID){
	$.ajax({
		url: "${pageContext.request.contextPath}/case_status/list",
		method: "GET",
		header: "application/json",
		success: function(data){
			var dataObject = data.DATA;
			 $("#ca_status").empty().append('<option value="">-- SELECT Status --</option>');
			 
			$.each(dataObject, function(key, value){
					var div = "<option value='"+value.statusId+"' >"+value.statusName+"</option>";
				$("#ca_status").append(div);
			}); 
			 
			$("#ca_status").select2("val",userID);
			
			} 
	});
}

function listTypeID(userID){
	$.ajax({
		url: "${pageContext.request.contextPath}/case_type/list",
		method: "GET",
		header: "application/json",
		success: function(data){
			var dataObject = data.DATA;
			 $("#ca_type").empty().append('<option value="">-- SELECT Type --</option>');
			 
			$.each(dataObject, function(key, value){
					var div = "<option value='"+value.caseTypeId+"' >"+value.caseTypeName+"</option>";
				$("#ca_type").append(div);
			}); 
			 
			$("#ca_type").select2("val",userID);
			
			} 
	});
}

function listPriorityID(userID){
	$.ajax({
		url: "${pageContext.request.contextPath}/case_priority/list",
		method: "GET",
		header: "application/json",
		success: function(data){
			var dataObject = data.DATA;
			 $("#ca_priority").empty().append('<option value="">-- SELECT Priority --</option>');
			 
			$.each(dataObject, function(key, value){
					var div = "<option value='"+value.priorityId+"' >"+value.priorityName+"</option>";
				$("#ca_priority").append(div);
			}); 
			 
			$("#ca_priority").select2("val",userID);
			
			} 
	});
}



function listDataByCon(){
	
	var data = ${cases};
	var result = data.body.DATA;
	var userid = ${users};

	$("#ca_id").val(result.caseId);
    $("#ca_subject").val(result.subject);
    $("#ca_description").val(result.des);
    $("#ca_resolution").val(result.resolution);

    
	if(result.userID == null || result.userID == ""){
		userAllList(userid,'#ca_assignTo','');	
	}else{
		userAllList(userid,'#ca_assignTo',result.userID);
	}
	
	if(result.statusId == null || result.statusId == "")
		listStatusID("");
	else
		listStatusID(result.statusId);

	if(result.caseTypeId == null || result.caseTypeId == "")
		listTypeID("");
	else
		listTypeID(result.caseTypeId);

	if(result.priorityId == null || result.priorityId == "")
		listPriorityID("");
	else
		listPriorityID(result.priorityId);

	
	funcSelectCustomer("${pageContext.request.contextPath}/customer/list", "GET", "#ca_customer", "Customer", result.custID);
	funcSelectContact("#ca_contact", "Contact", result.conID);
	
}


$(document).ready(function() {
	$(".select2").select2();
	
	var data = ${users};
	listDataByCon();
	
	
	
	$("#btn_clear").click(function(){
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
			}
			,
			ca_resolution: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The resolution must be less than 255 characters long.'
					}
				}
			}
			,
			ca_description: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The description must be less than 255 characters long.'
					}
				}
			}
		}
	}).on('success.form.bv', function(e) {
		
		var currentDate = new Date();
		var day = currentDate.getDate();
		var month = currentDate.getMonth() + 1;
		var year = currentDate.getFullYear();

		var status = "";
		if($("#ca_status").val()  != "")
			status = {"statusId": $("#ca_status").val()};
		else
			status = null;

		var type = "";
		if($("#ca_type").val()  != "")
			type = {"caseTypeId": $("#ca_type").val()};
		else
			type = null;

		var priority = "";
		if($("#ca_priority").val()  != "")
			priority = {"priorityId": $("#ca_priority").val()};
		else
			priority = null;

		var custID = "";
		if($("#ca_customer").val()  != ""){
			custID = {"custID": $("#ca_customer").val()};
		}else{
			custID = null;
		}

		
		var assign = "";
		if($("#ca_assignTo").val()  != ""){
			assign = {"userID": $("#ca_assignTo").val()};
		}else{
			assign = null;
		}

		var conta = "";
		if($("#ca_contact").val()  != ""){
			conta = {"conID": $("#ca_contact").val()};
		}else{
			conta = null;
		}
				
		$.ajax({
			url : "${pageContext.request.contextPath}/case/edit",
			type : "PUT",
			data : JSON.stringify({
				  "caseId": $("#ca_id").val(),
				  "status": status,
			      "type": type,
			      "priority": priority,
			      "customer": custID,
			      "contact": conta,
			      "subject": $("#ca_subject").val(),
			      "des": $("#ca_description").val(),
			      "resolution": $("#ca_resolution").val(),
			      "assignTo": assign,
			      "modifyBy": $.session.get("parentID"),     
			    }),	
			beforeSend: function(xhr) {
					    xhr.setRequestHeader("Accept", "application/json");
					    xhr.setRequestHeader("Content-Type", "application/json");
					    },
			success:function(data){
					$("#form-case").bootstrapValidator('resetForm', 'true');
					$('#form-case')[0].reset();
					$("#ca_type").select2("val","");	
					$("#ca_status").select2("val","");
					$("#ca_priority").select2("val","");
					
					swal({
	            		title:"Success",
	            		text:"User have been created new Case!",
	            		type:"success",  
	            		timer: 2000,   
	            		showConfirmButton: false
        			});
					setTimeout(function(){
						window.location.href = "${pageContext.request.contextPath}/list-cases";
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
				<h3 class="box-title"> &nbsp;</h3>
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
			
			<form method="post" id="form-case">
				
				<button type="button" class="btn btn-info btn-app" id="btn_save"> <i class="fa fa-save"></i> Save</button> 
				<a class="btn btn-info btn-app" id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
				<a class="btn btn-info btn-app" href="${pageContext.request.contextPath}/list-cases"> <i class="fa fa-reply"></i> Back </a>

				<div class="clearfix"></div>

				<div class="col-sm-2">
					<h4>Overview</h4>
				</div>

				<div class="col-sm-12">
					<hr style="margin-top: 3px;" />
				</div>

				<div class="row">
					<input type="hidden" id="ca_id" name="ca_id">
					<div class="col-sm-6" data-ng-init="listCaseStatus()">
						<div class="col-sm-6">
							<label class="font-label">Status <span class="requrie">(Required)</span></label>
							<div class="form-group">
								<select class="form-control select2" name="ca_status" id="ca_status" style="width:100%">
									<option value="">-- SELECT Status --</option>
									<option ng-repeat="u in case_status" value="{{u.statusId}}">{{u.statusName}}</option> 
								</select>
							</div>
						</div>
						

						<div class="col-sm-6" data-ng-init="listCaseType()">
							<label class="font-label"> Type <span class="requrie">(Required)</span></label>
							<div class="form-group">
								<select class="form-control select2" name="ca_type" id="ca_type" style="width:100%">
									<option value="">-- SELECT Type --</option>
									<option ng-repeat="u in case_type" value="{{u.caseTypeId}}">{{u.caseTypeName}}</option> 
								</select>
							</div>
						</div>
						
						<div class="col-sm-6" data-ng-init="listCasePriority()">
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
						
						
						<div class="col-sm-12">
							<label class="font-label">Description </label>
							<div class="form-group">
								<textarea style="height: 120px" rows="" cols="" name="ca_description" id="ca_description"
									class="form-control"></textarea>
							</div>
						</div>
					
					</div>

					<div class="col-sm-6">
						
						

						<div class="col-sm-6">
							<label class="font-label">Customer </label>
							<div class="form-group">
								<select class="form-control select2" name="ca_customer" id="ca_customer" style="width:100%">
									<option value="">-- SELECT Customer --</option>
								</select>
							</div>
						</div>
						
						
						<div class="col-sm-6">
							<label class="font-label">Contact </label>
							<div class="form-group">
								<select class="form-control select2" name="ca_contact" id="ca_contact" style="width:100%">
									<option value="">-- SELECT Contact --</option>
								</select>
							</div>
						</div>
						
						
						<div class="clearfix"></div>
						<div class="col-sm-12 ">
							<label class="font-label">Resolution </label>
							<div class="form-group">
								<textarea style="height: 120px" rows="" cols="" name="ca_resolution" id="ca_resolution"
									class="form-control"></textarea>
							</div>
						</div>
						

					</div>
					
					
				</div>
				
				
			<div class="clearfix"></div>
				
				<div class="col-sm-2"><h4>Other </h4></div>
				
				<div class="col-sm-12">
						<hr style="margin-top: 3px;" />
				</div>
				<div class="col-sm-6">
				
				</div>
				<div class="col-sm-12">
				
					<div class="col-sm-3">
							<label class="font-label">Assigned to  </label>
							<div class="form-group">
								<select class="form-control select2" name="ca_assignTo" id="ca_assignTo" style="width:100%">
									<option value=""></option>
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

