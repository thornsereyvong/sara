<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>

<% String roleDelete = (String)request.getAttribute("role_delete"); %>

<script type="text/javascript">
var app = angular.module('campaign', ['angularUtils.directives.dirPagination','oitozero.ngSweetAlert']);
var self = this;
app.controller('campController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){
	$scope.listCase= function(){
		$http.get("${pageContext.request.contextPath}/event/list").success(function(response){
				$scope.cases = response.DATA;
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

//alert($.session.get("parentID"));

</script>
<style>
.icon_color{
color:#2196F3;
}
.pagination {
    display: inline-block;
    padding-left: 0;
    margin: 0px 0px 13px 0px;
    border-radius: 4px;
    margin-buttom:10px;
}
</style>
<div class="content-wrapper" ng-app="campaign" ng-controller="campController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Events</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>Events </a></li>
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
				 	<a href="${pageContext.request.contextPath}/create-event" class="btn btn-info btn-app" ><i class="fa fa-plus" aria-hidden="true"></i> Create</a>
				 	<a href="${pageContext.request.contextPath}/list-events" class="btn btn-info btn-app" ><i class="fa fa-clone"	aria-hidden="true"></i> View</a>	
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
  			
				 
			<div class="tablecontainer table-responsive" data-ng-init="listCase()" > 
				<div dir-paginate="cc in cases |orderBy:sortKey:reverse |filter:search |itemsPerPage:1">
				<div class="col-sm-8 form-group">
						<a href="${pageContext.request.contextPath}/update-event/{{cc.evId}}" class="btn btn-success custom-width"><i class="fa fa-pencil" aria-hidden="true"></i> Edit</a>
						<button type="button" ng-click="deleteCon(cc.evId)" class="btn btn-danger custom-width"><i class="fa fa-times" aria-hidden="true"></i> Delete</button>
				</div>
				<div class="col-sm-4 text-right form-group">
					<dir-pagination-controls 
						max-size="2"
						direction-links="true"
						boundary-links="true"> 
					</dir-pagination-controls>
				</div>
				<div class="clearfix"></div>
				 <!-- Nav tabs -->
				  <ul class="nav nav-tabs" role="tablist">
				    <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">Overview</a></li>
				    <li role="presentation"><a href="#other" aria-controls="profile" role="tab" data-toggle="tab">Other</a></li>
				  </ul>
				
				  <!-- Tab panes -->
				  <div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="home">
				    	<div class="col-sm-6">
								<table class="table table-hover">
									<tr>
										<td width="200px"><i class="fa fa-check-square-o icon_color" aria-hidden="true"></i> Event ID</td>
										<td>{{cc.evId}}</td>
									</tr>
									<tr>
										<td><i class="fa fa-check-square-o icon_color" aria-hidden="true"></i> Event Name</td>
										<td>{{cc.evName}}</td>
									</tr>
									<tr>
										<td><i class="fa fa-check-square-o icon_color" aria-hidden="true"></i> Start Date</td>
										<td>{{cc.evStartDate | date:'dd-MM-yyyy'}}</td>
									</tr>
									<tr>
										<td><i class="fa fa-check-square-o icon_color" aria-hidden="true"></i> 	End Date</td>
										<td>{{cc.evEndDate | date:'dd-MM-yyyy'}}</td>
									</tr>
									<tr>
										<td><i class="fa fa-check-square-o icon_color" aria-hidden="true"></i> Duration</td>
										<td ><span>{{cc.evDuration}}</span></td>
									</tr>
									
								</table>
							</div>
							
							<div class="col-sm-6">
								<table class="table table-hover">
									<tr>
										<td width="200px"><i class="fa fa-check-square-o icon_color" aria-hidden="true"></i> Location</td>
										<td>{{cc.loName}}</td>
									</tr>
									<tr>
										<td><i class="fa fa-check-square-o icon_color" aria-hidden="true"></i>  Budget</td>
										<td>{{cc.evBudget | number:2}}</td>
									</tr>
									
								</table>
							</div>
							
				    </div>
				   
				    <div role="tabpanel" class="tab-pane" id="other">
				    		<div class="col-sm-6">
								<table class="table table-hover">
									<tr>
										<td width="200px"><i class="fa fa-check-square-o icon_color" aria-hidden="true"></i> Assigned To</td>
										<td>{{cc.username}}</td>
									</tr>
									<tr>
										<td width="200px"><i class="fa fa-check-square-o icon_color" aria-hidden="true"></i> Create Date</td>
										<td>{{cc.evCreateDate | date:'dd-MM-yyyy'}} By {{cc.evCreateBy}}</td>
									</tr>
									<tr>
										<td><i class="fa fa-check-square-o icon_color" aria-hidden="true"></i> Modified Date</td>
										<td>{{cc.evModifiedDate | date:'dd-MM-yyyy'}} By {{cc.evModifiedBy}}</td>
									</tr>
									
									
									
								</table>
							</div>
							
						
				    </div>
				    
				  </div>
				  
				  
				  
				</div>
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

