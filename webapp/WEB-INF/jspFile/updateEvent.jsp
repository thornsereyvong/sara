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
		<h1>Update Event</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Update Event</a></li>
		</ol>
	</section>
<script type="text/javascript">

var app = angular.module('campaign', []);
var self = this;
app.controller('campController',['$scope','$http',function($scope, $http){

	
}]);

function listStatusID(statusids){
	
	$.ajax({
		url: "${pageContext.request.contextPath}/event_location/list",
		method: "GET",
		header: "application/json",
		success: function(data){
			var dataObject = data.DATA;
			 $("#location").empty().append('<option value="">-- SELECT Location --</option>');
			$.each(data.DATA, function(key, value){
				var div = "<option value='"+value.loId+"' >"+value.loName+"</option>";
				$("#location").append(div);
			});  
			$("#location").select2("val",statusids);
			
			} 
		});
}

function listDataByCampID(){
	
	var data = ${event};
	var result = data.body.DATA;
	var user_id = ${users};
	
	$("#startDate").val(result.evStartDate);
	$("#endDate").val(result.evEndDate);
	$("#id").val(result.evId);
	$("#name").val(result.evName);
	$("#budget").val(result.evBudget);
	$("#description").val(result.evDes);

	userAllList(user_id,'#assignTo',result.userID);
	
	if(result.loId == null || result.loId == ""){
		listStatusID("");
	}else{
		listStatusID(result.loId);
	}

	$("#duration").select2("val",result.evDuration);
	
	
	if(result.evRelatedToModuleType == null || result.evRelatedToModuleId == ""){		
		$("#relateTo").select2("val","");
	}else{	
		$("#relateTo").select2("val",result.evRelatedToModuleType);
	}
	funcRelateTo("#reportType",result.evRelatedToModuleType, result.evRelatedToModuleId);
	
}


$(document).ready(function() {
 
	$("#relateTo").change(function(){
		var relate = $("#relateTo").val();
		$("#reportType").select2("val","");
		$("#reportType").empty();
		funcRelateTo("#reportType",relate,"");	
	});
	
	
	var data = ${users};
	
	$(".select2").select2();
	
	listDataByCampID();
	
	$('.date2').daterangepicker({
		singleDatePicker: true,
        showDropdowns: true,
        format: 'DD/MM/YYYY h:mm A',
        timePicker: true, 
        timePickerIncrement: 5
    }).on('change', function(e) {

		if($("#startDate").val() != ""){
			$('#form-call').bootstrapValidator('revalidateField', 'startDate');
		}

		if($("#endDate").val() != ""){
			$('#form-call').bootstrapValidator('revalidateField', 'endDate');
		}
    	
  
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
				name: {
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
				description: {
					validators: {
						stringLength: {
							max: 255,
							message: 'The description must be less than 255 characters long.'
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
	                        message: 'The value is not a valid date!'
						}
					}
				},
				endDate: {
					validators: {
						notEmpty: {
							message: 'The End Date is required and can not be empty!'
						},
						date: {
	                        format: 'DD/MM/YYYY h:mm A',
	                        message: 'The value is not a valid date!'
						}
					}
				},
				budget : {
						validators : {
							numeric: {
				                message: 'The value is not a number',
				                // The default separators
				                thousandsSeparator: '',
				                decimalSeparator: '.'
				            }
						}
					}
			}
		}).on('success.form.bv', function(e) {		
			$.ajax({
				url : "${pageContext.request.contextPath}/event/edit",
				type : "PUT",
				data : JSON.stringify({
					  "evId": $("#id").val(),					 
				      "evName": getValueStringById("name"),
				      "evLocation": getJsonById("loId","location","str"),
				      "evBudget": getValueStringById("budget"),
				      "evDes": getValueStringById("description"),
				      "evDuration": getValueStringById("duration"),
				      "startDate": getValueStringById("startDate"),
				      "endDate": getValueStringById("endDate"),
				      "assignTo": getJsonById("userID","assignTo","str"), 
				      "evRelatedToModuleId" : getValueStringById("reportType"),
				      "evRelatedToModuleType" : getValueStringById("relateTo"),
				      "evModifiedBy":  $.session.get("parentID")
 
					}),
				beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
						    },
				success:function(data){
					
						$("#form-call").bootstrapValidator('resetForm', 'true');
						$('#form-call')[0].reset();
						$("#location").select2("val","");
						$("#assignTo").select2("val","");
						$("#duration").select2("val","");
						
						swal({
		            		title:"Success",
		            		text:"User have been Update Event!",
		            		type:"success",  
		            		timer: 2000,   
		            		showConfirmButton: false
	        			});

						setTimeout(function(){
							window.location.href = "${pageContext.request.contextPath}/list-events";
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
			
			<form method="post" id="form-call">
				
				<button type="button" class="btn btn-info btn-app" id="btn_save" > <i class="fa fa-save"></i> Save</button> 
				<a class="btn btn-info btn-app" id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
				<a class="btn btn-info btn-app"  href="${pageContext.request.contextPath}/list-events"> <i class="fa fa-reply"></i> Back </a>

				<div class="clearfix"></div>

				<div class="col-sm-2">
					<h4>Overview</h4>
				</div>

				<div class="col-sm-12">
					<hr style="margin-top: 3px;" />
				</div>

				<div class="row">

					<div class="col-sm-6">

						
						<input type="hidden" id="id">
						<div class="col-sm-6">
							<label class="font-label">Name <span class="requrie">(Required)</span></label>
							<div class="form-group" id="c_name">
								<input type="text" class="form-control" name="name" id="name">
							</div>
						</div>
						
						<div class="col-sm-6" data-ng-init="listMeetignStatus()">
							<label class="font-label">Location  </label>
							<div class="form-group">
								<select class="form-control select2"  name="location" id="location" style="width: 100%;">
			                      <option value="">-- Select Location</option>
			                      <option ng-repeat="u in status" value="{{u.loId}}">{{u.loName}}</option>            
			                    </select>
							</div>
						</div>
						
						<div class="clearfix"></div>
						
						<div class="col-sm-6">
							<label class="font-label">Duration</label>
							<div class="bootstrap-timepicker">
			                    <div class="form-group">
			                    	<select class="form-control select2"  name="duration" id="duration" style="width: 100%;">
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
							<label class="font-label">Assigned to</label>
							<div class="form-group">
								<select class="form-control select2"  name="assignTo" id="assignTo" style="width: 100%;">
			                      <option value=""></option>           
			                    </select>
							</div>
						</div>
						
						<div class="clearfix"></div>
						<div class="col-sm-12">
							<label class="font-label">Description :</label>
							<div class="form-group">
								<textarea style="height: 120px" rows="" cols="" name="description" id="description"	class="form-control"></textarea>
							</div>
						</div>
						
					</div>

					<div class="col-sm-6">
						<div class="col-sm-6">
							<label class="font-label">Start date </label>
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
									<input type="text" class="form-control pull-right date2" name="startDate" id="startDate">
								</div> 
							</div>
						</div>
						
						<div class="col-sm-6">
							<label class="font-label">End date </label>
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
									<input type="text" class="form-control pull-right date2" name="endDate" id="endDate">
								</div> 
							</div>
						</div>
						<div class="clearfix"></div>
						<div class="col-sm-6">
							<label class="font-label">Related to </label>
							<div class="form-group">								
								<select class="form-control select2" name="relateTo" id="relateTo" style="width: 100%;">
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
								<select class="form-control select2" name="reportType" id="reportType">
									<option value="">--SELECT--</option>
								</select>
							</div>
						</div>
						<div class="clearfix"></div>
						<div class="col-sm-6">
							<label class="font-label">Budget </label>
							<div class="form-group" id="">
								<input type="text" class="form-control" name="budget" id="budget">
							</div>
						</div>
						
					</div>
					

					<div class="clearfix"></div>


				</div>
			</form>
			
			<div id="errors"></div>
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

