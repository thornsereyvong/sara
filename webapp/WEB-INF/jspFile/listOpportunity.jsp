<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>

<% String roleList = (String)request.getAttribute("role_list"); %>
<% String roleDelete = (String)request.getAttribute("role_delete"); %>

<script type="text/javascript">
var app = angular.module('campaign', ['angularUtils.directives.dirPagination','oitozero.ngSweetAlert']);
var self = this;
app.controller('campController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){
	$scope.listOpportunity = function(username){
		$http({
		    method: 'POST',
		    url: '${pageContext.request.contextPath}/opportunity/list',
		    headers: {
		    	'Accept': 'application/json',
		        'Content-Type': 'application/json'
		    },
		    data: {
		    	"username":username
		    }
		}).success(function(response){
			$scope.opportunity = response.DATA;
		});
	} ;
	
	$scope.sort = function(keyname){
	    $scope.sortKey = keyname;   //set the sortKey to the param passed
	    $scope.reverse = !$scope.reverse; //if true make it false and vice versa
	};
	
	$scope.deleteOpp = function(oppID){
		SweetAlert.swal({
            title: "Are you sure?", //Bold text
            text: "This Opportunity will not be able to recover!", //light text
            type: "warning", //type -- adds appropiriate icon
            showCancelButton: true, // displays cancel btton
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Yes, delete!",
            closeOnConfirm: false, //do not close popup after click on confirm, usefull when you want to display a subsequent popup
            closeOnCancel: false
        }, 
        function(isConfirm){ //Function that triggers on user action.        
	            var str = '<%=roleDelete%>';
	            if(isConfirm){
	            	if(str == "YES"){
	            		$http.delete("${pageContext.request.contextPath}/opportunity/remove/"+oppID)
	    	            .success(function(){
	    	            		SweetAlert.swal({
	    			            		title:"Deleted",
	    			            		text:"Opportunity have been deleted!",
	    			            		type:"success",  
	    			            		timer: 2000,   
	    			            		showConfirmButton: false
	    	            		});
	     	            		$scope.listOpportunity('${SESSION}');
	     		            });
					}else{
						SweetAlert.swal({
			                title:"Cancelled",
			                text:"You don't have permission delete!",
			                type:"error",
			                timer:2000,
			                showConfirmButton: false});
					}        
            } else {
                SweetAlert.swal({
	                title:"Cancelled",
	                text:"This Opportunity is safe!",
	                type:"error",
	                timer:2000,
	                showConfirmButton: false});
            }
        });
	};
	
}]);


</script>
<script>
	$(document).ready(function() {
		$('.table-responsive').on('show.bs.dropdown', function () {
		     $('.table-responsive').css( "overflow", "inherit" );
		});
	
		$('.table-responsive').on('hide.bs.dropdown', function () {
		     $('.table-responsive').css( "overflow", "auto" );
		}); 
	}); 
</script>
<div class="content-wrapper" ng-app="campaign" ng-controller="campController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Opportunity</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"><i class="fa fa-dashboard"></i>Opportunity</a></li>
		</ol>
	</section>

	<section class="content">

		<!-- Default box -->
		
		<div class="box box-danger">
			<div class="box-header with-border">
				<div style="background: #fff;margin-top: 15px;">
				 <div class="col-sm-12">
				 	<a href="${pageContext.request.contextPath}/create-opportunity" class="btn btn-info btn-app" ><i class="fa fa-plus" aria-hidden="true"></i> Create</a>				 	
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
				            <label >Search :</label>
				            <input type="text" ng-model="search" class="form-control" placeholder="Search">
				        </div>
				    </form>
				    <br/>
				  </div>
				  <div class="clearfix"></div>
			<div class="tablecontainer table-responsive" data-ng-init="listOpportunity('${SESSION}')" >
				<%	
					if(roleList.equals("YES")){
				%> 
				<table class="table table-hover" >
						<tr>
							<th style="cursor: pointer;" ng-click="sort('opId')">Opportunity ID
								<span class="glyphicon sort-icon" ng-show="sortKey=='opId'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('opName')">Opportunity Name
								<span class="glyphicon sort-icon" ng-show="sortKey=='campName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('custName')">Customer
								<span class="glyphicon sort-icon" ng-show="sortKey=='customer.custName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('osName')">Stage
								<span class="glyphicon sort-icon" ng-show="sortKey=='osName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('opAmount')">Amount
								<span class="glyphicon sort-icon" ng-show="sortKey=='opAmount'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('opCloseDate')">Close Date
								<span class="glyphicon sort-icon" ng-show="sortKey=='opCloseDate'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
											
							<th>Action</th>
						</tr>

						<tr dir-paginate="cc in opportunity |orderBy:sortKey:reverse |filter:search |itemsPerPage:5" class="ng-cloak">
							<td>{{cc.opId}}</td>
							<td>{{cc.opName}}</td>
							<td>{{cc.custName}}</td>
							<td>{{cc.osName}}</td>
							<td>{{cc.opAmount}}</td>
							<td>{{cc.opCloseDate | date:'dd-MM-yyyy'}}</td>	
							<td>
								<div class="col-sm-2">
									<div class="btn-group">
				                      <button type="button" class="btn btn-default btn-flat btn-sm" data-toggle="dropdown" aria-expanded="false">
										<span class="caret"></span> <span class="sr-only">Toggle
											Dropdown</span>
									 </button>
				                      <ul class="dropdown-menu" role="menu">
				                        <li><a href="${pageContext.request.contextPath}/update-opportunity/{{cc.opId}}"><i class="fa fa-pencil"></i> Edit</a></li>
				                        <li><a href="#" ng-click="deleteOpp(cc.opId)"><i class="fa fa-trash"></i> Delete</a></li>
				                        <li><a href="${pageContext.request.contextPath}/view-opportunity/{{cc.opId}}"><i class="fa fa-eye"></i> View</a></li>
				                      </ul>
				                    </div>
			                   	</div>
								
							</td>
						</tr>
				
				</table>
				<dir-pagination-controls
			       max-size="5"
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
			<div class="box-footer"></div>
		</div>
	</section>
</div>
<jsp:include page="${request.contextPath}/footer"></jsp:include>

