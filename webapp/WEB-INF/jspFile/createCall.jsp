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

var app = angular.module('campaign', ['angular-loading-bar', 'ngAnimate']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = false;
}]);
var self = this;
var username = "${SESSION}";

app.controller('campController',['$scope','$http',function( $scope, $http){

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
			
			swal({   
				title: "<span style='font-size: 25px;'>You are about to create call.</span>",
				text: "Click OK to continue or CANCEL to abort.",
				type: "info",
				html: true,
				showCancelButton: true,
				closeOnConfirm: false,
				showLoaderOnConfirm: true,		
			}, function(){ 
				setTimeout(function(){
					$.ajax({ 
						url : "${pageContext.request.contextPath}/call/add",
						type : "POST",
						data : JSON.stringify({ 				      
						      "startDate": getValueStringById("startDate"),
						      "callDuration": getValueStringById("duration"),
						      "callCreateBy": username,
						      "callStatus": getJsonById("callStatusId","status","int"),
						      "callDes": getValueStringById("description"),
						      "callSubject": getValueStringById("subject"),
						      "callAssignTo": getJsonById("userID","assignTo","str"),
						      "callRelatedToFieldId": getValueStringById("reportTo"),
						      "callRelatedToModuleType": getValueStringById("reportType")				      				      				      
							}),
						beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
					    }, 
					    success: function(result){					    						    
							if(result.MESSAGE == "INSERTED"){						
								
								$("#status").select2("val","");
								$("#reportType").select2("val","");
								$("#reportTo").select2("val","");
								$("#assignTo").select2("val","");
								$("#form-call").bootstrapValidator('resetForm', 'true');
								$('#form-call')[0].reset();
								$('#form-call').bootstrapValidator('resetForm', 'status');
								swal({
		    						title: "SUCCESSFUL",
		    					  	text: result.MSG,
		    					  	html: true,
		    					  	timer: 2000,
		    					  	type: "success"
		    					});			    											
			    				
																															
							}else{
								swal("UNSUCCESSFUL", result.MSG, "error");
							}
						},
			    		error:function(){
			    			alertMsgErrorSweet();
			    		} 
					});
				}, 500);
			});
			
			
		});	
	
});
</script>
	<section class="content">
		<!-- Default box -->
		<div class="box box-danger">
			<div class="box-body">
				<form method="post" id="form-call">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-left: -5px;">
						<button type="button" class="btn btn-info btn-app" id="btn_save" > <i class="fa fa-save"></i> Save</button> 
						<a class="btn btn-info btn-app" id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
						<a class="btn btn-info btn-app"  href="${pageContext.request.contextPath}/list-calls"> <i class="fa fa-reply"></i> Back </a>
					</div>
					<div class="clearfix"></div>
					<div class="col-sm-2"><h4>Overview</h4></div>
					<div class="col-sm-12"><hr style="margin-top: 3px;" /></div>
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
								<div class="col-xs-12 col-sm-12 col-md-12 col-lg-6">
									<label class="font-label">Subject <span class="requrie">(Required)</span></label>
									<div class="form-group" id="c_name">
										<input type="text" class="form-control" name="subject" id="subject">
									</div>
								</div>
								<div class="clearfix hidden-lg"></div>
								<div class="col-xs-12 col-sm-6 col-md-6 col-lg-3">
									<label class="font-label">Start date <span class="requrie">(Required)</span></label>
									<div class="form-group">
										<div class="input-group">
											<div class="input-group-addon">
												<i class="fa fa-calendar"></i>
											</div>
											<input type="text" class="form-control call-data-time pull-right" readonly="readonly" name="startDate" id="startDate">
										</div> 
									</div>
								</div>
								<div class="col-xs-12 col-sm-6 col-md-6 col-lg-3">							
				                    <div class="bootstrap-timepicker">
										<div class="form-group">
											<label>Duration <span class="requrie">(Required)</span></label>
											<div class="input-group">
												<div class="input-group-addon">
													<i class="fa fa-clock-o"></i>
												</div>
												<input type="text" class="form-control timepicker active" name="duration" id="duration" placeholder="hours:minutes" readonly="readonly">
											</div>
										</div>
									</div>
								</div>
								<div class="clearfix"></div>
								<div class="col-xs-12 col-sm-6 col-md-6 col-lg-3" data-ng-init="listStatus()" >
									<label class="font-label">Status <span class="requrie">(Required)</span></label>
									<div class="form-group">
										<select class="form-control select2-small" name="status" id="status" style="width: 100%;">
											<option value="">--SELECT Status</option>
											<option ng-repeat="st in status" value="{{st.callStatusId}}">{{st.callStatusName}}</option>
										</select>
									</div>
								</div>
								<div class="col-xs-12 col-sm-6 col-md-6 col-lg-3"  data-ng-init="listCampUser()">
									<label class="font-label">Assigned to  </label>
									<div class="form-group">
										<select class="form-control select2-small"  name="assignTo" id="assignTo" style="width: 100%;">
					                      <option value=""></option>           
					                    </select>
									</div>
								</div>
								<div class="clearfix hidden-lg"></div>
								<div class="col-xs-12 col-sm-6 col-md-6 col-lg-3">
									<label class="font-label">Related To </label>
									<div class="form-group">
										<select class="form-control select2-small" name="reportType" id="reportType" style="width: 100%;">
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
								
								<div class="col-xs-12 col-sm-6 col-md-6 col-lg-3">
									<label class="font-label">&nbsp;</label>
									<div class="form-group">
										<select class="form-control select2-small" name="reportTo" id="reportTo" style="width: 100%;">
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
			<div class="box-footer">
		</div>
		</div>
	</section>
</div>
<jsp:include page="${request.contextPath}/footer"></jsp:include>

