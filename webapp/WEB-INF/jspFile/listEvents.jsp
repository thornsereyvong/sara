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
	$scope.listContact = function(){
		$http.get("${pageContext.request.contextPath}/event/list").success(function(response){
				$scope.contact = response.DATA;
			});
		} ;
	
	$scope.sort = function(keyname){
	    $scope.sortKey = keyname;   //set the sortKey to the param passed
	    $scope.reverse = !$scope.reverse; //if true make it false and vice versa
	};
	
	$scope.deleteCon = function(oppID){
		SweetAlert.swal({
            title: "Are you sure?", //Bold text
            text: "This Event will not be able to recover!", //light text
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
						 $http.delete("${pageContext.request.contextPath}/event/remove/"+oppID)
				            .success(function(){
				            		SweetAlert.swal({
						            		title:"Deleted",
						            		text:"Event have been deleted!",
						            		type:"success",  
						            		timer: 2000,   
						            		showConfirmButton: false
				            		});
				            		$scope.listContact();	
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
	                text:"This Event is safe!",
	                type:"error",
	                timer:2000,
	                showConfirmButton: false});
            }
        });
	};
	
}]);


</script>

<div class="content-wrapper" ng-app="campaign" ng-controller="campController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Events</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"><i class="fa fa-dashboard"></i>Events</a></li>
		</ol>
	</section>

	<section class="content">

		<!-- Default box -->
		
		<div class="box box-danger">
			<div class="box-header with-border">
				
				<div style="background: #fff;margin-top: 15px;">
				 <div class="col-sm-12">
				 	<a href="${pageContext.request.contextPath}/create-event" class="btn btn-info btn-app" ><i class="fa fa-plus" aria-hidden="true"></i> Create</a>
				 	
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
			<div class="tablecontainer table-responsive" data-ng-init="listContact()" > 
				<%
				   if(roleList.equals("YES")){
				%>
				
				
				<table class="table table-hover" >
						<tr>
							<th style="cursor: pointer;" ng-click="sort('evId')">Event ID
								<span class="glyphicon sort-icon" ng-show="sortKey=='evId'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('evName')">Event Name
								<span class="glyphicon sort-icon" ng-show="sortKey=='evName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('loName')">Location 
								<span class="glyphicon sort-icon" ng-show="sortKey=='loName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('evStartDate')">Start Date 
								<span class="glyphicon sort-icon" ng-show="sortKey=='evStartDate'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('evEndDate')">End Date 
								<span class="glyphicon sort-icon" ng-show="sortKey=='evEndDate'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('evBudget')">Budget
								<span class="glyphicon sort-icon" ng-show="sortKey=='evBudget'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
											
							<th>Action</th>
						</tr>

						<tr dir-paginate="cc in contact |orderBy:sortKey:reverse |filter:search |itemsPerPage:5">
							<td>{{cc.evId}}</td>
							<td>{{cc.evName}} </td>
							<td>{{cc.loName}}</td>
							<td>{{cc.evStartDate | date:'dd-MM-yyyy'}}</td>
							<td>{{cc.evEndDate | date:'dd-MM-yyyy'}}</td>
							<td>{{cc.evBudget | number:2}}</td>	
							<td>
								<div class="col-sm-2">
									<div class="btn-group">
				                      <button type="button" class="btn btn-default btn-flat" data-toggle="dropdown" aria-expanded="false">
				                        <span class="caret"></span>
				                        <span class="sr-only">Toggle Dropdown</span>
				                      </button>
				                      <ul class="dropdown-menu" role="menu">
				                        <li><a href="${pageContext.request.contextPath}/update-event/{{cc.evId}}"><i class="fa fa-pencil"></i> Edit</a></li>
				                        <li><a href="#" ng-click="deleteCon(cc.evId)"><i class="fa fa-trash"></i> Delete</a></li>
				                        <li><a href="${pageContext.request.contextPath}/view-event/{{cc.evId}}"><i class="fa fa-eye"></i> View</a></li>
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

