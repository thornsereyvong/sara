<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>

<% String roleDelete = (String)request.getAttribute("roleDelete"); %>

<script type="text/javascript">

var app = angular.module('leadProject', ['angularUtils.directives.dirPagination','angular-loading-bar', 'ngAnimate']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = false;
}]);
var self = this;
app.controller('leadProjectController',['$scope','$http',function($scope, $http){
	$scope.listLeadProjects = function(){
		$http({
		    method: 'GET',
		    url: '${pageContext.request.contextPath}/project/list',
		    headers: {
		    	'Accept': 'application/json',
		        'Content-Type': 'application/json'
		    }
		}).success(function(response){
			$scope.leadProjects = response.DATA;
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
	
	$scope.deleteLeadProject = function(id){
		swal({   
			title: "<span style='font-size: 25px;'>You are about to delete lead project with ID: <span class='color_msg'>"+id+"</span>.</span>",   
			text: "Click OK to continue or CANCEL to abort.",   
			type: "info", 
			html: true,
			showCancelButton: true,   
			closeOnConfirm: false,   
			showLoaderOnConfirm: true, 
			
		}, function(){   
			setTimeout(function(){			
				$.ajax({ 
		    		url: "${pageContext.request.contextPath}/project/remove/"+id,
		    		method: "DELETE",
		    		beforeSend: function(xhr) {
		    		    xhr.setRequestHeader("Accept", "application/json");
		    		    xhr.setRequestHeader("Content-Type", "application/json");
		    	    }, 
		    	    success: function(result){	  
		    			if(result.MESSAGE == "DELETED"){	    				
		    				alertMsgSuccessSweetWithTxt(result.MSG) 
		    				$scope.listLeadProjects();
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
	};
	
}]);

</script>

<div class="content-wrapper" ng-app="leadProject" ng-controller="leadProjectController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Lead Projects</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"><i class="fa fa-dashboard"></i>Lead Projects</a></li>
		</ol>
	</section>

	<section class="content">

		<!-- Default box -->
		
		<div class="box box-danger">
			<div class="box-header with-border">
				<div style="background: #fff;margin-top: 15px;">
				 <div class="col-sm-12">
				 	<a href="${pageContext.request.contextPath}/create-lead-project" class="btn btn-info btn-app" ><i class="fa fa-plus" aria-hidden="true"></i> Create</a>
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
						<div class="tablecontainer table-responsive" data-ng-init="listLeadProjects()" > 
								<table class="table table-hover" >
									<tr>
										<th style="cursor: pointer;" ng-click="sort('id')">ID
											<span class="glyphicon sort-icon" ng-show="sortKey=='id'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
										</th>
										<th style="cursor: pointer;" ng-click="sort('name')">Name
											<span class="glyphicon sort-icon" ng-show="sortKey=='name'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
										</th>
										<th style="cursor: pointer;" ng-click="sort('accountManager')">Account Manager
											<span class="glyphicon sort-icon" ng-show="sortKey=='accountManager'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
										</th>
										<th style="cursor: pointer;" ng-click="sort('companyName')">Company
											<span class="glyphicon sort-icon" ng-show="sortKey=='companyName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
										</th>
										<th style="cursor: pointer;" ng-click="sort('email')">Email
											<span class="glyphicon sort-icon" ng-show="sortKey=='email'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
										</th>
										<th style="cursor: pointer;" ng-click="sort('startDate')">Start Date
											<span class="glyphicon sort-icon" ng-show="sortKey=='startDate'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
										</th>
										<th style="cursor: pointer;" ng-click="sort('endDate')">End Date
											<span class="glyphicon sort-icon" ng-show="sortKey=='endDate'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
										</th>
										<th>Action</th>
									</tr>
									<tr dir-paginate="lp in leadProjects |orderBy:sortKey:reverse |filter:search |itemsPerPage:pageSize.row" class="ng-cloak">
										<td>{{lp.id}}</td>
										<td>{{lp.name == '' ?'-':lp.name}}</td>
										<td>{{lp.accountManager == ''?'-':lp.accountManager}}</td>
										<td>{{lp.companyName == ''?'-':lp.companyName}}</td>
										<td>{{lp.email == ''?'-':lp.email}}</td>
										<td>{{lp.startDate == ''?'-':lp.startDate | date:'dd/MM/yyyy'}}</td>
										<td>{{lp.endDate == ''?'-':lp.endDate | date:'dd/MM/yyyy'}}</td>		
										<td>
											<div class="col-sm-2">
												<div class="btn-group">
							                      <button type="button" class="btn btn-default dropdown-toggle btn-sm" data-toggle="dropdown" aria-expanded="false">
							                        <span class="caret"></span>
							                        <span class="sr-only">Toggle Dropdown</span>
							                      </button>
							                      <ul class="dropdown-menu" role="menu">
							                        <li><a href="${pageContext.request.contextPath}/update-lead-project/{{lp.id}}"><i class="fa fa-pencil"></i> Edit</a></li>
							                        <li ng-if="'<%=roleDelete%>' == 'YES'" ng-click="deleteLeadProject(lp.id)"><a href="#"><i class="fa fa-trash"></i> Delete</a></li>
							                        <li><a href="${pageContext.request.contextPath}/view-lead-project/{{lp.id}}"><i class="fa fa-eye"></i> View</a></li>
							                      </ul>
							                    </div>
						                   	</div>	
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
			  </div>
		</div>
			</div>
			<!-- /.box-footer -->
			<div class="box-footer"></div>
			<!-- /.box-footer-->
		</div>
		<!-- /.box -->
	</section>
	<!-- /.content -->
</div>
<jsp:include page="${request.contextPath}/footer"></jsp:include>

