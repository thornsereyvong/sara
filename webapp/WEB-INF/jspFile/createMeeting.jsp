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
		<h1>Create Meeting</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"> Create Meeting</a></li>
		</ol>
	</section>
<script type="text/javascript">

var app = angular.module('campaign', ['angular-loading-bar', 'ngAnimate']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = false;
}]);
var self = this;
var username =  "${SESSION}";

app.controller('campController',['$scope','$http',function($scope, $http){

	$scope.listMeetignStatus = function(){
		$http.get("${pageContext.request.contextPath}/meeting_status/list")
		.success(function(response){
				$scope.status = response.DATA;
			});
		};	


}]);




$(document).ready(function() {

	$("#me_relateTo").change(function(){
		var relate = $("#me_relateTo").val();
		funcRelateTo("#me_reportType",relate,"");
	});

	 
	var data = ${users};
	$(".select2").select2();
	
	$('.date2').daterangepicker({
        singleDatePicker: true,
        showDropdowns: true,
        format: 'DD/MM/YYYY' 
    }).on('change', function(e) {

        if($("#me_startDate" != "")){
        	$('#form-meeting').bootstrapValidator('revalidateField', 'me_startDate');
         }

        if($("#me_endDate" != "")){
        	$('#form-meeting').bootstrapValidator('revalidateField', 'me_endDate');
         }
    	 
    });

	$(".timepicker").timepicker({
		format: 'h:mm',
        showInputs: false,
        minuteStep: 5,
        defaultTime: false,
        showMeridian : false
    }).on('change', function(e) {
     	$('#form-meeting').bootstrapValidator('revalidateField', 'duration');
 	});
	$('.meet-data-time').daterangepicker({
        format: 'DD/MM/YYYY h:mm A',
        singleDatePicker: true,
        showDropdowns: true,
        timePicker: true, 
        timePickerIncrement: 5,
    }).on('change', function(e) {
    	$('#form-meeting').bootstrapValidator('revalidateField', 'me_startDate');
    	$('#form-meeting').bootstrapValidator('revalidateField', 'me_endDate');
 	});
    
	userAllList(data,'#me_assignTo','');
	
	$("#btn_clear").click(function(){
		$("#form-meeting").bootstrapValidator('resetForm', 'true');
	});
	
	 $("#btn_save").click(function(){
		$("#form-meeting").submit();
	});


		
	$('#form-meeting').bootstrapValidator({
			message: 'This value is not valid',
			feedbackIcons: {
				valid: 'glyphicon glyphicon-ok',
				invalid: 'glyphicon glyphicon-remove',
				validating: 'glyphicon glyphicon-refresh'
			},
			fields: {
				me_subject: {
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
				me_startDate: {
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
				me_endDate: {
					validators: {
						notEmpty: {
							message: 'The End Date is required and can not be empty!'
						},
						date: {
	                        format: 'DD/MM/YYYY h:mm A',
	                        message: 'The value is not a valid date'
	                    }
					}
				},
				me_description: {
					validators: {
						stringLength: {
							max: 1000,
							message: 'The description must be less than 1000 characters long.'
						}
					}
				}
				,
				me_location: {
					validators: {
						stringLength: {
							max: 255,
							message: 'The location must be less than 255 characters long.'
						}
					}
				}
				
			}
		}).on('success.form.bv', function(e) {
			
			swal({   
				title: "<span style='font-size: 25px;'>You are about to create meeting.</span>",
				text: "Click OK to continue or CANCEL to abort.",
				type: "info",
				html: true,
				showCancelButton: true,
				closeOnConfirm: false,
				showLoaderOnConfirm: true,		
			}, function(){ 
				setTimeout(function(){
					$.ajax({ 
						url : "${pageContext.request.contextPath}/meeting/add",
						type : "POST",
						data : JSON.stringify({					   		
						      "meetingSubject": getValueStringById("me_subject"),
						      "meetingAssignTo": getJsonById("userID","me_assignTo","str"),
						      "meetingDes": getValueStringById("me_description"),
						      "startDate": getValueStringById("me_startDate"),
						      "meetingDuration": getValueStringById("me_duration"),
						      "endDate":  getValueStringById("me_endDate"),
						      "meetingStatus": getJsonById("statusId","me_status","int"),
						      "meetingLocation":  getValueStringById("me_location"),
						      "meetingRelatedToModuleType": getValueStringById("me_relateTo"),
						      "meetingRelatedToModuleId": getValueStringById("me_reportType"),
						      "meetingCreateBy": username  				    
						}),
						beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
					    }, 
					    success: function(result){					    						    
							if(result.MESSAGE == "INSERTED"){						
								
								swal({
		    						title: "SUCCESSFUL",
		    					  	text: result.MSG,
		    					  	html: true,
		    					  	timer: 2000,
		    					  	type: "success"
		    					});			    											
								setTimeout(function(){
									location.reload();
								},2000);
																															
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
			
			<form method="post" id="form-meeting">
				
				<button type="button" class="btn btn-info btn-app" id="btn_save" > <i class="fa fa-save"></i> Save</button> 
				<a class="btn btn-info btn-app" id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
				<a class="btn btn-info btn-app"  href="${pageContext.request.contextPath}/list-meetings"> <i class="fa fa-reply"></i> Back </a>

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
								<input type="text" class="form-control" name="me_subject" id="me_subject">
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
									<input type="text" class="form-control pull-right meet-data-time" name="me_startDate" id="me_startDate">
								</div> 
							</div>
						</div>
					
						<div class="col-sm-6">
							<label class="font-label">End date <span class="requrie">(Required)</span></label>
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
									<input type="text" class="form-control pull-right meet-data-time" name="me_endDate" id="me_endDate">
								</div> 
							</div>
						</div>
						
						<div class="clearfix"></div>
						<div class="col-sm-6">
							<label class="font-label">Duration </label>
							<div class="bootstrap-timepicker">
			                    <div class="form-group">
			                    	<select class="form-control select2"  name="me_duration" id="me_duration" style="width: 100%;">
				                      <option value="">--Select Duration--</option>   
				                      <option value="15 minutes">15 minutes</option>
				                      <option value="30 minutes">30 minutes</option>
				                      <option value="45 minutes">45 minutes</option> 
				                      <option value="1 hour">1 hour</option> 
				                      <option value="1:30 hours">1:30 hours</option> 
				                      <option value="2 hours">2 hours</option> 
				                      <option value="3 hours">3 hours</option> 
				                      <option value="6 hours">6 hours</option> 
				                      <option value="1 day">1 day</option>
				                      <option value="2 days">2 days</option>
				                      <option value="3 days">3 days</option>
				                      <option value="1 week">1 week</option>         
				                    </select>
			                    </div>
			                  </div>
						</div>
						
						<div class="col-sm-6">
							<label class="font-label">Assigned to </label>
							<div class="form-group">
								<select class="form-control select2"  name="me_assignTo" id="me_assignTo" style="width: 100%;">
			                      <option value=""></option>           
			                    </select>
							</div>
						</div>
					
						
						
					</div>

					<div class="col-sm-6">


						<div class="col-sm-6" data-ng-init="listMeetignStatus()" >
							<label class="font-label">Status :</label>
							<div class="form-group">
								<select class="form-control select2" name="me_status" id="me_status" style="width: 100%;">
									<option value="">--SELECT Status</option>
									<option ng-repeat="st in status" value="{{st.statusId}}">{{st.statusName}}</option>
								</select>
							</div>
						</div>
					
						<div class="col-sm-6">
							<label class="font-label">Location :</label>
							<div class="form-group" id="">
								<input type="text" class="form-control" name="me_location" id="me_location">
							</div>
						</div>
						
						<div class="clearfix"></div>
						<div class="col-sm-6">
							<label class="font-label">Related to </label>
							<div class="form-group">								
								<select class="form-control select2" name="me_relateTo" id="me_relateTo" style="width: 100%;">
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
						<label class="font-label">&nbsp; </label>
							<div class="form-group">
								<select class="form-control select2" name="me_reportType" id="me_reportType">
									<option value="">--SELECT--</option>
								</select>
							</div>
						</div>

					</div>
					

					<div class="clearfix"></div>
					<div class="clearfix"></div>
					<div class="col-sm-12">
						<div class="col-sm-12">
							<label class="font-label">Description :</label>
							<div class="form-group">
								<textarea style="height: 120px" rows="" cols="" name="me_description" id="me_description"	class="form-control"></textarea>
							</div>
						</div>
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

