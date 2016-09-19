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
var leadId = "${leadId}";
var username = "${SESSION}";
app.controller('campController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){
	
	$scope.LEAD = [];
	angular.element(document).ready(function () {					
		setTimeout(function(){
			
			$("#con_salutation").val($scope.LEAD.salutation);
			$("#con_leadSource").select2("val", $scope.LEAD.sourceID);
			$("#c_industry").select2("val", $scope.LEAD.industID);
			$("#op_campaign").select2("val", $scope.LEAD.campID);
			$("#op_leadSource").select2("val", $scope.LEAD.sourceID);
			
		}, 1000);
    });
	
	$scope.startupPage = function(){
		$http.get("${pageContext.request.contextPath}/lead/convert/startup/"+username+"/"+leadId).success(function(response){
			
			$scope.GROUP = response.GROUP;
			$scope.CONTACT = response.CONTACT;
			$scope.LEAD_STATUS = response.LEAD_STATUS;
			$scope.INDUSTRY = response.INDUSTRY;
			$scope.CUSTOMER = response.CUSTOMER;
			$scope.CUSTOMER_TYPE = response.CUSTOMER_TYPE;
			$scope.LEAD_SOURCE = response.LEAD_SOURCE;
			$scope.PRICE_CODE = response.PRICE_CODE;
			$scope.ASSIGN_TO = response.ASSIGN_TO;
			$scope.OPP_TYPES = response.OPP_TYPES;
			$scope.CAMPAIGN = response.CAMPAIGN;
			$scope.OPP_STAGES = response.OPP_STAGES;
			$scope.LEAD = response.LEAD;
			
		});
	}

}]);

var statusFrm = 0;

function getContact(){
	var con=[];	
	if($("#checkContact").is(':checked') == true){
		con = {
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
		      "customer": null	
		}
	}else{
		con = {"conID": getValueStringById("ConCotact")};
	}
	return con;
}

function getCustomer(){
	var cust=[];	
	if($("#checkCustomer").is(':checked') == true){
		cust = {		  
		  "custName": getValueStringById("cs_name"),
	      "custTel1": getValueStringById("c_tel1"),
	      "custTel2": getValueStringById("c_tel2"),
	      "custFax": getValueStringById("c_fax"),
	      "custEmail": getValueStringById("c_email"),
	      "custWebsite": getValueStringById("c_website"),
	      "custAddress": getValueStringById("c_address"),
	      "facebook": getValueStringById("c_facebook"),
	      "line": getValueStringById("c_line"),
	      "viber": getValueStringById("c_viber"),
	      "whatApp": getValueStringById("c_whatapp"),
	      "industID": getJsonById("industID","c_industry","int"),
		  "accountTypeID": getJsonById("accountID","c_type","int"),
		  "custDetails" : null,
		  "priceCode" : getValueStringById("c_price"),
		  "custGroupId" : getValueStringById("c_group"),
		  "imageName" : ""
		}
	}else{
		cust = {"custID": getValueStringById("CustCustomer")};
	}
	return cust;
}

function getOpportunity(){
	var opp = {
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
		      "opCreateBy": username
	}
	return opp;
}

$(document).ready(function() {
	
	$('#opCloseDate').daterangepicker({
        singleDatePicker: true,
        showDropdowns: true,
        format: 'DD/MM/YYYY'
    }).on('change', function(e) {
     	$('#frmOpportunity').bootstrapValidator('revalidateField', 'opCloseDate');
 	});
	
	
	$("#ConContact").change(function(){
		var conId = getValueStringById("ConContact");
		if(conId== ""){
			/* $("#checkContact").prop('checked', true);
			$('#collabContactFrm').collapse('show') */
		}else{
			$("#checkContact").prop('checked', false);
			$('#collabContactFrm').collapse('hide')
		}
	});
	
	$("#CustCustomer").change(function(){
		var conId = getValueStringById("CustCustomer");
		if(conId== ""){
			/* $("#checkCustomer").prop('checked', true);
			$('#custo').collapse('show') */
		}else{
			$("#checkCustomer").prop('checked', false);
			$('#custo').collapse('hide')
		}
	});
	
	
	$("#checkCustomer").change(function(){
		$("#CustCustomer").select2("val","");
		$("#ctrCustomer").data('bootstrapValidator').resetForm();
	});
	
	$("#checkContact").change(function(){
		$("#ConContact").select2("val","");
		$("#ctrContact").data('bootstrapValidator').resetForm();
	});
	
	
	$("#btn_clear").click(function(){
		$("#ctrContact").data('bootstrapValidator').resetForm();
		$("#ctrCustomer").data('bootstrapValidator').resetForm();
		$('#frmCustomer').data('bootstrapValidator').resetForm();
		$('#frmContact').data('bootstrapValidator').resetForm();
		$('#frmOpportunity').data('bootstrapValidator').resetForm();
	});
	
	 $("#btn_save").click(function(){
		 
		var statusCust = true;
		var statusCon = true;
		var statusOpp = true;
		
		if($("#checkCustomer").is(':checked')){
			$('#frmCustomer').data('bootstrapValidator').validate();
			statusCust = $("#frmCustomer").data('bootstrapValidator').validate().isValid();
		}else{
			$('#ctrCustomer').data('bootstrapValidator').validate();
			statusCust = $("#ctrCustomer").data('bootstrapValidator').validate().isValid();
		}
		
		if($("#checkContact").is(':checked')){
			$('#frmContact').data('bootstrapValidator').validate();
			statusCon = $("#frmContact").data('bootstrapValidator').validate().isValid();
		}else{
			$('#ctrContact').data('bootstrapValidator').validate();
			statusCon = $("#ctrContact").data('bootstrapValidator').validate().isValid();
		}
		
		if($("#checkOpportunity").is(':checked')){
			$('#frmOpportunity').data('bootstrapValidator').validate();
			statusOpp = $("#frmOpportunity").data('bootstrapValidator').validate().isValid();
		}
		
		
		if(statusCust == true && statusCon == true && statusOpp == true){		
			var dataFrm = "";	
			if($("#checkOpportunity").is(':checked') == true){
				dataFrm = {"CONTACT" : getContact(), "CUSTOMER" : getCustomer(),"custID": getValueStringById("CustCustomer"),"conID": getValueStringById("ConContact"),"OPPORTUNITY": getOpportunity(), "leadID": leadId};
			}else{
				dataFrm = {"CONTACT" : getContact(), "CUSTOMER" : getCustomer(),"custID": getValueStringById("CustCustomer"),"conID": getValueStringById("ConContact"),"OPPORTUNITY": "", "leadID": leadId};
			}
				
			
			$.ajax({
				url : "${pageContext.request.contextPath}/lead/convert",
				type : "POST",
				data : JSON.stringify(dataFrm),	
				beforeSend: function(xhr) {
			    	xhr.setRequestHeader("Accept", "application/json");
			    	xhr.setRequestHeader("Content-Type", "application/json");
			    },
				success:function(data){
					if(data.CUST_MESSAGE == "SUCCESS" && data.CON_MESSAGE == "SUCCESS"){
						swal({
		            		title:"Success",
		            		text:"You have been converted!",
		            		type:"success",  
		            		timer: 2000,   
		            		showConfirmButton: false
	        			});
						setTimeout(function(){window.location.href = "${pageContext.request.contextPath}/list-leads/";}, 2000);
					}else{
						alertMsgErrorSweet();	
					}
					
					
				},
				error:function(){
					alertMsgErrorSweet();	
				}
			});
		}
	});
	
	 $('#frmContact').bootstrapValidator({
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
	});
	 
	 $('#frmCustomer').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			cs_name: {
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
			c_tel1: {
				validators: {
					notEmpty: {
						message: 'The tel is required and can not be empty!'
					},
					stringLength: {
						max: 255,
						message: 'The tel must be less than 255 characters long.'
					}
				}
			},
			c_tel2: {
				validators: {
					
					stringLength: {
						max: 255,
						message: 'The tel must be less than 255 characters long.'
					}
				}
			},
			c_email: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The email must be less than 255 characters long.'
					}
				}
			}
			,
			c_fax: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The fax must be less than 255 characters long.'
					}
				}
			},
			c_address: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The address must be less than 255 characters long.'
					}
				}
			}
			,
			c_facebook: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The facebook must be less than 255 characters long.'
					}
				}
			},
			c_line: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The line must be less than 255 characters long.'
					}
				}
			},
			c_viber: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The viber must be less than 255 characters long.'
					}
				}
			},
			c_whatapp: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The whatApp must be less than 255 characters long.'
					}
				}
			},
			c_group: {
				validators: {
					notEmpty: {
						message: 'The  customer group is required and can not be empty!'
					}
				}
			},
			c_price: {
				validators: {
					notEmpty: {
						message: 'The  price code is required and can not be empty!'
					}
				}
			},
			c_shipAddr:{
				validators: {
					stringLength: {
						max: 255,
						message: 'The address must be less than 255 characters long.'
					}
				}
			},
			c_billAddr:{
				validators: {
					stringLength: {
						max: 255,
						message: 'The address must be less than 255 characters long.'
					}
				}
			}
		}
	});	
	 	
	 $('#frmOpportunity').bootstrapValidator({
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
						max: 255,
						message: 'The description must be less than 255 characters long.'
					}
				}
			}
		}
	});
	 
	 
	 $('#ctrCustomer').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			CustCustomer: {
				validators: {
					notEmpty: {
						message: 'The customer is required and can not be empty!'
					}
				}
			}
		}
	 });
	 
	 $('#ctrContact').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			ConContact: {
				validators: {
					notEmpty: {
						message: 'The contact is required and can not be empty!'
					}
				}
			}
		}
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
		    <li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"><i class="fa fa-dashboard"></i>Convert Lead</a></li>
		</ol>
	</section>

	<section class="content" data-ng-init="startupPage()">

		<!-- Default box -->
		
		<div class="box box-danger">
			<div class="box-header with-border">				
				<div style="background: #fff;margin-top: 15px;">				
				 <div class="col-sm-12">
				 	<a class="btn btn-info btn-app" id="btn_save"> <i class="fa fa-save"></i> Save</a> 
					<a class="btn btn-info btn-app"  id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
					<a class="btn btn-info btn-app" href="${pageContext.request.contextPath}/list-leads"> <i class="fa fa-reply"></i> Back </a>
				 </div> 
			</div>
			</div>
			
			<div class="box-body" >
				<div class="row">		
					<div class="col-sm-12" style="border-bottom: 1px solid #f4f4f4;">
						<div class="col-sm-3">					
							<div class="form-group">
								<input type="checkbox" value="1"  class="minimal-red " checked="checked" id="checkContact" name="checkContact" data-toggle="collapse" data-target="#collabContactFrm" aria-expanded="true" aria-controls="collabContactFrm">
								<label>Create Contact Or Select Contact <span class="requrie">(Required)</span></label>						
							</div>
						</div>
						<div class="col-sm-3">
							<form id="ctrContact">
								<div class="form-group" style="margin-left: 15px;">
									<select class="form-control select2" name="ConContact" id="ConContact" style="width: 100%;">
										<option value="">-- SELECT Contact --</option>
										<option ng-repeat="u in CONTACT" value="{{u.conID}}">{{u.conFirstname}} {{u.conLastname}}</option>
									</select>
								</div>
							</form>
						</div>
						<div class="clearfix"></div>
						<div class="collapse in" id="collabContactFrm" aria-expanded="true">
							<div class="row">
							<form id="frmContact">
								<div class="col-sm-12">
									<div class="col-sm-12">
									  	<div class="clearfix"></div>
										<div class="col-sm-2"><h4>Overview</h4></div>
										<div class="col-sm-12"><hr style="margin-top: 3px;" /></div>
										<div class="row">
											<div class="col-sm-12">
												<div class="col-sm-12">
													<div class="col-sm-3">
														<label class="font-label">First name <span class="requrie">(Required)</span></label>
														<div class="form-group">
															<div class="input-group">
								                            	<span class="input-group-btn">
									                                 <select class="btn" style="height: 34px; width: 75px;text-align:center" name="con_salutation" id="con_salutation">		                                      
									                                     <option value="Mr.">Mr.</option>
									                                     <option value="Ms.">Ms.</option>
									                                     <option value="Mrs.">Mrs.</option>
									                                     <option value="Dr.">Dr.</option>
									                                     <option value="Prof.">Prof.</option>
									                                  </select>
																</span>
																<input type="text" class="form-control" value="{{LEAD.firstName}}" name="con_firstName" id="con_firstName">
															</div>
														</div>
													</div>
													<div class="col-sm-3">
														<label class="font-label">Last name <span class="requrie">(Required)</span></label>
														<div class="form-group">
															<input type="text" class="form-control" value="{{LEAD.lastName}}" name="con_lastName" id="con_lastName">
														</div>
													</div>
													<div class="col-sm-3">
														<label>Phone <span class="requrie">(Required)</span></label>
														<div class="form-group">
															<input type="text"  class="form-control" value="{{LEAD.phone}}" id="con_phone" name="con_phone">
														</div>	
													</div>
																			
													<div class="col-sm-3">
														<label class="font-label">Mobile phone :</label>
														<div class="form-group">
															<input type="text"  class="form-control" value="{{LEAD.mobile}}" id="con_mobilePhone" name="con_mobilePhone">
														</div>	
													</div>
													
													<div class="clearfix"></div>
													
													<div class="col-sm-3">
														<label>Title </label>
														<div class="form-group">
															<input type="text"  class="form-control" value="{{LEAD.title}}" id="con_title" name="con_title">
														</div>
													</div>
													
													<div class="col-sm-3">
														<label class="font-label">Department </label>
														<div class="form-group">
															<input type="text"  class="form-control" value="{{LEAD.department}}" id="con_department" name="con_department">
														</div>	
													</div>
														
													<div class="col-sm-3">
														<label class="font-label">Email :</label>
														<div class="form-group">
															<input type="email"  class="form-control" value="{{LEAD.email}}" id="con_email" name="con_email">
														</div>
													</div>
													<div class="clearfix"></div>							
												</div>
											</div>
										</div>
									
										<div class="clearfix"></div>
										<div class="col-sm-2"><h4>Address </h4></div>				
										<div class="col-sm-12"><hr style="margin-top: 3px;" /></div>
										<div class="row">
											<div class="col-sm-12">
												<div class="col-sm-12">
													<div class="col-sm-3">
														<label class="font-label">No </label>
														<div class="form-group">
															<input type="text"  class="form-control" value="{{LEAD.no}}" id="con_no" name="con_no">
														</div>	
													</div>
													
													<div class="col-sm-3">
														<label class="font-label">Street </label>
														<div class="form-group">
															<input type="text"  class="form-control" value="{{LEAD.street}}" id="con_street" name="con_street">
														</div>
													</div>
													
													<div class="col-sm-3">
														<label class="font-label">Village </label>
														<div class="form-group">
															<input type="text"  class="form-control" value="{{LEAD.village}}"  id="con_village" name="con_village">
														</div>
													</div>
													
													<div class="col-sm-3">
														<label class="font-label">Commune </label>
														<div class="form-group">
															<input type="text"  class="form-control" value="{{LEAD.commune}}" id="con_commune" name="con_commune">
														</div>	
													</div>
													<div class="clearfix"></div>
													<div class="col-sm-3">
														<label class="font-label">District </label>
														<div class="form-group">
															<input type="text"  class="form-control" value="{{LEAD.district}}" id="con_district" name="con_district">
														</div>
													</div>
													
													<div class="col-sm-3">
														<label class="font-label">City </label>
														<div class="form-group">
															<input type="text"  class="form-control" value="{{LEAD.city}}" id="con_city" name="con_city">
														</div>	
													</div>
													
													<div class="col-sm-3">
														<label class="font-label">State</label>
														<div class="form-group">
															<input type="text"  class="form-control" value="{{LEAD.state}}" id="con_state" name="con_state">
														</div>	
													</div>
													
													<div class="col-sm-3">
														<label class="font-label">Country </label>
														<div class="form-group">
															<input type="text"  class="form-control" value="{{LEAD.country}}" id="con_country" name="con_country">
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
													<div class="col-sm-3">
														<label class="font-label">Assign To</label>
														<div class="form-group">
															
															<select class="form-control select2" name="con_assignedTo" id="con_assignedTo" style="width:100%">
																<option value="">-- SELECT Assign to --</option>
																<option ng-repeat="u in ASSIGN_TO" value="{{u.userID}}">{{u.username}}</option> 
															</select>
														</div>
													</div>
													<div class="col-sm-3">
														<label class="font-label">Lead source </label>
														<div class="form-group">
															<select class="form-control select2" name="con_leadSource" id="con_leadSource" style="width:100%">
																<option value="">-- SELECT Lead Source --</option>
																<option ng-repeat="u in LEAD_SOURCE" value="{{u.sourceID}}">{{u.sourceName}}</option> 
															</select>
														</div>
													</div>
													
												</div>
											</div>
										</div>
							  	</div>
							  </div>
						</form>
						</div>
					</div>  
				</div>	
				<div class="clearfix"></div>
				<br>	
				<div class="col-sm-12" style="border-bottom: 1px solid #f4f4f4;">
					<div class="col-sm-3">					
						<div class="form-group">
							<input type="checkbox" value="1" class="minimal-red" checked="checked" id="checkCustomer"  name="checkCustomer" data-toggle="collapse" data-target="#custo" aria-expanded="true" aria-controls="custo">
							<label>Create Customer Or Select Customer <span class="requrie">(Required)</span></label>						
						</div>
					</div>
					<div class="col-sm-3">
						<form id="ctrCustomer">
							<div class="form-group" style="margin-left: 15px;">
								<select class="form-control select2" name="CustCustomer" id="CustCustomer" style="width: 100%;">
									<option value="">-- SELECT Customer --</option>
									<option ng-repeat="u in CUSTOMER" value="{{u.custID}}">{{u.custName}}</option>
								</select>
							</div>
						</form>
					</div>
					<div class="clearfix"></div>
					<div class="collapse in" id="custo" aria-expanded="true">
						<div class="row"><form id="frmCustomer">
							<div class="col-sm-12">
								<div class="col-sm-12">
								  	<div class="clearfix"></div>
									<div class="col-sm-2"><h4>Overview</h4></div>
									<div class="col-sm-12"><hr style="margin-top: 3px;" /></div>
									<div class="row">
										<div class="col-sm-12">
											<div class="col-sm-12">
												<div class="col-sm-3">
													<label class="font-label">Name <span class="requrie">(Required)</span></label>
													<div class="form-group" id="c_name">
														<input type="text" class="form-control" value="{{LEAD.accountName}}" name="cs_name" id="cs_name">
													</div>
												</div>							
												<div class="col-sm-3">
													<label class="font-label">Tel <span class="requrie">(Required)</span></label>
													<div class="form-group">
														<input type="text" value="{{LEAD.phone}}"  class="form-control" name="c_tel1" id="c_tel1">
													</div>
												</div>							
												
												
												<div class="col-sm-3">
													<label class="font-label">Tel </label>
													<div class="form-group">
														<input type="text" class="form-control" name="c_tel2" id="c_tel2">
													</div>
												</div>							
												<div class="col-sm-3">
													<label class="font-label">Fax </label>
													<div class="form-group">
														<input type="text" class="form-control" name="c_fax" id="c_fax">
													</div>
												</div>																		
												<div class="clearfix"></div>
												<div class="col-sm-3">
													<label class="font-label">Email </label>
													<div class="form-group">
														<input type="email" value="{{LEAD.email}}"  class="form-control" name="c_email" id="c_email">
													</div>
												</div>							
												<div class="col-sm-3">
													<label class="font-label">Website </label>
													<div class="form-group">
														<input type="url" value="{{LEAD.website}}"  placeholder="http://www.example.com" class="form-control" name="c_website" id="c_website">
													</div>
												</div>
											</div>							
											<div class="clearfix"></div>
										</div>
									</div>
									
									
									<div class="clearfix"></div>				
									<div class="col-sm-2"><h4>Address</h4></div>				
									<div class="col-sm-12"><hr style="margin-top: 8px;"/></div>
									<div class="row">				
										<div class="col-sm-12">					
											<div class="col-sm-12">						
												<div class="col-sm-12">
													<label class="font-label">Bill To Address</label>
													<div class="form-group">
														<input type="text" placeholder="" class="form-control" name="c_billAddr" id="c_billAddr">
													</div>
												</div>															
																													
											</div>					
										</div>
									</div>
									
									
									<div class="clearfix"></div>				
									<div class="col-sm-2"><h4>Other</h4></div>				
									<div class="col-sm-12"><hr style="margin-top: 8px;"/></div>
									<div class="row">				
										<div class="col-sm-12">
											<div class="col-sm-12">				
												<div class="col-sm-3">
													<label class="font-label">Facebook</label>
													<div class="form-group">
														<input type="text" class="form-control" name="c_facebook" id="c_facebook">
													</div>
												</div>												
												<div class="col-sm-3">
													<label class="font-label">Line</label>
													<div class="form-group">
														<input type="text" class="form-control" name="c_line" id="c_line">
													</div>
												</div>											
												<div class="col-sm-3">
													<label class="font-label">Viber</label>
													<div class="form-group">
														<input type="text" class="form-control" name="c_viber" id="c_viber">
													</div>
												</div>												
												<div class="col-sm-3">
													<label class="font-label">WhatApp</label>
													<div class="form-group">
														<input type="text" class="form-control" name="c_whatapp" id="c_whatapp">
													</div>
												</div>
												<div class="clearfix"></div>				
												<div class="col-sm-3">
													<label class="font-label">Industry</label>
													<div class="form-group">
														<select class="form-control select2" name="c_industry" id="c_industry" style="width:100%">
															<option value="">-- SELECT Industry</option>
															<option ng-repeat="u in INDUSTRY" value="{{u.industID}}">{{u.industName}}</option> 
														</select>
													</div>
												</div>						
												<div class="col-sm-3">
													<label class="font-label">Type</label>
													<div class="form-group">
														<select style="width:100%" class="form-control select2" name="c_type" id="c_type">
															<option value="">-- SELECT Type</option>
															<option ng-repeat="u in CUSTOMER_TYPE" value="{{u.accountID}}">{{u.accountName}}</option> 
														</select>
													</div>
												</div>
													
											</div>	
										</div>
									</div>
									
									<div class="clearfix"></div>				
									<div class="col-sm-2"><h4>Setting</h4></div>				
									<div class="col-sm-12"><hr style="margin-top: 8px;"/></div>
									<div class="row">			
										<div class="col-sm-12">					
											<div class="col-sm-12">						
												<div class="col-sm-3">
													<label class="font-label">Customer Group <span class="requrie">(Required)</span></label>
													<div class="form-group">
														<select style="width:100%" class="form-control select2" name="c_group" id="c_group">
															<option value="">-- SELECT Customer Group --</option>
															<option ng-repeat="u in GROUP" value="{{u.custGroupId}}">[{{u.custGroupId}}] {{u.custGroupName}}</option> 
														</select>
													</div>
												</div>															
												<div class="col-sm-3">
													<label class="font-label">Price Code <span class="requrie">(Required)</span></label>
													<div class="form-group">
														<select style="width:100%" class="form-control select2" name="c_price" id="c_price">
															<option value="">-- SELECT Price Code --</option>
															<option ng-repeat="u in PRICE_CODE" value="{{u.priceCode}}">[{{u.priceCode}}] {{u.des}}</option> 
														</select>
													</div>
												</div>																		
											</div>					
										</div>
									</div>
						  		</div>
						  	</div>
						</form>
						</div>
					</div>
				</div>
				
				
				<div class="clearfix"></div>
				<br>	
				<div class="col-sm-12">
					<div class="col-sm-3">					
						<div class="form-group">
							<input type="checkbox" value="0" class="minimal-red" id="checkOpportunity"  name="checkOpportunity" data-toggle="collapse" data-target="#opportCollab" aria-expanded="false" aria-controls="opportCollab">
							<label>Create Opportunity </label>						
						</div>
					</div>
					
					<div class="clearfix"></div>
					<div class="collapse" id="opportCollab" aria-expanded="false">
						<div class="row">
						<form id="frmOpportunity">
							<div class="col-sm-12">
								<div class="col-sm-12">
								  	<div class="clearfix"></div>	
									<div class="col-sm-2"><h4>Overview</h4></div>	
									<div class="col-sm-12"><hr style="margin-top: 3px;" /></div>	
									<div class="row">
										<div  class="col-sm-12">
											<div class="col-sm-12">
												<div class="col-sm-3">
													<label class="font-label">Name <span class="requrie">(Required)</span></label>
													<div class="form-group">
														<input type="text" class="form-control" id="op_name" name="op_name">
													</div>
												</div>
												
												<div class="col-sm-3">
													<label class="font-label">Amount <span class="requrie">(Required)</span></label>
													<div class="form-group">
														<input type="text" class="form-control" id="op_amount" name="op_amount">
													</div>
												</div>
																				
												
												
												
												<div class="col-sm-3">
													<label class="font-label">Close date <span class="requrie">(Required)</span></label>
													<div class="form-group">
														<div class="input-group">
															<div class="input-group-addon">
																<i class="fa fa-calendar"></i>
															</div>
															<input type="text" class="form-control pull-right" name="opCloseDate" id="opCloseDate">
														</div> 
													</div>
												</div>
				
												<div class="col-sm-3">
													<label class="font-label">Next Step </label>
													<div class="form-group">
														<input type="text" class="form-control" id="op_nextStep" name="op_nextStep">
													</div>
												</div>
												<div class="clearfix"></div>									
												<div class="col-sm-3">
													<label class="font-label">Campaign </label>
													<div class="form-group">
														<select class="form-control select2" name="op_campaign" id="op_campaign" style="width: 100%;">
															<option value="">-- SELECT Campaign --</option>
															<option ng-repeat="u in CAMPAIGN" value="{{u.campID}}">{{u.campName}}</option>
														</select>
													</div>
												</div>
											
												<div class="col-sm-3">
													<label class="font-label ">Stage <span class="requrie">(Required)</span></label>
													<div class="form-group">
														<select class="form-control select2" name="op_stage" id="op_stage" style="width: 100%;">
															<option value="">-- SELECT Stage --</option>
															<option ng-repeat="u in OPP_STAGES" value="{{u.osId}}">{{u.osName}}</option> 
														</select>
													</div>
												</div>
												
												<div class="col-sm-3">
													<label class="font-label">Type </label>
													<div class="form-group">
														<select class="form-control select2" name="op_type" id="op_type" style="width: 100%;">
															<option value="">-- SELECT Type --</option>
															<option ng-repeat="u in OPP_TYPES" value="{{u.otId}}">{{u.otName}}</option> 
														</select>
													</div>
												</div>
												
												
												
												<div class="col-sm-3">
													<label class="font-label">Probability (%) </label>
													<div class="form-group">
														<input type="text" class="form-control" id="op_probability" name="op_probability">
													</div>
												</div>
												
												<div class="col-sm-3">
													<label class="font-label">Lead Source </label>
													<div class="form-group">
														<select class="form-control select2" name="op_leadSource" id="op_leadSource" style="width: 100%;">
															<option value="">-- SELECT Lead Source --</option>
															<option ng-repeat="u in LEAD_SOURCE" value="{{u.sourceID}}">{{u.sourceName}}</option>
															
														</select>
													</div>
												</div>
												
						
											</div>
											<div class="col-sm-12">
												<div class="col-sm-12">
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
										<div class="col-sm-12">
											<div class="col-sm-12">				
												<div class="col-sm-3">
													<label class="font-label">Assigned to  </label>
													<div class="form-group">
														<select class="form-control select2" name="op_assignTo" id="op_assignTo" style="width:100%">
															<option value="">-- SELECT Assign To --</option>
															<option ng-repeat="u in ASSIGN_TO" value="{{u.userID}}">{{u.username}}</option>
														</select>
													</div>
												</div>
											</div>																		
										</div>
									</div>
										  		</div>
										  	</div>
										</form>
										</div>
									</div>
								</div>
							</div>
						</div>			
			<div class="box-footer"></div>
			<dis id="errors"></dis>
		</div>
	</section>
</div>
<jsp:include page="${request.contextPath}/footer"></jsp:include>