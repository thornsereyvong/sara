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
	
	$scope.reportStartup = function(userId){
		$http.get("${pageContext.request.contextPath}/report/campaign/startup/"+userId).success(function(response){
			$scope.camp_parents = response.CAMPAIGNS;
			$scope.camp_status = response.STATUS;
			$scope.camp_types = response.TYPES;
			$scope.users = response.ASSIGN_TO;
			$("#startdate").val(response.DEFAULT_DATE.startDate);
			$("#todate").val(response.DEFAULT_DATE.endDate);
			$('#startdate').prop("disabled", true);  
	        $('#todate').prop("disabled", true); 
		});
	};
	
	
	$scope.calROI = function(gain, invest){
		if(invest <= 0 && gain <= 0){
			return 0;
		}else if((gain-invest)==0){
			return 0;
		}else if(invest <= 0 && gain > 0){
			return 100;
		}else{
			return ((gain-invest)/invest)*100;
		}
	}
	
	$scope.searchBtnClick = function(){	
   		$http({
 			method: 'POST',
		    url: '${pageContext.request.contextPath}/report/campaign/top-campaign',
		    headers: {
		    	'Accept': 'application/json',
		        'Content-Type': 'application/json'
		    },
		    data : {
			    "startDate":getValueStringById("startdate"),
			    "endDate":getValueStringById("todate"),
			    "statusId":getValueStringById("cam_status"),
			    "typeId":getValueStringById("cam_type"),
			    "campParentId":getValueStringById("cam_parent"),
			    "userId":getValueStringById("cam_assignTo")
			}
		}).success(function(response) {	
			$scope.campaigns = response.TOP_CAMPAIGN;
			
		});
	}; 
	
	$scope.excelBtnClick = function(){		
		 var blob = new Blob([document.getElementById('exportTbl').innerHTML], {
             type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8"
         });
         saveAs(blob, "top-campaign.xls");		
	}
	
	
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
		<h1>Top Campaign</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"> Top Campaign</a></li>
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
								<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
									<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
										<div class="form-group">
											<label>Date Filter</label> 
											<select name="datafilter" id="datafilter" class="form-control select2 input-lg" style="width: 100%;">
												<option value="All">All</option>
												<option value="range">Range</option>
												<option value="today">Today</option>
												<option value="this period">This Period</option>
												<option value="this year">This Year</option>
											</select>
										</div>
									</div>
									
									<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
						                <label class="font-label">Start date </label>
						                <div class="form-group">
					                  		<div class="input-group">
				                    			<div class="input-group-addon"> <i class="fa fa-calendar"></i> </div>
					                    		<input type="text" class="form-control pull-right date2" readonly="readonly" ng-model="startdate" name="startdate" id="startdate">
					                 	 	</div>
						                </div>
					              	</div>
						
					              	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
					                	<label class="font-label">End date</label>
					                	<div class="form-group">
					                  		<div class="input-group">
						                    	<div class="input-group-addon"> <i class="fa fa-calendar"></i> </div>
						                    	<input type="text" class="form-control pull-right date2" readonly="readonly" ng-model="todate" name="todate" id="todate">
						                  	</div>
				                		</div>
					              	</div>
					              	
					              	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
										<label class="font-label">Status</label>
										<div class="form-group">
											<select class="form-control select2" name="cam_status"
												style="width: 100%;" id="cam_status">
												<option value="">-- SELECT Status --</option>
												<option ng-repeat="stat in camp_status" value="{{stat.statusID}}">{{stat.statusName}}</option>
											</select>
										</div>
									</div>
									<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
										<label class="font-label">Type</label>
										<div class="form-group">
											<select class="form-control select2" name="cam_type"
												style="width: 100%;" id="cam_type">
												<option value="">-- SELECT Type --</option>
												<option ng-repeat="ty in camp_types" value="{{ty.typeID}}">{{ty.typeName}}</option>
											</select>
										</div>
									</div>
									<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
										<label class="font-label">Parent campaign </label>
										<div class="form-group">
											<select class="form-control select2" name="cam_parent"
												style="width: 100%;" id="cam_parent">
												<option value="">-- SELECT Parent --</option>
												<option ng-repeat="cam in camp_parents" value="{{cam.campID}}">[{{cam.campID}}]
													{{cam.campName}}</option>
											</select>
										</div>
									</div>
									<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
										<label class="font-label">Assigned to </label>
										<div class="form-group">
											<select class="form-control select2" name="cam_assignTo"
												id="cam_assignTo" style="width: 100%;">
												<option value="">-- SELECT User --</option>
												<option ng-repeat="user in users" value="{{user.userID}}">{{user.username}}</option>
											</select>
										</div>
									</div>
								</div>								
							</div>
						</form>
					</div>
					<div class="box-footer" style="padding-left: 0px; padding-right: 0px;">						
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="row">
							  	<form class="form-inline">
							  		<div class="col-xs-8">
								        <div class="form-group">
								        	<button ng-click="excelBtnClick()" type="button" name="btnPrint" id="btnPrint" class="btn btn-success">
												<i class="fa fa-file-excel-o"></i> &nbsp;excel
											</button>
								        </div>
								        <div class="form-group">
								        	<div class="input-group">
								        		<select class="form-control" ng-model="pageSize.row" id ="row" ng-options="obj.value as obj.label for obj in pageSize.rows"></select>
								        	</div>
								        </div>
								    </div>
							        <div class="col-xs-4">
								        <div class="form-group pull-right">
								        	<button ng-click="searchBtnClick()" type="button" name="btnsearch" id="btnsearch" class="btn btn-info">
												<i class="fa fa-search"></i> &nbsp;Search
											</button>
								        </div>
							        </div>
							    </form>
						    </div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div class="box box-success">
					<div class="box-body">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="tablecontainer table-responsive">
								<table class="table table-hover">
									<thead>
										<tr>
											<th>ID</th>
											<th>Campaign Name</th>
											<th>Type</th>
											<th>Status</th>
											<th>Start Date</th>
											<th>End Date</th>
											<th>Num Sent</th>
											<th>Response</th>
											<th>Num Total Opport</th>
											<th>Num Won Opport</th>
											<th>Total Amount Won Opport</th>
											<th>Actual Cost</th>
											<th>ROI</th>
										</tr>
									</thead>
									<tbody>
										<tr  dir-paginate="camp in campaigns |orderBy:sortKey:reverse |filter:search |itemsPerPage:pageSize.row" class="ng-cloak">
											<td>{{camp.campId}}</td>
											<td>{{camp.campName}}</td>
											<td>{{camp.typeName}}</td>
											<td>{{camp.statusName}}</td>
											<td ng-if="camp.startDate == null">-</td>
											<td ng-if="camp.startDate != null">{{camp.startDate}}</td>
											<td>{{camp.endDate}}</td>
											<td>{{camp.numSent}}</td>
											<td>{{camp.expResponse}} %</td>
											<td>{{camp.totalOpp}}</td>
											<td>{{camp.totalOppWon}}</td>
											<td>$ {{camp.totalAmtWon | number:2}}</td>
											<td>$ {{camp.actCost | number:2}}</td>
											<td>{{calROI(camp.totalAmtWon, camp.actCost) | number}} %</td>
										</tr>
									</tbody>
								</table>
							</div>
							<dir-pagination-controls
						       max-size="pageSize.row"
						       direction-links="true"
						       boundary-links="true" >
							</dir-pagination-controls>
							<div style="display:none;" id="exportTbl">
								<table>
									<thead>
										<tr>
											<th>Camp ID</th>
											<th>Camp Name</th>
											<th>Type</th>
											<th>Status</th>
											<th>Start Date</th>
											<th>End Date</th>
											<th>Num Sent</th>
											<th>Response</th>
											<th>Num Total Opport</th>
											<th>Num Won Opport</th>
											<th>Total Amount Won Opport</th>
											<th>Actual Cost</th>
											<th>ROI</th>
										</tr>
									</thead>
									<tbody>
										<tr  ng-repeat="camp in campaigns">
											<td>{{camp.campId}}</td>
											<td>{{camp.campName}}</td>
											<td>{{camp.typeName}}</td>
											<td>{{camp.statusName}}</td>
											<td ng-if="camp.startDate == null">-</td>
											<td ng-if="camp.startDate != null">{{camp.startDate}}</td>
											<td>{{camp.endDate}}</td>
											<td>{{camp.numSent}}</td>
											<td>{{camp.expResponse}} %</td>
											<td>{{camp.totalOpp}}</td>
											<td>{{camp.totalOppWon}}</td>
											<td>{{camp.totalAmtWon | number:2}}</td>
											<td>{{camp.actCost | number:2}}</td>
											<td>{{calROI(camp.totalAmtWon, camp.actCost) | number}} %</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div id="errors"></div>
		</div>
		
	</section>
</div>
<jsp:include page="${request.contextPath}/footer"></jsp:include>

