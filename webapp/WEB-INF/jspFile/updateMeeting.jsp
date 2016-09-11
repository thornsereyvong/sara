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
		<h1>Update Meeting</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"> Update Meeting</a></li>
		</ol>
	</section>
<script type="text/javascript">

var app = angular.module('campaign', ['oitozero.ngSweetAlert',]);
var self = this;
app.controller('campController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){

}]);


function listStatusID(statusids){
	
	$.ajax({
		url: "${pageContext.request.contextPath}/meeting_status/list",
		method: "GET",
		header: "application/json",
		success: function(data){
			var dataObject = data.DATA;
			 $("#me_status").empty().append('<option value="">-- SELECT Status --</option>');
			$.each(data.DATA, function(key, value){
				var div = "<option value='"+value.statusId+"' >"+value.statusName+"</option>";
				$("#me_status").append(div);
			});  
			$("#me_status").select2("val",statusids);
			
			} 
		});
}

function listDataByCampID(){
	var data = ${meeting};
	var result = data.body.DATA;
	var user_id = ${users};
	$("#me_startDate").val(result.meetingStartDate);
	var end = new Date(result.meetingEndDate);
	$("#me_endDate").val(result.meetingEndDate);
	$("#me_id").val(result.meetingId);
	$("#me_subject").val(result.meetingSubject);
	$("#me_location").val(result.meetingLocation);
	$("#me_description").val(result.meetingDes);

	userAllList(user_id,'#me_assignTo',result.userID);
	
	if(result.statusId == null || result.statusId == ""){
		listStatusID("");
	}else{
		listStatusID(result.statusId);
	}

	$("#me_duration").select2("val",result.meetingDuration);
	
	if(result.meetingRelatedToModuleType == null || result.meetingRelatedToModuleType == ""){
		$("#me_relateTo").select2("val","");
	}else{
		$("#me_relateTo").select2("val",result.meetingRelatedToModuleType);
	}
	
	funcRelateTo("#me_reportType",result.meetingRelatedToModuleType, result.meetingRelatedToModuleId);
	
	
}

$(document).ready(function() {

	$(".select2").select2();
	
	listDataByCampID();

	$("#me_relateTo").change(function(){
		var relate = $("#me_relateTo").val();
		$("#me_reportType").select2("val","");
		$("#me_reportType").empty();
		funcRelateTo("#me_reportType",relate,"");
	});

	
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
    
	
	
	$("#btn_clear").click(function(){
		location.reload();
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
		    var assign = "";	
			if($("#me_assignTo").val()  != ""){
				assign = {"userID": $("#me_assignTo").val()};
			}else{
				assign = null;
			}

			var status = "";	
			if($("#me_status").val()  != ""){
				status = {"statusId": $("#me_status").val()};
			}else{
				status = null;
			}

			$.ajax({
				url : "${pageContext.request.contextPath}/meeting/edit",
				type : "PUT",
				data : JSON.stringify({
					  "meetingId":$("#me_id").val(),
					  "meetingSubject": $("#me_subject").val(),
				      "meetingAssignTo": assign,
				      "meetingDes":$("#me_description").val(),
				      "startDate":  $("#me_startDate").val(),
				      "meetingDuration": $("#me_duration").val(),
				      "endDate":  $("#me_endDate").val(),
				      "meetingStatus": status,
				      "meetingLocation":  $("#me_location").val(),
				      "meetingRelatedToModuleType": $("#me_relateTo").val(),
				      "meetingRelatedToModuleId": $("#me_reportType").val(),
				      "meetingModifiedBy": $.session.get("parentID")
					}),
				beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
						    },
				success:function(data){
					
						$("#form-meeting").bootstrapValidator('resetForm', 'true');
						$('#form-meeting')[0].reset();
						$("#me_status").select2("val","");
						$("#me_relateTo").select2("val","");
						$("#me_reportType").select2("val","");
						$("#me_assignTo").select2("val","");
						$("#me_duration").select2("val","");
						
						swal({
		            		title:"Success",
		            		text:"User have been Update Meeting!",
		            		type:"success",  
		            		timer: 2000,   
		            		showConfirmButton: false
	        			});

						setTimeout(function(){
							window.location.href = "${pageContext.request.contextPath}/list-meetings";
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

						<input type="hidden" id="me_id">

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

