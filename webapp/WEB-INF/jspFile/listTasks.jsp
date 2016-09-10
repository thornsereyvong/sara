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
var app = angular.module('campaign', ['angularUtils.directives.dirPagination','oitozero.ngSweetAlert']);
var self = this;
app.controller('campController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){
	$scope.listContact = function(){
		$http.get("${pageContext.request.contextPath}/task/list").success(function(response){
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
            text: "This Task will not be able to recover!", //light text
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
						 $http.delete("${pageContext.request.contextPath}/task/remove/"+oppID)
				            .success(function(){
				            		SweetAlert.swal({
						            		title:"Deleted",
						            		text:"Task have been deleted!",
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
	                text:"This Task is safe!",
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

<div class="content-wrapper" ng-app="campaign"
	ng-controller="campController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Tasks</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"><i class="fa fa-dashboard"></i>Tasks</a></li>
		</ol>
	</section>

	<section class="content">

		<!-- Default box -->
		<div class="box box-danger">
			<div class="box-header with-border">
				<h3 class="box-title">&nbsp;</h3>
				<div class="box-tools pull-right">
					<button class="btn btn-box-tool" data-widget="collapse"
						data-toggle="tooltip" title="Collapse">
						<i class="fa fa-minus"></i>
					</button>
					<button class="btn btn-box-tool" data-widget="remove"
						data-toggle="tooltip" title="Remove">
						<i class="fa fa-times"></i>
					</button>
				</div>
				<div class="col-sm-12">
					<hr style="margin-bottom: 5px; margin-top: 8px;" />
				</div>
				<div style="background: #fff; margin-top: 15px;">
					<div class="col-sm-12">
						<a href="${pageContext.request.contextPath}/create-task"
							class="btn btn-info btn-app"><i class="fa fa-plus"
							aria-hidden="true"></i> Create</a> <a
							href="${pageContext.request.contextPath}/view-tasks"
							class="btn btn-info btn-app"><i class="fa fa-clone"
							aria-hidden="true"></i> View</a>
					</div>
					<div class="col-sm-12">
						<hr style="margin-bottom: 0; margin-top: 0px;" />
					</div>
				</div>
			</div>

			<div class="box-body " style="background: url(${pageContext.request.contextPath}/resources/images/boxed-bg.jpg);padding:30px;">
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
							<% if (roleList.equals("YES")) { %>
							<div class="table-responsive">
								<table class="table table-hover" data-ng-init="listContact()">
									<tr>
										<th style="cursor: pointer;" ng-click="sort('taskId')">Task
											ID <span class="glyphicon sort-icon"
											ng-show="sortKey=='taskId'"
											ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
										</th>
										<th style="cursor: pointer;" ng-click="sort('taskSubject')">Subject
											<span class="glyphicon sort-icon"
											ng-show="sortKey=='taskSubject'"
											ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
										</th>
										<th style="cursor: pointer;" ng-click="sort('taskStartDate')">Start
											Date <span class="glyphicon sort-icon"
											ng-show="sortKey=='taskStartDate'"
											ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
										</th>
										<th style="cursor: pointer;" ng-click="sort('taskDueDate')">Due
											Date <span class="glyphicon sort-icon"
											ng-show="sortKey=='taskDueDate'"
											ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
										</th>
	
										<th style="cursor: pointer;" ng-click="sort('taskStatusName')">Status
											<span class="glyphicon sort-icon"
											ng-show="sortKey=='taskStatusName'"
											ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
										</th>
										<th style="cursor: pointer;" ng-click="sort('conFirstname')">Contact
											<span class="glyphicon sort-icon"
											ng-show="sortKey=='conFirstname'"
											ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
										</th>
	
										<th>Action</th>
									</tr>
									<tr dir-paginate="cc in contact |orderBy:sortKey:reverse |filter:search |itemsPerPage:5">
										<td>{{cc.taskId}}</td>
										<td>{{cc.taskSubject}}</td>
										<td>{{cc.taskStartDate | date:'dd-MM-yyyy'}}</td>
										<td>{{cc.taskDueDate | date:'dd-MM-yyyy'}}</td>
										<td>{{cc.taskStatusName}}</td>
										<td>{{cc.conFirstname}} {{cc.conLastname}}</td>
										<td>
											<div class="col-sm-2 visible-lg-block">
												<div class="btn-group">
													<button type="button" class="btn btn-default btn-flat"
														data-toggle="dropdown" aria-expanded="false">
														<span class="caret"></span> <span class="sr-only">Toggle
															Dropdown</span>
													</button>
													<ul class="dropdown-menu pull-left" role="menu">
														<li><a
															href="${pageContext.request.contextPath}/update-task/{{cc.taskId}}"><i
																class="fa fa-pencil"></i> Edit</a></li>
														<li><a href="#" ng-click="deleteCon(cc.taskId)"><i
																class="fa fa-trash"></i> Delete</a></li>
														<li><a href="#"><i class="fa fa-eye"></i> View</a></li>
													</ul>
												</div>
											</div>
	
											<div
												class="visible-xs-block visible-sm-block visible-md-block">
												<div class="btn-group">
													<button type="button" class="btn btn-default btn-flat"
														data-toggle="dropdown" aria-expanded="false">
														<span class="caret"></span> <span class="sr-only">Toggle
															Dropdown</span>
													</button>
													<ul class="dropdown-menu pull-right" role="menu">
														<li><a
															href="${pageContext.request.contextPath}/update-task/{{cc.taskId}}"><i
																class="fa fa-pencil"></i> Edit</a></li>
														<li><a href="#" ng-click="deleteCon(cc.taskId)"><i
																class="fa fa-trash"></i> Delete</a></li>
														<li><a href="#"><i class="fa fa-eye"></i> View</a></li>
													</ul>
												</div>
											</div>
	
										</td>
									</tr>
								</table>
							</div>
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
			<!-- /.box-body -->
			<div class="box-footer"></div>
			<!-- /.box-footer-->
		</div>
		<!-- /.box -->
	</section>
	<!-- /.content -->
</div>
<!-- /.content-wrapper -->
<jsp:include page="${request.contextPath}/footer"></jsp:include>

