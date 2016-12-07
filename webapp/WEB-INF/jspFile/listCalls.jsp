<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>

<%
	String roleList = (String) request.getAttribute("role_list");
%>
<%
	String roleDelete = (String) request.getAttribute("role_delete");
%>


<script type="text/javascript">
var app = angular.module('campaign', ['angularUtils.directives.dirPagination','angular-loading-bar', 'ngAnimate']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = false;
}]);
var self = this;
app.controller('campController',['$scope','$http',function($scope, $http){	
	$scope.listContact = function(){
		$http.get("${pageContext.request.contextPath}/call/list").success(function(response){
				$scope.contact = response.DATA;
			});
		} ;
	
	$scope.sort = function(keyname){
	    $scope.sortKey = keyname;   //set the sortKey to the param passed
	    $scope.reverse = !$scope.reverse; //if true make it false and vice versa
	};
	
	$scope.deleteCon = function(oppID){
		var str = '<%=roleDelete%>';
		if(str == "YES"){
			swal({   
				title: "<span style='font-size: 25px;'>You are about to delete call with ID: <span class='color_msg'>"+oppID+"</span>.</span>",   
				text: "Click OK to continue or CANCEL to abort.",   
				type: "info", 
				html: true,
				showCancelButton: true,   
				closeOnConfirm: false,   
				showLoaderOnConfirm: true, 
				
			}, function(){   
				setTimeout(function(){			
					$.ajax({ 
			    		url: "${pageContext.request.contextPath}/call/remove/"+oppID,
			    		method: "DELETE",
			    		beforeSend: function(xhr) {
			    		    xhr.setRequestHeader("Accept", "application/json");
			    		    xhr.setRequestHeader("Content-Type", "application/json");
			    	    }, 
			    	    success: function(result){	  
			    			if(result.MESSAGE == "DELETED"){	    				
			    				swal({
			    					title:"SUCCESSFUL",
			    					text: result.MSG, 
			    					type:"success", 
			    					html: true,
			    					timer: 2000,
			    				});
			    				  
			    				setTimeout(function(){		
			    					$scope.listContact();
			    				},2000);
			    			}else{
			    				swal("Unsuccessful!", result.MSG, "error");
			    			}
			    		},
			    		error:function(){
			    			swal("Unsuccessful!", "Please try again!", "error");
			    		}		    	    
			    	});
				}, 500);
			});	
		}else{
			alertMsgNoPermision();
		}
	};
	
}]);

//alert($.session.get("parentID"));

</script>

<div class="content-wrapper" ng-app="campaign"
	ng-controller="campController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Calls</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"><i class="fa fa-dashboard"></i>Calls</a></li>
		</ol>
	</section>

	<section class="content">

		<!-- Default box -->

		<div class="box box-danger">
			<div class="box-header with-border">
				<div style="background: #fff; margin-top: 15px;">
					<div class="col-sm-12">
						<a href="${pageContext.request.contextPath}/create-call"
							class="btn btn-info btn-app"><i class="fa fa-plus"
							aria-hidden="true"></i> Create</a> 							
					</div>					
				</div>
			</div>

			<div class="box-body"
				style="background: url(${pageContext.request.contextPath}/resources/images/boxed-bg.jpg);padding:30px;">


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
						<div class="tablecontainer table-responsive" data-ng-init="listContact()">
							<%
								if (roleList.equals("YES")) {
							%>
							<table class="table table-hover">
								<tr>
									<th style="cursor: pointer;" ng-click="sort('callId')">Call
										ID <span class="glyphicon sort-icon"
										ng-show="sortKey=='callId'"
										ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
									</th>
									<th style="cursor: pointer;" ng-click="sort('callSubject')">Subject
										<span class="glyphicon sort-icon"
										ng-show="sortKey=='callSubject'"
										ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
									</th>
									<th style="cursor: pointer;" ng-click="sort('callStartDate')">Start
										Date <span class="glyphicon sort-icon"
										ng-show="sortKey=='callStartDate'"
										ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
									</th>
									<th style="cursor: pointer;" ng-click="sort('callDuration')">Duration
										<span class="glyphicon sort-icon"
										ng-show="sortKey=='callDuration'"
										ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
									</th>
									<th style="cursor: pointer;" ng-click="sort('callStatusName')">Status
										<span class="glyphicon sort-icon"
										ng-show="sortKey=='callStatusName'"
										ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
									</th>
									<th style="cursor: pointer;"
										ng-click="sort('callRelatedToModuleType')">Relate To <span
										class="glyphicon sort-icon"
										ng-show="sortKey=='callRelatedToModuleType'"
										ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}"></th>

									<th>Action</th>
								</tr>

								<tr dir-paginate="cc in contact |orderBy:sortKey:reverse |filter:search |itemsPerPage:5" class="ng-cloak">
									<td>{{cc.callId}}</td>
									<td>{{cc.callSubject}}</td>
									<td>{{cc.callStartDate | date:'dd-MM-yyyy h:mma'}}</td>
									<td>{{cc.callDuration}}</td>
									<td>{{cc.callStatusName}}</td>
									<td>{{cc.callRelatedToModuleType}}</td>
									<td>
										<div class="col-sm-2">
											<div class="btn-group">
												<button type="button" class="btn btn-default btn-flat btn-sm"
													data-toggle="dropdown" aria-expanded="false">
													<span class="caret"></span> <span class="sr-only">Toggle
														Dropdown</span>
												</button>
												<ul class="dropdown-menu pull-left" role="menu">
													<li><a
														href="${pageContext.request.contextPath}/update-call/{{cc.callId}}"><i
															class="fa fa-pencil"></i> Edit</a></li>
													<li><a href="#" ng-click="deleteCon(cc.callId)"><i
															class="fa fa-trash"></i> Delete</a></li>
													<li><a href="${pageContext.request.contextPath}/view-call/{{cc.callId}}"><i class="fa fa-eye"></i> View</a></li>
												</ul>
											</div>
										</div>
									</td>
								</tr>

							</table>
							<dir-pagination-controls max-size="5" direction-links="true"
								boundary-links="true"> </dir-pagination-controls>
							<%
								} else {
							%>
							<div class="alert alert-warning" role="alert">
								<i class="glyphicon glyphicon-cog"></i> You don't have
								permission list data
							</div>
							<%
								}
							%>

						</div>


					</div>
				</div>
			</div>
			<!-- /.box-body -->
			<div class="box-footer"></div>
			<!-- /.box-footer-->
		</div>
	</section>
</div>
<jsp:include page="${request.contextPath}/footer"></jsp:include>

