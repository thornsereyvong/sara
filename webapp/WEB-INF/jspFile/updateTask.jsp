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
		<h1> Update Task</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"><i class="fa fa-dashboard"></i> Update Task</a></li>
		</ol>
	</section>
<script type="text/javascript">

var app = angular.module('campaign', []);
var self = this;
app.controller('campController',['$scope','$http',function($scope, $http){

	$scope.listMeetignStatus = function(){
		$http.get("${pageContext.request.contextPath}/task_status/list")
		.success(function(response){
				$scope.status = response.DATA;
			});
		};	

		$scope.listContact = function(){
			$http.get("${pageContext.request.contextPath}/contact/list")
			.success(function(response){
					$scope.contact = response.DATA;
					
				});
			};	


}]);


function listStatusID(statusids){
	
	$.ajax({
		url: "${pageContext.request.contextPath}/task_status/list",
		method: "GET",
		header: "application/json",
		success: function(data){
			var dataObject = data.DATA;
			 $("#ts_status").empty().append('<option value="">-- SELECT Status --</option>');
			$.each(data.DATA, function(key, value){
				var div = "<option value='"+value.taskStatusId+"' >"+value.taskStatusName+"</option>";
				$("#ts_status").append(div);
			});  
			$("#ts_status").select2("val",statusids);
			$('#form-call').data('bootstrapValidator').resetField($('#ts_status'));
			
			} 
		});
}

function getData(){
	var data = ${task};
	var result = data.body.DATA;
	var user_id = ${users};
	$("#ts_startDate").val(result.taskStartDate);
	$("#ts_dueDate").val(result.taskDueDate);
	$("#ts_id").val(result.taskId);
	$("#ts_subject").val(result.taskSubject);
	
	$("#ts_description").val(result.taskDes);

	userAllList(user_id,'#ts_assignTo',result.userID);
	
	 if(result.taskStatusId == null || result.taskStatusId == ""){
		listStatusID("");
	}else{
		listStatusID(result.taskStatusId);
	} 

	$("#ts_priority").select2("val",result.taskPriority);
	
	if(result.taskRelatedToModule == null || result.taskRelatedToModule == ""){
		$("#ts_relateTo").select2("val","");
	}else{
		$("#ts_relateTo").select2("val",result.taskRelatedToModule);
	}
	
	funcRelateTo("#ts_reportType",result.taskRelatedToModule, result.taskRelatedToId);
	
	funcRelateTo("#ts_contact","Contact", result.conID);

}

$(document).ready(function() {
	
	
	$(".select2").select2();
	
	getData();
	 
	var data = ${users};

	
	$("#ts_relateTo").change(function(){
		var relate = $("#ts_relateTo").val();
		funcRelateTo("#ts_reportType",relate,"");
	});
	
	$('.date2').daterangepicker({
        singleDatePicker: true,
        showDropdowns: true,
        format: 'DD/MM/YYYY h:mm A',
        timePicker: true, 
        timePickerIncrement: 5 
    });


	$("#btn_clear").click(function(){
		location.reload();
	});
	
	 $("#btn_save").click(function(){
		$("#form-call").submit();
	});

		
		
	$('#form-call').bootstrapValidator({
			message: 'This value is not valid',
			feedbackIcons: {
				valid: 'glyphicon glyphicon-ok',
				invalid: 'glyphicon glyphicon-remove',
				validating: 'glyphicon glyphicon-refresh'
			},
			fields: {
				ts_subject: {
					validators: {
						notEmpty: {
							message: 'The Subject is required and can not be empty!'
						},
						stringLength: {
							max: 255,
							message: 'The Subject must be less than 255 characters long.'
						}
					}
				},
				ts_status: {
					validators: {
						notEmpty: {
							message: 'The Status is required and can not be empty!'
						}
					}
				},
				ts_priority: {
					validators: {
						notEmpty: {
							message: 'The Priorty is required and can not be empty!'
						}
					}
				},
				ts_startDate: {
					validators: {
						date: {
	                        format: 'DD/MM/YYYY h:mm A',
	                        message: 'The value is not a valid date!'
						}
					}
				},
				ts_dueDate: {
					validators: {
						date: {
	                        format: 'DD/MM/YYYY h:mm A',
	                        message: 'The value is not a valid date!'
						}
					}
				},
				ts_description: {
					validators: {
						stringLength: {
							max: 1000,
							message: 'The description must be less than 1000 characters long.'
						}
					}
				}
				
				
			}
		}).on('success.form.bv', function(e) {

		    var assign = "";	
			if($("#ts_assignTo").val()  != ""){
				assign = {"userID": $("#ts_assignTo").val()};
			}else{
				assign = null;
			}

			var status = "";	
			if($("#ts_status").val()  != ""){
				status = {"taskStatusId": $("#ts_status").val()};
			}else{
				status = null;
			}

			var contactssss = "";	
			if($("#ts_contact").val()  != ""){
				contactssss = {"conID": $("#ts_contact").val()};
			}else{
				contactssss = null;
			}

			$.ajax({
				url : "${pageContext.request.contextPath}/task/edit",
				type : "PUT",
				data : JSON.stringify({ 
					  "taskId": $("#ts_id").val(),   
				      "taskStatus": status,
				      "taskPriority": $("#ts_priority").val(),
				      "taskAssignTo": assign,
				      "taskRelatedToId": $("#ts_reportType").val(),
				      "taskRelatedToModule": $("#ts_relateTo").val(),
				      "taskDes": $("#ts_description").val(),
				      "dueDate": $("#ts_dueDate").val(),
				      "taskSubject":  $("#ts_subject").val(),
				      "startDate":  $("#ts_startDate").val(),
				      "taskContact": contactssss,
				      "taskModifiedBy": $.session.get("parentID"),
					}),
				beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
						    },
				success:function(data){

					$("#form-call").bootstrapValidator('resetForm', 'true');
					$('#form-call')[0].reset();
					$("#ts_status").select2("val","");
					$("#ts_relateTo").select2("val","");
					$("#ts_reportType").select2("val","");
					$("#ts_assignTo").select2("val","");
					$("#ts_priority").select2("val","");
					
					$("#form-call").bootstrapValidator('resetForm', 'ts_status');
					$("#form-call").bootstrapValidator('resetForm', 'ts_priority');
						swal({
		            		title:"Success",
		            		text:"User have been Update Task!",
		            		type:"success",  
		            		timer: 2000,   
		            		showConfirmButton: false
	        			});

						setTimeout(function(){
							window.location.href = "${pageContext.request.contextPath}/list-tasks";
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
				<p class="box-title">&nbsp;</p>
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
			
			<form method="post" id="form-call">
				
				<button type="button" class="btn btn-info btn-app" id="btn_save" > <i class="fa fa-save"></i> Save</button> 
				<a class="btn btn-info btn-app" id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
				<a class="btn btn-info btn-app"  href="${pageContext.request.contextPath}/list-tasks"> <i class="fa fa-reply"></i> Back </a>

				<div class="clearfix"></div>

				<div class="col-sm-2">
					<h4>Overview</h4>
				</div>

				<div class="col-sm-12">
					<hr style="margin-top: 3px;" />
				</div>

				<div class="row">
					<div class="col-sm-12">
					<div class="col-sm-6">
						<input type="hidden" id = "ts_id">
						<div class="col-sm-12">
							<label class="font-label">Subject <span class="requrie">(Required)</span></label>
							<div class="form-group" id="c_name">
								<input type="text" class="form-control" name="ts_subject" id="ts_subject">
							</div>
						</div>
						
						<div class="clearfix"></div>
						<div class="col-sm-6">
							<label class="font-label">Start date </label>
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
									<input type="text" class="form-control pull-right date2" name="ts_startDate" id="ts_startDate">
								</div> 
							</div>
						</div>
						
						<div class="col-sm-6">
							<label class="font-label">Due date :</label>
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
									<input type="text" class="form-control pull-right date2" name="ts_dueDate" id="ts_dueDate">
								</div> 
							</div>
						</div>
						
						<div class="clearfix"></div>
						<div class="col-sm-6">
							<label class="font-label">Priority <span class="requrie">(Required)</span></label>
							<div class="bootstrap-timepicker">
			                    <div class="form-group">
			                    	<select class="form-control select2"  name="ts_priority" id="ts_priority" style="width: 100%;">
				                      <option value="">--Select Priority--</option>   
				                      <option value="High">High</option>
				                      <option value="Medium">Medium</option>
				                      <option value="Low">Low</option> 
				                            
				                    </select>
			                    </div>
			                  </div>
						</div>
						
						<div class="col-sm-6">
							<label class="font-label">Assigned to </label>
							<div class="form-group">
								<select class="form-control select2"  name="ts_assignTo" id="ts_assignTo" style="width: 100%;">
			                      <option value=""></option>           
			                    </select>
							</div>
						</div>
						
						
						
					</div>

					<div class="col-sm-6">


						<div class="col-sm-6" data-ng-init="listMeetignStatus()" >
							<label class="font-label">Status <span class="requrie">(Required)</span></label>
							<div class="form-group">
								<select class="form-control select2" name="ts_status" id="ts_status" style="width: 100%;">
									<option value="">--SELECT Status</option>
									<option ng-repeat="st in status" value="{{st.taskStatusId}}">{{st.taskStatusName}}</option>
								</select>
							</div>
						</div>
						<div class="col-sm-6" data-ng-init="listContact()">
							<label class="font-label">Contact :</label>
							<div class="form-group" id="">
								<select class="form-control select2" name="ts_contact" id="ts_contact" style="width: 100%;">
									<option value="">--SELECT Contact</option>
									<option ng-repeat="st in contact" value="{{st.conID}}">{{st.conFirstName}} {{st.conLastName}}</option>
									
								</select>
							</div>
						</div>
						
						<div class="clearfix"></div>
						<div class="col-sm-6">
							<label class="font-label">Related To :</label>
							<div class="form-group">
								<select class="form-control select2" name="ts_relateTo" id="ts_relateTo" style="width: 100%;">
									<option value="">--SELECT Related--</option>
									<optgroup label="Marketing">
										<option value="Campaign">Campaign</option>
										<option value="Lead">Lead</option>
									</optgroup>
									<optgroup label="Sales">
										<option value="Customer">Customer</option>
										<option value="Contact">Contact</option>
										<option value="Opportunity">Opportunity</option>
									</optgroup>
									<optgroup label="Activities">
										<option value="Task">Tasks</option>
									</optgroup>
									<optgroup label="Support">
										<option value="Case">Case</option>
									</optgroup>
									
								</select>
						</div>
						
						</div>
						<div class="col-sm-6">
							<label class="font-label">&nbsp;</label>
							<div class="form-group">
								<select class="form-control select2" name="ts_reportType" id="ts_reportType" style="width: 100%;">
									<option value="">--SELECT--</option>
								</select>
							</div>
						</div>
					<div class="clearfix"></div>
					
						

					</div>
					<div class="clearfix"></div>
					<div class="col-sm-12">
						<div class="col-sm-12">
							<label class="font-label">Description :</label>
							<div class="form-group">
								<textarea style="height: 120px" rows="" cols="" name="ts_description" id="ts_description"	class="form-control"></textarea>
							</div>
						</div>
					</div>
					<div class="clearfix"></div>


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

