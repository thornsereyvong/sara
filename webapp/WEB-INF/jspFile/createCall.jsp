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
		<h1>Create Call</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"> Create Call</a></li>
		</ol>
	</section>
<script type="text/javascript">

var app = angular.module('campaign', ['oitozero.ngSweetAlert',]);
var self = this;
app.controller('campController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){

	$scope.listStatus = function(){
		$http.get("${pageContext.request.contextPath}/call_status/list")
		.success(function(response){
				$scope.status = response.DATA;
			});
	};	
	

}]);


$(document).ready(function() {

	$(".timepicker").timepicker({
		format: 'h:mm',
        showInputs: false,
        minuteStep: 5,
        defaultTime: false,
        showMeridian : false
    }).on('change', function(e) {
     	$('#form-call').bootstrapValidator('revalidateField', 'duration');
 	});
	
	$('.call-data-time').daterangepicker({
        format: 'DD/MM/YYYY h:mm A',
        singleDatePicker: true,
        showDropdowns: true,
        timePicker: true, 
        timePickerIncrement: 5,
    }).on('change', function(e) {
     	$('#form-call').bootstrapValidator('revalidateField', 'startDate');
 	});
	
	
	var data = ${users};
	$(".select2").select2();
	
	$("#reportType").change(function(){
		var relate = $("#reportType").val();
		funcRelateTo("#reportTo",relate,"");
	});
    
	
	userAllList(data,'#assignTo','');
	
	$("#btn_clear").click(function(){
		$("#form-call").bootstrapValidator('resetForm', 'true');
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
				subject: {
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
				startDate: {
					validators: {
						notEmpty: {
							message: 'The Start Date is required and can not be empty!'
						},
						date: {
	                        format: 'DD/MM/YYYY h:mm A',
	                        message: 'The value is not a valid date'
	                    }
					}
				},
				duration : {
					validators: {
						notEmpty: {
							message: 'The duration is required and can not be empty!'
						},
						stringLength: {
							max: 5,
							message: 'The duration must be less than 5 characters long.'
						}
					}
				},
				status : {
					validators: {
						notEmpty: {
							message: 'The Status is required and can not be empty!'
						}
					}
				},
				description : {
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
				if($("#assignTo").val()  != ""){
					assign = {"userID": $("#assignTo").val()};
				}else{
					assign = null;
				}

				var status = "";	
				if($("#status").val()  != ""){
					status = {"callStatusId": $("#status").val()};
				}else{
					status = null;
				}
			
			$.ajax({
				url : "${pageContext.request.contextPath}/call/add",
				type : "POST",
				data : JSON.stringify({ 

				      "startDate":  $("#startDate").val(),
				      "callDuration": $("#duration").val(),
				      "callCreateBy": $.session.get("parentID"),
				      "callStatus": status,
				      "callDes": $("#description").val(),
				      "callSubject": $("#subject").val(),
				      "callAssignTo": assign,
				      "callRelatedToFieldId": $("#reportTo").val(),
				      "callRelatedToModuleType": $("#reportType").val()
				      
					}),
				beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
						    },
				success:function(data){
					
						$("#form-call").bootstrapValidator('resetForm', 'true');
						$('#form-call')[0].reset();
						$("#status").select2("val","");
						$("#reportType").select2("val","");
						$("#reportTo").select2("val","");
						$("#assignTo").select2("val","");
						$('#form-call').bootstrapValidator('resetForm', 'status');
						swal({
		            		title:"Success",
		            		text:"User have been created new Call!",
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
			
			<form method="post" id="form-call">
				
				<button type="button" class="btn btn-info btn-app" id="btn_save" > <i class="fa fa-save"></i> Save</button> 
				<a class="btn btn-info btn-app" id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
				<a class="btn btn-info btn-app"  href="${pageContext.request.contextPath}/list-calls"> <i class="fa fa-reply"></i> Back </a>

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

						<div class="col-sm-12">
							<label class="font-label">Subject <span class="requrie">(Required)</span></label>
							<div class="form-group" id="c_name">
								<input type="text" class="form-control" name="subject" id="subject">
							</div>
						</div>
						<div class="clearfix"></div>
						<div class="col-sm-6">
							<label class="font-label">Start date <span class="requrie">(Required)</span></label>
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
									<input type="text" class="form-control call-data-time pull-right" name="startDate" id="startDate">
								</div> 
							</div>
						</div>
						
						
						<div class="col-sm-6">							
		                    <div class="bootstrap-timepicker">
								<div class="form-group">
									<label>Duration <span class="requrie">(Required)</span></label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-clock-o"></i>
										</div>
										<input type="text" class="form-control timepicker active" name="duration" id="duration" placeholder="hours:minutes">
									</div>
								</div>
							</div>
						</div>
						
						
						
						
					</div>

					<div class="col-sm-6">

						<div class="col-sm-6" data-ng-init="listStatus()" >
							<label class="font-label">Status <span class="requrie">(Required)</span></label>
							<div class="form-group">
								<select class="form-control select2" name="status" id="status" style="width: 100%;">
									<option value="">--SELECT Status</option>
									<option ng-repeat="st in status" value="{{st.callStatusId}}">{{st.callStatusName}}</option>
								</select>
							</div>
						</div>
						<div class="col-sm-6"  data-ng-init="listCampUser()">
							<label class="font-label">Assigned to  </label>
							<div class="form-group">
								<select class="form-control select2"  name="assignTo" id="assignTo" style="width: 100%;">
			                      <option value=""></option>           
			                    </select>
							</div>
							
						</div>
						<div class="clearfix"></div>
						<div class="col-sm-6">
							<label class="font-label">Related To </label>
							<div class="form-group">
								<select class="form-control select2" name="reportType" id="reportType" style="width: 100%;">
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
								<select class="form-control select2" name="reportTo" id="reportTo" style="width: 100%;">
									<option value="">--SELECT--</option>
								</select>
							</div>
						</div>

					</div>
					<div class="clearfix"></div>
					<div class="col-sm-12">
						<div class="col-sm-12">
							<label class="font-label">Description </label>
							<div class="form-group">
								<textarea style="height: 120px" rows="" cols="" name="description" id="description"	class="form-control"></textarea>
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

