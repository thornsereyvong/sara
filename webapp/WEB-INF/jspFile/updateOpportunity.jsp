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
<div class="content-wrapper" class="content-wrapper" ng-app="campaign" ng-controller="campController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Update Opportunity</h1>
		<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li><a href="#"> Update Opportunity</a></li>
		</ol>
	</section>
<script type="text/javascript">


var app = angular.module('campaign', ['oitozero.ngSweetAlert',]);
var self = this;
app.controller('campController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){



}]);



function listSourceID(userID){
	$.ajax({
		url: "${pageContext.request.contextPath}/lead_source/list",
		method: "GET",
		header: "application/json",
		success: function(data){
			var dataObject = data.DATA;
			 $("#op_leadSource").empty().append('<option value="">-- SELECT Lead Source --</option>');
			 
			$.each(dataObject, function(key, value){
					var div = "<option value='"+value.sourceID+"' >"+value.sourceName+"</option>";
				$("#op_leadSource").append(div);
			}); 
			 
			$("#op_leadSource").select2("val",userID);
			
			} 
	});
}


function listCustomerID(userID){
	$.ajax({
		url: "${pageContext.request.contextPath}/customer/list",
		method: "GET",
		header: "application/json",
		success: function(data){
			var dataObject = data.DATA;
			 $("#op_customer").empty().append('<option value="">-- SELECT Customer --</option>');
			 
			$.each(dataObject, function(key, value){
					var div = "<option value='"+value.custID+"' >"+value.custName+"</option>";
				$("#op_customer").append(div);
			}); 
			 
			$("#op_customer").select2("val",userID);
			
			} 
	});
}

function listParentID(parent){
	$.ajax({
		url: "${pageContext.request.contextPath}/campaign/list",
		method: "GET",
		header: "application/json",
		success: function(data){
			var dataObject = data.DATA;
			 $("#op_campaign").empty().append('<option value="">-- SELECT Campiagn --</option>');
			$.each(dataObject, function(key, value){
					var div = "<option value='"+value.campID+"' >"+value.campName+"</option>";
				$("#op_campaign").append(div);
			});  
			$("#op_campaign").select2("val",parent);
			
			} 
		});
}

function listTypeID(parent){
	$.ajax({
		url: "${pageContext.request.contextPath}/op_type/list",
		method: "GET",
		header: "application/json",
		success: function(data){
			var dataObject = data.DATA;
			 $("#op_type").empty().append('<option value="">-- SELECT Type --</option>');
			$.each(dataObject, function(key, value){
					var div = "<option value='"+value.otId+"' >"+value.otName+"</option>";
				$("#op_type").append(div);
			});  
			$("#op_type").select2("val",parent);
			
			} 
		});
}

function listStageID(parent){
	$.ajax({
		url: "${pageContext.request.contextPath}/op_stage/list",
		method: "GET",
		header: "application/json",
		success: function(data){
			var dataObject = data.DATA;
			 $("#op_stage").empty().append('<option value="">-- SELECT Stage --</option>');
			$.each(dataObject, function(key, value){
					var div = "<option value='"+value.osId+"' >"+value.osName+"</option>";
				$("#op_stage").append(div);
			});  
			$("#op_stage").select2("val",parent);
			
			} 
		});
}


function listDataByOpp(){
	
	var data = ${opp};
	var result = data.body.DATA;
	var userid = ${users};
	
	
	$("#op_id").val(result.opId);
	$("#op_name").val(result.opName);
	$("#op_amount").val(result.opAmount);

	var d = new Date(result.opCloseDate);
	var dd = d.getDate();
	var mm = d.getMonth()+1;
	var yy = d.getFullYear();
	
	$("#op_colseDate").val(dd+"/"+mm+"/"+yy);

	
	$("#op_probability").val(result.opProbability);
	$("#op_nextStep").val(result.opNextStep);
	$("#cam_description").val(result.opDes);


	if(result.userID == null || result.userID == "")
		userAllList(userid,'#op_assignTo','');
	else
		userAllList(userid,'#op_assignTo',result.userID);
	 

	if(result.custID == null || result.custID == "")
		listCustomerID("");
	else
		listCustomerID(result.custID);

	if(result.sourceID == null || result.sourceID == ""){
		listSourceID("");
	}else{
		listSourceID(result.sourceID);
	}

	if(result.campID == null || result.campID == ""){
		listParentID("");
	}else{
		listParentID(result.campID);
	}
	

	if(result.otId == null || result.otId == ""){
		listTypeID("");
	}else{
		listTypeID(result.otId);
	}

	if(result.osId == null || result.osId == ""){
		listStageID("");
	}else{
		listStageID(result.osId);
	}
	
}

$(document).ready(function() {
    
	$(".select2").select2();

	$('#op_colseDate').daterangepicker({
        singleDatePicker: true,
        showDropdowns: true,
        format: 'DD/MM/YYYY'
    });
    
	listDataByOpp();
	
	$("#btn_save").click(function(){
		$("#form-opportunity").submit();
	});
	
	$("#btn_clear").click(function(){
		$("#form-opportunity").bootstrapValidator('resetForm', 'true');
		$('#form-opportunity')[0].reset();
		$("#op_customer").select2("val","");
		$("#op_stage").select2("val","");
		$("#op_type").select2("val","");
		$("#op_leadSource").select2("val","");
		$("#op_campaign").select2("val","");
	});

	
	$('#form-opportunity').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {	
			op_name: {
				validators: {
					notEmpty: {
						message: 'The  name is required and can not be empty!'
					},
					stringLength: {
						max: 255,
						message: 'The name must be less than 255 characters long.'
					}
				}
			},
			op_amount: {
				validators: {
					notEmpty: {
						message: 'The  amount is required and can not be empty!'
					},
					numeric: {
		                message: 'The value is not a number',
		                // The default separators
		                thousandsSeparator: '',
		                decimalSeparator: '.'
		            }
				}
			},
			op_customer: {
				validators: {
					notEmpty: {
						message: 'The  customer is required and can not be empty!'
					}
				}
			},
			op_colseDate: {
				validators: {
					notEmpty: {
						message: 'The  close date is required and can not be empty!'
					},
					date: {
                        format: 'DD/MM/YYYY',
                        message: 'The value is not a valid date'
                    }
				}
			},
			op_probability: {
				validators: {
					numeric: {
		                message: 'The value is not a number',
		                // The default separators
		                thousandsSeparator: '',
		                decimalSeparator: '.'
		            },
					between: {
                        min: 1,
                        max: 100,
                        message: 'The latitude must be between 1 and 99'
                    }
				}
			},
			op_stage: {
				validators: {
					notEmpty: {
						message: 'The  stage is required and can not be empty!'
					}
				}
			}
			,
			op_nextStep: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The step must be less than 255 characters long.'
					}
				}
			}
			,
			cam_description: {
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


		var type = "";	
		if($("#op_type").val()  != "")
			type = {"otId": $("#op_type").val()};
		else
			type = null;

		var camp = "";	
		if($("#op_campaign").val()  != "")
			camp = {"campID": $("#op_campaign").val()};
		else
			camp = null;

		var stage = "";
		if($("#op_stage").val()  != "")
			stage = {"osId": $("#op_stage").val()};
		else
			stage = null;

		var source = "";
		if($("#op_leadSource").val()  != "")
			source = {"sourceID": $("#op_leadSource").val()};
		else
			source = null;

		var custID = "";
		if($("#op_customer").val()  != "")
			custID = {"custID": $("#op_customer").val()};
		else
			custID = null;

		var assing = "";
		if($("#op_assignTo").val()  != "")
			assing = {"userID": $("#op_assignTo").val()};
		else
			assing = null;

		var createDate = $("#op_colseDate").val();
		var opCloseDate = createDate.split("/").reverse().join("-");
		
		$.ajax({
			url : "${pageContext.request.contextPath}/opportunity/edit",
			type : "PUT",
			data : JSON.stringify({
				 "opId": $("#op_id").val(),
			      "opName": $("#op_name").val(),
			      "opAmount": $("#op_amount").val(),
			      "customer":custID,
			      "opCloseDate": opCloseDate,
			      "opTypeID": type,
			      "opStageId": stage,
			      "opProbability": $("#op_probability").val(),
			      "opLeadSourceID": source,
			      "opNextStep": $("#op_nextStep").val(),
			      "opCampId": camp,
			      "opDes": $("#cam_description").val(),
			      "opAssignedTo": assing,
			      "opModifyBy": $.session.get("parentID")  
			    }),	
			beforeSend: function(xhr) {
					    xhr.setRequestHeader("Accept", "application/json");
					    xhr.setRequestHeader("Content-Type", "application/json");
					    },
			success:function(data){
				
					$("#form-opportunity").bootstrapValidator('resetForm', 'true');
					$('#form-opportunity')[0].reset();		
					$("#op_customer").select2("val","");
					$("#op_stage").select2("val","");
					$("#op_type").select2("val","");
					$("#op_leadSource").select2("val","");
					$("#op_campaign").select2("val","");
					
					swal({
	            		title:"Success",
	            		text:"User have been Update Opportunity!",
	            		type:"success",  
	            		timer: 2000,   
	            		showConfirmButton: false
        			});

					setTimeout(function(){
						window.location.href = "${pageContext.request.contextPath}/list-opportunity/";
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
			
			<form method="post" id="form-opportunity">
				
				<button type="button" class="btn btn-info btn-app" id="btn_save"> <i class="fa fa-save"></i> Save</button> 
				<a class="btn btn-info btn-app" id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
				<a class="btn btn-info btn-app" href="${pageContext.request.contextPath}/list-opportunity"> <i class="fa fa-reply"></i> Back </a>

				<div class="clearfix"></div>

				<div class="col-sm-2">
					<h4>Overview</h4>
				</div>
				<input type="hidden" class="form-control" id="op_id" name="op_id">
				<div class="col-sm-12">
					<hr style="margin-top: 3px;" />
				</div>

				<div class="row">

					<div class="col-sm-6">
						<div class="col-sm-6">
							<label class="font-label">Name <span class="requrie">(Required)</span></label>
							<div class="form-group">
								<input type="text" class="form-control" id="op_name" name="op_name">
							</div>
						</div>
						
						<div class="col-sm-6">
							<label class="font-label">Amount <span class="requrie">(Required)</span></label>
							<div class="form-group">
								<input type="text" class="form-control" id="op_amount" name="op_amount">
							</div>
						</div>
						
						
						<div class="col-sm-6" data-ng-init="listCustomer()">
							<label class="font-label">Customer <span class="requrie">(Required)</span></label>
							<div class="form-group">
								<select class="form-control select2" name="op_customer" id="op_customer" style="width: 100%;">
									<option value="">-- SELECT Customer --</option>
									
								</select>
							</div>
						</div>
						
						
						<div class="col-sm-6">
							<label class="font-label">Close date <span class="requrie">(Required)</span></label>
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
									<input type="text" class="form-control pull-right" name="op_colseDate" id="op_colseDate">
								</div> 
							</div>
						</div>
						
						
						
						
						
						
						<div class="col-sm-6">
							<label class="font-label">Next Step </label>
							<div class="form-group">
								<input type="text" class="form-control" id="op_nextStep" name="op_nextStep">
							</div>
						</div>
						
						
						<div class="col-sm-6"  data-ng-init="listCampaigns()" >
							<label class="font-label">Campaign </label>
							<div class="form-group">
								<select class="form-control select2" name="op_campaign" id="op_campaign" style="width: 100%;">
									<option value="">-- SELECT Campaign --</option>
									
								</select>
							</div>
						</div>
						
						
						<div class="col-sm-12">
							<label class="font-label">Description </label>
							<div class="form-group">
								<textarea style="height: 120px" rows="" cols="" name="cam_description" id="cam_description"
									class="form-control"></textarea>
							</div>
						</div>
						
						
					</div>

					<div class="col-sm-6">
						
						<div class="col-sm-6"  data-ng-init="listType()" >
							<label class="font-label">Type </label>
							<div class="form-group">
								<select class="form-control select2" name="op_type" id="op_type" style="width: 100%;">
									<option value="">-- SELECT Type --</option>
									 
								</select>
							</div>
						</div>
						
						<div class="col-sm-6" data-ng-init="listStage()">
							<label class="font-label ">Stage <span class="requrie">(Required)</span></label>
							<div class="form-group">
								<select class="form-control select2" name="op_stage" id="op_stage" style="width: 100%;">
									<option value="">-- SELECT Stage --</option>
									
								</select>
							</div>
						</div>
						
						<div class="col-sm-6">
							<label class="font-label">Probability (%) </label>
							<div class="form-group">
								<input type="text" class="form-control" id="op_probability" name="op_probability">
							</div>
						</div>
						
						<div class="col-sm-6" data-ng-init="listLeadSource()">
							<label class="font-label">Lead Source </label>
							<div class="form-group">
								<select class="form-control select2" name="op_leadSource" id="op_leadSource" style="width: 100%;">
									<option value="">-- SELECT Lead Source --</option>
									
								</select>
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
				
					<div class="col-sm-3" data-ng-init="listUser()">
							<label class="font-label">Assigned to : </label>
							<div class="form-group">
								<select class="form-control select2"  name="op_assignTo" id="op_assignTo" style="width: 100%;">
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

