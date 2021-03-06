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
<div class="content-wrapper" class="content-wrapper" ng-app="opportunityApp" ng-controller="opportunityController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Create Opportunity</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-dashboard"></i> Home</a></li>
			<li><a href="#"> Create Opportunity</a></li>
		</ol>
	</section>
<script type="text/javascript">


var app = angular.module('opportunityApp', ['angular-loading-bar', 'ngAnimate']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = false;
}]);
var self = this;
var username = "${SESSION}";
app.controller('opportunityController',['$scope','$http',function($scope, $http){
	$scope.startupPage = function(){		
		$http({
		    method: 'POST',
		    url: "${pageContext.request.contextPath}/opportunity/add/startup",
		    headers: {
		    	'Accept': 'application/json',
		        'Content-Type': 'application/json'
		    },
		    data: {"username":username}
		}).success(function(response) {			
			$scope.source = response.LEAD_SOURCE;
			$scope.type = response.OPP_TYPES;
			$scope.campaigns = response.CAMPAIGNS;
			$scope.customer = response.CUSTOMERS;
			$scope.stage = response.OPP_STAGES;
			$scope.assignTo = response.ASSIGN_TO;
			$scope.classCode = response.CLASSES;
			$scope.priceCode = response.PRICE_CODE;
			var custId = "${custId}";
			if(custId != ''){
				setTimeout(function(){
					$('#op_customer').select2('val', custId);
				}, 1000);
			}
		});
	};
	
	
}]);



$(document).ready(function() {

	$('#opCloseDate').daterangepicker({
        singleDatePicker: true,
        showDropdowns: true,
        format: 'DD/MM/YYYY'
    }).on('change', function(e) {
     	$('#form-opportunity').bootstrapValidator('revalidateField', 'opCloseDate');
 	});
	
	$("#op_customer").change(function(){
		var i = $("#op_customer :selected").attr("data-index");
		$("#op_price").select2('val',i);
		$('#form-opportunity').data('bootstrapValidator').resetField($('#op_price'));
	});
	
	
	$("#btn_save").click(function(){
		$("#form-opportunity").submit();
	});
	$("#btn_clear").click(function(){		
		$("#op_customer").select2("val","");
		$("#op_stage").select2("val","");
		$("#op_type").select2("val","");
		$("#op_leadSource").select2("val","");
		$("#op_campaign").select2("val","");		
		$("#form-opportunity").bootstrapValidator('resetForm', 'true');
		$('#form-opportunity')[0].reset();
		
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
			op_price: {
				validators: {
					notEmpty: {
						message: 'The price code is required and can not be empty!'
					}
				}
			},
			opCloseDate: {
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
                        min: 0,
                        max: 100,
                        message: 'The probability must be between 1 and 100'
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
						max: 1000,
						message: 'The description must be less than 1000 characters long.'
					}
				}
			}
		}
	}).on('success.form.bv', function(e) {	
		swal({   
			title: "<span style='font-size: 25px;'>You are about to create opportunity.</span>",
			text: "Click OK to continue or CANCEL to abort.",
			type: "info",
			html: true,
			showCancelButton: true,
			closeOnConfirm: false,
			showLoaderOnConfirm: true,		
		}, function(){
			setTimeout(function(){
				$.ajax({ 
					url : "${pageContext.request.contextPath}/opportunity/add",
					type : "POST",
					data : JSON.stringify({
					      "opName": getValueStringById("op_name"),
					      "opAmount": getInt("op_amount"),
					      "customer": getJsonById("custID","op_customer","str"),
					      "opCloseDate": getDateByFormat("opCloseDate"),
					      "opTypeID": getJsonById("otId","op_type","int"),
					      "opStageId": getJsonById("osId","op_stage","int"),
					      "opProbability": getValueStringById("op_probability"),
					      "opLeadSourceID": getJsonById("sourceID","op_leadSource","int"),
					      "opNextStep": getValueStringById("op_nextStep"),
					      "opCampId": getJsonById("campID","op_campaign","str"),
					      "opDes": getValueStringById("cam_description"),
					      "opAssignedTo": getJsonById("userID","op_assignTo","str"),
					      "opCreateBy": $.session.get("parentID"),
					      "priceCode" : getJsonById("priceCode","op_price","str"),
					      "ameClass" : getJsonById("classId","op_classCode","str")
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
	    					  	type: "success"
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
				<form method="post" id="form-opportunity" data-ng-init="startupPage()">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-left: -5px;">
						<button type="button" class="btn btn-info btn-app" id="btn_save"> <i class="fa fa-save"></i> Save</button> 
						<a class="btn btn-info btn-app" id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
						<a class="btn btn-info btn-app" href="${pageContext.request.contextPath}/list-opportunity"> <i class="fa fa-reply"></i> Back </a>
					</div>
					<div class="clearfix"></div>	
					<div class="col-sm-2"><h4>Overview</h4></div>	
					<div class="col-sm-12"><hr style="margin-top: 3px;" /></div>	
					<div class="row">
						<div  class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Name <span class="requrie">(Required)</span></label>
									<div class="form-group">
										<input type="text" class="form-control" id="op_name" name="op_name">
									</div>
								</div>
								
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Amount <span class="requrie">(Required)</span></label>
									<div class="form-group">
										<input type="number" class="form-control" step="0.01" id="op_amount" name="op_amount">
									</div>
								</div>
								<div class="clearfix hidden-md hidden-lg"></div>
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label ">Stage <span class="requrie">(Required)</span></label>
									<div class="form-group">
										<select class="form-control select2" name="op_stage" id="op_stage" style="width: 100%;">
											<option value="">-- SELECT Stage --</option>
											<option ng-repeat="u in stage" value="{{u.osId}}">{{u.osName}}</option> 
										</select>
									</div>
								</div>
								<div class="clearfix hidden-sm hidden-lg"></div>
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Probability (%) </label>
									<div class="form-group">
										<input type="text" class="form-control" id="op_probability" name="op_probability">
									</div>
								</div>
								<div class="clearfix hidden-md"></div>
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Close date <span class="requrie">(Required)</span></label>
									<div class="form-group">
										<div class="input-group">
											<div class="input-group-addon">
												<i class="fa fa-calendar"></i>
											</div>
											<input type="text" class="form-control pull-right" readonly="readonly" name="opCloseDate" id="opCloseDate">
										</div> 
									</div>
								</div>
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Next Step </label>
									<div class="form-group">
										<input type="text" class="form-control" id="op_nextStep" name="op_nextStep">
									</div>
								</div>
								<div class="clearfix hidden-lg"></div>
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Type </label>
									<div class="form-group">
										<select class="form-control select2" name="op_type" id="op_type" style="width: 100%;">
											<option value="">-- SELECT Type --</option>
											<option ng-repeat="u in type" value="{{u.otId}}">{{u.otName}}</option> 
										</select>
									</div>
								</div>
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Campaign </label>
									<div class="form-group">
										<select class="form-control select2" name="op_campaign" id="op_campaign" style="width: 100%;">
											<option value="">-- SELECT Campaign --</option>
											<option ng-repeat="u in campaigns" value="{{u.campID}}">[{{u.campID}}] {{u.campName}}</option>
										</select>
									</div>
								</div>
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Lead Source </label>
									<div class="form-group">
										<select class="form-control select2" name="op_leadSource" id="op_leadSource" style="width: 100%;">
											<option value="">-- SELECT Lead Source --</option>
											<option ng-repeat="u in source" value="{{u.sourceID}}">{{u.sourceName}}</option>
											
										</select>
									</div>
								</div>
								<div class="clearfix hidden-sm hidden-lg"></div>
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Customer <span class="requrie">(Required)</span></label>
									<div class="form-group">
										<select class="form-control select2" name="op_customer" id="op_customer" style="width: 100%;">
											<option value="">-- SELECT Customer --</option>
											<option data-index="{{u.priceCode.priceCode}}" ng-repeat="(key, u) in customer" value="{{u.custID}}">[{{u.custID}}] {{u.custName}}</option>
										</select>
									</div>
								</div>
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Price Code <span class="requrie">(Required)</span></label>
									<div class="form-group">
										<select style="width:100%" class="form-control select2" name="op_price" id="op_price">
											<option value="">-- SELECT Price Code --</option>
											<option ng-repeat="u in priceCode" value="{{u.priceCode}}">[{{u.priceCode}}] {{u.des}}</option> 
										</select>
									</div>
								</div>
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<div class="form-group">
										<label>Class</label> 
										<select id="op_classCode" name="op_classCode" class="form-control select2 input-lg" style="width: 100%;">
											<option selected="selected" value="">Select A Class</option>
											<option ng-repeat="u in classCode" value="{{u.classId}}">[{{u.classId}}] {{u.des}}</option>
										</select>
									</div>
								</div>
								<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
									<label class="font-label">Description </label>
									<div class="form-group">
										<textarea rows="3" cols="" name="cam_description" id="cam_description"
											class="form-control"></textarea>
									</div>
								</div>
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
										<select class="form-control select2" name="op_assignTo" id="op_assignTo" style="width:100%">
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
			<div class="box-footer"></div>
		</div>
	</section>
</div>
<jsp:include page="${request.contextPath}/footer"></jsp:include>

