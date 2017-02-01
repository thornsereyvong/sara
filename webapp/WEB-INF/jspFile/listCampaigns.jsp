<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>

<% String roleList = (String)request.getAttribute("role_list"); %>
<% String roleDelete = (String)request.getAttribute("role_delete"); %>

<script type="text/javascript">

var app = angular.module('campaign', ['angularUtils.directives.dirPagination','angular-loading-bar', 'ngAnimate']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = false;
}]);
var self = this;
app.controller('campController',['$scope','$http',function($scope, $http){
	$scope.listCampaigns = function(){
		$http.get("${pageContext.request.contextPath}/campaign/list").success(function(response){
				$scope.campaigns = response.DATA;
			});
		} ;
	
	$scope.sort = function(keyname){
	    $scope.sortKey = keyname;   //set the sortKey to the param passed
	    $scope.reverse = !$scope.reverse; //if true make it false and vice versa
	};

	$scope.pageSize = {};
	$scope.currentPage = 1;
	$scope.pageSize.rows = [ 
					{ value: "5", label: "5" },
    				{ value: "10", label: "10" },
            		{ value: "15", label: "15" },
            		{ value: "20", label: "20" },
            		{ value: "25", label: "25" },
            		{ value: "30", label: "30" },
            		];
	$scope.pageSize.row = $scope.pageSize.rows[0].value;
	
	$scope.deleteCamp = function(campID){
		var str = '<%=roleDelete%>';
		if(str == "YES"){
			swal({   
				title: "<span style='font-size: 25px;'>You are about to delete campaign with ID: <span class='color_msg'>"+campID+"</span>.</span>",   
				text: "Click OK to continue or CANCEL to abort.",   
				type: "info", 
				html: true,
				showCancelButton: true,   
				closeOnConfirm: false,   
				showLoaderOnConfirm: true, 
				
			}, function(){   
				setTimeout(function(){			
					$.ajax({ 
			    		url: "${pageContext.request.contextPath}/campaign/remove/"+campID,
			    		method: "POST",
			    		beforeSend: function(xhr) {
			    		    xhr.setRequestHeader("Accept", "application/json");
			    		    xhr.setRequestHeader("Content-Type", "application/json");
			    	    },
			    	    success: function(result){	  
			    			if(result.MESSAGE == "DELETED"){
			    				alertMsgSuccessSweetWithTxt(result.MSG);
			    				setTimeout(function(){		
			    					$scope.listCampaigns();
			    				},2000);
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
		}else{
			alertMsgNoPermision();
		}
		
		
	};
	
}]);

</script>

<div class="content-wrapper" ng-app="campaign" ng-controller="campController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Campaigns</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"><i class="fa fa-dashboard"></i>Campaigns </a></li>
		</ol>
	</section>

	<section class="content">
		<div class="box box-danger">
			<div class="box-header with-border">
				<div style="background: #fff;margin-top: 15px;">
				 <div class="col-sm-12">
				 	<a href="${pageContext.request.contextPath}/create-campaign" class="btn btn-info btn-app" ><i class="fa fa-plus" aria-hidden="true"></i> Create</a>
				 </div>
			</div>
			</div>
			<div class="box-body" style="background: url(${pageContext.request.contextPath}/resources/images/boxed-bg.jpg);padding:30px;">
			<div class="clearfix"></div>
			<div class="panel panel-default">
  				<div class="panel-body">
				 	<div class="col-sm-2">
					  	<form class="form-inline">
					        <div class="form-group" style="padding-top: 20px;">
					        	<div class="input-group">
					        		 <span class="input-group-btn">
							       	 	<button class="btn btn-default" type="button" disabled="disabled"><i class="fa fa-search" aria-hidden="true"></i></button>
							      	</span>
					        		<input type="text" ng-model="search" class="form-control" placeholder="Search">
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="col-sm-2">
					  	<form class="form-inline">
					        <div class="form-group" style="padding-top: 20px;">
					        	<label>Row: </label>
					        	<div class="input-group">
					        		<select class="form-control" ng-model="pageSize.row" id ="row" ng-options="obj.value as obj.label for obj in pageSize.rows"></select>
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="clearfix"></div>
				<div class="col-sm-12">
					<div class="tablecontainer table-responsive" data-ng-init="listCampaigns()" > 
						<%				
						   if(roleList.equals("YES")){
						%>
						
							<table class="table table-hover" >
								<tr>
									<th style="cursor: pointer;" ng-click="sort('campID')">Campaign ID
										<span class="glyphicon sort-icon" ng-show="sortKey=='campID'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
									</th>
									<th style="cursor: pointer;" ng-click="sort('campName')">Campaign Name
										<span class="glyphicon sort-icon" ng-show="sortKey=='campName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
									</th>
									<th style="cursor: pointer;" ng-click="sort('statusName')">Status
										<span class="glyphicon sort-icon" ng-show="sortKey=='statusName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
									</th>
									<th style="cursor: pointer;" ng-click="sort('typeName')">Type
										<span class="glyphicon sort-icon" ng-show="sortKey=='typeName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
									</th>
									<th style="cursor: pointer;" ng-click="sort('startDate')">Start Date
										<span class="glyphicon sort-icon" ng-show="sortKey=='startDate'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
									</th>
									<th style="cursor: pointer;" ng-click="sort('endDate')">End Date
										<span class="glyphicon sort-icon" ng-show="sortKey=='endDate'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
									</th>
													
									<th>Action</th>
								</tr>
		
								<tr dir-paginate="cc in campaigns |orderBy:sortKey:reverse |filter:search |itemsPerPage:pageSize.row" current-page="currentPage" class="ng-cloak">
									<td data-index="{{ ($index + 1) + (currentPage - 1) * pageSize.row}}">{{cc.campID}}</td>
									<td>{{cc.campName}}</td>
									<td>{{cc.statusName}}</td>
									<td>{{cc.typeName}}</td>
									<td ng-if="cc.startDate == null">-</td>
									<td ng-if="cc.startDate != null">{{cc.startDate | date:'dd-MM-yyyy'}}</td>
									<td>{{cc.endDate | date:'dd-MM-yyyy'}}</td>	
									<td>
										<div class="col-sm-2">
											<div class="btn-group">
						                      <button type="button" class="btn btn-default btn-flat btn-sm" data-toggle="dropdown" aria-expanded="false">
						                        <span class="caret"></span>
						                        <span class="sr-only">Toggle Dropdown</span>
						                      </button>
						                      <ul class="dropdown-menu" role="menu">
						                        <li><a href="${pageContext.request.contextPath}/update-campaign/{{cc.campID}}"><i class="fa fa-pencil"></i> Edit</a></li>
						                        <li><a href="#"  ng-click="deleteCamp(cc.campID)"><i class="fa fa-trash"></i> Delete</a></li>
						                        <li><a href="${pageContext.request.contextPath}/view-campaign/{{cc.campID}}"><i class="fa fa-eye"></i> View</a></li>
						                      </ul>
						                    </div>
					                   	</div>
										<%-- <a href="${pageContext.request.contextPath}/update-campaign/{{cc.campID}}" class="btn btn-success custom-width"><i class="fa fa-pencil" aria-hidden="true"></i> Edit</a>
										<button type="button" ng-click="deleteCamp(cc.campID)" class="btn btn-danger custom-width"><i class="fa fa-times" aria-hidden="true"></i> Delete</button>	 --%>
									</td>
								</tr>
						
						</table>
						<dir-pagination-controls
					       max-size="pageSize.row"
					       direction-links="true"
					       boundary-links="true" >
						   </dir-pagination-controls>
						</div>
					</div>
				<%	   
				   }else{
					   
				%>
					<div class="alert alert-warning" role="alert"><i class="glyphicon glyphicon-cog"></i> You don't have permission list data</div>
				<%
				   }
				
				%>
				
				

			  </div>
		</div>
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
				


<!-- /.content-wrapper -->





<jsp:include page="${request.contextPath}/footer"></jsp:include>

				