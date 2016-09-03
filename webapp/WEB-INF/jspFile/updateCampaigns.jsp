<%@page import="com.app.entities.CrmCampaign"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>

<style>
.font-label {
	font-size: 13px;
	padding-top: 4px;
}
</style>
<div class="content-wrapper" ng-app="campaign" ng-controller="campController" id="campController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Update Campaign</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Update Campaign</a></li>
		</ol>
	</section>
<script type="text/javascript">

var app = angular.module('campaign', ['oitozero.ngSweetAlert',]);
var self = this;
app.controller('campController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){


}]);



 function listStatusID(statusids){
	
		$.ajax({
			url: "${pageContext.request.contextPath}/camp_status/list",
			method: "GET",
			header: "application/json",
			success: function(data){
				var dataObject = data.DATA;
				 $("#cam_status").empty().append('<option value="">-- SELECT Status --</option>');
				$.each(data.DATA, function(key, value){
					var div = "<option value='"+value.statusID+"' >"+value.statusName+"</option>";
					$("#cam_status").append(div);
				});  
				$("#cam_status").select2("val",statusids);
				
				} 
			});
	}

 function listTypeID(type){
		$.ajax({
			url: "${pageContext.request.contextPath}/camp_type/list",
			method: "GET",
			header: "application/json",
			success: function(data){
				var dataObject = data.DATA;
				 $("#cam_type").empty().append('<option value="">-- SELECT Type --</option>');
				$.each(dataObject, function(key, value){
					var div = "<option value='"+value.typeID+"' >"+value.typeName+"</option>";
					$("#cam_type").append(div);
				});  
				$("#cam_type").select2("val",type);
				} 
			});
	}

 function listParentID(parent,not_equal){
	    var parent = ${parent};
	    $("#cam_parent").empty().append('<option value="">-- SELECT Parent --</option>');
	    if(parent.body.DATA != ""){
				$.each(parent.body.DATA, function(key, value){
						var div = "<option value='"+value.campID+"' >"+value.campName+"</option>";
					$("#cam_parent").append(div);
				});  
				$("#cam_parent").select2("val",parent);
		   } 
	    $("#cam_parent").select2("val","");
	}
 

function listDataByCampID(){
	
	var data = ${campaign};
	var user_id = ${users};
	
	var result = data.body.DATA;
	
	
	$("#cam_id").val(result.campID);
	$("#cam_name").val(result.campName);

	
	var d = new Date(result.startDate);
	var dd = d.getDate();
	var mm = d.getMonth()+1;
	var yy = d.getFullYear();
	
	$("#cam_startDate").val(dd+"/"+mm+"/"+yy);

	
	var end = new Date(result.endDate);
	
	var dds = end.getDate();
	var mms = end.getMonth()+1;
	var yys = end.getFullYear();
	
	$("#cam_endDate").val(dds+"/"+mms+"/"+yys);

	

	$("#cam_description").val(result.description);
	
	$("#cam_budget").val(result.budget);
	$("#cam_actualCost").val(result.actualCost);
	$("#cam_expectedCost").val(result.expectedCost);
	$("#cam_expectedRevenue").val(result.expectedRevenue);
	$("#cam_numSend").val(result.numSend);
	$("#cam_expectedResponse").val(result.expectedResponse);

	//listCampUserID(result.assignTo);

	
	userAllList(user_id,'#cam_assignTo',result.userID);
	
	
	
	
	if(result.statusID == null || result.statusID == ""){
		listStatusID("");
	}else{	
		listStatusID(result.statusID);
	}

	if(result.typeID == null || result.typeID == ""){
		listTypeID("");
	}else{
		listTypeID(result.typeID);
	}

	
	if(result.parentID == null || result.parentID == ""){
		listParentID("",result.campID);
	}else{
		listParentID(result.parentID, result.campID);
	}
	
}


$(document).ready(function() {
	$(".select2").select2();
	
	listDataByCampID();
	
	function clearForm(){
		$("#cam_startDate").val("");
		$("#cam_parent").val("");
		$("#cam_description").val("");
		$("#cam_assignTo").val("");
	}

	$("#cam_name").change(function(){	
		var name = $("#cam_name").val();
		
		$.ajax({
			url: "${pageContext.request.contextPath}/campaign/list/validate/"+name,
			method: "GET",
			header: "application/json",
			statusCode: {
			    404: function(xhr) {
				    
			     }
			 },
			success: function(data){
			   var dataObject = data.MESSAGE;	
				if(dataObject == "EXIST"){
					
					var i = '<i class="form-control-feedback bv-no-label glyphicon glyphicon-remove" data-bv-icon-for="cam_name" style="display: block;"></i>';
					var small = '<small class="help-block" data-bv-validator="notEmpty" data-bv-for="cam_name" data-bv-result="INVALID" style="">The Campaign Name is already exit ! </small>';
					$("#div_camName").find("i").remove();
					$("#div_camName").find("small").remove();
					$("#div_camName").removeClass("form-group has-feedback has-success").addClass("form-group has-feedback has-error");	
					$("#div_camName").append(i+small);
					$("#btn_save").attr("disabled","disabled");	
				}else{
					var i = '<i class="form-control-feedback bv-no-label glyphicon glyphicon-ok" data-bv-icon-for="cam_name" style="display: block;"></i>';
			    	$("#div_camName").find("i").remove();
					$("#div_camName").find("small").remove();
					$("#div_camName").removeClass("form-group has-feedback has-error").addClass("form-group has-feedback has-success");	
					$("#div_camName").append(i);
					$("#btn_save").removeAttr("disabled");	
					
					}
				 
			} 
		});


		
	});
	
	$("#btn_clear").click(function(){
		$("#form-campaigns").bootstrapValidator('resetForm', 'true');
	});
	
	$("#btn_save").click(function(){
		$("#form-campaigns").submit();
	});
	
	$('#form-campaigns').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			cam_name: {
				validators: {
					notEmpty: {
						message: 'The Campaign Name is required and can not be empty!'
					}
				}
			},
			cam_status: {
				validators: {
					notEmpty: {
						message: 'The Campaign Status is required and can not be empty!'
					}
				}
			},
			cam_type: {
				validators: {
					notEmpty: {
						message: 'The Campaign Type is required and can not be empty!'
					}
				}
			},
			
			cam_endDate: {
				validators: {
					notEmpty: {
						message: 'The Campaign EndDate is required and can not be empty!'
					}
				}
			},
			cam_budget: {
				validators: {
					digits: {
						message: 'The value can contain only digits'
					}
				}
			},
			cam_actualCost: {
				validators: {
					digits: {
						message: 'The value can contain only digits'
					}
				}
			},
			cam_numSend: {
				validators: {
					digits: {
						message: 'The value can contain only digits'
					}
				}
			},
			cam_expectedResponse: {
				validators: {
					digits: {
						message: 'The value can contain only digits'
					}
				}
			},
			cam_expectedCost: {
				validators: {
					digits: {
						message: 'The value can contain only digits'
					}
				}
			},
			cam_expectedRevenue: {
				validators: {
					digits: {
						message: 'The value can contain only digits'
					}
				}
			}
		}
	}).on('success.form.bv', function(e) {
		
		var currentDate = new Date();
		var day = currentDate.getDate();
		var month = currentDate.getMonth() + 1;
		var year = currentDate.getFullYear();


		var createDate = $("#cam_startDate").val();
		var newCreateDate = createDate.split("/").reverse().join("-");
		
		var endDate = $("#cam_endDate").val();
		var endCreateDate = endDate.split("/").reverse().join("-");

		var parentID = "" ;
		if($("#cam_parent").val() != ""){
				parentID = {"campID":$("#cam_parent").val()};
			}else{
				parentID = null;
			}
		
		var status = "";
		if($("#cam_status").val() != ""){
			status = {"statusID":$("#cam_status").val()};
		}else{
			status = null;
		}

		var type = "";
		if($("#cam_type").val() != ""){
			type = {"typeID":$("#cam_type").val()};
		}else{
			type = null;
		}	

		var assign = "";
		if($("#cam_assignTo").val() != ""){
			assign = {"userID":$("#cam_assignTo").val()};
		}else{
			assign = null;
		}
		
		$.ajax({
			url : "${pageContext.request.contextPath}/campaign/edit",
			type : "PUT",
			data : JSON.stringify({ 
				    "campID" : $("#cam_id").val(),
					"campName" : $("#cam_name").val(),
					"startDate" : newCreateDate,
					"endDate" : endCreateDate,
					"status" : status,
					"type": type,
					"description" : $("#cam_description").val(),
					"parent" : parentID,
					"budget" : $("#cam_budget").val(),
					"assignTo" : assign,
					"actualCost" : $("#cam_actualCost").val(),
					"expectedCost" : $("#cam_expectedCost").val(),
					"expectedRevenue" : $("#cam_expectedRevenue").val(),
					"numSend" : $("#cam_numSend").val(),
					"expectedResponse" : $("#cam_expectedResponse").val(),
					"modifiedBy" : $.session.get("parentID"),
				}),
			
			beforeSend: function(xhr) {
					    xhr.setRequestHeader("Accept", "application/json");
					    xhr.setRequestHeader("Content-Type", "application/json");
					    },
			success:function(data){
					$("#form-campaigns").bootstrapValidator('resetForm', 'true');
					$('#form-campaigns')[0].reset();
					$("#cam_parent").select2("val","");
					$("#cam_assignTo").select2("val","");
					swal({
	            		title:"Success",
	            		text:"User have been Update campaign!",
	            		type:"success",  
	            		timer: 2000,   
	            		showConfirmButton: false
        			});
					setTimeout(function(){
						window.location.href = "${pageContext.request.contextPath}/list-campaigns";
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
			
			<form method="post" id="form-campaigns">
				
				<button type="button" class="btn btn-info btn-app" id="btn_save" > <i class="fa fa-save"></i> Save</button> 
				<a class="btn btn-info btn-app" id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
				<a class="btn btn-info btn-app"  href="${pageContext.request.contextPath}/list-campaigns"> <i class="fa fa-reply"></i> Back </a>

				<div class="clearfix"></div>
	
				<div class="col-sm-2">
					<h4>Overview</h4>
				</div>

				<div class="col-sm-12">
					<hr style="margin-top: 3px;" />
				</div>
		
				
				<div class="row">
					<input type="hidden" name="cam_id" id="cam_id" >
					<div class="col-sm-6">
						<div class="col-sm-2">
							<label class="font-label">Campains Name :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group" id="div_camName">
								<input type="text" class="form-control" name="cam_name" id="cam_name" value="">
							</div>
						</div>
						<div class="col-sm-2">
							<label class="font-label">Start Date :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
									<input type="text" class="form-control pull-right" name="cam_startDate" id="cam_startDate">
								</div> 
							</div>
						</div>
						<div class="col-sm-2">
							<label class="font-label">End Date :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
						        <div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
									<input type="text" class="form-control pull-right" name="cam_endDate" id="cam_endDate"> 
								</div>
							</div>
						</div>
						<div class="clearfix"></div>
						<div class="col-sm-2">
							<label class="font-label">Description :</label>
						</div>
						<div class="col-sm-10">
							<div class="form-group">
								<textarea style="height: 120px" rows="" cols="" name="cam_description" id="cam_description"
									class="form-control"></textarea>
							</div>
						</div>
						<div class="col-sm-2">
							<label class="font-label">Assigned to : </label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<select class="form-control select2"  name="cam_assignTo" id="cam_assignTo" style="width: 100%;">
									<option value=""></option>
			                    </select>
							</div>
						</div>
					</div>

					<div class="col-sm-6">

						<div class="col-sm-2">
							<label class="font-label">Status :</label>
						</div>
						<div class="col-sm-4" >
						
							<div class="form-group">
								<select class="form-control select2" name="cam_status" id="cam_status">
									
								</select>
							</div>
						</div>
	
						<div class="col-sm-2">
							<label class="font-label">Type :</label>
						</div>
						<div class="col-sm-4" >
							<div class="form-group" >
								<select class="form-control select2" name="cam_type" id="cam_type">
									
								</select>
							</div>
						</div>

						<div class="col-sm-2">
							<label class="font-label">Parent ID :</label>
						</div>
						<div class="col-sm-4" >
							<div class="form-group">
								<select class="form-control select2" name="cam_parent" id="cam_parent">
									
								</select>
							</div>
						</div>

					</div>
					

					<div class="clearfix"></div>


				</div>
				
				<div class="clearfix"></div>
				
				<div class="col-sm-2"><h4>Budget</h4></div>
				
				<div class="col-sm-12">
						<hr />
				</div>
				
				<div class="col-sm-6">
				
					<div class="col-sm-2">
							<label class="font-label">Budget:</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text" class="form-control" name="cam_budget" id="cam_budget">
							</div>
						</div>
					<div class="col-sm-2">
							<label class="font-label">Actual Cost:</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text" class="form-control" name="cam_actualCost" id="cam_actualCost">
							</div>
						</div>
						
						<div class="col-sm-2">
							<label class="font-label">Number Send:</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text" class="form-control" name="cam_numSend" id="cam_numSend">
							</div>
						</div>
						
						<div class="col-sm-2">
							<label class="font-label">Expected Response:</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text" class="form-control" name="cam_expectedResponse" id="cam_expectedResponse">
							</div>
						</div>
					
						
				</div>
				
				<div class="col-sm-6">
				
					<div class="col-sm-2">
							<label class="font-label">Expected Cost:</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text" class="form-control" name="cam_expectedCost" id="cam_expectedCost">
							</div>
						</div>
					<div class="col-sm-2">
							<label class="font-label">Expected Revenue:</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text" class="form-control" name="cam_expectedRevenue" id="cam_expectedRevenue">
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

