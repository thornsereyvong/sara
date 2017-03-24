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

<div class="content-wrapper" class="content-wrapper" ng-app="leadProject" ng-controller="leadProjectController" id="leadProjectController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Update Lead project</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"> Update Lead project</a></li>
		</ol>
	</section>
<script type="text/javascript">
var app = angular.module('leadProject', ['angular-loading-bar', 'ngAnimate']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = false;
}]);
var self = this;
var id = "${id}";
app.controller('leadProjectController',['$scope','$http',function($scope, $http){
	$scope.findLeadProjectById = function() {
		$http({
		    method: 'GET',
		    url: '${pageContext.request.contextPath}/project/view/'+id,
		    headers: {
		    	'Accept': 'application/json',
		        'Content-Type': 'application/json'
		    }
		}).success(function(response) {
			$scope.project = response.DATA;
			$("#name").val($scope.project.name);
			$("#account_manager").val($scope.project.accountManager);
			$("#company").val($scope.project.companyName);
			$("#biz_type").val($scope.project.typeBiz);
			$("#biz_size").val($scope.project.sizeBiz);
			$("#address").val($scope.project.address);
			$("#per_in_charge").val($scope.project.perInCharge);
			$("#mobile").val($scope.project.mobile);
			$("#email").val($scope.project.email);
			$("#url").val($scope.project.url);
			$("#owner").val($scope.project.owner);
			$("#consultant").val($scope.project.consultant);
			$("#construction").val($scope.project.construction);
			$("#main_construction").val($scope.project.mainConstruction);
			$("#subconstructor").val($scope.project.subConstructor);
			$("#remark").val($scope.project.remark);
			$("#startDate").val(moment.unix($scope.project.startDate/1000).format("DD/MM/YYYY hh:mm A"));
			$("#endDate").val(moment.unix($scope.project.endDate/1000).format("DD/MM/YYYY hh:mm A"));
		});
	};
}]);

$(document).ready(function() {
	$("#btn_clear").click(function(){
		$("#form-leads").bootstrapValidator('resetForm', 'true');
		$('#form-leads')[0].reset();
	});
	$("#btn_save").click(function(){
		$("#form-leads").submit();
	});

	$('.date2').daterangepicker({
        singleDatePicker: true,
        showDropdowns: true,
        format: 'DD/MM/YYYY h:mm A',
        timePicker: true, 
        timePickerIncrement: 5
       
    }).on('change', function(e) {
		if($("#startDate").val() != ""){
			$('#form-leads').bootstrapValidator('revalidateField', 'startDate');
		}
		if($("#endDate").val() != ""){
			$('#form-leads').bootstrapValidator('revalidateField', 'endDate');
		}
	});
	
	$('#form-leads').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			name: {
				validators: {
					notEmpty: {
						message: 'The Project name is required and can not be empty!'
					},
					stringLength: {
						max: 100,
						message: 'The Project name be less than 100 characters long.'
					}
				}
			},
			startDate: {
				validators: {
					notEmpty: {
						message: 'The Start Date is required and can not be empty!'
					},
					date: {
                        format: 'DD/MM/YYYY h:mm A',
                        message: 'The value is not a valid date!'
					}
				}
			},
			endDate: {
				validators: {
					notEmpty: {
						message: 'The End Date is required and can not be empty!'
					},
					date: {
                        format: 'DD/MM/YYYY h:mm A',
                        message: 'The value is not a valid date!'
					}
				}
			}
		}
	}).on('success.form.bv', function(e) {
		var startDate = moment(getValueStringById("startDate"), "DD/MM/YYYY H:mm").unix();
		var endDate = moment(getValueStringById("endDate"), "DD/MM/YYYY H:mm").unix();
		var frmDataLead = {
				"id":id,
				"name": getValueStringById("name"),
			    "accountManager": getValueStringById("account_manager"),
			    "companyName": getValueStringById("company"),
			    "typeBiz": getValueStringById("biz_type"),
			    "sizeBiz": getValueStringById("biz_size"),
			    "address": getValueStringById("address"),
			    "perInCharge": getValueStringById("per_in_charge"),
			    "mobile": getValueStringById("mobile"),
			    "email": getValueStringById("email"),
			    "url":  getValueStringById("url"),
			    "owner": getValueStringById("owner"),
			    "consultant": getValueStringById("consultant"),
			    "construction": getValueStringById("construction"),
			    "mainConstruction": getValueStringById("main_construction"),
			    "subConstructor": getValueStringById("subconstructor"),
			    "remark": getValueStringById("lea_state"),
			    "startDate": moment.unix(startDate),
			    "endDate": moment.unix(endDate)
		};
		 swal({   
			title: "<span style='font-size: 25px;'>You are about to update lead project.</span>",
			text: "Click OK to continue or CANCEL to abort.",
			type: "info",
			html: true,
			showCancelButton: true,
			closeOnConfirm: false,
			showLoaderOnConfirm: true,		
		}, function(){ 
			setTimeout(function(){
				$.ajax({ 
					url : "${pageContext.request.contextPath}/project/edit",
					type : "PUT",
					data : JSON.stringify(frmDataLead),	
					beforeSend: function(xhr) {
					    xhr.setRequestHeader("Accept", "application/json");
					    xhr.setRequestHeader("Content-Type", "application/json");
				    }, 
				    success: function(result){					    						    
						if(result.MESSAGE == "UPDATED"){
							$("#form-leads").bootstrapValidator('resetForm', 'true');
							$('#form-leads')[0].reset();
							alertMsgSuccessSweetWithTxt(result.MSG);
							reloadForm(2000);
						}else{
							alertMsgErrorSweetWithTxt(result.MSG);
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
	<section class="content" data-ng-init="findLeadProjectById()">
		<div class="box box-danger">
			<div class="box-body">
			<form method="post" id="form-leads">
				<div class="col-sm-12 col-xs-12 col-md-12 col-lg-12">
					<a class="btn btn-info btn-app" id="btn_save"> <i class="fa fa-save"></i> Save</a> 
					<a class="btn btn-info btn-app"  id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
					<a class="btn btn-info btn-app" href="${pageContext.request.contextPath}/lead-project"> <i class="fa fa-reply"></i> Back </a>
				</div>
				<div class="clearfix"></div>
				<div class="col-sm-2"><h4>Overview</h4></div>
				<div class="col-sm-12"><hr style="margin-top: 3px;" /></div>
				<div class="row">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">Name <span class="requrie">(Required)</span></label>
								<div class="form-group">
									<input type="text" class="form-control" id="name" name="name">
								</div>
							</div>
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">Account Manager </label>
								<div class="form-group">
									<input type="text"  class="form-control" id="account_manager" name="account_manager">
								</div>	
							</div>
							<div class="clearfix hidden-lg hidden-md"></div>
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">Company </label>
								<div class="form-group">
									<input type="text" class="form-control" id="company" name="company">
								</div>	
							</div>
							<div class="clearfix hidden-sm hidden-lg"></div>
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">Business Type </label>
								<div class="form-group">
									<input type="text"  class="form-control" id="biz_type" name="biz_type">
								</div>	
							</div>
							<div class="clearfix hidden-md"></div>
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">Business Size </label>
								<div class="form-group">
									<input type="text" class="form-control" id="biz_size" name="biz_size">
								</div>
							</div>
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">Owner </label>
								<div class="form-group">
									<input type="text" class="form-control" id="owner" name="owner">
								</div>
							</div>						
						
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label>Person In Charge</label>
								<div class="form-group">
									<input type="text"  class="form-control" id="per_in_charge" name="per_in_charge">
								</div>	
							</div>
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3 ">
								<label class="font-label">Mobile Phone </label>
								<div class="form-group">
									<input type="text"  class="form-control" id="mobile" name="mobile">
								</div>	
							</div>
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">Website </label>
								<div class="form-group">
									<input type="url" placeholder="http://www.example.com" class="form-control" id="url" name="url">
								</div>	
							</div>
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">Email </label>
								<div class="form-group">
									<input type="email"  class="form-control" id="email" name="email">
								</div>	
							</div>
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">Start date</label>
								<div class="form-group">
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input type="text" class="form-control pull-right date2" name="startDate" id="startDate" ng-model="startDate">
									</div> 
								</div>
							</div>
						
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">End date</span></label>
								<div class="form-group">
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input type="text" class="form-control pull-right date2" name="endDate" id="endDate"  ng-model="endDate">
									</div> 
								</div>
							</div>
							<div class="col-sm-12">
								<label class="font-label">Address </label>
								<div class="form-group">
									<textarea  rows="3" cols="" name="address" id="address"
										class="form-control"></textarea>
								</div>
							</div>		
						</div>
					</div>
				</div>
				<div class="clearfix"></div>				
				<div class="col-sm-12"><h4>More Information </h4></div>
				<div class="col-sm-12"> <hr style="margin-top: 3px;" /></div>
				<div class="row" >
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">Consultant</label>
								<div class="form-group">
									<input type="text"  class="form-control" id="consultant" name="consultant">
								</div>
							</div>
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">Construction</label>
								<div class="form-group">
									<input type="text"  class="form-control" id="construction" name="construction">
								</div>
							</div>
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">Main Construction</label>
								<div class="form-group">
									<input type="text"  class="form-control" id="main_construction" name="main_construction">
								</div>
							</div>
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">Sub Constructor </label>
								<div class="form-group">
									<input type="text"  class="form-control" id="subconstructor" name="subconstructor">
								</div>
							</div>
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<label class="font-label">Remark </label>
								<div class="form-group">
									<input type="text"  class="form-control" id="remark" name="remark">
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

