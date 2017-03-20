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
			    				swal({
			    					title:"UNSUCCESSFUL",
			    					text: result.MSG, 
			    					type:"error", 
			    					html: true,
			    					timer: 2000,
			    				});
			    			}
			    		},
			    		error:function(){
			    			swal("UNSUCCESSFUL!", "Please try again!", "error");
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
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-left: -5px;">
						<a href="${pageContext.request.contextPath}/create-call" class="btn btn-info btn-app"><i class="fa fa-plus" aria-hidden="true"></i> Create</a> 							
					</div>					
				</div>
			</div>

			<div class="box-body" style="background: url(${pageContext.request.contextPath}/resources/images/boxed-bg.jpg);">
				<div class="clearfix"></div>
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="row">
							<div class="col-xs-9 col-sm-6 col-md-4 col-lg-2">
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
							<div class="col-xs-3 col-sm-2 col-sm-offset-4 col-md-offset-6 col-lg-1 col-lg-offset-9">
							  	<form class="form-inline">
							        <div class="form-group pull-right">
							        	<div class="input-group">
							        		<select class="form-control" ng-model="pageSize.row" id ="row" ng-options="obj.value as obj.label for obj in pageSize.rows"></select>
							        	</div>
							        </div>
							    </form>
							    <br/>
							</div>
							<div class="clearfix"></div>
							<div class="col-sm-12">
								<div class="tablecontainer table-responsive" data-ng-init="listContact()">
									<%
										if (roleList.equals("YES")) {
									%>
									<table class="table table-hover">
										<tr>
											<th style="cursor: pointer;" ng-click="sort('callId')">ID <span class="glyphicon sort-icon"
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
		
											<th class="text-center">Action</th>
										</tr>
										<tr dir-paginate="cc in contact |orderBy:sortKey:reverse |filter:search |itemsPerPage:pageSize.row" class="ng-cloak">
											<td>{{cc.callId}}</td>
											<td>{{cc.callSubject}}</td>
											<td>{{cc.callStartDate | date:'dd-MM-yyyy h:mma'}}</td>
											<td>{{cc.callDuration}}</td>
											<td>{{cc.callStatusName}}</td>
											<td ng-if="cc.callRelatedToModuleType == ''">-</td>
											<td ng-if="cc.callRelatedToModuleType != ''"><span><span class="badge bg-red">{{cc.callRelatedToModuleType}}</span> <span>[{{cc.callRelatedToFieldId}}] {{cc.relatedToName}}</span></span></td>
											<td class="text-center" style="min-width: 100px;">
												<a href="${pageContext.request.contextPath}/update-call/{{cc.callId}}"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="edit"><i class="fa fa-pencil text-primary"></i></button></a>
												<a href="#" ng-click="deleteCon(cc.callId)"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="delete"><i class="fa fa-trash text-danger"></i></button></a>
												<a href="${pageContext.request.contextPath}/view-call/{{cc.callId}}"><button type="button" data-toggle="tooltip" class="btn btn-xs" title="view"><i class="fa fa-eye text-info"></i></button></a>
											</td>
										</tr>
										<tr>
											<td colspan="7">
												<dir-pagination-controls max-size="pageSize.row" direction-links="true" boundary-links="true"> </dir-pagination-controls>
											</td>
										</tr>
									</table>
									<%
										} else {
									%>
									<div class="alert alert-warning" role="alert">
										<i class="glyphicon glyphicon-cog"></i> You don't have permission list data
									</div>
									<%
										}
									%>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- /.box-body -->
		</div>
	</section>
</div>
<jsp:include page="${request.contextPath}/footer"></jsp:include>

