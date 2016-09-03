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

<div class="content-wrapper" ng-app="campaign" ng-controller="campController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Create Contact</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Create Contact</a></li>
		</ol>
	</section>


<script type="text/javascript">

var app = angular.module('campaign', ['oitozero.ngSweetAlert',]);
var self = this;
app.controller('campController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){

	$scope.listLeadSource = function(){
		$http.get("${pageContext.request.contextPath}/lead_source/list")
		.success(function(response){
				$scope.lead_source = response.DATA;
			});
		};
		
}]);



$(document).ready(function() {
	$(".select2").select2();
	
	var data = ${users};
	
	userAllList(data,'#con_assignedTo','');
	userReportList("#con_report","");
	
	funcSelectCustomer("${pageContext.request.contextPath}/customer/list", "GET", "#con_customer", "Customer", "");

	$("#btn_clear").click(function(){
		$("#form-contact").bootstrapValidator('resetForm', 'true');
		$('#form-contact')[0].reset();
	});
	
	$("#btn_save").click(function(){
		$("#form-contact").submit();
	});
	
	$('#form-contact').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			con_firstName: {
				validators: {
					notEmpty: {
						message: 'The Contact Frist Name ID is required and can not be empty!'
					}
				}
			},
			
			con_lastName: {
				validators: {
					notEmpty: {
						message: 'The Contact Last Name is required and can not be empty!'
					}
				}
			},
			con_phone: {
				validators: {
					notEmpty: {
						message: 'The Contact Phone is required and can not be empty!'
					}
				}
			}
		}
	}).on('success.form.bv', function(e) {
		
		
		
		var currentDate = new Date();
		var day = currentDate.getDate();
		var month = currentDate.getMonth() + 1;
		var year = currentDate.getFullYear();

	     	var sources = "";
			if($("#con_leadSource").val()  != ""){
				sources = {"sourceID": $("#con_leadSource").val()};
			}else{
				sources = null;
			}

			var assign = "";
			if($("#con_assignedTo").val()  != ""){
				assign = {"userID": $("#con_assignedTo").val()};
			}else{
				assign = null;
			}

			var assignRe = "";
			if($("#con_report").val()  != ""){
				assignRe = {"userID": $("#con_report").val()};
			}else{
				assignRe = null;
			}

			var custID = "";
			if($("#con_customer").val()  != ""){
				custID = {"custID": $("#con_customer").val()};
			}else{
				custID = null;
			}
			
			
		$.ajax({
			url : "${pageContext.request.contextPath}/contact/add",
			type : "POST",
			data : JSON.stringify({
			      "conFirstname": $("#con_firstName").val(),
			      "conLastname": $("#con_lastName").val(),
			      "conPhone": $("#con_phone").val(),
			      "conMobile": $("#con_mobilePhone").val(),
			      "conEmial": $("#con_email").val(),
			      "conTitle": $("#con_title").val(),
			      "conDepartment": $("#con_department").val(),
			      "conNo": $("#con_no").val(),
			      "conStreet": $("#con_street").val(),
			      "conVillage": $("#con_village").val(),
			      "conCommune": $("#con_commune").val(),
			      "conDistrict": $("#con_district").val(),
			      "conCity": $("#con_city").val(),
			      "conState": $("#con_state").val(),
			      "conCountry": $("#con_country").val(),
			      "conAssignTo": assign,
			      "conLeadSource": sources,
			      "conReportTo": assignRe,
			      "conCreateBy": $.session.get("parentID"),
			      "conCreateDate": year+"-"+month+"-"+day,
			      "customer": custID
			    }),	
			beforeSend: function(xhr) {
					    xhr.setRequestHeader("Accept", "application/json");
					    xhr.setRequestHeader("Content-Type", "application/json");
					    },
			success:function(data){
					$("#form-contact").bootstrapValidator('resetForm', 'true');
					$('#form-contact')[0].reset();
					$("#con_customer").select2("val","");	
					$("#con_assignedTo").select2("val","");
					$("#con_report").select2("val","");
					$("#con_leadSource").select2("val","");
					swal({
	            		title:"Success",
	            		text:"User have been created new Contact!",
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
		
			<form method="post" id="form-contact">
				
				<button type="button" class="btn btn-info btn-app" id="btn_save"> <i class="fa fa-save"></i> Save</button> 
				<a class="btn btn-info btn-app" id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
				<a class="btn btn-info btn-app" href="${pageContext.request.contextPath}/list-contacts"> <i class="fa fa-reply"></i> Back </a>

				<div class="clearfix"></div>

				<div class="col-sm-2">
					<h4>Overview</h4>
				</div>

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
						
						<div class="col-sm-2">
							<label class="font-label">Customer :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<select class="form-control select2" name="con_customer" id="con_customer">
									<!-- <option value="">-- SELECT Customer --</option> -->
								</select>
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
						

					</div>
					
				
				

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
				
				
				<div class="col-sm-2"><h4>Other </h4></div>
				
				<div class="col-sm-12">
						<hr style="margin-top: 3px;" />
				</div>

				<div class="col-sm-12">
				
					<div class="col-sm-1">
							<label class="font-label">Assigned to : </label>
						</div>
						<div class="col-sm-2">
							<div class="form-group">
								
								<select class="form-control select2" name="con_assignedTo" id="con_assignedTo">
									<option value=""></option>
								</select>
							</div>
						</div>
						
						<div class="clearfix"></div>
						<div class="col-sm-1">
							<label class="font-label">Lead Source :</label>
						</div>
						<div class="col-sm-2" data-ng-init="listLeadSource()">
							<div class="form-group">
								<select class="form-control select2" name="con_leadSource" id="con_leadSource">
									<option value="">-- SELECT Lead Source --</option>
									<option ng-repeat="u in lead_source" value="{{u.sourceID}}">{{u.sourceName}}</option> 
								</select>
							</div>
						</div>
						<div class="clearfix"></div>
						<div class="col-sm-1">
							<label class="font-label">Report to : </label>
						</div>
						<div class="col-sm-2">
							<div class="form-group">
								<select class="form-control select2" name="con_report" id="con_report">
									<option value=""></option>
								</select>
							</div>
						</div>
						
				</div>

			</form>
			</div>
			<!-- /.box-body -->
			<div class="box-footer">
				<div id="test_div"></div>
			</div>
			<!-- /.box-footer-->
		</div>
		
		<!-- /.box -->


	</section>
	<!-- /.content -->


</div>

<!-- /.content-wrapper -->




<jsp:include page="${request.contextPath}/footer"></jsp:include>

