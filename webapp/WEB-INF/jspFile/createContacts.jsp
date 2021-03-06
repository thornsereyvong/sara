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

<div class="content-wrapper" ng-app="contactApp" ng-controller="contactController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Create Contact</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"> Create Contact</a></li>
		</ol>
	</section>


<script type="text/javascript">

var app = angular.module('contactApp', ['angular-loading-bar', 'ngAnimate']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = false;
}]);
var self = this;
var username = "${SESSION}";
app.controller('contactController',['$scope','$http',function($scope, $http){
	$scope.startupPage = function(){		
		$http({
		    method: 'POST',
		    url: "${pageContext.request.contextPath}/contact/startup/"+username,
		    headers: {
		    	'Accept': 'application/json',
		        'Content-Type': 'application/json'
		    }
		}).success(function(response) {
			$scope.source = response.LEAD_SOURCE;
			$scope.customer = response.CUSTOMERS;
			$scope.assignTo = response.ASSIGN_TO;
			$scope.reportTo = response.REPORT_TO;
			var custId = "${custId}";
			if(custId != ''){
				setTimeout(function(){
					$('#con_customer').select2('val', custId);
				}, 1000);
			}
		});
	};		
}]);



$(document).ready(function() {
	$("#btn_clear").click(function(){
		$("#con_customer").select2("val","");	
		$("#con_assignedTo").select2("val","");
		$("#con_report").select2("val","");
		$("#con_leadSource").select2("val","");
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
						message: 'The first name is required and can not be empty!'
					},
					stringLength: {
						max: 255,
						message: 'The first name must be less than 255 characters long.'
					}
				}
			},
			
			con_lastName: {
				validators: {
					notEmpty: {
						message: 'The last name is required and can not be empty!'
					},
					stringLength: {
						max: 255,
						message: 'The last name must be less than 255 characters long.'
					}
				}
			},
			con_phone: {
				validators: {
					notEmpty: {
						message: 'The phone is required and can not be empty!'
					},
					stringLength: {
						max: 255,
						message: 'The last name must be less than 255 characters long.'
					}
				}
			},
			con_mobilePhone: {
				validators: {
					
					stringLength: {
						max: 255,
						message: 'The last name must be less than 255 characters long.'
					}
				}
			},
			con_title: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The title must be less than 255 characters long.'
					}
				}
			},
			con_department: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The department must be less than 255 characters long.'
					}
				}
			},
			con_email: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The email must be less than 255 characters long.'
					}
				}
			}
			,
			con_no: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The no must be less than 255 characters long.'
					}
				}
			}
			,
			con_street: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The street must be less than 255 characters long.'
					}
				}
			}
			,
			con_village: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The village must be less than 255 characters long.'
					}
				}
			},
			con_commune: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The commune must be less than 255 characters long.'
					}
				}
			},
			con_district: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The district must be less than 255 characters long.'
					}
				}
			},
			con_state: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The state must be less than 255 characters long.'
					}
				}
			},
			con_city: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The city must be less than 255 characters long.'
					}
				}
			},
			con_country: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The country must be less than 255 characters long.'
					}
				}
			}
		}
	}).on('success.form.bv', function(e) {
		
		swal({   
			title: "<span style='font-size: 25px;'>You are about to create contact.</span>",
			text: "Click OK to continue or CANCEL to abort.",
			type: "info",
			html: true,
			showCancelButton: true,
			closeOnConfirm: false,
			showLoaderOnConfirm: true,		
		}, function(){ 
			setTimeout(function(){
				$.ajax({ 
					url : "${pageContext.request.contextPath}/contact/add",
					method: "POST",
					data : JSON.stringify({
					      "conSalutation" : getValueStringById("con_salutation"),
						  "conFirstname": getValueStringById("con_firstName"),
					      "conLastname": getValueStringById("con_lastName"),
					      "conPhone": getValueStringById("con_phone"),
					      "conMobile": getValueStringById("con_mobilePhone"),
					      "conEmial": getValueStringById("con_email"),
					      "conTitle": getValueStringById("con_title"),
					      "conDepartment": getValueStringById("con_department"),
					      "conNo": getValueStringById("con_no"),
					      "conStreet": getValueStringById("con_street"),
					      "conVillage": getValueStringById("con_village"),
					      "conCommune": getValueStringById("con_commune"),
					      "conDistrict": getValueStringById("con_district"),
					      "conCity": getValueStringById("con_city"),
					      "conState": getValueStringById("con_state"),
					      "conCountry": getValueStringById("con_country"),
					      "conAssignTo": getJsonById("userID","con_assignedTo","str"),
					      "conLeadSource": getJsonById("sourceID","con_leadSource","int"),
					      "conReportTo": getJsonById("conID","con_report","str"),
					      "conCreateBy": username,
					      "customer": getJsonById("custID","con_customer","str")
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
		    											
		    				setTimeout(function(){		
		    					$("#con_customer").select2("val","");	
		    					$("#con_assignedTo").select2("val","");
		    					$("#con_report").select2("val","");
		    					$("#con_leadSource").select2("val","");
		    					$("#form-contact").bootstrapValidator('resetForm', 'true');
		    					$('#form-contact')[0].reset(); 		    					
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
		<div class="box box-danger">
			
			<div class="box-body">
		
			<form method="post" id="form-contact" data-ng-init="startupPage()">
				<div class="col-sm-12">
					<button type="button" class="btn btn-info btn-app" id="btn_save"> <i class="fa fa-save"></i> Save</button> 
					<a class="btn btn-info btn-app" id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
					<a class="btn btn-info btn-app" href="${pageContext.request.contextPath}/list-contacts"> <i class="fa fa-reply"></i> Back </a>
				</div>

				<div class="clearfix"></div>
				<div class="col-sm-2"><h4>Overview</h4></div>
				<div class="col-sm-12"><hr style="margin-top: 3px;" /></div>
				<div class="row">
					<div class="col-sm-12">
						<div class="col-sm-12">
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">First name <span class="requrie">(Required)</span></label>
								<div class="form-group">
									<div class="input-group">
		                            	<span class="input-group-btn">
			                                 <select class="btn" name="con_salutation" id="con_salutation">		                                      
			                                     <option value="Mr.">Mr.</option>
			                                     <option value="Ms.">Ms.</option>
			                                     <option value="Mrs.">Mrs.</option>
			                                     <option value="Dr.">Dr.</option>
			                                     <option value="Prof.">Prof.</option>
			                                  </select>
										</span>
										<input type="text" class="form-control" name="con_firstName" id="con_firstName">
									</div>
								</div>
							</div>
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">Last name <span class="requrie">(Required)</span></label>
								<div class="form-group">
									<input type="text" class="form-control" name="con_lastName" id="con_lastName">
								</div>
							</div>
							<div class="clearfix hidden-md hidden-lg"></div>
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label>Phone <span class="requrie">(Required)</span></label>
								<div class="form-group">
									<input type="tel"  class="form-control" id="con_phone" name="con_phone">
								</div>	
							</div>
							<div class="clearfix hidden-lg hidden-sm"></div>						
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">Mobile phone :</label>
								<div class="form-group">
									<input type="tel"  class="form-control" id="con_mobilePhone" name="con_mobilePhone">
								</div>	
							</div>
							
							<div class="clearfix hidden-md"></div>
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">Customer </label>
								<div class="form-group">
									<select class="form-control select2" name="con_customer" id="con_customer" style="width:100%">
										<option value="">-- SELECT Customer --</option>
										<option ng-repeat="u in customer" value="{{u.custID}}">[{{u.custID}}] {{u.custName}}</option> 
									</select>
								</div>
							</div>
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label>Title </label>
								<div class="form-group">
									<input type="text"  class="form-control" id="con_title" name="con_title">
								</div>
							</div>
							<div class="clearfix hidden-lg"></div>
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">Department </label>
								<div class="form-group">
									<input type="text"  class="form-control" id="con_department" name="con_department">
								</div>	
							</div>
								
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">Email :</label>
								<div class="form-group">
									<input type="email"  class="form-control" id="con_email" name="con_email">
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<!-- <div class="clearfix"></div> -->
				<div class="col-sm-2"><h4>Address </h4></div>				
				<div class="col-sm-12"><hr style="margin-top: 3px;" /></div>
				<div class="row">
					<div class="col-sm-12">
						<div class="col-sm-12">
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">No </label>
								<div class="form-group">
									<input type="text"  class="form-control" id="con_no" name="con_no">
								</div>	
							</div>
							
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">Street </label>
								<div class="form-group">
									<input type="text"  class="form-control" id="con_street" name="con_street">
								</div>
							</div>
							
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">Village </label>
								<div class="form-group">
									<input type="text"  class="form-control" id="con_village" name="con_village">
								</div>
							</div>
							
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">Commune </label>
								<div class="form-group">
									<input type="text"  class="form-control" id="con_commune" name="con_commune">
								</div>	
							</div>
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">District </label>
								<div class="form-group">
									<input type="text"  class="form-control" id="con_district" name="con_district">
								</div>
							</div>
							
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">City </label>
								<div class="form-group">
									<input type="text"  class="form-control" id="con_city" name="con_city">
								</div>	
							</div>
							
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">State</label>
								<div class="form-group">
									<input type="text"  class="form-control" id="con_state" name="con_state">
								</div>	
							</div>
							
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">Country </label>
								<div class="form-group">
									<input type="text"  class="form-control" id="con_country" name="con_country">
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="col-sm-2"><h4>Other </h4></div>				
				<div class="col-sm-12"><hr style="margin-top: 3px;" /></div>
				<div class="row">
					<div class="col-sm-12">
						<div class="col-sm-12">
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">Assign To</label>
								<div class="form-group">
									
									<select class="form-control select2" name="con_assignedTo" id="con_assignedTo" style="width:100%">
										<option value="">-- SELECT Assign To --</option>
										<option ng-repeat="u in assignTo" value="{{u.userID}}">{{u.username}}</option>
									</select>
								</div>
							</div>
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">Lead source </label>
								<div class="form-group">
									<select class="form-control select2" name="con_leadSource" id="con_leadSource" style="width:100%">
										<option value="">-- SELECT Lead Source --</option>
										<option ng-repeat="u in source" value="{{u.sourceID}}">{{u.sourceName}}</option> 
									</select>
								</div>
							</div>
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">Report to</label>
								<div class="form-group">
									<select class="form-control select2" name="con_report" id="con_report" style="width:100%">
										<option value="">-- SELECT Report To --</option>
										<option ng-repeat="u in reportTo" value="{{u.conID}}">[{{u.conID}}] {{u.conSalutation}} {{u.conFirstname}} {{u.conLastname}}</option> 
									</select>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form>
			</div>
			<div class="box-footer"></div>
			<dis id="errors"></dis>
		</div>
	</section>
</div>
<jsp:include page="${request.contextPath}/footer"></jsp:include>

