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
	$scope.listOpportunity = function(){
		$http.get("${pageContext.request.contextPath}/opportunity/list").success(function(response){
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
     	            		$scope.listOpportunity();
     	            		window.location.href = "${pageContext.request.contextPath}/view-opportunity";
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
		<h1>Opportunity</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>Opportunity</a></li>
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
				 	<a href="${pageContext.request.contextPath}/create-opportunity" class="btn btn-info btn-app" ><i class="fa fa-plus" aria-hidden="true"></i> Create</a>
				 	<a href="${pageContext.request.contextPath}/list-opportunity" class="btn btn-info btn-app" ><i class="fa fa-clone"	aria-hidden="true"></i> View</a>
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
  				
				
				  <div class="clearfix"></div>
			<div class="tablecontainer table-responsive" data-ng-init="listOpportunity()" > 
				<div dir-paginate="cc in opportunity |orderBy:sortKey:reverse |filter:search |itemsPerPage:1">
				<div class="col-sm-8 form-group">
						<a href="${pageContext.request.contextPath}/update-opportunity/{{cc.opId}}" class="btn btn-success custom-width"><i class="fa fa-pencil" aria-hidden="true"></i> Edit</a>
						<button type="button" ng-click="deleteOpp(cc.opId)" class="btn btn-danger custom-width"><i class="fa fa-times" aria-hidden="true"></i> Delete</button>
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
				   		 <li role="presentation" class="active"><a href="#home" aria-controls="pro" role="tab" data-toggle="tab">Overview</a></li>
				   		 <li role="presentation" ><a href="#other" aria-controls="other" role="tab" data-toggle="tab">Other</a></li>
				  	 </ul>
				
				  <!-- Tab panes -->
				  
				  <div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="home">
				    	<div class="col-sm-6">
								<table class="table table-hover">
									<tr>
										<td width="200px"><i class="fa fa-check-square-o icon_color" aria-hidden="true"></i>Opportunity ID</td>
										<td>{{cc.opId}}</td>
									</tr>
									<tr>
										<td><i class="fa fa-check-square-o icon_color" aria-hidden="true"></i>Name </td>
										<td>{{cc.opName}}</td>
									</tr>
									<tr>
										<td><i class="fa fa-check-square-o icon_color" aria-hidden="true"></i> Customer</td>
										<td>{{cc.custName}}</td>
									</tr>
									<tr>
										<td><i class="fa fa-check-square-o icon_color" aria-hidden="true"></i> CloseDate</td>
										<td>{{cc.opCloseDate}}</td>
									</tr>
									<tr>
										<td><i class="fa fa-check-square-o icon_color" aria-hidden="true"></i> Probability</td>
										<td>{{cc.opProbability}}</td>
									</tr>
									
									<tr>
										<td><i class="fa fa-check-square-o icon_color" aria-hidden="true"></i> Description</td>
										<td>{{cc.opDes}}</td>
									</tr>
									
								</table>
							</div>
							
							<div class="col-sm-6">
								<table class="table table-hover">
									<tr>
										<td width="200px"><i class="fa fa-check-square-o icon_color" aria-hidden="true"></i> Type </td>
										<td>{{cc.otName}}</td>
									</tr>
									<tr>
										<td><i class="fa fa-check-square-o icon_color" aria-hidden="true"></i> Stage</td>
										<td>{{cc.osName}}</td>
									</tr>
									<tr>
										<td><i class="fa fa-check-square-o icon_color" aria-hidden="true"></i> Lead Source</td>
										<td>{{cc.sourceName}}</td>
									</tr>
									<tr>
										<td><i class="fa fa-check-square-o icon_color" aria-hidden="true"></i> NextStep</td>
										<td>{{cc.opNextStep}}</td>
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
												<td>{{cc.opCreateDate | date:'dd-MM-yyyy'}} By {{cc.opCreateBy}}</td>
											</tr>
											<tr>
												<td><i class="fa fa-check-square-o icon_color" aria-hidden="true"></i> Modify Date </td>
												<td>{{cc.opModifyDate | date:'dd-MM-yyyy'}} By {{cc.opModifyBy}}</td>
											</tr>
										</table>
									</div>
						
				    </div>
				    
				  </div>
				  
				  
				  
					
			  		  <!--close  -->
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

