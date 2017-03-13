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
<div class="content-wrapper" ng-app="campaign" id="campController" ng-controller="campController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Create Customer</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"> Create Customer</a></li>
		</ol>
	</section>
<script type="text/javascript">

var app = angular.module('campaign', ['angular-loading-bar', 'ngAnimate']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = false;
}]);
var self = this;

app.controller('campController',['$scope','$http',function($scope, $http){		
	
	$scope.keyS = -1;
	
	$scope.startupCustomer = function() {
		$http.get("${pageContext.request.contextPath}/customer/startup").success(function(response){
			$scope.custGroup = response.GROUP;
			$scope.industry = response.INDUSTRY;
			$scope.priceCode = response.PRICE_CODE;
			$scope.type = response.TYPE;
		});
		$scope.shipToAdd = [{"addr":""}];
	}	
	
	
	$scope.btnAddMoreShip = function(){	
		$scope.shipToAdd.push({"code":"", "addr":""}); 
		setTimeout(function(){
			if($scope.shipToAdd.length == 1){
				$scope.keyS = 0;
				$('input[name=ckShipAdd]:first', '#form-customer').attr('checked', true);
			}
		}, 500);
		
	}
	$scope.btnRemoveMoreShip = function(key){
		$scope.shipToAdd.splice(key,1);
		setTimeout(function(){
			var ckShip = $('input[name=ckShipAdd]:checked', '#form-customer').val();
			if(ckShip == undefined){				
				$('input[name=ckShipAdd]:first', '#form-customer').attr('checked', true);
			}
		}, 500);
	}
	
	$scope.newAddr = {};
	$scope.getAddress = function(){ 
		var shipToAddrAdd = [];	
		var msg = true;
		var a =0;
		
		
		angular.forEach($scope.shipToAdd, function(value, key) { a++;
			var txtAddr = $.trim($scope.shipToAdd[key].addr);
			var txtCode = $.trim($scope.shipToAdd[key].code);
			
			if(a==1){
				if(txtAddr == "" && txtCode == "" && $scope.shipToAdd.length == 1 ){
					$("#c_shipCode"+key).attr("style","");
				}else{
					if(txtCode != ""){
						shipToAddrAdd.push({"shipId":$scope.shipToAdd[key].code, "shipName":$scope.shipToAdd[key].addr});
						$("#c_shipCode"+key).attr("style","");
					}else{
						shipToAddrAdd.push({"shipId":$scope.shipToAdd[key].code, "shipName":$scope.shipToAdd[key].addr});
						$("#c_shipCode"+key).attr("style","border: 1px solid #dd4b39;");
						msg = false;
					}
				}
				
			}else{
				if(txtCode != ""){
					shipToAddrAdd.push({"shipId":$scope.shipToAdd[key].code, "shipName":$scope.shipToAdd[key].addr});
					$("#c_shipCode"+key).attr("style","");
				}else{
					shipToAddrAdd.push({"shipId":$scope.shipToAdd[key].code, "shipName":$scope.shipToAdd[key].addr});
					$("#c_shipCode"+key).attr("style","border: 1px solid #dd4b39;");
					msg = false;
				}
			}
							
		});	
		
		if(shipToAddrAdd.length == 0)
			return {"msg": msg , "data":null};			
		var ship = {"msg": msg , "data":shipToAddrAdd};	
		return  ship;
	}
}]);

$(document).ready(function() {
	$(".select2").select2();
	$("#btn_clear").click(function(){
		location.reload()
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
				},
				
			}
		}).on('success.form.bv', function(e) {							
			var ship = angular.element(document.getElementById('campController')).scope().getAddress();
			var ckShip = $('input[name=ckShipAdd]:checked', '#form-customer').val();
			
			if(ship.msg == true){
				swal({   
					title: "<span style='font-size: 25px;'>You are about to create customer.</span>",
					text: "Click OK to continue or CANCEL to abort.",
					type: "info",
					html: true,
					showCancelButton: true,
					closeOnConfirm: false,
					showLoaderOnConfirm: true,		
				}, function(){
					setTimeout(function(){
						$.ajax({ 
							url : "${pageContext.request.contextPath}/customer/add",
							type : "POST",
							data : JSON.stringify({ 
							      "custName": getValueStringById("cs_name"),
							      "custTel1": getValueStringById("c_tel1"),
							      "custTel2": getValueStringById("c_tel2"),
							      "custFax": getValueStringById("c_fax"),
							      "custEmail": getValueStringById("c_email"),
							      "custWebsite": getValueStringById("c_website"),
							      "custAddress": getValueStringById("c_billAddr"),
							      "facebook": getValueStringById("c_facebook"),
							      "line": getValueStringById("c_line"),
							      "viber": getValueStringById("c_viber"),
							      "whatApp": getValueStringById("c_whatapp"),
							      "industID": getJsonById("industID","c_industry","int"),
								  "accountTypeID": getJsonById("accountID","c_type","int"),
								  "shipAddresses" : ship.data,
								  "priceCode" : getJsonById("priceCode","c_price","str"),
								  "custGroup" : getJsonById("custGroupId","c_group","str"),
								  "imageName" : "",
								  "aId" : ckShip
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
			}
		}).on('error.form.bv', function(e) {
			angular.element(document.getElementById('campController')).scope().getAddress();
		});
});
</script>
	<section class="content">
		<div class="box box-danger">
			
			<div class="box-body">			
				<form method="post" id="form-customer" data-ng-init="startupCustomer()">	
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">				
						<button type="button" class="btn btn-info btn-app" id="btn_save" > <i class="fa fa-save"></i> Save</button> 
						<a class="btn btn-info btn-app" id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
						<a class="btn btn-info btn-app"  href="${pageContext.request.contextPath}/list-customers"> <i class="fa fa-reply"></i> Back </a>
					</div>
					<div class="clearfix"></div>
					<div class="col-sm-2"><h4>Overview</h4></div>
					<div class="col-sm-12"><hr style="margin-top: 3px;" /></div>
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Name <span class="requrie">(Required)</span></label>
									<div class="form-group" id="c_name">
										<input type="text" class="form-control  ng-cloak" name="cs_name" id="cs_name">
									</div>
								</div>							
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Tel <span class="requrie">(Required)</span></label>
									<div class="form-group">
										<input type="text" class="form-control  ng-cloak" name="c_tel1" id="c_tel1">
									</div>
								</div>							
								
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Tel </label>
									<div class="form-group">
										<input type="text" class="form-control  ng-cloak" name="c_tel2" id="c_tel2">
									</div>
								</div>							
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Fax </label>
									<div class="form-group">
										<input type="text" class="form-control  ng-cloak" name="c_fax" id="c_fax">
									</div>
								</div>																		
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Email </label>
									<div class="form-group">
										<input type="email" class="form-control  ng-cloak" name="c_email" id="c_email">
									</div>
								</div>							
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Website </label>
									<div class="form-group">
										<input type="url" placeholder="http://www.example.com" class="form-control  ng-cloak" name="c_website" id="c_website">
									</div>
								</div>
							</div>							
							<div class="clearfix"></div>
						</div>
					</div>
					
					<div class="clearfix"></div>				
					<div class="col-sm-12"><h4>Address</h4></div>				
					<div class="col-sm-12"><hr style="margin-top: 8px;"/></div>
					<div class="row">				
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">					
							<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">						
								<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
									<label class="font-label">Bill To Address</label>
									<div class="form-group">
										<input type="text" placeholder="" class="form-control  ng-cloak" name="c_billAddr" id="c_billAddr">
									</div>
								</div>															
								<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
									<label class="font-label">Ship To Address</label>	
								</div>
								
								<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-bottom: 10px;" ng-repeat="(key, add) in shipToAdd">									
									<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2" style="padding-left: 0px;padding-right: 0px;">
										 <div class="input-group"  style="margin-bottom: 5px;">                            	
											<span class="input-group-addon">
										       <input ng-if="key ==0 ||  shipToAdd.length <= 1 || key== keyS " type="radio" style="cursor: pointer;" checked="checked" name="ckShipAdd" value="{{shipToAdd[key].code}}" aria-label="...">
										       <input ng-if="key >0 && shipToAdd.length > 1 && key != keyS " type="radio" style="cursor: pointer;" class="cursor_pointer" name="ckShipAdd" value="{{shipToAdd[key].code}}" aria-label="...">
										    </span>
										     <input type="text" placeholder="Address Code"  ng-model="shipToAdd[key].code" name="c_shipCode" class="form-control  ng-cloak" id="c_shipCode{{key}}" >
										</div>	
									</div>
									<div class="col-xs-6 col-sm-8 col-md-8 col-lg-10" style="padding-left: 0px;padding-right: 0px;">										 										
										<div class="input-group"  style="margin-bottom: 5px;">                            												
										     <input type="text"  placeholder="Description" ng-model="shipToAdd[key].addr" name="c_shipAddr" class="form-control  ng-cloak" id="c_shipAddr{{key}}" >
											 <span class="input-group-btn">
										     	<button  name="c_shipAddr" type="button" ng-click="btnRemoveMoreShip(key)" class="btn btn-danger"><i class="fa  fa-minus-square-o"></i></button>
										     </span>
										</div>									
									</div>																
								</div>
								<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-bottom: 15px;">													
									<button type="button" ng-click="btnAddMoreShip()" id="btnAddMoreShip" class="btn btn-primary"><i class="fa fa-plus-square-o"></i></button>
								</div>																
							</div>					
						</div>
					</div>
					
					
					<div class="clearfix"></div>				
					<div class="col-sm-2"><h4>Other</h4></div>				
					<div class="col-sm-12"><hr style="margin-top: 8px;"/></div>
					<div class="row">				
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">				
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Facebook</label>
									<div class="form-group">
										<input type="text" class="form-control  ng-cloak" name="c_facebook" id="c_facebook">
									</div>
								</div>												
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Line</label>
									<div class="form-group">
										<input type="text" class="form-control  ng-cloak" name="c_line" id="c_line">
									</div>
								</div>											
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Viber</label>
									<div class="form-group">
										<input type="text" class="form-control  ng-cloak" name="c_viber" id="c_viber">
									</div>
								</div>												
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">WhatApp</label>
									<div class="form-group">
										<input type="text" class="form-control  ng-cloak" name="c_whatapp" id="c_whatapp">
									</div>
								</div>
								
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3" data-ng-init="listIndustry()">
									<label class="font-label">Industry</label>
									<div class="form-group">
										<select class="form-control  ng-cloak select2" name="c_industry" id="c_industry" style="width:100%">
											<option value="">-- SELECT Industry</option>
											<option ng-repeat="u in industry" value="{{u.industID}}">{{u.industName}}</option> 
										</select>
									</div>
								</div>						
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3" data-ng-init="listAccount()">
									<label class="font-label">Type</label>
									<div class="form-group">
										<select style="width:100%" class="form-control  ng-cloak select2" name="c_type" id="c_type">
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
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">					
							<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">						
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Customer Group <span class="requrie">(Required)</span></label>
									<div class="form-group">
										<select style="width:100%" class="form-control  ng-cloak select2" name="c_group" id="c_group">
											<option value="">-- SELECT Customer Group --</option>
											<option ng-repeat="u in custGroup" value="{{u.custGroupId}}">[{{u.custGroupId}}] {{u.custGroupName}}</option> 
										</select>
									</div>
								</div>															
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
									<label class="font-label">Price Code <span class="requrie">(Required)</span></label>
									<div class="form-group">
										<select style="width:100%" class="form-control  ng-cloak select2" name="c_price" id="c_price">
											<option value="">-- SELECT Price Code --</option>
											<option ng-repeat="u in priceCode" value="{{u.priceCode}}">[{{u.priceCode}}] {{u.des}}</option> 
										</select>
									</div>
								</div>																		
							</div>					
						</div>
					</div>
					
					<div class="clearfix"></div>				
					<div class="col-sm-12"><h4>Attachment Picture</h4></div>				
					<div class="col-sm-12"><hr style="margin-top: 8px;"/></div>
					<div class="row">				
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">					
							<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">					
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
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
		</div>
	</section>
</div>
<jsp:include page="${request.contextPath}/footer"></jsp:include>

