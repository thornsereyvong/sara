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
	
	$scope.reportLeadByCampaign = function(){
		$http.get("${pageContext.request.contextPath}/report/campaign/lead-by-campaign").success(function(response){
			$scope.leadCampaigns = response.LEAD_BY_CAMPAIGN;
		});
	};
	
	$scope.excelBtnClick = function(){		
		 var blob = new Blob([document.getElementById('exportTbl').innerHTML], {
            type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8"
        });
        saveAs(blob, "lead-by-campaign.xls");		
	}

}]);


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
		<h1>Lead By Campaign</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"> Lead By Campaign</a></li>
		</ol>
	</section>

	<section class="content" data-ng-init="reportLeadByCampaign()">
		<div class="row">
			<div class="col-md-12">
				<div class="box box-primary">
					<div class="box-header">						
						<div class="">
						  	<form class="form-inline" style="padding-top: 20px;">
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
						    </form>
						</div>					
					</div>
					<div class="clearfix"></div>
					<div class="box-body">
						<div class="tablecontainer table-responsive">
							<table class="table table-hover">
								<thead>
									<tr>
										<th>CAMPAIGN NAME</th>
										<th>LEAD OWNER</th>
										<th>LEAD NAME</th>
										<th>COMPANY</th>
										<th>EMAIL</th>
										<th>LEAD STATUS</th>
										<th>LEAD CREATED DATE</th>
									</tr>
								</thead>
								<tbody>
									<tr  dir-paginate="lc in leadCampaigns |orderBy:sortKey:reverse |filter:search |itemsPerPage:pageSize.row" class="ng-cloak">
										<td>[{{lc.campId}}] {{lc.campName}}</td>
										<td>{{lc.leadOwner}}</td>
										<td>[{{lc.leadId}}] {{lc.leadName}}</td>
										<td>{{lc.leadCompany}}</td>
										<td ng-if="lc.leadEmail == ''">-</td>
										<td ng-if="lc.leadEmail != ''">{{lc.leadEmail}}</td>
										<td>{{lc.leadStatus}}</td>
										<td>{{lc.leadCreatedDate}}</td>
									</tr>
								</tbody>
							</table>
							<dir-pagination-controls
						       max-size="pageSize.row"
						       direction-links="true"
						       boundary-links="true" >
							</dir-pagination-controls>
							
							<div style="display:none;" id="exportTbl">
								<table class="table table-hover">
								<thead>
									<tr>
										<th>CAMPAIGN</th>
										<th>LEAD OWNER</th>
										<th>LEAD NAME</th>
										<th>COMPANY</th>
										<th>EMAIL</th>
										<th>LEAD STATUS</th>
										<th>LEAD CREATED DATE</th>
									</tr>
								</thead>
								<tbody>
									<tr  ng-repeat="lc in leadCampaigns |orderBy:sortKey:reverse |filter:search " class="ng-cloak">
										<td>[{{lc.campId}}] {{lc.campName}}</td>
										<td>{{lc.leadOwner}}</td>
										<td>[{{lc.leadId}}] {{lc.leadName}}</td>
										<td>{{lc.leadCompany}}</td>
										<td ng-if="lc.leadEmail == ''">-</td>
										<td ng-if="lc.leadEmail != ''">{{lc.leadEmail}}</td>
										<td>{{lc.leadStatus}}</td>
										<td>{{lc.leadCreatedDate}}</td>
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

