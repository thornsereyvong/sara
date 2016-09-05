<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>




<style>
.font-label {
	font-size: 13px;
	padding-top: 4px;
}
</style>
<div class="content-wrapper" ng-app="campaign" ng-controller="campController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Create Customer</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li><a href="#"> Create Customer</a></li>
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
				
	$scope.listCampUser = function() {
		$http.get("${pageContext.request.contextPath}/user/list")
		.success(function(response){
			$scope.camp_user = response.DATA;
		});
		
	}	

}]);




$(document).ready(function() {
	$(".select2").select2();

	$("#btn_clear").click(function(){
		$("#form-customer").bootstrapValidator('resetForm', 'true');
	});
	
	 $("#btn_save").click(function(){
		$("#form-customer").submit();
		
	});


		
		$('#form-customer').bootstrapValidator({
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
				}
			}
		}).on('success.form.bv', function(e) {

			var currentDate = new Date();
			var day = currentDate.getDate();
			var month = currentDate.getMonth() + 1;
			var year = currentDate.getFullYear();

		    var industry = "";	
			if($("#c_industry").val()  != ""){
				industry = {"industID": $("#c_industry").val()};
			}else{
				industry = null;
			}

			var account = "";	
			if($("#c_type").val()  != ""){
				account = {"accountID": $("#c_type").val()};
			}else{
				account = null;
			}


			
			$.ajax({
				url : "${pageContext.request.contextPath}/customer/add",
				type : "POST",
				data : JSON.stringify({ 
				      "custName": $("#cs_name").val(),
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
					  "accountTypeID": account	
					}),
				beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
						    },
				success:function(data){
					
						$("#form-customer").bootstrapValidator('resetForm', 'true');
						$('#form-customer')[0].reset();
						$("#c_industry").select2("val","");
						$("#c_type").select2("val","");
						
						swal({
		            		title:"Success",
		            		text:"User have been created new Customer!",
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
			
			<form method="post" id="form-customer">
				
				<button type="button" class="btn btn-info btn-app" id="btn_save" > <i class="fa fa-save"></i> Save</button> 
				<a class="btn btn-info btn-app" id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
				<a class="btn btn-info btn-app"  href="${pageContext.request.contextPath}/list-customers"> <i class="fa fa-reply"></i> Back </a>

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
							<label class="font-label">Name <span class="requrie">(Required)</span></label>
							<div class="form-group" id="c_name">
								<input type="text" class="form-control" name="cs_name" id="cs_name">
							</div>
						</div>
						
						<div class="col-sm-6">
							<label class="font-label">Tel <span class="requrie">(Required)</span></label>
							<div class="form-group">
								<input type="text" class="form-control" name="c_tel1" id="c_tel1">
							</div>
						</div>
						
						<div class="clearfix"></div>
						<div class="col-sm-6">
							<label class="font-label">Tel </label>
							<div class="form-group">
								<input type="text" class="form-control" name="c_tel2" id="c_tel2">
							</div>
						</div>
						
						<div class="col-sm-6">
							<label class="font-label">Fax </label>
							<div class="form-group">
								<input type="text" class="form-control" name="c_fax" id="c_fax">
							</div>
						</div>
						
						<div class="col-sm-12">
							<label class="font-label">Address </label>
							<div class="form-group">
								<textarea style="height: 120px" rows="" cols="" name="c_address" id="c_address"	class="form-control"></textarea>
							</div>
						</div>
						
					</div>

					<div class="col-sm-6">

						<div class="col-sm-6">
							<label class="font-label">Email </label>
							<div class="form-group">
								<input type="email" class="form-control" name="c_email" id="c_email">
							</div>
						</div>
						

						<div class="col-sm-6">
							<label class="font-label">Website </label>
							<div class="form-group">
								<input type="url" placeholder="http://www.example.com" class="form-control" name="c_website" id="c_website">
							</div>
						</div>
						

					</div>
					

					<div class="clearfix"></div>


				</div>
				
				<div class="clearfix"></div>
				
				<div class="col-sm-2"><h4>Other</h4></div>
				
				<div class="col-sm-12">
						<hr style="margin-top: 8px;"/>
				</div>
				<div class="row">
				<div class="col-sm-6">
				
					<div class="col-sm-6">
							<label class="font-label">Facebook</label>
							<div class="form-group">
								<input type="text" class="form-control" name="c_facebook" id="c_facebook">
							</div>
						</div>
						
						
					<div class="col-sm-6">
							<label class="font-label">Line</label>
							<div class="form-group">
								<input type="text" class="form-control" name="c_line" id="c_line">
							</div>
						</div>
						
						
						<div class="col-sm-6">
							<label class="font-label">Viber</label>
							<div class="form-group">
								<input type="text" class="form-control" name="c_viber" id="c_viber">
							</div>
						</div>
						
						
						<div class="col-sm-6">
							<label class="font-label">WhatApp</label>
							<div class="form-group">
								<input type="text" class="form-control" name="c_whatapp" id="c_whatapp">
							</div>
						</div>
						
				</div>
				
				<div class="col-sm-6">
				
					<div class="col-sm-6" data-ng-init="listIndustry()">
							<label class="font-label">Industry</label>
							<div class="form-group">
								<select class="form-control select2" name="c_industry" id="c_industry" style="width:100%">
									<option value="">-- SELECT Industry</option>
									<option ng-repeat="u in industry" value="{{u.industID}}">{{u.industName}}</option> 
								</select>
							</div>
						</div>
						
					<div class="col-sm-6" data-ng-init="listAccount()">
							<label class="font-label">Type</label>
							<div class="form-group">
								<select class="form-control select2" name="c_type" id="c_type">
									<option value="">-- SELECT Type</option>
									<option ng-repeat="u in account" value="{{u.accountID}}">{{u.accountName}}</option> 
								</select>
							</div>
						</div>
						
					</div>	
				</div>

			</form>
			</div>
			<!-- /.box-body -->
			<div class="box-footer"><div id="test_div"></div></div>
			<!-- /.box-footer-->
		</div>
		
		<!-- /.box -->


	</section>
	<!-- /.content -->


</div>

<!-- /.content-wrapper -->


<jsp:include page="${request.contextPath}/footer"></jsp:include>

