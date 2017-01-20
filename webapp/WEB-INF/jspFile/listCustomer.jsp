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
	$scope.listCustomer = function(){
		$http.get("${pageContext.request.contextPath}/customer/list").success(function(response){
				$scope.customer = response.DATA;
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
	$scope.pageSize.row = $scope.pageSize.rows[0].value;
	
	$scope.deleteCustomer = function(custId){
		var str = '<%=roleDelete%>';
		if(str == "YES"){
			swal({   
				title: "<span style='font-size: 25px;'>You are about to delete customer with ID: <span class='color_msg'>"+custId+"</span>.</span>",   
				text: "Click OK to continue or CANCEL to abort.",   
				type: "info", 
				html: true,
				showCancelButton: true,   
				closeOnConfirm: false,   
				showLoaderOnConfirm: true, 
				
			}, function(){   
				setTimeout(function(){			
					$.ajax({ 
			    		url: "${pageContext.request.contextPath}/customer/remove/"+custId,
			    		method: "DELETE",
			    		async: false,
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
			    					$scope.listCustomer();
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
			    			swal("UNSUCCESSFUL", "Please try again!", "error");
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
		<h1>Customers</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"><i class="fa fa-dashboard"></i>Customers</a></li>
		</ol>
	</section>

	<section class="content">

		<!-- Default box -->
		
		<div class="box box-danger">
			<div class="box-header with-border">
				
				<div style="background: #fff;margin-top: 15px;">
				 <div class="col-sm-12">
				 	<a href="${pageContext.request.contextPath}/create-customer" class="btn btn-info btn-app" ><i class="fa fa-plus" aria-hidden="true"></i> Create</a>				 
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
							<div class="tablecontainer table-responsive" data-ng-init="listCustomer()" > 
								<%
									if(roleList.equals("YES")){
								%>
									<table class="table table-hover" >
										<tr>
											<th style="cursor: pointer;" ng-click="sort('custID')">CustomerID
												<span class="glyphicon sort-icon" ng-show="sortKey=='custID'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
											</th>
											<th style="cursor: pointer;" ng-click="sort('custName')">Customer Name
												<span class="glyphicon sort-icon" ng-show="sortKey=='custName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
											</th>
											<th style="cursor: pointer;" ng-click="sort('custTel1')">Tel
												<span class="glyphicon sort-icon" ng-show="sortKey=='custTel1'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
											</th>
											<th style="cursor: pointer;" ng-click="sort('custEmail')">Email
												<span class="glyphicon sort-icon" ng-show="sortKey=='email'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
											</th>
											<th style="cursor: pointer;" ng-click="sort('industID.industName')">Industry
												<span class="glyphicon sort-icon" ng-show="sortKey=='industID.industName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
											</th>
											
															
											<th>Action</th>
										</tr>
				
										<tr dir-paginate="cc in customer |orderBy:sortKey:reverse |filter:search |itemsPerPage:pageSize.row" class="ng-cloak">
											<td>{{cc.custID}}</td>
											<td>{{cc.custName}}</td>
											<td ng-if="cc.custTel1 == ''">-</td>
											<td ng-if="cc.custTel1 != ''">{{cc.custTel1}}</td>
											<td ng-if="cc.custEmail == ''">-</td>
											<td ng-if="cc.custEmail != ''">{{cc.custEmail}}</td>
											<td ng-if="cc.industID.industName == null">-</td>
											<td ng-if="cc.industID.industName != null">{{cc.industID.industName}}</td>
											<td>
												<div class="col-sm-2">
													<div class="btn-group">
								                      <button type="button" class="btn btn-default btn-flat btn-sm" data-toggle="dropdown" aria-expanded="false">
								                        <span class="caret"></span>
								                        <span class="sr-only">Toggle Dropdown</span>
								                      </button>
								                      <ul class="dropdown-menu" role="menu">
								                        <li><a href="${pageContext.request.contextPath}/update-customer/{{cc.custID}}"><i class="fa fa-pencil"></i> Edit</a></li>
								                        <li><a href="#" ng-click="deleteCustomer(cc.custID)"><i class="fa fa-trash"></i> Delete</a></li>
								                        <li><a href="${pageContext.request.contextPath}/view-customer/{{cc.custID}}"><i class="fa fa-eye"></i> View</a></li>
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
					</div>
				</div>
			<div class="box-footer"></div>
		</div>
	</section>
</div>
<jsp:include page="${request.contextPath}/footer"></jsp:include>

