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


<div class="content-wrapper" class="content-wrapper" ng-app="campaign"
	ng-controller="campController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Update Lead</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i
					class="fa fa-home"></i> Home</a></li>
			<li><a href="#"> Update Lead</a></li>
		</ol>
	</section>
	<script type="text/javascript">
var app = angular.module('campaign', []);
var self = this;
var leadId = "${leadId}";
var username = "${SESSION}";
app.controller('campController',['$scope','$http',function($scope, $http){
	
	$scope.LEAD = [];
	angular.element(document).ready(function () {					
		
    });
	
	
	$scope.addLeadOnStartup = function() {
		$http({
		    method: 'POST',
		    url: '${pageContext.request.contextPath}/lead/edit/startup/'+leadId+"/"+username,
		    headers: {
		    	'Accept': 'application/json',
		        'Content-Type': 'application/json'
		    },
		    data: {
		    	"username" : username,
		    	"leadId" : leadId
		    }
		}).success(function(response) {
			$scope.users = response.ASSIGN_TO;
			$scope.lead_status = response.LEAD_STATUS;
			$scope.lead_source = response.LEAD_SOURCE;
			$scope.lead_industry = response.INDUSTRY;
			$scope.campaigns = response.CAMPAIGN;
			$scope.LEAD = response.LEAD;
			$scope.child = response.CHILD;	
			if($scope.child === "NOT_EXIST"){
				$("#lea_assignTo").prop("disabled", true);
			}
			
			setTimeout(function(){			
				$("#lea_assignTo").select2("val",$scope.LEAD.assignToUserID);
				$("#lea_ca").select2("val",$scope.LEAD.campID);	
				$("#lea_industry").select2("val",$scope.LEAD.industID);	
				$("#lea_source").select2("val",$scope.LEAD.sourceID);	
				$("#lea_status").select2("val",$scope.LEAD.statusID);	
				$("#lea_salutation").val($scope.LEAD.salutation);
				
				$('#form-leads').data('bootstrapValidator').resetField($('#lea_ca'));
				$('#form-leads').data('bootstrapValidator').resetField($('#lea_status'));
				
			}, 1000);
			
			
		});
	};
}]);

$(document).ready(function() {
	$(".select2").select2();
	$("#btn_clear").click(function(){
		location.reload();
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
					},
					stringLength: {
						max: 100,
						message: 'The Campaign must be less than 100 characters long.'
					}
				}
			},
			lea_firstName: {
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
			lea_lastName: {
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
			lea_phone: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The phone must be less than 255 characters long.'
					}
				}
			}
			,
			lea_mobilePhone: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The mobile phone must be less than 255 characters long.'
					}
				}
			},
			lea_title: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The title must be less than 255 characters long.'
					}
				}
			}
			,
			lea_department: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The department must be less than 255 characters long.'
					}
				}
			}
			,
			lea_email: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The department must be less than 255 characters long.'
					}
				}
			},
			lea_accountName: {
				validators: {
					notEmpty: {
						message: 'The company name is required and can not be empty!'
					},
					stringLength: {
						max: 255,
						message: 'The Company must be less than 255 characters long.'
					}
				}
			},
			lea_no: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The no must be less than 255 characters long.'
					}
				}
			},
			lea_street: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The street must be less than 255 characters long.'
					}
				}
			},
			lea_village: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The village must be less than 255 characters long.'
					}
				}
			}
			,
			lea_commune: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The commune must be less than 255 characters long.'
					}
				}
			},
			lea_district: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The district must be less than 255 characters long.'
					}
				}
			},
			lea_state: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The state must be less than 255 characters long.'
					}
				}
			},
			lea_city: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The city must be less than 255 characters long.'
					}
				}
			},
			lea_country: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The country must be less than 255 characters long.'
					}
				}
			},
			lea_description: {
				validators: {
					stringLength: {
						max: 1000,
						message: 'The description must be less than 1000 characters long.'
					}
				}
			},
			lea_status: {
				validators: {
					notEmpty: {
						message: 'The status is required and can not be empty!'
					}
				}
			}
			
			
			
		}
	}).on('success.form.bv', function(e) {
				
		var frmDataLead = {
				"leadID" : leadId,
				"salutation": getValueStringById("lea_salutation"),
			    "firstName": getValueStringById("lea_firstName"),
			    "lastName": getValueStringById("lea_lastName"),
			    "title": getValueStringById("lea_title"),
			    "department": getValueStringById("lea_department"),
			    "phone": getValueStringById("lea_phone"),
			    "mobile": getValueStringById("lea_mobilePhone"),
			    "website": getValueStringById("lea_website"),
			    "accountName": getValueStringById("lea_accountName"),
			    "no":  getValueStringById("lea_no"),
			    "street": getValueStringById("lea_street"),
			    "village": getValueStringById("lea_village"),
			    "commune": getValueStringById("lea_commune"),
			    "district": getValueStringById("lea_district"),
			    "city": getValueStringById("lea_city"),
			    "state": getValueStringById("lea_state"),
			    "country": getValueStringById("lea_country"),
			    "description": getValueStringById("lea_description"),
			    "status": getJsonById("statusID","lea_status","int"),
			    "industry": getJsonById("industID","lea_industry","int"),
			    "source": getJsonById("sourceID","lea_source","int"),
			    "campaign": getJsonById("campID","lea_ca","str"),
			    "assignTo": getJsonById("userID","lea_assignTo","str"),
			    "modifyBy": username,
			    "email": getValueStringById("lea_email")
		};
		
		
		swal({   
			title: "<span style='font-size: 25px;'>You are about to update lead.</span>",
			text: "Click OK to continue or CANCEL to abort.",
			type: "info",
			html: true,
			showCancelButton: true,
			closeOnConfirm: false,
			showLoaderOnConfirm: true,		
		}, function(){
			setTimeout(function(){
				$.ajax({ 
					url : "${pageContext.request.contextPath}/lead/edit",
					type : "PUT",
					data : JSON.stringify(frmDataLead),	
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
		<div class="box box-danger">
			
			<div class="box-body">
			
			<form method="post" id="form-leads" data-ng-init = "addLeadOnStartup()">
				
				<a class="btn btn-info btn-app" id="btn_save"> <i class="fa fa-save"></i> Save</a> 
				<a class="btn btn-info btn-app"  id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Reload</a> 
				<a class="btn btn-info btn-app" href="${pageContext.request.contextPath}/list-leads"> <i class="fa fa-reply"></i> Back </a>

				<div class="clearfix"></div>
				<div class="col-sm-2"><h4>Overview</h4></div>
				<div class="col-sm-12"><hr style="margin-top: 3px;" /></div>
				<div class="row">
					<div class="col-sm-12">
						<div class="col-sm-6">
							<div class="col-sm-6">
								<label class="font-label">First Name <span class="requrie">(Required)</span></label>
								<div class="form-group">
		                            <div class="input-group">
		                            	<span class="input-group-btn">
			                                 <select class="btn" style="height: 34px; width: 75px;text-align:center" name="lea_salutation" id="lea_salutation">		                                      
			                                     <option value="Mr.">Mr.</option>
			                                     <option value="Ms.">Ms.</option>
			                                     <option value="Mrs.">Mrs.</option>
			                                     <option value="Dr.">Dr.</option>
			                                     <option value="Prof.">Prof.</option>
			                                  </select>
										</span>
										<input type="text" value="{{LEAD.firstName}}" name="lea_firstName" class="form-control ng-cloak" id="lea_firstName">
									</div>
								</div>	
							</div>
							
							<div class="col-sm-6">
								<label class="font-label">Last Name <span class="requrie">(Required)</span></label>
								<div class="form-group">
									<input type="text" value="{{LEAD.lastName}}"  class="form-control ng-cloak" id="lea_lastName" name="lea_lastName">
								</div>
							</div>
							
							<div class="clearfix"></div>
							<div class="col-sm-6">
								<label class="font-label">Company Name <span class="requrie">(Required)</span></label>
								<div class="form-group">
									<input type="text" value="{{LEAD.accountName}}"  class="form-control ng-cloak" id="lea_accountName" name="lea_accountName">
								</div>	
							</div>
							<div class="col-sm-6">
								<label class="font-label">Title </label>
								<div class="form-group">
									<input type="text" value="{{LEAD.title}}"  class="form-control ng-cloak" id="lea_title" name="lea_title">
								</div>	
							</div>
							<div class="clearfix"></div>
							<div class="col-sm-6">
								<label class="font-label">Department </label>
								<div class="form-group">
									<input type="text" value="{{LEAD.department}}"  class="form-control ng-cloak" id="lea_department" name="lea_department">
								</div>
							</div>						
						</div>
						<div class="col-sm-6">
							<div class="col-sm-6">
								<label>Phone :</label>
								<div class="form-group">
									<input type="text" value="{{LEAD.phone}}"  class="form-control ng-cloak" id="lea_phone" name="lea_phone">
								</div>	
							</div>
							<div class="col-sm-6 ">
								<label class="font-label">Mobile Phone </label>
								<div class="form-group">
									<input type="text" value="{{LEAD.mobile}}"  class="form-control ng-cloak" id="lea_mobilePhone" name="lea_mobilePhone">
								</div>	
							</div>
							<div class="col-sm-6">
								<label class="font-label">Website </label>
								<div class="form-group">
									<input type="url" value="{{LEAD.website}}"  placeholder="http://www.example.com" class="form-control ng-cloak" id="lea_website" name="lea_website">
								</div>	
							</div>
							<div class="col-sm-6">
								<label class="font-label">Email </label>
								<div class="form-group">
									<input type="email" value="{{LEAD.email}}"   class="form-control ng-cloak" id="lea_email" name="lea_email">
								</div>	
							</div>
						</div>
						<div class="col-sm-12">
							<div class="col-sm-12">
								<label class="font-label">Description </label>
								<div class="form-group">
									<textarea  rows="3" cols="" name="lea_description" id="lea_description"
										class="form-control ng-cloak">{{LEAD.description}}</textarea>
								</div>
							</div>
						</div>		
					</div>
					
				</div>
				
				
				<div class="clearfix"></div>				
				<div class="col-sm-2"><h4>Address </h4></div>				
				<div class="col-sm-12"><hr style="margin-top: 3px;" /></div>
				<div class="row">
					<div class="col-sm-12">
						<div class="col-sm-6">
						
							<div class="col-sm-6">
								<label class="font-label">No </label>
								<div class="form-group">
									<input type="text" value="{{LEAD.no}}"   class="form-control ng-cloak" id="lea_no" name="lea_no">
								</div>	
							</div>
								
							<div class="col-sm-6">
								<label class="font-label">Street </label>
								<div class="form-group">
									<input type="text" value="{{LEAD.street}}"  class="form-control ng-cloak" id="lea_street" name="lea_street">
								</div>	
							</div>
								
							<div class="col-sm-6">
								<label class="font-label">Village </label>
								<div class="form-group">
									<input type="text" value="{{LEAD.village}}"  class="form-control ng-cloak" id="lea_village" name="lea_village">
								</div>
							</div>
								
							<div class="col-sm-6">
								<label class="font-label">Commune </label>
								<div class="form-group">
									<input type="text" value="{{LEAD.commune}}"  class="form-control ng-cloak" id="lea_commune" name="lea_commune">
								</div>
							</div>
								
							
						</div>
						<div class="col-sm-6">
							<div class="col-sm-6">
								<label class="font-label">District </label>
								<div class="form-group">
									<input type="text" value="{{LEAD.district}}"  class="form-control ng-cloak" id="lea_district" name="lea_district">
								</div>	
							</div>
							
							<div class="col-sm-6">
								<label class="font-label">City </label>
								<div class="form-group">
									<input type="text" value="{{LEAD.city}}"  class="form-control ng-cloak" id="lea_city" name="lea_city">
								</div>	
							</div>
							
							<div class="col-sm-6">
								<label class="font-label">State </label>
								<div class="form-group">
									<input type="text" value="{{LEAD.state}}"  class="form-control ng-cloak" id="lea_state" name="lea_state">
								</div>
							</div>
							
							<div class="col-sm-6">
								<label class="font-label">Country </label>
								<div class="form-group">
									<input type="text" value="{{LEAD.country}}"  class="form-control ng-cloak" id="lea_country" name="lea_country">
								</div>	
							</div>
						</div>
												
					</div>
				</div>		
				
						
						
			<div class="clearfix"></div>
			<div class="col-sm-2"><h4>More Information </h4></div>
			<div class="col-sm-12"> <hr style="margin-top: 3px;" />
			</div>
			<div class="row" >
				<div class="col-sm-12">
					<div class="col-sm-6">
						<div class="col-sm-6">
							<label class="font-label">Campaign <span class="requrie">(Required)</span></label>
							<div class="form-group">
								<select class="form-control select2" name="lea_ca" id="lea_ca" style="width: 100%;">
									<option value="">-- SELECT Campaign --</option>
									<option ng-repeat="u in campaigns" value="{{u.campID}}">[{{u.campID}}] {{u.campName}}</option>
								</select>
							</div>
						</div>
						<div class="col-sm-6"">
							<label class="font-label">Status <span class="requrie">(Required)</span></label>
							<div class="form-group">
								<select class="form-control select2" name="lea_status" id="lea_status" style="width: 100%;">
									<option value="">-- SELECT Status --</option>
									<option ng-repeat="u in lead_status" value="{{u.statusID}}">{{u.statusName}}</option> 
								</select>
							</div>
						</div>
							
						
					</div>
				  	<div class="col-sm-6">		
						<div class="col-sm-6">
							<label class="font-label">Source </label>
							<div class="form-group">
								<select class="form-control select2" name="lea_source" id="lea_source" style="width: 100%;">
									<option value="">-- SELECT Source --</option>
									<option ng-repeat="u in lead_source" value="{{u.sourceID}}">{{u.sourceName}}</option> 
								</select>
							</div>
						</div>
						<div class="col-sm-6">
							<label class="font-label">Industry </label>
							<div class="form-group" >
								<select class="form-control select2" name="lea_industry" id="lea_industry" style="width: 100%;">
									<option value="">-- SELECT Industry --</option>
									<option ng-repeat="u in lead_industry" value="{{u.industID}}">{{u.industName}}</option> 
								</select>
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
						<label class="font-label">Assigned to : </label>
						<div class="form-group">
							<select class="form-control select2"  name="lea_assignTo" id="lea_assignTo" style="width: 100%;">
		                      	<option value="">-- SELECT User --</option>
								<option ng-repeat="user in users" value="{{user.userID}}">{{user.username}}</option>         
			            	</select>
						</div>
					</div>
					<div class="col-sm-6">
						<label class="font-label">Image :</label>
						<div class="form-group">
							<input style="width: 100%;" accept="image/*" type="file" name="file" id="fileLogo" class="btn btn-default">
						</div>
					</div>	
				</div>
				</div>
			</div>
			
		</form>
	</div>
	<div id="errors"></div>
	<div class="box-footer"></div>
</div>
</section>
</div>
<jsp:include page="${request.contextPath}/footer"></jsp:include>
