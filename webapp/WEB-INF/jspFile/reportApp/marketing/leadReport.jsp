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
	$scope.pageSize.row = $scope.pageSize.rows[0].value;
	
	$scope.reportStartup = function(userId){
		$http.get("${pageContext.request.contextPath}/report/lead/startup/").success(function(response){
			$scope.lead_status = response.STATUS;
			$scope.lead_source = response.SOURCE;
			$scope.users = response.ASSIGN_TO;
			$("#startdate").val(response.STARTUP_DATE.startDate);
			$("#todate").val(response.STARTUP_DATE.endDate);
			$('#startdate').prop("disabled", true);  
	        $('#todate').prop("disabled", true);
		});
	};

	$scope.reportStartupDate = function(dateType){
		$http.get("${pageContext.request.contextPath}/report/lead/startup/date/"+dateType).success(function(response){
			$("#startdate").val(response.STARTUP_DATE.startDate);
			$("#todate").val(response.STARTUP_DATE.endDate);
			$('#startdate').prop("disabled", true);  
	        $('#todate').prop("disabled", true);
		});
	};
	
	$scope.searchBtnClick = function(){	
   		$http({
 			method: 'POST',
		    url: '${pageContext.request.contextPath}/report/lead/exec-lead',
		    headers: {
		    	'Accept': 'application/json',
		        'Content-Type': 'application/json'
		    },
		    data : {
			    "dateType":getValueStringById("date_type"),
			    "startDate":getValueStringById("startdate"),
			    "endDate":getValueStringById("todate"),
			    "status":getValueStringById("lead_status"),
			    "source":getValueStringById("lead_source"),
			    "assignTo":getValueStringById("lead_assignTo")
			}
		}).success(function(response) {	
			$scope.leads = response.REPORT;
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

	$('#date_type').change(function(){
		if($("#datafilter").val() == 'All'){
			 angular.element('#objController').scope().reportStartupDate(getValueStringById("date_type"));
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
		        angular.element('#objController').scope().reportStartupDate(getValueStringById("date_type"));
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
			     $('#startdate').val(moment().format('D/MMM/YYYY'));  
			     $('#todate').val(moment().format('D/MMM/YYYY'));
		        break;
		    case 'this period':
		    	 $('#startdate').prop("disabled", true);  
			     $('#todate').prop("disabled", true);
			     $('#startdate').val("01/"+moment().format('MMM')+"/"+(new Date()).getFullYear());  
			     $('#todate').val(getLastDayOfMonth()+"/"+moment().format('MMM')+"/"+(new Date()).getFullYear()); 
		        break;
		    case 'this year':
		    	 $('#startdate').prop("disabled", true);  
			     $('#todate').prop("disabled", true);
			     $('#startdate').val("01/Jan/"+(new Date()).getFullYear());  
			     $('#todate').val("31/Dec/"+(new Date()).getFullYear()); 
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
		<h1>Exec Leads</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"> Exec Leads</a></li>
		</ol>
	</section>

	<section class="content" data-ng-init="reportStartup('${SESSION}')">
		
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
										<label class="font-label">Date Type</label>
										<div class="form-group">
											<select class="form-control select2" name="date_type"
												style="width: 100%;" id="date_type">
												<option value="createdDate">Created Date</option>
												<option value="convertedDate">Converted Date</option>
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
											<select class="form-control select2" name="lead_status"
												style="width: 100%;" id="lead_status">
												<option value="">-- SELECT Status --</option>
												<option ng-repeat="stat in lead_status" value="{{stat.statusID}}">{{stat.statusName}}</option>
											</select>
										</div>
									</div>
									<div class="col-sm-3">
										<label class="font-label">Source</label>
										<div class="form-group">
											<select class="form-control select2" name="lead_source"
												style="width: 100%;" id="lead_source">
												<option value="">-- SELECT Source --</option>
												<option ng-repeat="le in lead_source" value="{{le.sourceID}}">{{le.sourceName}}</option>
											</select>
										</div>
									</div>
									<div class="col-sm-3">
										<label class="font-label">Assigned to </label>
										<div class="form-group">
											<select class="form-control select2" name="lead_assignTo"
												id="lead_assignTo" style="width: 100%;">
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
										<th>LEAD SOURCE</th>
										<th>LEAD STATUS</th>
										<th>LEAD NAME</th>
										<th>COMPANY</th>
										<th>OPPORTUNITY AMOUNT</th>
										<th>CREATED DATE</th>
										<th>CONVERTED DATE</th>
										<th>OPPORTUNITY NAME</th>
									</tr>
								</thead>
								<tbody>
									<tr  dir-paginate="le in leads |orderBy:sortKey:reverse |filter:search |itemsPerPage:pageSize.row" class="ng-cloak">
										<td>{{le.leadId}}</td>
										<td>{{le.sourceName}}</td>
										<td>{{le.statusName}}</td>
										<td>{{le.leadName}}</td>
										<td>{{le.company}}</td>
										<td ng-if="le.opAmount == null">$ 0.00</td>
										<td ng-if="le.opAmount != null">$ {{le.opAmount}}</td>
										<td>{{le.createdDate}}</td>
										<td ng-if="le.convertedDate == null">-</td>
										<td ng-if="le.convertedDate != null">{{le.convertedDate}}</td>
										<th ng-if="le.opName == null">-</th>
										<td ng-if="le.opName != null">{{le.opName}}</td>
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

