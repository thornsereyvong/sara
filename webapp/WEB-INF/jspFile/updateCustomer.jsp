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
<div class="content-wrapper" id="campController" ng-app="campaign" ng-controller="campController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1> Update Customer</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"> Update Customer</a></li>
		</ol>
	</section>
<script type="text/javascript">

var app = angular.module('campaign', ['oitozero.ngSweetAlert',]);
var self = this;
var custId = "${custId}";
var username = "${SESSION}";
var lastAid= 0;
app.controller('campController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){		
	
	
	$scope.CUSTOMER = [];
	angular.element(document).ready(function () {					
		setTimeout(function(){
			$("#c_group").select2("val",$scope.CUSTOMER.custGroupId);
			$("#c_price").select2("val",$scope.CUSTOMER.priceCode);
			$("#c_type").select2("val",$scope.CUSTOMER.accountTypeID);
			$("#c_industry").select2("val",$scope.CUSTOMER.industID);
		}, 1000);
    });
	
	
	
	$scope.startupCustomer = function() {
		$http.get("${pageContext.request.contextPath}/customer/startup/"+custId).success(function(response){
			
			
			
			$scope.custGroup = response.GROUP;
			$scope.industry = response.INDUSTRY;
			$scope.priceCode = response.PRICE_CODE;
			$scope.type = response.TYPE;
			$scope.shipToAdd = response.CUSTOMER.custDetails;
			$scope.CUSTOMER = response.CUSTOMER;
			
			if(response.CUSTOMER.custDetails.length>0){
				lastAid = Number($scope.shipToAdd[response.CUSTOMER.custDetails.length-1].aId)+1;
			}else{
				lastAid = 1;
			}
			
		});
		
	}	
	
	
	$scope.btnAddMoreShip = function(){		
		$scope.shipToAdd.push({ "custId": custId,"aId": lastAid,"address": ""}); 
		lastAid++;
	}
	$scope.btnRemoveMoreShip = function(key){
		$scope.shipToAdd.splice(key,1);
	}
	
	$scope.shipToAdd = {};
	$scope.getAddress = function(){ 
		var shipToAddrAdd = [];
		angular.forEach($scope.shipToAdd, function(value, key) {
			var txtAddr = $.trim($scope.shipToAdd[key].address);
			if(txtAddr != ""){
				shipToAddrAdd.push({"custId":value.custId,"aId":value.aId, "address":txtAddr});
			}			
		});
		if(shipToAddrAdd.length == 0)
			return null;		
		return shipToAddrAdd;
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
		}).on('success.form.bv', function(e) {							

			var ship = angular.element(document.getElementById('campController')).scope().getAddress();
			$.ajax({
				url : "${pageContext.request.contextPath}/customer/edit",
				type : "PUT",
				data : JSON.stringify({
					  "custID" : custId,
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
					  "custDetails" : ship,
					  "priceCode" : getValueStringById("c_price"),
					  "custGroupId" : getValueStringById("c_group"),
					  "imageName" : ""
				}),
				beforeSend: function(xhr) {
				    xhr.setRequestHeader("Accept", "application/json");
				    xhr.setRequestHeader("Content-Type", "application/json");
			    },
				success:function(data){					
					
					if(data.MESSAGE == "UPDATED"){
						swal({
		            		title:"Success",
		            		text:"You have been updated customer!",
		            		type:"success",  
		            		timer: 2000,   
		            		showConfirmButton: false
	        			});
						reloadForm(2000);
					}else{
						alertMsgErrorSweet();	
					}
				},
				error:function(){
					alertMsgErrorSweet();	
				}
			});	
		});	
});
</script>
	<section class="content">
		<div class="box box-danger">
			
			<div class="box-body">			
				<form method="post" id="form-customer" data-ng-init="startupCustomer()">					
					<button type="button" class="btn btn-info btn-app" id="btn_save" > <i class="fa fa-save"></i> Save</button> 
					<a class="btn btn-info btn-app" id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
					<a class="btn btn-info btn-app"  href="${pageContext.request.contextPath}/list-customers"> <i class="fa fa-reply"></i> Back </a>
	
					<div class="clearfix"></div>
					<div class="col-sm-2"><h4>Overview</h4></div>
					<div class="col-sm-12"><hr style="margin-top: 3px;" /></div>
					<div class="row">
						<div class="col-sm-12">
							<div class="col-sm-6">
								<div class="col-sm-6">
									<label class="font-label">Name <span class="requrie">(Required)</span></label>
									<div class="form-group" id="c_name">
										<input type="text" value="{{CUSTOMER.custName}}" class="form-control" name="cs_name" id="cs_name">
									</div>
								</div>							
								<div class="col-sm-6">
									<label class="font-label">Tel <span class="requrie">(Required)</span></label>
									<div class="form-group">
										<input type="text" value="{{CUSTOMER.custTel1}}" class="form-control" name="c_tel1" id="c_tel1">
									</div>
								</div>							
								
								<div class="clearfix"></div>
								<div class="col-sm-6">
									<label class="font-label">Tel </label>
									<div class="form-group">
										<input type="text" value="{{CUSTOMER.custTel2}}" class="form-control" name="c_tel2" id="c_tel2">
									</div>
								</div>							
								<div class="col-sm-6">
									<label class="font-label">Fax </label>
									<div class="form-group">
										<input type="text" value="{{CUSTOMER.custFax}}" class="form-control" name="c_fax" id="c_fax">
									</div>
								</div>																		
							</div>
							<div class="col-sm-6">
								<div class="col-sm-6">
									<label class="font-label">Email </label>
									<div class="form-group">
										<input type="email" value="{{CUSTOMER.custEmail}}" class="form-control" name="c_email" id="c_email">
									</div>
								</div>							
								<div class="col-sm-6">
									<label class="font-label">Website </label>
									<div class="form-group">
										<input type="url" value="{{CUSTOMER.custWebsite}}" placeholder="http://www.example.com" class="form-control" name="c_website" id="c_website">
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
										<input type="text" value="{{CUSTOMER.custAddress}}" placeholder="" class="form-control" name="c_billAddr" id="c_billAddr">
									</div>
								</div>															
								<div class="col-sm-12" style="margin-bottom: 15px;">
									<label class="font-label">Ship To Address</label>														
									<div class="input-group" ng-repeat="(key, add) in shipToAdd" style="margin-bottom: 5px;">                            	
										<input type="text" ng-model="shipToAdd[key].address"  name="c_shipAddr" class="form-control" id="c_shipAddr" >
										<span class="input-group-btn">
			                                 <button style="height: 34px;" name="c_shipAddr" type="button" ng-click="btnRemoveMoreShip(key)" class="btn btn-danger"><i class="fa  fa-minus-square-o"></i></button>
										</span>
									</div>														
									<button type="button" ng-click="btnAddMoreShip()" id="btnAddMoreShip" class="btn btn-primary"><i class="fa fa-plus-square-o"></i></button>
								</div>																		
							</div>					
						</div>
					</div>
					
					
					<div class="clearfix"></div>				
					<div class="col-sm-2"><h4>Other</h4></div>				
					<div class="col-sm-12"><hr style="margin-top: 8px;"/></div>
					<div class="row">				
						<div class="col-sm-12">
							<div class="col-sm-6">				
								<div class="col-sm-6">
									<label class="font-label">Facebook</label>
									<div class="form-group">
										<input type="text" value="{{CUSTOMER.facebook}}" class="form-control" name="c_facebook" id="c_facebook">
									</div>
								</div>												
								<div class="col-sm-6">
									<label class="font-label">Line</label>
									<div class="form-group">
										<input type="text" value="{{CUSTOMER.line}}"  class="form-control" name="c_line" id="c_line">
									</div>
								</div>											
								<div class="col-sm-6">
									<label class="font-label">Viber</label>
									<div class="form-group">
										<input type="text" value="{{CUSTOMER.viber}}" class="form-control" name="c_viber" id="c_viber">
									</div>
								</div>												
								<div class="col-sm-6">
									<label class="font-label">WhatApp</label>
									<div class="form-group">
										<input type="text" value="{{CUSTOMER.whatApp}}" class="form-control" name="c_whatapp" id="c_whatapp">
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
										<select style="width:100%" class="form-control select2" name="c_type" id="c_type">
											<option value="">-- SELECT Type</option>
											<option ng-repeat="u in type" value="{{u.accountID}}">{{u.accountName}}</option> 
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
							<div class="col-sm-6">						
								<div class="col-sm-6">
									<label class="font-label">Customer Group <span class="requrie">(Required)</span></label>
									<div class="form-group">
										<select style="width:100%" class="form-control select2" name="c_group" id="c_group">
											<option value="">-- SELECT Customer Group --</option>
											<option ng-repeat="u in custGroup" value="{{u.custGroupId}}">[{{u.custGroupId}}] {{u.custGroupName}}</option> 
										</select>
									</div>
								</div>															
								<div class="col-sm-6">
									<label class="font-label">Price Code <span class="requrie">(Required)</span></label>
									<div class="form-group">
										<select style="width:100%" class="form-control select2" name="c_price" id="c_price">
											<option value="">-- SELECT Price Code --</option>
											<option ng-repeat="u in priceCode" value="{{u.priceCode}}">[{{u.priceCode}}] {{u.des}}</option> 
										</select>
									</div>
								</div>																		
							</div>					
						</div>
					</div>
					
					<div class="clearfix"></div>				
					<div class="col-sm-2"><h4>Attachment Picture</h4></div>				
					<div class="col-sm-12"><hr style="margin-top: 8px;"/></div>
					<div class="row">				
						<div class="col-sm-12">					
							<div class="col-sm-6">					
								<div class="col-sm-6">
									<label class="font-label">Logo</label>
									<div class="form-group">
										<input style="width: 100%;" accept="image/*" type="file" name="file" id="fileLogo" class="btn btn-default">
									</div>
								</div>							
							</div>					
						</div>
					</div>
				</form>
			</div>
			<div class="box-footer"><div id="test_div"></div></div>
			<div id="errors"></div>
		</div>
	</section>
</div>
<jsp:include page="${request.contextPath}/footer"></jsp:include>

