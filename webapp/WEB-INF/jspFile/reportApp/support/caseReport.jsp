<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>
<script type="text/javascript">

var app = angular.module('objApp', ['angularUtils.directives.dirPagination','angular-loading-bar', 'ngAnimate']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = false;
}]);
var self = this;
app.controller('objController',['$scope','$http',function($scope, $http){	

	$scope.pageSize = {};

	$scope.pageSize.rows = [ 
					{ value: "5", label: "5" },
    				{ value: "10", label: "10" },
            		{ value: "15", label: "15" },
            		{ value: "20", label: "20" },
            		{ value: "25", label: "25" },
            		{ value: "30", label: "30" },
            		];
	$scope.pageSize.row = $scope.pageSize.rows[1].value;
	
	$scope.reportStartup = function(){
		$http.get("${pageContext.request.contextPath}/report/case/startup").success(function(response){
			$scope.status = response.STATUS;
			$scope.types = response.TYPES;
			$scope.origins = response.ORIGINS;
			$scope.priorities = response.PRIORITIES;
			$scope.products = response.PRODUCTS;
			$scope.customers = response.CUSTOMERS;
			$scope.contacts = response.CONTACTS;
			$scope.users = response.ASSIGN_TO;
			$("#startdate").val(response.STATUP_DATE.startDate);
			$("#todate").val(response.STATUP_DATE.endDate);
			$('#startdate').prop("disabled", true);  
	        $('#todate').prop("disabled", true); 
		});
	};
	
	$scope.searchBtnClick = function(){	
   		$http({
 			method: 'POST',
		    url: '${pageContext.request.contextPath}/report/case/case-report',
		    headers: {
		    	'Accept': 'application/json',
		        'Content-Type': 'application/json'
		    },
		    data : {
			    "startDate":getValueStringById("startdate"),
			    "endDate":getValueStringById("todate"),
			    "status":getValueStringById("case_status"),
			    "type":getValueStringById("case_type"),
			    "origin":getValueStringById("case_origin"),
			    "priority":getValueStringById("case_priority"),
			    "product":getValueStringById("case_product"),
			    "customer":getValueStringById("case_customer"),
			    "contact":getValueStringById("case_contact"),
			    "assignTo":getValueStringById("case_assignTo")
			}
		}).success(function(response) {	
			$scope.cases = response.REPORT;
			
		});
	}; 

}]);

$(function(){
	$('#todate').daterangepicker({
        singleDatePicker: true,
        showDropdowns: true,
        format: 'YYYY-MM-DD' 
    }).on('change', function(e) {
		if($("#todate").val() != ""){
			$('#form-campaigns').bootstrapValidator('revalidateField', 'todate');
		}			  
	});
	
	$('#startdate').daterangepicker({
        singleDatePicker: true,
        showDropdowns: true,
        format: 'YYYY-MM-DD' 
    }).on('change', function(e) {
		if($("#startdate").val() != ""){
			$('#form-campaigns').bootstrapValidator('revalidateField', 'startdate');
		}		  
	});
	
	$("#datafilter").change(function(){
		var action = $("#datafilter").val();
		switch(action) {
		    case 'All':
		        $('#startdate').prop("disabled", true);  
		        $('#todate').prop("disabled", true);
		        $('#startdate').val($('#startdate').attr('data-default-date'));  
		        $('#todate').val($('#todate').attr('data-default-date')); 
		        angular.element('#objController').scope().reportStartup('${SESSION}');
		        break;
		    case 'range':
		    	$('#startdate').prop("disabled", false);  
		        $('#todate').prop("disabled", false);
		        $('#startdate').val("");  
		        $('#todate').val("");
		        break;
		    case 'today':
		    	 $('#startdate').prop("disabled", true);  
			     $('#todate').prop("disabled", true); 				     				    
			     $('#startdate').val(moment().format('YYYY-MM-DD'));  
			     $('#todate').val(moment().format('YYYY-MM-DD'));
		        break;
		    case 'this period':
		    	 $('#startdate').prop("disabled", true);  
			     $('#todate').prop("disabled", true);
			     $('#startdate').val((new Date()).getFullYear()+"-"+moment().format('MM')+"-"+"01");  
			     $('#todate').val((new Date()).getFullYear()+"-"+moment().format('MM')+"-"+getLastDayOfMonth()); 
		        break;
		    case 'this year':
		    	 $('#startdate').prop("disabled", true);  
			     $('#todate').prop("disabled", true);
			     $('#startdate').val((new Date()).getFullYear()+"-01-01");  
			     $('#todate').val((new Date()).getFullYear()+"-12-01"); 
		        break;
		}				
	});
});

</script>

<style>
	#loading-bar {
	  pointer-events: all;
	  z-index: 99999;
	  border: none;
	  margin: 0px;
	  padding: 0px;
	  width: 100%;
	  height: 100%;
	  top: 0px;
	  left: 0px;
	  cursor: wait;
	  position: fixed;
	 /*  background-color: rgba(0, 0, 0, 0.6); */
	}
	#loading-bar-spinner {
	  top: 50%;
	  left: 50%;
	}
</style>
<div class="content-wrapper" ng-app="objApp" ng-controller="objController" id="objController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Case Report</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"> Case Report</a></li>
		</ol>
	</section>
	<section class="content" data-ng-init="reportStartup()">
		<div class="row">
			<div class="col-md-12">
				<div class="box box-primary">	
					<div class="box-header with-border">
		        		<h3 class="box-title">Filter</h3>
		              	<div class="box-tools pull-right">
		               		<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
		               	</div>
		          	</div>
					<div class="box-body">
						<form method="post" id="frmFilter">	
							<div class="row">
								<div class="col-sm-12">
									<div class="col-md-3">
										<div class="form-group">
											<label>Date Filter</label> <select name="datafilter"
												id="datafilter" class="form-control select2 input-lg"
												style="width: 100%;">
												<option value="All">All</option>
												<option value="range">Range</option>
												<option value="today">Today</option>
												<option value="this period">This Period</option>
												<option value="this year">This Year</option>
											</select>
										</div>
									</div>
									
									<div class="col-sm-3">
						                <label class="font-label">Start date </label>
						                <div class="form-group">
					                  		<div class="input-group">
				                    			<div class="input-group-addon"> <i class="fa fa-calendar"></i> </div>
					                    		<input type="text" class="form-control pull-right date2" readonly="readonly" ng-model="startdate" name="startdate" id="startdate">
					                 	 	</div>
						                </div>
					              	</div>
						
					              	<div class="col-sm-3">
					                	<label class="font-label">End date</label>
					                	<div class="form-group">
					                  		<div class="input-group">
						                    	<div class="input-group-addon"> <i class="fa fa-calendar"></i> </div>
						                    	<input type="text" class="form-control pull-right date2" readonly="readonly" ng-model="todate" name="todate" id="todate">
						                  	</div>
				                		</div>
					              	</div>
					              	
					              	<div class="col-sm-3">
										<label class="font-label">Status</label>
										<div class="form-group">
											<select class="form-control select2" name="case_status"
												style="width: 100%;" id="case_status">
												<option value="">-- SELECT Status --</option>
												<option ng-repeat="stat in status" value="{{stat.statusId}}">{{stat.statusName}}</option>
											</select>
										</div>
									</div>
									<div class="col-sm-3">
										<label class="font-label">Type</label>
										<div class="form-group">
											<select class="form-control select2" name="case_type"
												style="width: 100%;" id="case_type">
												<option value="">-- SELECT Type --</option>
												<option ng-repeat="ty in types" value="{{ty.caseTypeId}}">{{ty.caseTypeName}}</option>
											</select>
										</div>
									</div>
									<div class="col-sm-3">
										<label class="font-label">Origin</label>
										<div class="form-group">
											<select class="form-control select2" name="case_origin"
												style="width: 100%;" id="case_origin">
												<option value="">-- SELECT Origin --</option>
												<option ng-repeat= "or in origins" value="{{or.originId}}">{{or.originTitle}}</option>
											</select>
										</div>
									</div>
									<div class="col-sm-3">
										<label class="font-label">Priority</label>
										<div class="form-group">
											<select class="form-control select2" name="case_priority"
												style="width: 100%;" id="case_priority">
												<option value="">-- SELECT Priority --</option>
												<option ng-repeat="pr in priorities" value="{{pr.priorityId}}">{{pr.priorityName}}</option>
											</select>
										</div>
									</div>
									<div class="col-sm-3">
										<label class="font-label">Product </label>
										<div class="form-group">
											<select class="form-control select2" name="case_product"
												style="width: 100%;" id="case_product">
												<option value="">-- SELECT Product --</option>
												<option ng-repeat="p in products" value="{{p.itemId}}">[{{p.itemId}}]
													{{p.itemName}}</option>
											</select>
										</div>
									</div>
									<div class="col-sm-3">
										<label class="font-label">Customer </label>
										<div class="form-group">
											<select class="form-control select2" name="case_customer"
												style="width: 100%;" id="case_customer">
												<option value="">-- SELECT Customer --</option>
												<option ng-repeat="cust in customers" value="{{cust.custID}}">[{{cust.custID}}]
													{{cust.custName}}</option>
											</select>
										</div>
									</div>
									<div class="col-sm-3">
										<label class="font-label">Contact </label>
										<div class="form-group">
											<select class="form-control select2" name="case_contact"
												style="width: 100%;" id="case_contact">
												<option value="">-- SELECT Contact --</option>
												<option ng-repeat="con in contacts" value="{{con.conID}}">[{{con.conID}}]
													{{con.conSalutation}} {{con.conFirstname}} {{con.conLastname}}</option>
											</select>
										</div>
									</div>
									<div class="col-sm-3">
										<label class="font-label">Assigned to </label>
										<div class="form-group">
											<select class="form-control select2" name="case_assignTo"
												id="case_assignTo" style="width: 100%;">
												<option value="">-- SELECT User --</option>
												<option ng-repeat="user in users" value="{{user.userID}}">{{user.username}}</option>
											</select>
										</div>
									</div>
								</div>								
							</div>
						</form>
					</div>
					<div class="box-footer">						
						<div class="col-sm-2">
						  	<form class="form-inline">
						  		<div class="form-group">
						        	<button ng-click="searchBtnClick()" type="button" name="btnPrint" id="btnPrint" class="btn btn-default">
										<i class="fa fa-print"></i> &nbsp;Print
									</button>
						        </div>
						        <div class="form-group">
						        	<div class="input-group">
						        		<select class="form-control" ng-model="pageSize.row" id ="row" ng-options="obj.value as obj.label for obj in pageSize.rows"></select>
						        	</div>
						        </div>
						    </form>
						</div>					
						<button ng-click="searchBtnClick()" type="button" name="btnsearch" id="btnsearch" class="btn btn-info pull-right">
							<i class="fa fa-search"></i> &nbsp;Search
						</button>
					</div>
				</div>
			</div>
			<div class="col-md-12">
				<div class="box box-success">
					<div class="box-body">
						<div class="tablecontainer table-responsive">
							<table class="table table-hover">
								<thead>
									<tr>
										<th>ID</th>
										<th>SUBJECT</th>
										<th>TYPE</th>
										<th>STATUS</th>
										<th>PRIORITY</th>
										<th>ORIGIN</th>
										<th>PRODUCT</th>
										<th>CUSTOMER</th>
										<th>CONTACT</th>
										<th>RESOLVED BY</th>
										<th>RESOLVED DATE</th>
										<th>ARTICLE</th>
									</tr>
								</thead>
								<tbody>
									<tr dir-paginate="ca in cases |orderBy:sortKey:reverse |filter:search |itemsPerPage:pageSize.row" class="ng-cloak">
										<td>{{ca.caseId}}</td>
										<td>{{ca.caseSubject}}</td>
										<td>{{ca.typeName}}</td>
										<td>{{ca.statusName}}</td>
										<td>{{ca.priorityName}}</td>
										<td>{{ca.originId==null ? '-':ca.originName}}</td>
										<td ng-if="ca.itemId==null">-</td>
										<td ng-if="ca.itemId!=null">[{{ca.itemId}}] {{ca.itemName}}</td>
										<td ng-if="ca.custId==null">-</td>
										<td ng-if="ca.custId!=null">[{{ca.custId}}] {{ca.custName}}</td>
										<td ng-if="ca.contactId==null">-</td>
										<td ng-if="ca.contactId!=null">[{{ca.contactId}}] {{ca.contactName}}</td>
										<td>{{ca.resolvedBy == null ? '-':ca.resovedBy}}</td>
										<td>{{ca.resolvedDate == null ? '-':ca.resolvedDate}}</td>
										<td>{{ca.articleTitle == null ? '-':ca.articleTitle}}</td>
									</tr>
								</tbody>
							</table>
							<dir-pagination-controls
						       max-size="pageSize.row"
						       direction-links="true"
						       boundary-links="true" >
							</dir-pagination-controls>
						</div>
					</div>
				</div>
			</div>
			<div id="errors"></div>
		</div>
	</section>
</div>
<jsp:include page="${request.contextPath}/footer"></jsp:include>

