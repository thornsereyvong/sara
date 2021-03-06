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
		<h1>Create Case</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"> Create Case</a></li>
		</ol>
	</section>
<script type="text/javascript">

var app = angular.module('caseApp', ['angular-loading-bar', 'ngAnimate']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = false;
}]);
var self = this;
var username = "${SESSION}";
app.controller('caseController',['$scope','$http',function($scope, $http){
	$scope.startupPage = function(){
		$http.get("${pageContext.request.contextPath}/case/startup/"+username).success(function(response){
			$scope.case_status = response.CASE_STATUS;
			$scope.case_type = response.CASE_TYPE;
			$scope.case_priority = response.CASE_PRIORITY;
			$scope.customer = response.CUSTOMERS;
			$scope.contact = response.CONTACTS;
			$scope.assignTo = response.ASSIGN_TO;	
			$scope.items = response.ITEMS;
			$scope.case_origin = response.CASE_ORIGIN;
			var custId = "${custId}";
			if(custId != ''){
				setTimeout(function(){
					$('#ca_customer').select2('val', custId);
				}, 1000);
			}
		});
	};			
}]);
$(document).ready(function() {
	$("#btn_clear").click(function(){
		location.reload();	
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
	
	$("#btn_save").click(function(){
		$("#form-case").submit();
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
			},
			ca_key: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The keyword must be less than 255 characters long.'
					}
				}
			}
			
		}
	}).on('success.form.bv', function(e) {
		swal({   
			title: "<span style='font-size: 25px;'>You are about to create case.</span>",
			text: "Click OK to continue or CANCEL to abort.",
			type: "info",
			html: true,
			showCancelButton: true,
			closeOnConfirm: false,
			showLoaderOnConfirm: true,		
		}, function(){ 
			setTimeout(function(){
				$.ajax({ 
					url : "${pageContext.request.contextPath}/case/add",
					type : "POST",
					data : JSON.stringify({
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
					      "createBy": $.session.get("parentID"),
					      "item" : getJsonById("itemId","ca_product","str"),
					      "convertFollowupDate": getValueStringById("ca_followup_date"),
					      "key" : getValueStringById("ca_key")
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
	    					  	type: "success",
	    					});
		    											
		    				setTimeout(function(){		
		    					$("#ca_type").select2("val","");	
		    					$("#ca_status").select2("val","");
		    					$("#ca_priority").select2("val","");
		    					$("#ca_assignTo").select2("val","");
		    					$("#ca_customer").select2("val","");
		    					$("#ca_contact").select2("val","");
		    					$("#ca_product").select2("val","");
		    					$("#ca_origin").select2("val","");
		    			      	$("#form-case").bootstrapValidator('resetForm', 'true');
		    					$('#form-case')[0].reset(); 		    					
		    				},2000);
																														
						}else{
							swal("UNSUCCESSFUL", result.MSG, "error");
						}
					},
		    		error:function(){
		    			swal("UNSUCCESSFUL", "Please try again!", "error");
		    		} 
				});
			}, 500);
		});
	});		
});
</script>
	<section class="content">
		<div class="box box-danger" data-ng-element-ready="divIsReady()">			
			<div class="box-body">			
				<form method="post" id="form-case" data-ng-init="startupPage()">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-left: -5px;">
						<button type="button" class="btn btn-info btn-app" id="btn_save"> <i class="fa fa-save"></i> Save</button> 
						<a class="btn btn-info btn-app" id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
						<a class="btn btn-info btn-app" href="${pageContext.request.contextPath}/list-cases"> <i class="fa fa-reply"></i> Back </a>
					</div>
					<div class="clearfix"></div>
					<div class="col-sm-2"><h4>Overview</h4></div>
					<div class="col-sm-12"><hr style="margin-top: 3px;" /></div>
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Subject <span class="requrie">(Required)</span></label>
									<div class="form-group">
										<input type="text" class="form-control" id="ca_subject" name="ca_subject">
									</div>
								</div>
								
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Status <span class="requrie">(Required)</span></label>
									<div class="form-group">
										<select class="form-control select2" name="ca_status" id="ca_status" style="width:100%">
											<option value="">-- SELECT Status --</option>
											<option ng-repeat="u in case_status" value="{{u.statusId}}">{{u.statusName}}</option> 
										</select>
									</div>
								</div>
								<div class="clearfix hidden-md hidden-lg"></div>
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label"> Type <span class="requrie">(Required)</span></label>
									<div class="form-group">
										<select class="form-control select2" name="ca_type" id="ca_type" style="width:100%">
											<option value="">-- SELECT Type --</option>
											<option ng-repeat="u in case_type" value="{{u.caseTypeId}}">{{u.caseTypeName}}</option> 
										</select>
									</div>
								</div>
								<div class="clearfix hidden-lg hidden-sm"></div>							
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Priority <span class="requrie">(Required)</span></label>
									<div class="form-group">
										<select class="form-control select2" name="ca_priority" id="ca_priority" style="width:100%">
											<option value="">-- SELECT Priority --</option>
											<option ng-repeat="u in case_priority" value="{{u.priorityId}}">{{u.priorityName}}</option> 
										</select>
									</div>
								</div>	
								<div class="clearfix hidden-md"></div>
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Origin </label>
									<div class="form-group">
										<select class="form-control select2" name="ca_origin" id="ca_origin" style="width:100%">
											<option value="">-- SELECT Origin --</option>
											<option ng-repeat="or in case_origin" value="{{or.originId}}">{{or.originTitle}}</option> 
										</select>
									</div>
								</div>
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
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
								<div class="clearfix hidden-lg"></div>								
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Product</label>
									<div class="form-group">
										<select class="form-control select2" name="ca_product" id="ca_product" style="width:100%">
											<option value="">-- SELECT product --</option>
											<option ng-repeat="p in items" value="{{p.itemId}}">[{{p.itemId}}] {{p.itemName}}</option>
										</select>
									</div>
								</div>
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Customer </label>
									<div class="form-group">
										<select class="form-control select2" name="ca_customer" id="ca_customer" style="width:100%">
											<option value="">-- SELECT Customer --</option>
											<option ng-repeat="u in customer" value="{{u.custID}}">[{{u.custID}}] {{u.custName}}</option>
										</select>
									</div>
								</div>
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Contact </label>
									<div class="form-group">
										<select class="form-control select2" name="ca_contact" id="ca_contact" style="width:100%">
											<option value="">-- SELECT Contact --</option>
											<option ng-repeat="u in contact" value="{{u.conID}}">[{{u.conID}}] {{u.conSalutation}} {{u.conFirstname}} {{u.conLastname}}</option>
										</select>
									</div>
								</div>
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Keyword</label>
									<div class="form-group">
										<input type="text" class="form-control" id="ca_key" name="ca_key">
									</div>
								</div>	
							</div>
							<div class="clearfix"></div>
							<div class="col-sm-12">
								<div class="col-sm-12">
									<label class="font-label">Description </label>
									<div class="form-group">
										<textarea  rows="4" cols="" name="ca_description" id="ca_description"
											class="form-control"></textarea>
									</div>
								</div>
								<div class="clearfix"></div>
								<!-- <div class="col-sm-12 ">
									<label class="font-label">Resolution </label>
									<div class="form-group">
										<textarea  rows="5" cols="" name="ca_resolution" id="ca_resolution" class="form-control"></textarea>
									</div>
								</div> -->
							</div>
						</div>
					</div>
					<div class="clearfix"></div>
					<div class="col-sm-2"><h4>Other </h4></div>
					<div class="col-sm-12"><hr style="margin-top: 3px;" /></div>
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">				
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
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
			<div class="box-footer">
		</div>
		</div>
	</section>
</div>
<jsp:include page="${request.contextPath}/footer"></jsp:include>

