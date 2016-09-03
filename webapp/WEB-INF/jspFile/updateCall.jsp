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
		<h1>Update Call</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Update Call</a></li>
		</ol>
	</section>
<script type="text/javascript">

var app = angular.module('campaign', ['oitozero.ngSweetAlert',]);
var self = this;
app.controller('campController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){


}]);


function listStatusID(statusids){
	
	$.ajax({
		url: "${pageContext.request.contextPath}/call_status/list",
		method: "GET",
		header: "application/json",
		success: function(data){
			var dataObject = data.DATA;
			 $("#status").empty().append('<option value="">-- SELECT Status --</option>');
			$.each(data.DATA, function(key, value){
				var div = "<option value='"+value.callStatusId+"' >"+value.callStatusName+"</option>";
				$("#status").append(div);
			});  
			$("#status").select2("val",statusids);
			
			} 
		});
}

function listDataByCampID(){
	
	var data = ${calls};
	var result = data.body.DATA;
	var user_id = ${users};


	var d = new Date(result.callStartDate);
	var dd = d.getDate();
	var mm = d.getMonth()+1;
	var yy = d.getFullYear();
	
	$("#startDate").val(dd+"/"+mm+"/"+yy);

	
	
	$("#id").val(result.callId);
	$("#subject").val(result.callSubject);
	$("#duration").val(result.callDuration);
	$("#description").val(result.callDes);

	userAllList(user_id,'#assignTo',result.userID);
	
	if(result.callStatusId == null || result.callStatusId == ""){
		listStatusID("");
	}else{
		listStatusID(result.callStatusId);
	}

	$("#reportType").select2("val",result.callRelatedToModuleType);
	
	funcRelateTo("#reportTo",result.callRelatedToModuleType,result.callRelatedToFieldId);
}



$(document).ready(function() {
	
	
	
	$(".select2").select2();
	
	listDataByCampID();
	$("#reportType").change(function(){
		var relate = $("#reportType").val();
		funcRelateTo("#reportTo",relate,"");
	});
	
	$('#startDate').daterangepicker({
        singleDatePicker: true,
        showDropdowns: true,
        format: 'DD/MM/YYYY' 
    });
	$(".timepicker").timepicker({
        showInputs: false,
        defaultTime: false
      });
    

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
						}
					}
				},
				startDate: {
					validators: {
						notEmpty: {
							message: 'The Start Date is required and can not be empty!'
						}
					}
				},
				duration : {
					validators: {
						notEmpty: {
							message: 'The Duration is required and can not be empty!'
						}
					}
				},
				status : {
					validators: {
						notEmpty: {
							message: 'The Status is required and can not be empty!'
						}
					}
				}
				
			}
		}).on('success.form.bv', function(e) {

			var currentDate = new Date();
			var day = currentDate.getDate();
			var month = currentDate.getMonth() + 1;
			var year = currentDate.getFullYear();

			var createDate = $("#startDate").val();
			var newCreateDate = createDate.split("/").reverse().join("-");
			
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
				url : "${pageContext.request.contextPath}/call/edit",
				type : "PUT",
				data : JSON.stringify({ 
					  "callId": $("#id").val(),
				      "callStartDate": newCreateDate,
				      "callDuration": $("#duration").val(),
				      "callCreateBy": $.session.get("parentID"),
				      "callStatus": status,
				      "callDes": $("#description").val(),
				      "callSubject": $("#subject").val(),
				      "callAssignTo": assign,
				      "callRelatedToFieldId": $("#reportTo").val(),
				      "callRelatedToModuleType": $("#reportType").val(),
				      "callCreateDate": year+"-"+month+"-"+day
				      
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
						
						swal({
		            		title:"Success",
		            		text:"User have been Update Call!",
		            		type:"success",  
		            		timer: 2000,   
		            		showConfirmButton: false
	        			});
						setTimeout(function(){
							window.location.href = "${pageContext.request.contextPath}/list-calls";
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
				<a class="btn btn-info btn-app"  href="${pageContext.request.contextPath}/list-calls"> <i class="fa fa-reply"></i> Back </a>

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
						<div class="col-sm-2">
							<label class="font-label">* Subject :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group" id="c_name">
								<input type="text" class="form-control" name="subject" id="subject">
							</div>
						</div>
						<div class="col-sm-2">
							<label class="font-label">* Start Date :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
									<input type="text" class="form-control pull-right" name="startDate" id="startDate">
								</div> 
							</div>
						</div>
						<div class="clearfix"></div>
						<div class="col-sm-2">
							<label class="font-label">* Duration :</label>
						</div>
						<div class="col-sm-4">
							<div class="bootstrap-timepicker">
			                    <div class="form-group">
			                     
			                      <div class="input-group">
			                        <input type="text" class="form-control timepicker" name="duration" id="duration">
			                        <div class="input-group-addon">
			                          <i class="fa fa-clock-o"></i>
			                        </div>
			                        
			                      </div><!-- /.input group -->
			                    </div><!-- /.form group -->
			                  </div>
						</div>
						<div class="col-sm-2">
							<label class="font-label">Assigned to : </label>
						</div>
						<div class="col-sm-4" data-ng-init="listCampUser()">
							<div class="form-group">
								<select class="form-control select2"  name="assignTo" id="assignTo" style="width: 100%;">
			                      <option value=""></option>           
			                    </select>
							</div>
						</div>
						<div class="clearfix"></div>
						<div class="col-sm-2">
							<label class="font-label">Description :</label>
						</div>
						<div class="col-sm-10">
							<div class="form-group">
								<textarea style="height: 120px" rows="" cols="" name="description" id="description"	class="form-control"></textarea>
							</div>
						</div>
					</div>

					<div class="col-sm-6">

						

						<div class="col-sm-2" data-ng-init="listStatus()" >
							<label class="font-label">* Status :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<select class="form-control select2" name="status" id="status">
									<option value="">--SELECT Status</option>
									<option ng-repeat="st in status" value="{{st.callStatusId}}">{{st.callStatusName}}</option>
								</select>
							</div>
						</div>
						<div class="clearfix"></div>
						<div class="col-sm-2">
							<label class="font-label">Related To :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<select class="form-control select2" name="reportType" id="reportType">
									<option value="">--SELECT Related--</option>
									<optgroup label="Marketing">
										<option value="campaign">Campaign</option>
										<option value="lead">Lead</option>
									</optgroup>
									<optgroup label="Sales">
										<option value="customer">Customer</option>
										<option value="contact">Contact</option>
										<option value="opportunity">Opportunity</option>
									</optgroup>
									<optgroup label="Activities">
										<option value="task">Tasks</option>
									</optgroup>
									<optgroup label="Support">
										<option value="case">Case</option>
									</optgroup>
									
								</select>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="form-group">
								<select class="form-control select2" name="reportTo" id="reportTo">
									<option value="">--SELECT--</option>
								</select>
							</div>
						</div>

					</div>
					

					<div class="clearfix"></div>


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

