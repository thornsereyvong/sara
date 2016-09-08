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
		<h1>Create Lead</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li><a href="#"> Create Lead</a></li>
		</ol>
	</section>
<script type="text/javascript">


var app = angular.module('campaign', ['oitozero.ngSweetAlert',]);
var self = this;
app.controller('campController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){

			$scope.addLeadOnStartup = function(username) {
				$http({
				    method: 'POST',
				    url: '${pageContext.request.contextPath}/lead/add/startup',
				    headers: {
				    	'Accept': 'application/json',
				        'Content-Type': 'application/json'
				    },
				    data: {
				    	"username":username
				    }
				}).success(function(response) {
					$scope.users = response.ASSIGN_TO;
					$scope.lead_status = response.LEAD_STATUS;
					$scope.lead_source = response.LEAD_SOURCE;
					$scope.lead_industry = response.INDUSTRY;
					$scope.campaigns = response.CAMPAIGN;
					$scope.child = response.CHILD;	
					if($scope.child === "NOT_EXIST"){
						$("#lea_assignTo").prop("disabled", true);
					}
				});
			};
	}]);

$(document).ready(function() {
	$(".select2").select2();
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
					},
					stringLength: {
						max: 100,
						message: 'The must be less than 100 characters long.'
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
						max: 255,
						message: 'The description must be less than 255 characters long.'
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
			url : "${pageContext.request.contextPath}/lead/add",
			type : "POST",
			data : JSON.stringify({
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
			    "createBy": $.session.get("parentID"),
			    "createDate":  year+"-"+month+"-"+day,
			    "email": $("#lea_email").val()
			    }),	
			beforeSend: function(xhr) {
					    xhr.setRequestHeader("Accept", "application/json");
					    xhr.setRequestHeader("Content-Type", "application/json");
					    },
			success:function(data){
					$("#form-leads").bootstrapValidator('resetForm', 'true');
					$('#form-leads')[0].reset();
					$("#lea_assignTo").select2("val","");
					$("#lea_ca").select2("val","");	
					$("#lea_industry").select2("val","");	
					$("#lea_source").select2("val","");	
					$("#lea_status").select2("val","");		
					swal({
	            		title:"Success",
	            		text:"User have been created new Lead!",
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
									<input type="text" name="lea_firstName" class="form-control" id="lea_firstName">
								</div>
							</div>	
						</div>
						
						<div class="col-sm-6">
							<label class="font-label">Last Name <span class="requrie">(Required)</span></label>
							<div class="form-group">
								<input type="text" class="form-control" id="lea_lastName" name="lea_lastName">
							</div>
						</div>
						
						<div class="clearfix"></div>
						<div class="col-sm-6">
							<label class="font-label">Title </label>
							<div class="form-group">
								<input type="text" class="form-control" id="lea_title" name="lea_title">
							</div>	
						</div>
					
						<div class="col-sm-6">
							<label class="font-label">Department </label>
							<div class="form-group">
								<input type="text"  class="form-control" id="lea_department" name="lea_department">
							</div>
						</div>
						
						<div class="col-sm-6">
							<label class="font-label">Company Name </label>
							<div class="form-group">
								<input type="text"  class="form-control" id="lea_accountName" name="lea_accountName">
							</div>	
						</div>
						

						
					</div>

					<div class="col-sm-6">
						<div class="col-sm-6">
							<label>Phone :</label>
							<div class="form-group">
								<input type="text"  class="form-control" id="lea_phone" name="lea_phone">
							</div>	
						</div>
						<div class="col-sm-6 ">
							<label class="font-label">Mobile Phone </label>
							<div class="form-group">
								<input type="text"  class="form-control" id="lea_mobilePhone" name="lea_mobilePhone">
							</div>	
						</div>
						<div class="col-sm-6">
							<label class="font-label">Website </label>
							<div class="form-group">
								<input type="url" placeholder="http://www.example.com" class="form-control" id="lea_website" name="lea_website">
							</div>	
						</div>
						<div class="col-sm-6">
							<label class="font-label">Email </label>
							<div class="form-group">
								<input type="email"  class="form-control" id="lea_email" name="lea_email">
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
				<div class="row">
				<div class="col-sm-6">
				
					<div class="col-sm-6">
						<label class="font-label">No </label>
						<div class="form-group">
							<input type="text"  class="form-control" id="lea_no" name="lea_no">
						</div>	
					</div>
						
					<div class="col-sm-6">
						<label class="font-label">Street </label>
						<div class="form-group">
							<input type="text"  class="form-control" id="lea_street" name="lea_street">
						</div>	
					</div>
						
					<div class="col-sm-6">
						<label class="font-label">Village </label>
						<div class="form-group">
							<input type="text"  class="form-control" id="lea_village" name="lea_village">
						</div>
					</div>
						
					<div class="col-sm-6">
						<label class="font-label">Commune </label>
						<div class="form-group">
							<input type="text"  class="form-control" id="lea_commune" name="lea_commune">
						</div>
					</div>
						
					<div class="col-sm-12">
						<label class="font-label">Description </label>
						<div class="form-group">
							<textarea style="height: 120px" rows="" cols="" name="lea_description" id="lea_description"
								class="form-control"></textarea>
						</div>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="col-sm-6">
						<label class="font-label">District </label>
						<div class="form-group">
							<input type="text"  class="form-control" id="lea_district" name="lea_district">
						</div>	
					</div>
					
					<div class="col-sm-6">
						<label class="font-label">City </label>
						<div class="form-group">
							<input type="text"  class="form-control" id="lea_city" name="lea_city">
						</div>	
					</div>
					
					<div class="col-sm-6">
						<label class="font-label">State </label>
						<div class="form-group">
							<input type="text"  class="form-control" id="lea_state" name="lea_state">
						</div>
					</div>
					
					<div class="col-sm-6">
						<label class="font-label">Country </label>
						<div class="form-group">
							<input type="text"  class="form-control" id="lea_country" name="lea_country">
						</div>	
					</div>
				</div>
			  </div>
				
			<div class="clearfix"></div>
			<div class="col-sm-2"><h4>More Information </h4></div>
			<div class="col-sm-12"> <hr style="margin-top: 3px;" />
			</div>
			<div class="row" data-ng-init = "addLeadOnStartup('${SESSION}')">
				<div class="col-sm-6">
					<div class="col-sm-6"">
						<label class="font-label">Status </label>
						<div class="form-group">
							<select class="form-control select2" name="lea_status" id="lea_status" style="width: 100%;">
								<option value="">-- SELECT Status --</option>
								<option ng-repeat="u in lead_status" value="{{u.statusID}}">{{u.statusName}}</option> 
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
						<label class="font-label">Campaign</label>
						<div class="form-group">
							<select class="form-control select2" name="lea_ca" id="lea_ca" style="width: 100%;">
								<option value="">-- SELECT Campaign --</option>
								<option ng-repeat="u in campaigns" value="{{u.campID}}">{{u.campName}}</option>
							</select>
						</div>
					</div>
				</div>	
			</div>
				
			<div class="clearfix"></div>
			<div class="col-sm-2"><h4>Other </h4></div>
			<div class="col-sm-12"><hr style="margin-top: 3px;" /></div>
			<div class="row">
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

