
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>
<%
	String roleDelete = (String) request.getAttribute("role_delete");
%>


<script type="text/javascript">


var app = angular.module('marketSurveyApp', ['angularUtils.directives.dirPagination','angular-loading-bar', 'ngAnimate']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = false;
}]);
var self = this;
var username = "${SESSION}";
var server = "${pageContext.request.contextPath}";
var noteId = "${noteId}";
app.controller('marketSurveyController',['$scope','$http',function($scope, $http){
	
	angular.element(document).ready(function () {				
		
    });

	$scope.listCompetitors = function(){
		$http.get("${pageContext.request.contextPath}/hbu/competitor/list").success(function(response){
				$scope.competitors = response.COMPETITORS;
				$scope.length = $scope.competitors.length;
			});
		};
    
	
	$scope.startup = function(){				
		$http.get("${pageContext.request.contextPath}/hbu/market-survey/startup").success(function(response){
			$scope.items = response.ITEMS;
			$scope.customers = response.CUSTOMERS;
		});
	};

	$scope.findCompetitorByItemId = function(itemId){
		$http.get("${pageContext.request.contextPath}/item/view/"+itemId).success(function(response){
			$scope.item = response.ITEM;
		});
	};

	$scope.findHBUItemById = function(itemId){
		$http.get("${pageContext.request.contextPath}/item/view/"+itemId).success(function(response){
			$scope.item = response.ITEM;
			$.each($scope.item.competitors,function(i, com){
				$("input[name=competitor]:not(:checked)").each(function(){
					if($(this).val() == com.comId){
						$(this).prop('checked',true);
					}
				});
				
			});
		});
	};
}]);


$(document).ready(function(){
	$('.date2').daterangepicker({
        singleDatePicker: true,
        showDropdowns: true,
        format: 'DD/MM/YYYY h:mm A',
        timePicker: true, 
        timePickerIncrement: 5
       
    }).on('change', function(e) {
		if($("#surveyDate").val() != ""){
			$('#form-call').bootstrapValidator('revalidateField', 'surveyDate');
		}
	});

	$("#addCustToPro").hide();
	$("#addCompetitor").hide();

	$("#product").change(function(){
		if($("#product").val() != ""){
			angular.element(document.getElementById('marketSurveyController')).scope().findCompetitorByItemId($("#product").val());
			$("#addCustToPro").show();
			$("#addCompetitor").show();
		}else{
			$("#addCustToPro").hide();
			$("#addCompetitor").hide();
		}
	});

	/*Add customer to product block*/
	
	$("#addCustToPro").click(function(){
		$("#frmAddCustomerToProduct").modal('toggle');
		/* if($("product").val() != ""){
			//angular.element(document.getElementById('marketSurveyController')).scope().findHBUItemById($("#product").val());
		} */
	});

	function addCustomersToProduct(){
		var customers = [];
		$("input[name=customer]:checked").each(function(){
			customers.push({"custId":$(this).val()});
		});
		$('#frmAddCompetitorToProduct').bootstrapValidator({
			message: 'This value is not valid',
			feedbackIcons: {
				valid: 'glyphicon glyphicon-ok',
				invalid: 'glyphicon glyphicon-remove',
				validating: 'glyphicon glyphicon-refresh'
			},
			fields: {
				product: {
					validators: {
						notEmpty: {
							message: 'The product is required and can not be empty!'
						}
					}
				}
			}
		}).on('success.form.bv', function(e) {
			swal({   
				title: "<span style='font-size: 25px;'>You are about to add competitors to product.</span>",
				text: "Click OK to continue or CANCEL to abort.",
				type: "info",
				html: true,
				showCancelButton: true,
				closeOnConfirm: false,
				showLoaderOnConfirm: true,		
			}, function(){ 
					setTimeout(function(){
						$.ajax({ 
							url : "${pageContext.request.contextPath}/item/add/customer",
							type : "POST",
							data : JSON.stringify({
								  "itemId" : getValueStringById("product"),
								  "customers": customers,
							}),
							beforeSend: function(xhr) {
							    xhr.setRequestHeader("Accept", "application/json");
							    xhr.setRequestHeader("Content-Type", "application/json");
						    }, 
						    success: function(result){	
						    	$("input[name=customer]:checked").attr('checked',false);
						    	$('#frmAddCustomerToProduct').bootstrapValidator('resetForm', true);
								if(result.MESSAGE == "INSERTED"){						
									swal({
			    						title: "SUCCESSFUL",
			    					  	text: result.MSG,
			    					  	html: true,
			    					  	timer: 2000,
			    					  	type: "success"
			    					});
									$("#frmAddCustomerToProduct").modal('toggle');
									angular.element(document.getElementById('marketSurveyController')).scope().findCompetitorByItemId(getValueStringById("product"));
								}else{
									swal({
			    						title: "UNSUCCESSFUL",
			    					  	text: result.MSG,
			    					  	html: true,
			    					  	timer: 2000,
			    					  	type: "error"
			    					});
								}
							},
				    		error:function(){
				    			alertMsgErrorSweet();
				    		} 
						});
				}, 500);
			});
		});
		$("#frmAddCompetitorToProduct").submit();
	}

	$("#btnAddCust").click(function(){
		addCustomersToProduct();
	});
	
	/*End customer block*/

	/*Add competitor block*/
	
	$("#addCompetitor").click(function(){
		$("#frmAddCompetitorToProduct").modal('toggle');
		if($("product").val() != ""){
			angular.element(document.getElementById('marketSurveyController')).scope().findHBUItemById($("#product").val());
		}
	});

	
	$("input[name=check-all]").change(function(){
		if($(this).is(':checked')){
			$("input[name=competitor]:not(:checked)").each(function(){
				$(this).prop('checked',true);
			});
		}else{
			$("input[name=competitor]:checked").each(function(){
				$(this).prop('checked',false);
			});
		}
	});


	function addCompetitorsToProduct(){
		var competitors = [];
		$("input[name=competitor]:checked").each(function(){
			competitors.push({"comId":$(this).val()});
		});
		$('#frmAddCompetitorToProduct').bootstrapValidator({
			message: 'This value is not valid',
			feedbackIcons: {
				valid: 'glyphicon glyphicon-ok',
				invalid: 'glyphicon glyphicon-remove',
				validating: 'glyphicon glyphicon-refresh'
			},
			fields: {
				ato_product: {
					validators: {
						notEmpty: {
							message: 'The product is required and can not be empty!'
						}
					}
				}
			}
		}).on('success.form.bv', function(e) {
			swal({   
				title: "<span style='font-size: 25px;'>You are about to add competitors to product.</span>",
				text: "Click OK to continue or CANCEL to abort.",
				type: "info",
				html: true,
				showCancelButton: true,
				closeOnConfirm: false,
				showLoaderOnConfirm: true,		
			}, function(){ 
					setTimeout(function(){
						$.ajax({ 
							url : "${pageContext.request.contextPath}/item/add",
							type : "POST",
							data : JSON.stringify({
								  "itemId" : getValueStringById("product"),
								  "competitors": competitors,
							}),
							beforeSend: function(xhr) {
							    xhr.setRequestHeader("Accept", "application/json");
							    xhr.setRequestHeader("Content-Type", "application/json");
						    }, 
						    success: function(result){	
						    	$("input[name=competitor]:checked").attr('checked',false);
						    	$('#frmAddCompetitorToProduct').bootstrapValidator('resetForm', true);
								if(result.MESSAGE == "INSERTED"){						
									swal({
			    						title: "SUCCESSFUL",
			    					  	text: result.MSG,
			    					  	html: true,
			    					  	timer: 2000,
			    					  	type: "success"
			    					});
									$("#frmAddCompetitorToProduct").modal('toggle');
									angular.element(document.getElementById('marketSurveyController')).scope().findCompetitorByItemId(getValueStringById("product"));
								}else{
									swal({
			    						title: "UNSUCCESSFUL",
			    					  	text: result.MSG,
			    					  	html: true,
			    					  	timer: 2000,
			    					  	type: "error"
			    					});
								}
							},
				    		error:function(){
				    			alertMsgErrorSweet();
				    		} 
						});
				}, 500);
			});
		});
		$("#frmAddCompetitorToProduct").submit();
	}

	$("#btnAdd").click(function(){
		addCompetitorsToProduct();
	});

	/*End add competitor block*/
});
</script>
<style>
.panel-heading1 h4 {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    line-height: normal;
    width: 75%;
    padding-top: 8px;
}
.trask-btn{
	color: #dd4b39 !important;
}

.like-btn{
	color: #3289c8 !important;
}
.unlike-btn{
}

.icon_color {
	color: #2196F3;
}
.iTable tbody{
	border-top: 1px solid #d2d6de !important;
}
.iTable thead, tr, td{
	border:0px !important;
}



.iTD-width-50 {
	width: 50px;
}

.show-edit {
	width: 70% !important;
	margin: -25px 30% -5px !important;
}

.iTD {
	text-align: center;
	vertical-align: middle;
}

.item_border {
	border: 1px solid #f0f0f0;
}

.font-size-icon-30 {
	font-size: 20px;
}

.pagination {
	display: inline-block;
	padding-left: 0;
	margin: 0px 0px 13px 0px;
	border-radius: 4px;
	margin-buttom: 10px;
}

.cusor_pointer {
	cursor: pointer;
}

.breadcrumb1 {
	padding: 0;
	background: #D4D4D4;
	list-style: none;
	overflow: hidden;
	margin: 10px;
}

.breadcrumb1>li+li:before {
	padding: 0;
}

.breadcrumb1 li {
	float: left;
}

.breadcrumb1 li.active a {
	background: brown; /* fallback color */
	background: rgb(75, 202, 129);
}

.breadcrumb1 li.completed a {
	background: brown; /* fallback color */
	background: hsl(192, 100%, 41%);
}

.breadcrumb1 li.active a:after {
	border-left: 30px solid rgb(75, 202, 129);
}

.breadcrumb1 li.dead a {
	background: brown; /* fallback color */
	background: red;
}

.breadcrumb1 li.dead a:after {
	border-left: 30px solid red;
}

.breadcrumb1 li.completed a:after {
	border-left: 30px solid hsl(192, 100%, 41%);
}

.breadcrumb1 li a {
	color: white;
	text-decoration: none;
	padding: 10px 0 10px 45px;
	position: relative;
	display: block;
	float: left;
}

.breadcrumb1 li a:after {
	content: " ";
	display: block;
	width: 0;
	height: 0;
	border-top: 50px solid transparent;
	/* Go big on the size, and let overflow hide */
	border-bottom: 50px solid transparent;
	border-left: 30px solid hsla(0, 0%, 83%, 1);
	position: absolute;
	top: 50%;
	margin-top: -50px;
	left: 100%;
	z-index: 2;
}

.breadcrumb1 li a:before {
	content: " ";
	display: block;
	width: 0;
	height: 0;
	border-top: 50px solid transparent;
	/* Go big on the size, and let overflow hide */
	border-bottom: 50px solid transparent;
	border-left: 30px solid white;
	position: absolute;
	top: 50%;
	margin-top: -50px;
	margin-left: 1px;
	left: 100%;
	z-index: 1;
}

.breadcrumb1 li:first-child a {
	padding-left: 15px;
}

.breadcrumb1 li a:hover {
	background: rgb(75, 202, 129);
}

.breadcrumb1 li a:hover:after {
	border-left-color: rgb(75, 202, 129) !important;
}

.widget-user .widget-user-header {
    padding: 20px;
    height: 70px !important;
    border-top-right-radius: 3px;
    border-top-left-radius: 3px;
}

.widget-user .widget-user-image {
    position: absolute;
    top: 14px;
    left: 50%;
    margin-left: -45px;
}
</style>
<div class="content-wrapper" id="marketSurveyController" ng-app="marketSurveyApp" ng-controller="marketSurveyController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1><!-- Market Survey -->&nbsp;</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"><i class="fa fa-dashboard"></i>Market Survey</a></li>
		</ol>
	</section>

	<section class="content" data-ng-init="startup()">
		<div class="row">
			<div class="col-md-12">
				<!-- Widget: user widget style 1 -->
				<div class="box box-widget widget-user">
					<!-- Add the bg color to the header using any of the bg-* classes -->
					<div class="widget-user-header bg-aqua-active">
						<h1 class="widget-user-username">Market Survey</h1>
					</div>
					<div class="widget-user-image">
						<img class="img-circle"
							src="${pageContext.request.contextPath}/resources/images/module/Note.png"
							alt="User Avatar">
					</div>
					<div class="box-footer">
						<div class="row">
							<div class="col-md-12">
								<div class="nav-tabs-custom">
									<ul class="nav nav-tabs">										
										<li class="active"><a href="#detail_tap" data-toggle="tab" aria-expanded="true">Survey</a></li>	
										<li class=""><a href="#systemInfo_tap" data-toggle="tab" aria-expanded="false">Market Share</a></li>										
									</ul>
									<div class="tab-content">
										<div class="tab-pane in active" id="detail_tap">
											<div class="row">
												<div class="col-sm-12">
													<form id="frmLeadDetail">
														<!-- <div class="col-sm-12"> -->
															<div class="box-header with-border row">
																<div style="background: #fff;">
																	<div class="col-sm-1">
																		<a class="btn btn-info btn-app" id = "addCustToPro"><i class="fa fa-puzzle-piece" aria-hidden="true"></i> Add Customer</a> 
																	</div>
																	<div class="col-sm-1">
																		<a class="btn btn-info btn-app" id = "addCompetitor"><i class="fa fa-puzzle-piece" aria-hidden="true"></i> Add Competitor</a> 
																	</div>
																</div>
															</div>
														<!-- </div> -->
														<div class="col-sm-6" data-ng-init="" style="margin-top: 15px;">
															<label class="font-label">Product <span class="requrie">(Required)</span></label>
															<div class="form-group">
																<select class="form-control select2"  name="product" id="product" style="width: 100%;">
											                      <option value="">[-- Select Product --]</option>
											                      <option ng-repeat="item in items" value="{{item.itemId}}">[{{item.itemId}}] {{item.itemName}}</option>            
											                    </select>
															</div>
														</div>
														<div class="col-sm-6" style="margin-top: 15px;">
															<label class="font-label">Survey Date <span class="requrie">(Required)</span></label>
															<div class="form-group">
																<div class="input-group">
																	<div class="input-group-addon">
																		<i class="fa fa-calendar"></i>
																	</div>
																	<input type="text" class="form-control pull-right date2" name="surveyDate" id="surveyDate">
																</div> 
															</div>
														</div>
														<div class="col-sm-12 table-responsive">
															<table class="table table-bordered">
																<tr>
																	<th class="col-sm-2">[{{item.itemId}}] {{item.itemName}}</th>
																	<th  ng-repeat = "com in item.competitors" class="text-center">{{com.comName}}</th>
																</tr>
																<tr ng-repeat="cust in item.customers">
																	<td>{{cust.custName}}</td>
																	<td ng-repeat = "com in item.competitors" class="text-center"><input type="checkbox" onClick="clkCheck(this)" name="surveyValue" value="1" /></td>
																</tr>
															</table>
														</div>
													</form>
												</div>
											</div>

										</div>
										<div class="tab-pane" id="systemInfo_tap">
											<div class="row">
												<div class="col-sm-12">
													<form id="frmLeadDetail">
														<div class="col-sm-4">
															<ul class="list-group list-group-unbordered">																																
																<li class="list-group-item ">Create By<a
																	class="pull-right show-text-detail">{{note.noteCreateBy}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_firstName"
																			id="lea_firstName" class="form-control"
																			value="{{lead.firstName}}"> -->
																		<div class="clearfix"></div>
																	</div>
																</li>
																<li class="list-group-item item_border">Create Date <a
																	class="pull-right show-text-detail">{{note.createDateTime}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_firstName"
																			id="lea_firstName" class="form-control"
																			value="{{lead.firstName}}"> -->
																		<div class="clearfix"></div>
																	</div>
																</li>
															</ul>
														</div>
														<div class="col-sm-4">
															<ul class="list-group list-group-unbordered">																																
																<li class="list-group-item ">Modify By<a
																	class="pull-right show-text-detail">{{note.noteModifiedBy}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_firstName"
																			id="lea_firstName" class="form-control"
																			value="{{lead.firstName}}"> -->
																		<div class="clearfix"></div>
																	</div>
																</li>
																<li class="list-group-item item_border">Modify Date <a ng-if="note.noteModifiedBy != null "
																	class="pull-right show-text-detail">{{note.noteModifiedDate | date:'dd/MM/yyyy h:mm a'}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_firstName"
																			id="lea_firstName" class="form-control"
																			value="{{lead.firstName}}"> -->
																		<div class="clearfix"></div>
																	</div>
																</li>
															</ul>
														</div>
														
														
														<br>
														<div class="col-sm-12 text-center" id="showBtnEditLead"
															style="display: none;">
															<button type="button" class="btn btn-primary"
																ng-click="saveEditDetailLead()">Save</button>
															<button type="button" class="btn btn-danger"
																ng-click="cancelEditDetailLead()">Cancel</button>
														</div>
													</form>
												</div>
											</div>

										</div>
										


									</div>
									<!-- /.tab-content -->
								</div>
							</div>

						</div>
						<!-- /.row -->
					</div>
				</div>
				<!-- /.widget-user -->
			</div>
		</div>
		
		<div ng-controller="marketSurveyController" class="modal fade modal-default" id="frmAddCompetitorToProduct" role="dialog">
			<div class="modal-dialog  modal-xs" data-ng-init="">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" ng-click="cancelAddCompetitor()" class="close"
							data-dismiss="modal">&times;</button>
						<h4 class="modal-title">
							<b  id="tCompetitorToProduct">Add Competitors to Product</b>
						</h4>
					</div>
					<div class="modal-body">
						<div class="row">
							<form id="frmAddCompetitorToProduct">
								<div class="col-md-12">
									<div data-ng-init="listCompetitors()">
										<div class="form-group table-responsive">
											<table class="table table-bordered">
												<tr class="active info">
													<th><label>Competitor List</label></th>
													<th class="text-center"><input type="checkbox" name="check-all" onClick()/><!-- <i class="fa fa-check-square-o" aria-hidden="true"></i> --></th>
												</tr>
												<tr ng-repeat = "com in competitors"><!-- dir-paginate = "com in competitors |orderBy:sortKey:reverse |filter:search |itemsPerPage:6" -->
													<td class="col-md-11">[{{com.comId}}] {{com.comName}}</td>
													<td class="col-md-1 text-center"><input type="checkbox"  name="competitor" value="{{com.comId}}" /></td>
												</tr>
											</table>
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" id="btnCancel"
							ng-click="cancelAddCompetitor()" name="btnCancel"
							class="btn btn-danger" data-dismiss="modal">Cancel</button>
						&nbsp;&nbsp;
						<button type="button" class="btn btn-primary pull-right"
							id="btnAdd" name="btnAdd">Add</button>
					</div>
				</div>
			</div>
		</div>
		
		<div ng-controller="marketSurveyController" class="modal fade modal-default" id="frmAddCustomerToProduct" role="dialog">
			<div class="modal-dialog  modal-xs">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" ng-click="cancelAddCompetitor()" class="close"
							data-dismiss="modal">&times;</button>
						<h4 class="modal-title">
							<b  id="tCustomerToProduct">Add Customers to Product</b>
						</h4>
					</div>
					<div class="modal-body">
						<div class="row">
							<form id="frmAddCustomerToProduct">
								<div class="col-md-12">
									<div class="form-group table-responsive">
										<table class="table table-bordered">
											<tr class="active info">
												<th><label>Customer List</label></th>
												<th class="text-center"><input type="checkbox" name="checkAll" onClick()/><!-- <i class="fa fa-check-square-o" aria-hidden="true"></i> --></th>
											</tr>
											<tr ng-repeat = "cust in customers"><!-- dir-paginate = "com in competitors |orderBy:sortKey:reverse |filter:search |itemsPerPage:6" -->
												<td class="col-md-11">[{{cust.custId}}] {{cust.custName}}</td>
												<td class="col-md-1 text-center"><input type="checkbox"  name="customer" value="{{cust.custId}}" /></td>
											</tr>
										</table>
									</div>
								</div>
							</form>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" id="btn-cancel"
							ng-click="cancelAddCompetitor()" name="btn-cancel"
							class="btn btn-danger" data-dismiss="modal">Cancel</button>
						&nbsp;&nbsp;
						<button type="button" class="btn btn-primary pull-right"
							id="btnAddCust" name="btnAddCust">Add</button>
					</div>
				</div>
			</div>
		</div>
	</section>
	<div id="errors"></div>
</div>

<jsp:include page="${request.contextPath}/footer"></jsp:include>
