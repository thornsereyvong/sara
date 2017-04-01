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
	$scope.listLeads = function(username){
		$http({
		    method: 'POST',
		    url: '${pageContext.request.contextPath}/lead/list',
		    headers: {
		    	'Accept': 'application/json',
		        'Content-Type': 'application/json'
		    },
		    data: {
		    	"username":username
		    }
		}).success(function(response){
			$scope.leads = response.DATA;
		});
	}
	
	$scope.sort = function(keyname){
	    $scope.sortKey = keyname;   //set the sortKey to the param passed
	    $scope.reverse = !$scope.reverse; //if true make it false and vice versa
	};

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
	
	$scope.deleteLead = function(leadID){
		
		var str = '<%=roleDelete%>';
		if(str == "YES"){
			swal({   
				title: "<span style='font-size: 25px;'>You are about to delete lead with ID: <span class='color_msg'>"+leadID+"</span>.</span>",   
				text: "Click OK to continue or CANCEL to abort.",   
				type: "info", 
				html: true,
				showCancelButton: true,   
				closeOnConfirm: false,   
				showLoaderOnConfirm: true, 
				
			}, function(){   
				setTimeout(function(){			
					$.ajax({ 
			    		url: "${pageContext.request.contextPath}/lead/remove/"+leadID,
			    		method: "DELETE",
			    		beforeSend: function(xhr) {
			    		    xhr.setRequestHeader("Accept", "application/json");
			    		    xhr.setRequestHeader("Content-Type", "application/json");
			    	    }, 
			    	    success: function(result){	  
			    			if(result.MESSAGE == "DELETED"){	    				
			    				
			    				alertMsgSuccessSweetWithTxt(result.MSG) 
			    				setTimeout(function(){		
			    					$scope.listLeads();
			    				},2000);
			    				
							}else{
								alertMsgErrorSweetWithTxt(result.MSG)
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
		<h1>Leads</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"><i class="fa fa-dashboard"></i>Leads</a></li>
		</ol>
	</section>

	<section class="content">

		<!-- Default box -->
		
		<div class="box box-danger">
			<div class="box-header with-border">
				<div style="background: #fff;margin-top: 15px;">
				 <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-left: -5px;">
				 	<a href="${pageContext.request.contextPath}/create-lead" class="btn btn-info btn-app" ><i class="fa fa-plus" aria-hidden="true"></i> Create</a>
				 	<%-- <a href="${pageContext.request.contextPath}/view-leads" class="btn btn-info btn-app" ><i class="fa fa-clone"	aria-hidden="true"></i> View</a> --%>
				 </div>
				  <!-- <div class="col-sm-12">
					<hr style="margin-bottom: 0;margin-top: 0px;" />
				 </div> --> 
			</div>
			</div>
			
			<div class="box-body" style="background: url(${pageContext.request.contextPath}/resources/images/boxed-bg.jpg);">
			<div class="clearfix"></div>
			<div class="panel panel-default">
  				<div class="panel-body">
  					<div class="row">
				 	<div class="col-xs-9 col-sm-6 col-md-4 col-lg-4">
					  	<form class="form-inline">
					        <div class="form-group">
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
					<div class="col-xs-3 col-sm-2 col-sm-offset-4 col-md-offset-6 col-lg-2 col-lg-offset-6">
					  	<form class="form-inline">
					        <div class="form-group" style="float: right;">
					        	<div class="input-group">
					        		<select class="form-control" ng-model="pageSize.row" id ="row" ng-options="obj.value as obj.label for obj in pageSize.rows"></select>
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="clearfix"></div>
					<div class="col-sm-12">
						<div class="tablecontainer table-responsive" data-ng-init="listLeads('${SESSION}')" > 
							<% if(roleList.equals("YES")){ %>
								<table class="table table-hover" >
									<tr>
										<th style="cursor: pointer;" ng-click="sort('leadID')">ID
											<span class="glyphicon sort-icon" ng-show="sortKey=='campID'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
										</th>
										<th style="cursor: pointer;" ng-click="sort('salutation')">Name
											<span class="glyphicon sort-icon" ng-show="sortKey=='campName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
										</th>
										<th style="cursor: pointer;" ng-click="sort('statusName')">Status
											<span class="glyphicon sort-icon" ng-show="sortKey=='statusName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
										</th>
										<th style="cursor: pointer;" ng-click="sort('accountName')">Company
											<span class="glyphicon sort-icon" ng-show="sortKey=='type.typeName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
										</th>
										<th style="cursor: pointer;" ng-click="sort('email')">Email
											<span class="glyphicon sort-icon" ng-show="sortKey=='startDate'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
										</th>
										<th style="cursor: pointer;" ng-click="sort('createDate')">Created Date
											<span class="glyphicon sort-icon" ng-show="sortKey=='endDate'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
										</th>
										<th class="text-center">Action</th>
									</tr>
									<tr dir-paginate="cc in leads |orderBy:sortKey:reverse |filter:search |itemsPerPage:pageSize.row" class="ng-cloak">
										<td>{{cc.leadID}}</td>
										<td>{{cc.salutation}} {{cc.firstName}} {{cc.lastName}}</td>
										<td>{{cc.statusName}}</td>
										<td>{{cc.accountName}}</td>
										<td ng-if="cc.email == ''">-</td>
										<td ng-if="cc.email !=''">{{cc.email}}</td>
										<td>{{cc.createDate | date:'dd-MM-yyyy'}}</td>	
										<td class="text-center" style="min-width: 100px;">
											<button ng-if="cc.statusName == 'Converted'" type="button" disabled="disabled" class="btn btn-xs" data-toggle="tooltip" title="You cannot edit converted lead!"><i class="fa fa-pencil text-primary"></i></button>
											<a ng-if=" cc.statusName != 'Converted'" href="${pageContext.request.contextPath}/update-lead/{{cc.leadID}}"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="edit"><i class="fa fa-pencil text-primary"></i></button></a>
											<a href="#" ng-click="deleteLead(cc.leadID)"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="delete"><i class="fa fa-trash text-danger"></i></button></a>
											<a href="${pageContext.request.contextPath}/view-lead/{{cc.leadID}}"><button type="button" data-toggle="tooltip" class="btn btn-xs" title="view"><i class="fa fa-eye text-info"></i></button></a>
											<a ng-if=" cc.statusName != 'Converted' " href="${pageContext.request.contextPath}/convert-lead/{{cc.leadID}}"><button type="button"  data-toggle="tooltip" class="btn btn-xs" title="Convert"><i class="fa fa-retweet"></i></button></a>
											<button ng-if=" cc.statusName == 'Converted'" type="button" disabled="disabled" data-toggle="tooltip" class="btn btn-xs" title="Converted"><i class="fa fa-retweet"></i></button>
										</td>
									</tr>
								</table>
							</div>	
							<dir-pagination-controls
						       max-size="pageSize.row"
						       direction-links="true"
						       boundary-links="true" >
						    </dir-pagination-controls>
						<%	}else{ %>					
							<div class="alert alert-warning" role="alert"><i class="glyphicon glyphicon-cog"></i> You don't have permission list data</div>					
						<% } %>
					</div>
				</div>
			  </div>
			</div>
			</div>
			<!-- /.box-body -->
		</div>
		<!-- /.box -->
	</section>
	<!-- /.content -->
</div>
<!-- /.content-wrapper -->
<jsp:include page="${request.contextPath}/footer"></jsp:include>
