<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>


<script type="text/javascript">
var app = angular.module('campaign', ['angularUtils.directives.dirPagination','angular-loading-bar', 'ngAnimate']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = false;
}]);
var self = this;
var str = "${roleDelete}";
app.controller('campController',['$scope','$http',function($scope, $http){
	$scope.listContact = function(){
		$http.get("${pageContext.request.contextPath}/role/list").success(function(response){
				$scope.contact = response.DATA;
			});
		} ;
	
	$scope.sort = function(keyname){
	    $scope.sortKey = keyname;   //set the sortKey to the param passed
	    $scope.reverse = !$scope.reverse; //if true make it false and vice versa
	};
	
	$scope.deleteCon = function(oppID){				
		if(str == "YES"){
			swal({   
				title: "<span style='font-size: 25px;'>You are about to delete role with ID: <span class='color_msg'>"+oppID+"</span>.</span>",   
				text: "Click OK to continue or CANCEL to abort.",   
				type: "info", 
				html: true,
				showCancelButton: true,   
				closeOnConfirm: false,   
				showLoaderOnConfirm: true, 
				
			}, function(){   
				setTimeout(function(){			
					$.ajax({ 
			    		url: "${pageContext.request.contextPath}/role/remove/"+oppID,
			    		method: "DELETE",
			    		async: false,
			    		beforeSend: function(xhr) {
			    		    xhr.setRequestHeader("Accept", "application/json");
			    		    xhr.setRequestHeader("Content-Type", "application/json");
			    	    }, 
			    	    success: function(result){	  
			    			if(result.MESSAGE == "DELETED"){
			    				alertMsgSuccessSweetWithTxt(result.MSG);  
			    				setTimeout(function(){		
			    					$scope.listContact();
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

<div class="content-wrapper" ng-app="campaign"
	ng-controller="campController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Role Management</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>Role
					Management</a></li>
		</ol>
	</section>

	<section class="content">

		<!-- Default box -->

		<div class="box box-danger">
			<div class="box-header with-border">
				<div style="background: #fff; margin-top: 15px;">
					<div class="col-sm-12">
						<a href="${pageContext.request.contextPath}/create-role"
							class="btn btn-info btn-app"><i class="fa fa-plus"
							aria-hidden="true"></i> Create</a> <a
							href="${pageContext.request.contextPath}/view-role-management"
							class="btn btn-info btn-app"><i class="fa fa-clone"
							aria-hidden="true"></i> View</a>
					</div>
				</div>
			</div>

			<div class="box-body" style="background: url(${pageContext.request.contextPath}/resources/images/boxed-bg.jpg);padding:30px;">
				<div class="clearfix"></div>
				<div class="panel panel-default">
					<div class="panel-body">

						<div class="col-sm-4">
							<form class="form-inline">
								<div class="form-group" style="padding-top: 10px;">
									<label>Search :</label> <input type="text" ng-model="search"
										class="form-control" placeholder="Search">
								</div>
							</form>
							<br />
						</div>
						<div class="clearfix"></div>
						<div class="tablecontainer table-responsive"
							data-ng-init="listContact()">
							<table class="table table-hover">
								<tr>
									<th style="cursor: pointer;" ng-click="sort('roleId')">Role
										ID <span class="glyphicon sort-icon"
										ng-show="sortKey=='roleId'"
										ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
									</th>
									<th style="cursor: pointer;" ng-click="sort('roleName')">Role
										Name <span class="glyphicon sort-icon"
										ng-show="sortKey=='roleName'"
										ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
									</th>
									<th style="cursor: pointer;" ng-click="sort('description')">Description
										<span class="glyphicon sort-icon"
										ng-show="sortKey=='description'"
										ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
									</th>


									<th>Action</th>
								</tr>

								<tr
									dir-paginate="cc in contact |orderBy:sortKey:reverse |filter:search |itemsPerPage:5">
									<td>{{cc.roleId}}</td>
									<td>{{cc.roleName}}</td>
									<td>{{cc.description}}</td>
									<td><a
										href="${pageContext.request.contextPath}/update-role/{{cc.roleId}}"
										class="btn btn-success custom-width"><i
											class="fa fa-pencil" aria-hidden="true"></i></a>
										<button type="button" ng-click="deleteCon(cc.roleId)"
											class="btn btn-danger custom-width">
											<i class="fa fa-times" aria-hidden="true"></i>
										</button></td>
								</tr>

							</table>
							<dir-pagination-controls max-size="5" direction-links="true"
								boundary-links="true"> </dir-pagination-controls>
						</div>


					</div>
				</div>
			</div>
			<div class="box-footer"></div>
		</div>
	</section>
</div>
<jsp:include page="${request.contextPath}/footer"></jsp:include>

