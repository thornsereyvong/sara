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
		<h1>Create Case</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Create Case</a></li>
		</ol>
	</section>
<script type="text/javascript">

var app = angular.module('campaign', ['oitozero.ngSweetAlert',]);
var self = this;
app.controller('campController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){

	$scope.listCaseStatus = function(){
		$http.get("${pageContext.request.contextPath}/case_status/list")
		.success(function(response){
				$scope.case_status = response.DATA;
			});
		};

	$scope.listCaseType = function(){
			$http.get("${pageContext.request.contextPath}/case_type/list")
			.success(function(response){
					$scope.case_type = response.DATA;
				});
			};
   $scope.listCasePriority  = function(){
		$http.get("${pageContext.request.contextPath}/case_priority/list")
		.success(function(response){
				$scope.case_priority = response.DATA;
			});
		};	
		
}]);



$(document).ready(function() {
	$(".select2").select2();
	
	var data = ${users};
	
	userAllList(data,'#con_assignedTo','');

	userAllList(data,'#ca_assignTo','');
	funcSelectCustomer("${pageContext.request.contextPath}/customer/list", "GET", "#ca_customer", "Customer", "");
	funcSelectContact("#ca_contact", "Contact", "");
	
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
			url : "${pageContext.request.contextPath}/case/add",
			type : "POST",
			data : JSON.stringify({
			      "status": status,
			      "type": type,
			      "priority": priority,
			      "customer": custID,
			      "contact": conta,
			      "subject": $("#ca_subject").val(),
			      "des": $("#ca_description").val(),
			      "resolution": $("#ca_resolution").val(),
			      "assignTo": assign,
			      "createBy": $.session.get("parentID"),
			      "createDate": year+"-"+month+"-"+day,
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
					$("#ca_assignTo").select2("val","");
					$("#ca_customer").select2("val","");
					$("#ca_contact").select2("val","");
					
					swal({
	            		title:"Success",
	            		text:"User have been created new Case!",
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
				<h3 class="box-title">&nbsp; </h3>
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

					<div class="col-sm-6" data-ng-init="listCaseStatus()">
						<div class="col-sm-2">
							<label class="font-label">* Status :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<select class="form-control select2" name="ca_status" id="ca_status">
									<option value="">-- SELECT Status --</option>
									<option ng-repeat="u in case_status" value="{{u.statusId}}">{{u.statusName}}</option> 
								</select>
							</div>
						</div>

						<div class="col-sm-2" data-ng-init="listCaseType()">
							<label class="font-label">* Type :</label>
						</div>
						<div class="col-sm-4" >
							<div class="form-group">
								<select class="form-control select2" name="ca_type" id="ca_type">
									<option value="">-- SELECT Type --</option>
									<option ng-repeat="u in case_type" value="{{u.caseTypeId}}">{{u.caseTypeName}}</option> 
								</select>
							</div>
						</div>
						
						<div class="col-sm-2" data-ng-init="listCasePriority()">
							<label class="font-label">* Priority :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<select class="form-control select2" name="ca_priority" id="ca_priority">
									<option value="">-- SELECT Priority --</option>
									<option ng-repeat="u in case_priority" value="{{u.priorityId}}">{{u.priorityName}}</option> 
								</select>
							</div>
						</div>
						
						<div class="col-sm-2">
							<label class="font-label">* Subject :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text" class="form-control" id="ca_subject" name="ca_subject">
							</div>
						</div>
						
						<div class="col-sm-2">
							<label class="font-label">Description :</label>
						</div>
						<div class="col-sm-10">
							<div class="form-group">
								<textarea style="height: 120px" rows="" cols="" name="ca_description" id="ca_description"
									class="form-control"></textarea>
							</div>
						</div>
						
						
						
						

					</div>

					<div class="col-sm-6">
						
						

						<div class="col-sm-2">
							<label class="font-label">Customer :</label>
						</div>
						<div class="col-sm-4" >
							<div class="form-group">
								<select class="form-control select2" name="ca_customer" id="ca_customer">
									<option value="">-- SELECT Customer --</option>
								</select>
							</div>
						</div>
						
						<div class="col-sm-2">
							<label class="font-label">Contact :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<select class="form-control select2" name="ca_contact" id="ca_contact">
									<option value="">-- SELECT Contact --</option>
								</select>
							</div>
						</div>
						
						<div class="clearfix"></div>
						<div class="col-sm-2 ">
							<label class="font-label">Resolution :</label>
						</div>
						<div class="col-sm-10">
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
				
					<div class="col-sm-1">
							<label class="font-label">Assigned to : </label>
						</div>
						<div class="col-sm-2">
							<div class="form-group">
								<select class="form-control select2" name="ca_assignTo" id="ca_assignTo">
									<option value=""></option>
								</select>
							</div>
						</div>
						
						
				</div>
				
				
				

			</form>
			</div>
			<!-- /.box-body -->
			<div class="box-footer"><div id="test_div"></div></div>
			<!-- /.box-footer-->
		</div>
		
		<!-- /.box -->


	</section>
	<!-- /.content -->


</div>

<!-- /.content-wrapper -->




<jsp:include page="${request.contextPath}/footer"></jsp:include>

