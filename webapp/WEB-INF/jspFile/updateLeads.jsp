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
		<h1>Update Lead</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Update Lead</a></li>
		</ol>
	</section>
<script type="text/javascript">


var app = angular.module('campaign', ['oitozero.ngSweetAlert',]);
var self = this;
app.controller('campController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){

	$scope.listCampaigns = function(){
		$http.get("${pageContext.request.contextPath}/campaign/list")
		.success(function(response){
				$scope.campaigns = response.DATA;
			});
	};	
		
	$scope.listLeadStatus = function(){
				$http.get("${pageContext.request.contextPath}/lead_status/list")
				.success(function(response){
						$scope.lead_status = response.DATA;
					});
				};
	$scope.listLeadSource = function(){
					$http.get("${pageContext.request.contextPath}/lead_source/list")
					.success(function(response){
							$scope.lead_source = response.DATA;
						});
					};
	$scope.listLeadIndustry = function(){
						$http.get("${pageContext.request.contextPath}/industry/list")
						.success(function(response){
								$scope.lead_industry = response.DATA;
							});
						};
	/* $scope.listCampUser = function() {
		$http.get("${pageContext.request.contextPath}/user/list")
		.success(function(response){
			$scope.camp_user = response.DATA;
		});
		
	}	 */

}]);



function listStatusID(statusids){
	$.ajax({
		url: "${pageContext.request.contextPath}/lead_status/list",
		method: "GET",
		header: "application/json",
		success: function(data){
			var dataObject = data.DATA;
			 $("#lea_status").empty().append('<option value="">-- SELECT Status --</option>');
			$.each(data.DATA, function(key, value){
				var div = "<option value='"+value.statusID+"' >"+value.statusName+"</option>";
				$("#lea_status").append(div);
			});  
			$("#lea_status").select2("val",statusids);
			} 
		});
}

function listSourceID(source){
	$.ajax({
		url: "${pageContext.request.contextPath}/lead_source/list",
		method: "GET",
		header: "application/json",
		success: function(data){
			var dataObject = data.DATA;
			 $("#lea_source").empty().append('<option value="">-- SELECT Source --</option>');
			$.each(data.DATA, function(key, value){
				var div = "<option value='"+value.sourceID+"' >"+value.sourceName+"</option>";
				$("#lea_source").append(div);
				
			});  
			$("#lea_source").select2("val",source);
			} 
		});
}

function listIndustryID(industry){
	$.ajax({
		url: "${pageContext.request.contextPath}/industry/list",
		method: "GET",
		header: "application/json",
		success: function(data){
			var dataObject = data.DATA;
			 $("#lea_industry").empty().append('<option value="">-- SELECT Industry --</option>');
			$.each(data.DATA, function(key, value){
				var div = "<option value='"+value.industID+"' >"+value.industName+"</option>";
				$("#lea_industry").append(div);
			});  

			$("#lea_industry").select2("val",industry);
			
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
			$("#lea_ca").empty().append('<option value="">-- SELECT Campiagn --</option>');
			$.each(dataObject, function(key, value){
					var div = "<option value='"+value.campID+"' >"+value.campName+"</option>";
				$("#lea_ca").append(div);
			});  
			$("#lea_ca").select2("val",parent);
			
			} 
		});
}

function listDataByCampID(){
	
	var data = ${lead};
	var userid = ${users};
	
	var result = data.body.DATA;
	$("#lea_id").val(result.leadID);
	$("#lea_salutation").val(result.salutation);
	$("#lea_firstName").val(result.firstName);
	$("#lea_lastName").val(result.lastName);
	$("#lea_title").val(result.title);
	$("#lea_department").val(result.department);
	$("#lea_phone").val(result.phone);
	$("#lea_mobilePhone").val(result.mobile);
	$("#lea_website").val(result.website);
	$("#lea_email").val(result.email);
	$("#lea_no").val(result.no);
	$("#lea_street").val(result.street);
	$("#lea_village").val(result.village);
	$("#lea_commune").val(result.commune);
	$("#lea_district").val(result.district);
	$("#lea_city").val(result.city);
	$("#lea_state").val(result.state);
	$("#lea_country").val(result.country);
	$("#lea_accountName").val(result.accountName);
	$("#lea_description").val(result.description);
	

	userAllList(userid,'#lea_assignTo',result.assignToUserID);
	
	
	if(result.statusID == null || result.statusID == ""){
		listStatusID("");
	}else{
		listStatusID(result.statusID);
	} 

	if(result.industID == null || result.industID == ""){
		listIndustryID("");
	}else{
		listIndustryID(result.industID);
	} 

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
	
}


$(document).ready(function() {

	
	$(".select2").select2();
	listDataByCampID();
	
	
	
	$("#btn_clear").click(function(){
		$("#form-leads").bootstrapValidator('resetForm', 'true');
		$('#form-leads')[0].reset();
	});
	$("#btn_save").click(function(){
		$("#form-leads").submit();
	});
	
	$('#form-leads').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			lea_ca: {
				validators: {
					notEmpty: {
						message: 'The Campaign is required and can not be empty!'
					}
				}
			},
			lea_firstName: {
				validators: {
					notEmpty: {
						message: 'The Lead First name is required and can not be empty!'
					}
				}
			},
			lea_lastName: {
				validators: {
					notEmpty: {
						message: 'The Lead Last name is required and can not be empty!'
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
		
		if($("#lea_status").val()  != ""){
			status = {"statusID": $("#lea_status").val()};
		}else{
			status = null;
		}

		var source = "";
		
		if($("#lea_source").val()  != ""){
			source = {"sourceID": $("#lea_source").val()};
		}else{
			source = null;
		}

		var industry = "";
		
		if($("#lea_industry").val()  != ""){
			industry = {"industID": $("#lea_industry").val()};
		}else{
			industry = null;
		}

		var camp = "";
		
		if($("#lea_ca").val()  != ""){
			camp = {"campID": $("#lea_ca").val()};
		}else{
			camp = null;
		}

		var ato = "";
		
		if($("#lea_assignTo").val()  != ""){
			ato = {"userID": $("#lea_assignTo").val()};
		}else{
			ato = null;
		}

		
		
		$.ajax({
			url : "${pageContext.request.contextPath}/lead/edit",
			type : "PUT",
			data : JSON.stringify({
				  "leadID": $("#lea_id").val(),
				  "salutation": $("#lea_salutation").val(),
				  "firstName": $("#lea_firstName").val(),
				  "lastName": $("#lea_lastName").val(),
				  "title": $("#lea_title").val(),
				  "department": $("#lea_department").val(),
				  "phone": $("#lea_phone").val(),
				  "mobile": $("#lea_mobilePhone").val(),
				  "website": $("#lea_website").val(),
				  "accountName": $("#lea_accountName").val(),
				  "no":  $("#lea_no").val(),
				  "street": $("#lea_street").val(),
				  "village": $("#lea_village").val(),
				  "commune": $("#lea_commune").val(),
				  "district": $("#lea_district").val(),
				  "city": $("#lea_city").val(),
				  "state": $("#lea_state").val(),
				  "country": $("#lea_country").val(),
				  "description": $("#lea_description").val(),
				  "status": status,
				  "industry": industry,
				  "source": source,
				  "campaign": camp,
				  "assignTo": ato,
				  "modifyBy": $.session.get("parentID"),
				  "email": $("#lea_email").val()
			    }),	
			beforeSend: function(xhr) {
					    xhr.setRequestHeader("Accept", "application/json");
					    xhr.setRequestHeader("Content-Type", "application/json");
					    },
			success:function(data){
					$("#form-leads").bootstrapValidator('resetForm', 'true');
					$('#form-leads')[0].reset();	
					swal({
	            		title:"Success",
	            		text:"User have been Update Lead!",
	            		type:"success",  
	            		timer: 2000,   
	            		showConfirmButton: false
        			});
					setTimeout(function(){
						window.location.href = "${pageContext.request.contextPath}/list-leads/";
					}, 2000);
					
				},
			error:function(){
				errorMessage();
				}
			});
			
	});	
	
});
</script>

<style type="text/css">
.input-group-btn select {
	border-color: #ccc;
	margin-top: 0px;
    margin-bottom: 0px;
    padding-top: 7px;
    padding-bottom: 7px;
}
.padding-right{
padding-right: 10px;
}

</style>

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
			
			<form method="post" id="form-leads">
				
				<a class="btn btn-info btn-app" id="btn_save"> <i class="fa fa-save"></i> Save</a> 
				<a class="btn btn-info btn-app"  id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
				<a class="btn btn-info btn-app" href="${pageContext.request.contextPath}/list-leads"> <i class="fa fa-reply"></i> Back </a>

				<div class="clearfix"></div>

				<div class="col-sm-2">
					<h4>Overview</h4>
				</div>

				<div class="col-sm-12">
					<hr style="margin-top: 3px;" />
				</div>

				<div class="row">
				
					<div class="col-sm-6">
						<input type="hidden" name="lea_id" id="lea_id" >
						<div class="col-sm-2">
							<label class="font-label">First Name :</label>
						</div>
						
						<div class="col-sm-4"> 
							<div class="form-group">
	                            <div class="input-group">
	                            		<span class="input-group-btn">
		                                    <select class="btn" style="width: 64px;text-align:center" name="lea_salutation" id="lea_salutation">
		                                      <option value=""></option> 
		                                      <option value="Mr.">Mr.</option>
		                                      <option value="Ms.">Ms.</option>
		                                       <option value="Mrs.">Mrs.</option>
		                                       <option value="Dr.">Dr.</option>
		                                       <option value="Prof.">Prof.</option>
		                                    </select>
										</span>
										<input type="text" name="lea_firstName" class="form-control" id="lea_firstName">
								</div>
							</div>					
						</div>
						
						<div class="col-sm-2">
							<label class="font-label">Last Name :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text" class="form-control" id="lea_lastName" name="lea_lastName">
							</div>	
						</div>
						<div class="clearfix"></div>
						<div class="col-sm-2">
							<label class="font-label">Title :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text" class="form-control" id="lea_title" name="lea_title">
							</div>	
						</div>
						
						<div class="col-sm-2">
							<label class="font-label">Department :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text"  class="form-control" id="lea_department" name="lea_department">
							</div>	
						</div>

						<div class="col-sm-2" style="padding-right: 2px;">
							<label class="font-label">Campany Name :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text"  class="form-control" id="lea_accountName" name="lea_accountName">
							</div>	
						</div>
						
					</div>

					<div class="col-sm-6">
	
						<div class="col-sm-2">
							<label>Phone :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text"  class="form-control" id="lea_phone" name="lea_phone">
							</div>	
						</div>
						
						<div class="col-sm-2 padding-right">
							<label class="font-label">Mobile Phone :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text"  class="form-control" id="lea_mobilePhone" name="lea_mobilePhone">
							</div>	
						</div>
						
						<div class="col-sm-2">
							<label class="font-label">Website :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text"  class="form-control" id="lea_website" name="lea_website">
							</div>	
						</div>
						
						<div class="col-sm-2">
							<label class="font-label">Email :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text"  class="form-control" id="lea_email" name="lea_email">
							</div>	
						</div>
						

					</div>
					
					

					<div class="clearfix"></div>


				</div>
				
				<div class="clearfix"></div>
				
				<div class="col-sm-2"><h4>Address </h4></div>
				
				<div class="col-sm-12">
						<hr style="margin-top: 3px;" />
				</div>
				
				<div class="col-sm-6">
				
					<div class="col-sm-2">
							<label class="font-label">No :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text"  class="form-control" id="lea_no" name="lea_no">
							</div>	
						</div>
					<div class="col-sm-2">
							<label class="font-label">Street :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text"  class="form-control" id="lea_street" name="lea_street">
							</div>	
						</div>
						<div class="col-sm-2">
							<label class="font-label">Village :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text"  class="form-control" id="lea_village" name="lea_village">
							</div>	
						</div>
						<div class="col-sm-2">
							<label class="font-label">Commune :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text"  class="form-control" id="lea_commune" name="lea_commune">
							</div>	
						</div>
						
						<div class="col-sm-2">
							<label class="font-label">Description :</label>
						</div>
						<div class="col-sm-10">
							<div class="form-group">
								<textarea style="height: 120px" rows="" cols="" name="lea_description" id="lea_description"
									class="form-control"></textarea>
							</div>
						</div>
						
				</div>
				<div class="col-sm-6">
						<div class="col-sm-2">
							<label class="font-label">District :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text"  class="form-control" id="lea_district" name="lea_district">
							</div>	
						</div>
						<div class="col-sm-2">
							<label class="font-label">City :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text"  class="form-control" id="lea_city" name="lea_city">
							</div>	
						</div>
						<div class="col-sm-2">
							<label class="font-label">State :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text"  class="form-control" id="lea_state" name="lea_state">
							</div>	
						</div>
						<div class="col-sm-2">
							<label class="font-label">Country :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<input type="text"  class="form-control" id="lea_country" name="lea_country">
							</div>	
						</div>
				</div>
				
				
				<div class="clearfix"></div>
				
				<div class="col-sm-2"><h4>More Information </h4></div>
				
				<div class="col-sm-12">
						<hr style="margin-top: 3px;" />
				</div>
				<div class="col-sm-6">
					<div class="col-sm-2" data-ng-init="listLeadStatus()">
							<label class="font-label">Status :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<select class="form-control select2" name="lea_status" id="lea_status">
									<option value="">-- SELECT Status --</option>
									<option ng-repeat="u in lead_status" value="{{u.statusID}}">{{u.statusName}}</option> 
								</select>
							</div>
						</div>
						<div class="col-sm-2" data-ng-init="listLeadIndustry()">
							<label class="font-label">Industry :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group" >
								<select class="form-control select2" name="lea_industry" id="lea_industry">
									<option value="">-- SELECT Industry --</option>
									<option ng-repeat="u in lead_industry" value="{{u.industID}}">{{u.industName}}</option> 
								</select>
							</div>
						</div>
						<div class="col-sm-2" data-ng-init="listLeadSource()">
							<label class="font-label">Source :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<select class="form-control select2" name="lea_source" id="lea_source">
									<option value="">-- SELECT Source --</option>
									<option ng-repeat="u in lead_source" value="{{u.sourceID}}">{{u.sourceName}}</option> 
								</select>
							</div>
						</div>
						<div class="col-sm-2" data-ng-init="listCampaigns()">
							<label class="font-label">Campaign Name :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<select class="form-control select2" name="lea_ca" id="lea_ca">
									<option value="">-- SELECT Campaign --</option>
									<option ng-repeat="u in campaigns" value="{{u.campID}}">{{u.campName}}</option>
								</select>
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
						<div class="col-sm-2" data-ng-init="listCampUser()">
							<div class="form-group">
								<select class="form-control select2"  name="lea_assignTo" id="lea_assignTo" style="width: 100%;">
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

