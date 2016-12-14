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
<div class="content-wrapper" ng-app="caseApp" ng-controller="caseController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Update Case</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"> Update Case</a></li>
		</ol>
	</section>
<script type="text/javascript">

var app = angular.module('caseApp', ['angular-loading-bar', 'ngAnimate']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = false;
}]);
var self = this;
var caseId= "${caseId}";
var username = "${SESSION}";
var dataCase = [];
app.controller('caseController',['$scope','$http',function($scope, $http){	
	$scope.dataCase = [];
	angular.element(document).ready(function () {					
		setTimeout(function(){
			$("#ca_type").select2("val",$scope.dataCase.caseTypeId);	
			$("#ca_status").select2("val",$scope.dataCase.statusId);
			$("#ca_priority").select2("val",$scope.dataCase.priorityId);
			$("#ca_assignTo").select2("val",$scope.dataCase.userID);
			$("#ca_customer").select2("val",$scope.dataCase.custID);
			$("#ca_contact").select2("val",$scope.dataCase.conID);
			$("#ca_product").select2("val",$scope.dataCase.caseItemId);	
			$("#ca_origin").select2("val",$scope.dataCase.caseOriginId);
			$("#ca_followup_date").val($scope.dataCase.followupDate);
			
			
			$('#form-case').data('bootstrapValidator').resetField($('#ca_type'));
			$('#form-case').data('bootstrapValidator').resetField($('#ca_status'));
			$('#form-case').data('bootstrapValidator').resetField($('#ca_priority'));
			//$('#form-case').data('bootstrapValidator').resetField($('#ca_origin'));
			
			
		}, 2000);
    });
	
	$scope.startupPage = function(){
		$http.get("${pageContext.request.contextPath}/case/startup/"+username+"/"+caseId).success(function(response){
			$scope.case_status = response.CASE_STATUS;
			$scope.case_type = response.CASE_TYPE;
			$scope.case_origin = response.CASE_ORIGIN;
			$scope.case_priority = response.CASE_PRIORITY;
			$scope.customer = response.CUSTOMERS;
			$scope.contact = response.CONTACTS;
			$scope.assignTo = response.ASSIGN_TO;
			$scope.dataCase = response.CASE;
			$scope.items = response.ITEMS;
		});
	};			
}]);


//function addData


$(document).ready(function() {
	$("#btn_reload").click(function(){
		location.reload();	
	});
	
	$("#btn_save").click(function(){
		$("#form-case").submit();
	});

	$('.date2').daterangepicker({
        singleDatePicker: true,
        showDropdowns: true,
        format: 'DD/MM/YYYY h:mm A',
        timePicker: true, 
        timePickerIncrement: 5
       
    }).on('change', function(e) {
		if($("#ca_followup_date").val() != ""){
			$('#form-case').bootstrapValidator('revalidateField', 'ca_followup_date');
		}
	});
	
	$('#form-case').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			ca_priority: {
				validators: {
					notEmpty: {
						message: 'The priority is required and can not be empty!'
					},
					stringLength: {
						max: 255,
						message: 'The name must be less than 255 characters long.'
					}
				}
			},
			
			ca_status: {
				validators: {
					notEmpty: {
						message: 'The status is required and can not be empty!'
					}
				}
			},
			ca_followup_date: {
				validators: {
					date: {
                        format: 'DD/MM/YYYY h:mm A',
                        message: 'The value is not a valid date!'
					}
				}
			},
			ca_subject: {
				validators: {
					notEmpty: {
						message: 'The subject is required and can not be empty!'
					}
				}
			},
			ca_type: {
				validators: {
					notEmpty: {
						message: 'The type is required and can not be empty!'
					}
				}
			},
			ca_resolution: {
				validators: {
					stringLength: {
						max: 1000,
						message: 'The resolution must be less than 1000 characters long.'
					}
				}
			},
			ca_description: {
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
			title: "<span style='font-size: 25px;'>You are about to update case.</span>",
			text: "Click OK to continue or CANCEL to abort.",
			type: "info",
			html: true,
			showCancelButton: true,
			closeOnConfirm: false,
			showLoaderOnConfirm: true,		
		}, function(){
			setTimeout(function(){
				$.ajax({ 
					url : "${pageContext.request.contextPath}/case/edit",
					type : "PUT",
					data : JSON.stringify({
						  "caseId": caseId,
					      "status": getJsonById("statusId","ca_status","int"),
					      "type": getJsonById("caseTypeId","ca_type","int"),
					      "origin": getJsonById("originId","ca_origin","int"),
					      "priority": getJsonById("priorityId","ca_priority","int"),
					      "customer": getJsonById("custID","ca_customer","str"),
					      "contact": getJsonById("conID","ca_contact","str"),
					      "subject": getValueStringById("ca_subject"),
					      "des": getValueStringById("ca_description"),
					     /*  "resolution": getValueStringById("ca_resolution"), */
					      "assignTo": getJsonById("userID","ca_assignTo","str"),
					      "item": getJsonById("itemId","ca_product","str"),
					      "modifyBy": username,
					      "convertFollowupDate": getValueStringById("ca_followup_date")
				    }),
					beforeSend: function(xhr) {
					    xhr.setRequestHeader("Accept", "application/json");
					    xhr.setRequestHeader("Content-Type", "application/json");
				    }, 
				    success: function(result){	
						if(result.MESSAGE == "UPDATED"){	
							swal({
	    						title: "SUCCESSFUL",
	    					  	text: result.MSG,
	    					  	html: true,
	    					  	timer: 2000,
	    					  	type: "success",
	    					  	showConfirmButton  : false
	    					});
							reloadForm(2000);																																
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
		<div class="box box-danger">			
			<div class="box-body">			
				<form method="post" id="form-case" data-ng-init="startupPage()">					
					<button type="button" class="btn btn-info btn-app" id="btn_save"> <i class="fa fa-save"></i> Save</button> 
					<a class="btn btn-info btn-app" id="btn_reload"> <i class="fa fa-refresh" aria-hidden="true"></i>Reload</a> 
					<a class="btn btn-info btn-app" href="${pageContext.request.contextPath}/list-cases"> <i class="fa fa-reply"></i> Back </a>
	
					<div class="clearfix"></div>
					<div class="col-sm-2"><h4>Overview</h4></div>
					<div class="col-sm-12"><hr style="margin-top: 3px;" /></div>
					<div class="row">
						<div class="col-sm-12">
							<div class="col-sm-6">
								<div class="col-sm-6">
									<label class="font-label">Subject <span class="requrie">(Required)</span></label>
									<div class="form-group">
										<input type="text" value="{{dataCase.subject}}" class="form-control" id="ca_subject" name="ca_subject">
									</div>
								</div>
								<div class="col-sm-6">
									<label class="font-label">Status <span class="requrie">(Required)</span></label>
									<div class="form-group">
										<select class="form-control select2" data-item="{{dataCase.statusId}}" name="ca_status" id="ca_status" style="width:100%">
											<option value="">-- SELECT Status --</option>
											<option ng-repeat="u in case_status"  ng-selected="{{u.statusId == dataCase.statusId}}" value="{{u.statusId}}">{{u.statusName}}</option> 
										</select>
									</div>
								</div>
								<div class="col-sm-6">
									<label class="font-label"> Type <span class="requrie">(Required)</span></label>
									<div class="form-group">
										<select class="form-control select2" name="ca_type" id="ca_type" style="width:100%">
											<option value="">-- SELECT Type --</option>
											<option ng-repeat="u in case_type" value="{{u.caseTypeId}}">{{u.caseTypeName}}</option> 
										</select>
									</div>
								</div>
								<div class="col-sm-6">
									<label class="font-label">Priority <span class="requrie">(Required)</span></label>
									<div class="form-group">
										<select class="form-control select2" name="ca_priority" id="ca_priority" style="width:100%">
											<option value="">-- SELECT Priority --</option>
											<option ng-repeat="u in case_priority" value="{{u.priorityId}}">{{u.priorityName}}</option> 
										</select>
									</div>
								</div>	
								<div class="clearfix"></div>							
								<div class="col-sm-6">
									<label class="font-label">Origin </span></label>
									<div class="form-group">
										<select class="form-control select2" name="ca_origin" id="ca_origin" style="width:100%">
											<option value="">-- SELECT Origin --</option>
											<option ng-repeat="or in case_origin" value="{{or.originId}}">{{or.originTitle}}</option> 
										</select>
									</div>
								</div>
								<div class="col-sm-6">
									<label class="font-label">Followup Date</label>
									<div class="form-group">
										<div class="input-group">
											<div class="input-group-addon">
												<i class="fa fa-calendar"></i>
											</div>
											<input type="text" class="form-control pull-right date2" name="ca_followup_date" id="ca_followup_date">
										</div> 
									</div>
								</div>	
							</div>
							<div class="col-sm-6">
								<div class="col-sm-6">
									<label class="font-label">Product </label>
									<div class="form-group">
										<select class="form-control select2" name="ca_product" id="ca_product" style="width:100%">
											<option value="">-- SELECT Product --</option>
											<option ng-repeat="p in items" value="{{p.itemId}}">[{{p.itemId}}] {{p.itemName}}</option>
										</select>
									</div>
								</div>
								<div class="col-sm-6">
									<label class="font-label">Customer </label>
									<div class="form-group">
										<select class="form-control select2" name="ca_customer" id="ca_customer" style="width:100%">
											<option value="">-- SELECT Customer --</option>
											<option ng-repeat="u in customer" value="{{u.custID}}">[{{u.custID}}] {{u.custName}}</option>
										</select>
									</div>
								</div>
								<div class="col-sm-6">
									<label class="font-label">Contact </label>
									<div class="form-group">
										<select class="form-control select2" name="ca_contact" id="ca_contact" style="width:100%">
											<option value="">-- SELECT Contact --</option>
											<option ng-repeat="u in contact" value="{{u.conID}}">{{u.conSalutation}} {{u.conFirstname}} {{u.conLastname}}</option>
										</select>
									</div>
								</div>
								
							</div>
							<div class="clearfix"></div>
							<div class="col-sm-12">
								<div class="col-sm-12">
									<label class="font-label">Description </label>
									<div class="form-group">
										<textarea  rows="4" value="" cols="" name="ca_description" id="ca_description"
											class="form-control">{{dataCase.des}}</textarea>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="clearfix"></div>
					<div class="col-sm-2"><h4>Other </h4></div>
					<div class="col-sm-12"><hr style="margin-top: 3px;" /></div>
					<div class="row">
						<div class="col-sm-12">
							<div class="col-sm-6">				
								<div class="col-sm-6">
									<label class="font-label">Assigned to  </label>
									<div class="form-group">
										<select class="form-control select2" name="ca_assignTo" id="ca_assignTo" style="width:100%">
											<option value="">-- SELECT Assign To --</option>
											<option ng-repeat="u in assignTo" value="{{u.userID}}">{{u.username}}</option>
										</select>
									</div>
								</div>
							</div>																		
						</div>
					</div>
				</form>
			</div>
			<div class="box-footer"><div id="test_div"></div></div>
			<dis id="errors"></dis>
		</div>
	</section>
</div>
<jsp:include page="${request.contextPath}/footer"></jsp:include>

