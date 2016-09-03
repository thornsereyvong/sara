<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>


<style type="text/css">
.font-label {
	font-size: 13px;
	padding-top: 4px;
}


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

<script type="text/javascript">

var app = angular.module('campaign', ['angularUtils.directives.dirPagination','oitozero.ngSweetAlert']);
var self = this;
app.controller('campController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){
	$scope.listIndustry = function(){
		$http.get("${pageContext.request.contextPath}/industry/list")
		.success(function(response){
				$scope.industry = response.DATA;
			});
		};
$scope.listAccount = function(){
			$http.get("${pageContext.request.contextPath}/account_type/list")
			.success(function(response){
					$scope.account = response.DATA;
				});
			};
	
}]);

function listSourceID(source){
	$.ajax({
		url: "${pageContext.request.contextPath}/lead_source/list",
		method: "GET",
		header: "application/json",
		success: function(data){
			var dataObject = data.DATA;
			 $("#con_leadSource").empty().append('<option value="">-- SELECT Source --</option>');
			$.each(data.DATA, function(key, value){
				var div = "<option value='"+value.sourceID+"' >"+value.sourceName+"</option>";
				$("#con_leadSource").append(div);
				
			});  
			$("#con_leadSource").select2("val",source);
			} 
		});
}


function listDataByCampID(){
	
	var data = ${conLead};
	var userid = ${users};
	
	var result = data.body.DATA;
	
	//$("#lea_salutation").val(result.salutation);
	$("#lea_id").val(result.leadID);
	$("#con_firstName").val(result.firstName);
	$("#con_lastName").val(result.lastName);
	$("#con_title").val(result.title);
	$("#con_department").val(result.department);
	$("#con_phone").val(result.phone);
	$("#con_mobilePhone").val(result.mobile);
	$("#con_website").val(result.website);
	$("#con_email").val(result.email);
	$("#con_no").val(result.no);
	$("#con_street").val(result.street);
	$("#con_village").val(result.village);
	$("#con_commune").val(result.commune);
	$("#con_district").val(result.district);
	$("#con_city").val(result.city);
	$("#con_state").val(result.state);
	$("#con_country").val(result.country);
	$("#con_accountName").val(result.accountName);
	$("#con_description").val(result.description);

	var na = "";
	if(result.accountName == ""){
		na = result.firstName+" "+result.lastName;
	}else{
		na = result.accountName;
	}

	$("#c_name").val(na);
    $("#c_tel1").val(result.phone);
    $("#c_tel2").val(result.mobile);
   
    $("#c_email").val(result.email);
    
   
    
	//
	
	if(result.sourceID == null || result.sourceID == ""){
		listSourceID("");
	}else{
		listSourceID(result.sourceID);
	}

	//funcSelectCustomer("${pageContext.request.contextPath}/customer/list", "GET", "#con_customer", "Customer", result.custID);
	
}


$(document).ready(function() {
	$(".select2").select2();
	listDataByCampID();

	$("#btn_clear").click(function(){
		$("#form-convert").bootstrapValidator('resetForm', 'true');
		$('#form-convert')[0].reset();
	});
	
	 $("#btn_save").click(function(){
		$("#form-convert").submit();
		
	});
		
	$('#form-convert').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			c_name: {
				validators: {
					notEmpty: {
						message: 'The Customer Name is required and can not be empty!'
					}
				}
			},
			con_firstName: {
				validators: {
					notEmpty: {
						message: 'The Contact Name is required and can not be empty!'
					}
				}
			},
			con_lastName: {
				validators: {
					notEmpty: {
						message: 'The Contact Name is required and can not be empty!'
					}
				}
			},
			c_tel1: {
				validators: {
					notEmpty: {
						message: 'The Custoemr Tell is required and can not be empty!'
					}
				}
			},
			con_phone: {
				validators: {
					notEmpty: {
						message: 'The Custoemr Tell is required and can not be empty!'
					}
				}
			}
		}
	}).on('success.form.bv', function(e) {

		var currentDate = new Date();
		var day = currentDate.getDate();
		var month = currentDate.getMonth() + 1;
		var year = currentDate.getFullYear();

	    var industry = "";	
		if($("#c_industry").val()  != ""){
			industry = $("#c_industry").val();
		}else{
			industry = null;
		}

		var account = "";	
		if($("#c_type").val()  != ""){
			account =$("#c_type").val();
		}else{
			account = null;
		}

		var sources = "";
		if($("#con_leadSource").val()  != ""){
			sources = $("#con_leadSource").val();
		}else{
			sources = null;
		}


	
		$.ajax({
			url : "${pageContext.request.contextPath}/lead/convert",
			type : "POST",
			data : JSON.stringify({
				"conFirstname":  $("#con_firstName").val(),
			      "conLastname": $("#con_lastName").val(),
			      "conPhone": $("#con_phone").val(),
			      "conMobile":$("#con_mobilePhone").val(),
			      "conEmial": $("#con_email").val(),
			      "conTitle":$("#con_title").val(),
			      "conDepartment": $("#con_department").val(),
			      "conNo": $("#con_no").val(),
			      "conStreet": $("#con_street").val(),
			      "conVillage": $("#con_village").val(),
			      "conCommune": $("#con_commune").val(),
			      "conDistrict": $("#con_district").val(),
			      "conCity": $("#con_city").val(),
			      "conState": $("#con_state").val(),
			      "conCountry": $("#con_country").val(),
			      "conLeadSoruce":  sources,
			      "custName": $("#c_name").val(),
			      "custTel1": $("#c_tel1").val(),
			      "custTel2": $("#c_tel2").val(),
			      "custFax": $("#c_fax").val(),
			      "custEmail": $("#c_email").val(),
			      "custWebsite": $("#c_website").val(),
			      "custAddress": $("#c_address").val(),
			      "facebook": $("#c_facebook").val(),
			      "line": $("#c_line").val(),
			      "viber": $("#c_viber").val(),
			      "whatApp": $("#c_whatapp").val(),
			      "industID": industry,
			      "accountTypeID": account,
			      "leadStatusId":"3",
			      "leadID": $("#lea_id").val(),
			      "conCreateBy": $.session.get("parentID"),
				  "conCreateDate": year+"-"+month+"-"+day

			    }),	
			beforeSend: function(xhr) {
					    xhr.setRequestHeader("Accept", "application/json");
					    xhr.setRequestHeader("Content-Type", "application/json");
					    },
			success:function(data){
				$("#form-convert").bootstrapValidator('resetForm', 'true');
				$('#form-convert')[0].reset();				
					swal({
				    		title:"Success",
				            text:"User have been Convert Leads Success!",
				            type:"success",  
				            timer: 2000,   
				            showConfirmButton: false
				    });
					setTimeout(function(){
						window.location.href = "${pageContext.request.contextPath}/view-leads";
					}, 2000);

				},
			error:function(){
				errorMessage();
				}
			});
		
		
	

		 
		
	});

	
});


</script>
<style>
.icon_color{
color:#2196F3;
}
.pagination {
    display: inline-block;
    padding-left: 0;
    margin: 0px 0px 13px 0px;
    border-radius: 4px;
    margin-buttom:10px;
}
</style>
<div class="content-wrapper" ng-app="campaign" ng-controller="campController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Convert Lead</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>Convert Lead</a></li>
		</ol>
	</section>

	<section class="content">

		<!-- Default box -->
		<form method="POST" id="form-convert">
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
				<div class="col-sm-12">
					<hr style="margin-bottom: 5px;margin-top: 8px;" />
				 </div> 
				<div style="background: #fff;margin-top: 15px;">
				
				 <div class="col-sm-12">
				 	<a class="btn btn-info btn-app" id="btn_save"> <i class="fa fa-save"></i> Save</a> 
					<a class="btn btn-info btn-app"  id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
					<a class="btn btn-info btn-app" href="${pageContext.request.contextPath}/list-leads"> <i class="fa fa-reply"></i> Back </a>
				 </div>
				 
				  
				 
			</div>
			</div>
			
			<div class="box-body" >
							
					<div class="col-sm-12">
						<div class="form-group">
							<input type="checkbox" value="1"  class="minimal-red " checked="checked" id="checkContact" name="checkContact" data-toggle="collapse" data-target="#collapseExample" aria-expanded="true" aria-controls="collapseExample">
							<label>Create Contact  *</label>
						</div>
						<div class="collapse in" id="collapseExample" aria-expanded="true">
						<div class="row">
						  <div class="col-sm-12">
						  		<form method="post" id="form-contact">
							
								<div class="clearfix"></div>
				
								<div class="col-sm-2">
									<h4>Overview</h4>
								</div>
								<input type="hidden" id="lea_id">
								<div class="col-sm-12">
									<hr style="margin-top: 3px;" />
								</div>
				
								<div class="row">
				
									<div class="col-sm-6">
				
										<div class="col-sm-2">
											<label class="font-label">First Name *:</label>
										</div>
										<div class="col-sm-4">
											<div class="form-group">
												<input type="text" class="form-control" name="con_firstName" id="con_firstName">
											</div>
										</div>
				
										<div class="col-sm-2">
											<label class="font-label">Last Name *:</label>
										</div>
										<div class="col-sm-4">
											<div class="form-group">
												<input type="text" class="form-control" name="con_lastName" id="con_lastName">
											</div>
										</div>
										
										<div class="col-sm-2">
											<label>Title :</label>
										</div>
										<div class="col-sm-4">
											<div class="form-group">
												<input type="text"  class="form-control" id="con_title" name="con_title">
											</div>	
										</div>
										
										<div class="col-sm-2 padding-right">
											<label class="font-label">Department :</label>
										</div>
										<div class="col-sm-4">
											<div class="form-group">
												<input type="text"  class="form-control" id="con_department" name="con_department">
											</div>	
										</div>
										
									</div>
				
									<div class="col-sm-6">
									
										<div class="col-sm-2">
											<label>Phone *:</label>
										</div>
										<div class="col-sm-4">
											<div class="form-group">
												<input type="text"  class="form-control" id="con_phone" name="con_phone">
											</div>	
										</div>
										
										<div class="col-sm-2 padding-right">
											<label class="font-label">Mobile Phone :</label>
										</div>
										<div class="col-sm-4">
											<div class="form-group">
												<input type="text"  class="form-control" id="con_mobilePhone" name="con_mobilePhone">
											</div>	
										</div>	
										<div class="col-sm-2">
											<label class="font-label">Email :</label>
										</div>
										<div class="col-sm-4">
											<div class="form-group">
												<input type="text"  class="form-control" id="con_email" name="con_email">
											</div>	
										</div>
										<div class="clearfix"></div>
										
				
									</div>
									
								
								
				
								</div>
										<div class="clearfix"></div>
								
								<div class="col-sm-2"><h4>Address </h4></div>
								
								<div class="col-sm-12">
										<hr style="margin-top: 3px;" />
								</div>
								<div class="row">
								<div class="col-sm-6">
								
									<div class="col-sm-2">
											<label class="font-label">No :</label>
										</div>
										<div class="col-sm-4">
											<div class="form-group">
												<input type="text"  class="form-control" id="con_no" name="con_no">
											</div>	
										</div>
									<div class="col-sm-2">
											<label class="font-label">Street :</label>
										</div>
										<div class="col-sm-4">
											<div class="form-group">
												<input type="text"  class="form-control" id="con_street" name="con_street">
											</div>	
										</div>
										<div class="col-sm-2">
											<label class="font-label">Village :</label>
										</div>
										<div class="col-sm-4">
											<div class="form-group">
												<input type="text"  class="form-control" id="con_village" name="con_village">
											</div>	
										</div>
										<div class="col-sm-2">
											<label class="font-label">Commune :</label>
										</div>
										<div class="col-sm-4">
											<div class="form-group">
												<input type="text"  class="form-control" id="con_commune" name="con_commune">
											</div>	
										</div>
										
										
										
								</div>
								<div class="col-sm-6">
										<div class="col-sm-2">
											<label class="font-label">District :</label>
										</div>
										<div class="col-sm-4">
											<div class="form-group">
												<input type="text"  class="form-control" id="con_district" name="con_district">
											</div>	
										</div>
										<div class="col-sm-2">
											<label class="font-label">City :</label>
										</div>
										<div class="col-sm-4">
											<div class="form-group">
												<input type="text"  class="form-control" id="con_city" name="con_city">
											</div>	
										</div>
										<div class="col-sm-2">
											<label class="font-label">State :</label>
										</div>
										<div class="col-sm-4">
											<div class="form-group">
												<input type="text"  class="form-control" id="con_state" name="con_state">
											</div>	
										</div>
										<div class="col-sm-2">
											<label class="font-label">Country :</label>
										</div>
										<div class="col-sm-4">
											<div class="form-group">
												<input type="text"  class="form-control" id="con_country" name="con_country">
											</div>	
										</div>
								</div>
								<div>
								
								<div class="col-sm-2"><h4>Other </h4></div>
								
								<div class="col-sm-12">
										<hr style="margin-top: 3px;" />
								</div>
				
								<div class="col-sm-12">
								
								
										<div class="col-sm-1">
											<label class="font-label">Lead Source :</label>
										</div>
										<div class="col-sm-2" data-ng-init="listLeadSource()">
											<div class="form-group">
												<select class="form-control select2" style="width:100%" name="con_leadSource" id="con_leadSource">
													<option value="">-- SELECT Lead Source --</option>
													<option ng-repeat="u in lead_source" value="{{u.sourceID}}">{{u.sourceName}}</option> 
												</select>
											</div>
										</div>
										
										</div> 
										
								</div>
				
							</form>
						  </div>
						  </div>
						</div>
					</div>
					
				<div class="col-sm-12"><hr></div>
				<div class="row">
				<div class="col-sm-12">
						<div class="form-group">
							<input type="checkbox" value="1" class="minimal-red" checked="checked" id="checkCustomer"  name="checkCustomer" data-toggle="collapse" data-target="#custo" aria-expanded="true" aria-controls="custo">
							<label>Create Customer  *</label>
						</div>
						<div class="collapse in" id="custo" aria-expanded="true">
							<div class="row">
								<div class="col-sm-6">	
									<div class="col-sm-2">
										<label class="font-label">Name *:</label>
									</div>
									<div class="col-sm-4">
										<div class="form-group" id="name">
											<input type="text" class="form-control" name="c_name" id="c_name">
										</div>
									</div>
									<div class="col-sm-2">
										<label class="font-label">Tel *:</label>
									</div>
									<div class="col-sm-4">
										<div class="form-group">
											<input type="text" class="form-control" name="c_tel1" id="c_tel1">
										</div>
									</div>
									<div class="clearfix"></div>
									<div class="col-sm-2">
										<label class="font-label">Tel :</label>
									</div>
									<div class="col-sm-4">
										<div class="form-group">
											<input type="text" class="form-control" name="c_tel2" id="c_tel2">
										</div>
									</div>
									<div class="col-sm-2">
										<label class="font-label">Fax :</label>
									</div>
									<div class="col-sm-4">
										<div class="form-group">
											<input type="text" class="form-control" name="c_fax" id="c_fax">
										</div>
									</div>
									
								</div>
			
								<div class="col-sm-6">
			
									<div class="col-sm-2">
										<label class="font-label">Email :</label>
									</div>
									<div class="col-sm-4">
										<div class="form-group">
											<input type="text" class="form-control" name="c_email" id="c_email">
										</div>
									</div>
			
									<div class="col-sm-2">
										<label class="font-label">Website :</label>
									</div>
									<div class="col-sm-4">
										<div class="form-group">
											<input type="text" class="form-control" name="c_website" id="c_website">
										</div>
									</div>
			
								</div>
								<div class="col-sm-12">
									<div class="col-sm-1">
										<label class="font-label">Address :</label>
									</div>
									<div class="col-sm-11">
										<div class="form-group">
											<textarea style="height: 120px;width:100%" rows="" cols="" name="c_address" id="c_address"	class="form-control"></textarea>
										</div>
									</div>
								</div>
			
								<div class="clearfix"></div>
			
							
				
								<div class="col-sm-2"><h4>Other</h4></div>
								
								<div class="col-sm-12">
										<hr style="margin-top: 8px;"/>
								</div>
								
								<div class="col-sm-6">
								
									<div class="col-sm-2">
											<label class="font-label">Facebook:</label>
										</div>
										<div class="col-sm-4">
											<div class="form-group">
												<input type="text" class="form-control" name="c_facebook" id="c_facebook">
											</div>
										</div>
										
									<div class="col-sm-2">
											<label class="font-label">Line:</label>
										</div>
										<div class="col-sm-4">
											<div class="form-group">
												<input type="text" class="form-control" name="c_line" id="c_line">
											</div>
										</div>
										
										<div class="col-sm-2">
											<label class="font-label">Viber:</label>
										</div>
										<div class="col-sm-4">
											<div class="form-group">
												<input type="text" class="form-control" name="c_viber" id="c_viber">
											</div>
										</div>
										
										<div class="col-sm-2">
											<label class="font-label">WhatApp:</label>
										</div>
										<div class="col-sm-4">
											<div class="form-group">
												<input type="text" class="form-control" name="c_whatapp" id="c_whatapp">
											</div>
										</div>
								</div>
								
								<div class="col-sm-6">
								
									<div class="col-sm-2" data-ng-init="listIndustry()">
											<label class="font-label">Industry:</label>
										</div>
										<div class="col-sm-4">
											<div class="form-group">
												<select class="form-control select2" name="c_industry" id="c_industry">
													<option value="">-- SELECT Industry</option>
													<option ng-repeat="u in industry" value="{{u.industID}}">{{u.industName}}</option> 
												</select>
											</div>
										</div>
									<div class="col-sm-2" data-ng-init="listAccount()">
											<label class="font-label">Type:</label>
										</div>
										<div class="col-sm-4">
											<div class="form-group">
												<select class="form-control select2" name="c_type" id="c_type">
													<option value="">-- SELECT Type</option>
													<option ng-repeat="u in account" value="{{u.accountID}}">{{u.accountName}}</option> 
												</select>
											</div>
										</div>
										
								</div>
			
							</div>
						</div>
						
						
				
				</div>
				
				</div>
				
			</div>
			
			
			<!-- <div class="box-footer"></div> -->
			<!-- /.box-footer-->
		</div>
		</form>
		<!-- /.box -->


	</section>
	<!-- /.content -->


</div>

<!-- /.content-wrapper -->



<!-- /.content-wrapper -->





<jsp:include page="${request.contextPath}/footer"></jsp:include>

