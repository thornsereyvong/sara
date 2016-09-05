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
	$scope.listLeads = function(username){
		/* $http.get("${pageContext.request.contextPath}/lead/list").success(function(response){
				$scope.leads = response.DATA;
			});
		} ; */
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
	
	
	$scope.deleteLead = function(leadID){
		SweetAlert.swal({
            title: "Are you sure?", //Bold text
            text: "This Lead will not be able to recover!", //light text
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
            		 $http.delete("${pageContext.request.contextPath}/lead/remove/"+leadID)
     	            .success(function(){
     	            		SweetAlert.swal({
     			            		title:"Deleted",
     			            		text:"Lead have been deleted!",
     			            		type:"success",  
     			            		timer: 2000,   
     			            		showConfirmButton: false
     	            		});
     	            		$scope.listLeads();
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
	                text:"This Lead is safe!",
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
		<h1>Leads</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>Leads</a></li>
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
					<hr style="margin-bottom: 5px;margin-top: 8px;" />
				 </div> 
				<div style="background: #fff;margin-top: 15px;">
				 <div class="col-sm-12">
				 	<a href="${pageContext.request.contextPath}/create-lead" class="btn btn-info btn-app" ><i class="fa fa-plus" aria-hidden="true"></i> Create</a>
				 	<a href="${pageContext.request.contextPath}/view-leads" class="btn btn-info btn-app" ><i class="fa fa-clone"	aria-hidden="true"></i> View</a>
				 </div>
				 
				  
				  <div class="col-sm-12">
					<hr style="margin-bottom: 0;margin-top: 0px;" />
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
			<div class="tablecontainer table-responsive" data-ng-init="listLeads('${SESSION}')" > 
				<%
					
				if(roleList.equals("YES")){
				%>
					<table class="table table-hover" >
						<tr>
							<th style="cursor: pointer;" ng-click="sort('leadID')">Lead ID
								<span class="glyphicon sort-icon" ng-show="sortKey=='campID'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('salutation')">Lead Name
								<span class="glyphicon sort-icon" ng-show="sortKey=='campName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('statusName')">Status
								<span class="glyphicon sort-icon" ng-show="sortKey=='statusName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('accountName')">Account Name
								<span class="glyphicon sort-icon" ng-show="sortKey=='type.typeName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('email')">Email
								<span class="glyphicon sort-icon" ng-show="sortKey=='startDate'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('createDate')">Date Create
								<span class="glyphicon sort-icon" ng-show="sortKey=='endDate'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
											
							<th>Action</th>
						</tr>

						<tr dir-paginate="cc in leads |orderBy:sortKey:reverse |filter:search |itemsPerPage:5">
							<td>{{cc.leadID}}</td>
							<td>{{cc.salutation}} {{cc.firstName}} {{cc.lastName}}</td>
							<td>{{cc.statusName}}</td>
							<td>{{cc.accountName}}</td>
							<td>{{cc.email}}</td>
							<td>{{cc.createDate | date:'dd-MM-yyyy'}}</td>	
							<td>
								<a href="${pageContext.request.contextPath}/update-lead/{{cc.leadID}}" class="btn btn-success custom-width"><i class="fa fa-pencil" aria-hidden="true"></i> Edit</a>
								<button type="button" ng-click="deleteLead(cc.leadID)" class="btn btn-danger custom-width"><i class="fa fa-times" aria-hidden="true"></i> Delete</button>
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

