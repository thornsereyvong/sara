<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>
	<script type="text/javascript">

var app = angular.module('saleOrderApp', ['angularUtils.directives.dirPagination','oitozero.ngSweetAlert']);
var self = this;
app.controller('saleOrderController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){
	$scope.listSaleOrder = function(){
		$http.get("${pageContext.request.contextPath}/sale-order/list-all-sale-order").success(function(response){			
			$scope.saleOrder = response.DATA;			
			});
		} ;
	
	$scope.sort = function(keyname){
	    $scope.sortKey = keyname;   //set the sortKey to the param passed
	    $scope.reverse = !$scope.reverse; //if true make it false and vice versa
	};
	
	$scope.deleteSaleOder = function(saleId){
		SweetAlert.swal({
            title: "", //Bold text
            text: "Are you sure you want to delete the sale order: "+saleId+" from the system?", //light text
            type: "warning", //type -- adds appropiriate icon
            showCancelButton: true, // displays cancel btton
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Yes",
            closeOnConfirm: false, //do not close popup after click on confirm, usefull when you want to display a subsequent popup
            closeOnCancel: false
        }, 
        function(isConfirm){ //Function that triggers on user action.
	            var str = 'YES';
	        	
	            if(isConfirm){
	            	if(str == "YES"){
	            		$http.delete("${pageContext.request.contextPath}/sale-order/delete-sale-order/"+saleId)
	    	            .success(function(data){
	    	            		if(data.MESSAGE == "DELETED"){
	    	            			SweetAlert.swal({
	    			            		title:"Deleted",
	    			            		text:"The sale order:"+saleId+" was successfully deleted!",
	    			            		type:"success",  
	    			            		timer: 2000,   
	    			            		showConfirmButton: false
		    	            		});
	    	            			$scope.listSaleOrder();
	    	            		}else{
	    	            			SweetAlert.swal({
	    				                title:"Unsuccessfully",
	    				                text:"data.MESSAGE",
	    				                type:"error",
	    				                timer:2000,
	    				                showConfirmButton: false});
	    	            		}
	    	            	
	    	            		
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
	                text:"This sale order is safe!",
	                type:"error",
	                timer:2000,
	                showConfirmButton: false});
            }
        });
	};
	
}]);

</script>

<div class="content-wrapper" ng-app="saleOrderApp" ng-controller="saleOrderController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>List Sale Order</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>List Sale Order</a></li>
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
				 	<a href="${pageContext.request.contextPath}/sale-order/add" class="btn btn-info btn-app" ><i class="fa fa-plus" aria-hidden="true"></i> Create</a>
				 	<a href="${pageContext.request.contextPath}/view-customers" class="btn btn-info btn-app" ><i class="fa fa-clone" aria-hidden="true"></i> View</a>
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
			<div class="tablecontainer table-responsive" data-ng-init="listSaleOrder()" > 
				
					<table class="table table-hover" >
						<tr>
							<th style="cursor: pointer;" ng-click="sort('saleId')">Entry No
								<span class="glyphicon sort-icon" ng-show="sortKey=='saleId'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('saleReference')">Reference
								<span class="glyphicon sort-icon" ng-show="sortKey=='saleReference'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('saleDate')">Sale Date
								<span class="glyphicon sort-icon" ng-show="sortKey=='saleDate'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('custId')">Customer ID
								<span class="glyphicon sort-icon" ng-show="sortKey=='custId'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('custName')">Customer Name
								<span class="glyphicon sort-icon" ng-show="sortKey=='custName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('totalAmt')">Total Amount
								<span class="glyphicon sort-icon" ng-show="sortKey=='totalAmt'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('pmtStatus')">Payment Status
								<span class="glyphicon sort-icon" ng-show="sortKey=='pmtStatus'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('PostStatus')">Post Status
								<span class="glyphicon sort-icon" ng-show="sortKey=='PostStatus'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
											
							<th>Action</th>
						</tr>

						<tr dir-paginate="qq in saleOrder |orderBy:sortKey:reverse |filter:search |itemsPerPage:5">
							<td>{{qq.saleId}}</td>
							<td>{{qq.saleReference}}</td>
							<td>{{qq.saleDate | date:'dd-MMM-yyyy'}}</td>
							<td>{{qq.custId}}</td>
							<td>{{qq.custName}}</td>
							<td>{{qq.totalAmt | number}}</td>	
							<td>{{qq.pmtStatus}}</td>
							<td>{{qq.PostStatus}}</td>	
							<td>
								<a href="${pageContext.request.contextPath}/sale-order/edit/{{qq.saleId}}" class="btn btn-success custom-width"><i class="fa fa-pencil" aria-hidden="true"></i> Edit</a>
								<button type="button" ng-click="deleteSaleOder(qq.saleId)" class="btn btn-danger custom-width"><i class="fa fa-times" aria-hidden="true"></i> Delete</button>
								<a href="${pageContext.request.contextPath}/sale-order/print/{{qq.saleId}}" target="_blank" class="btn btn-info custom-width"><i class="fa  fa-print" aria-hidden="true"></i> Print</a>
								
							</td>
						</tr>
				
				</table>
				
			    <dir-pagination-controls
			       max-size="5"
			       direction-links="true"
			       boundary-links="true" >
			    </dir-pagination-controls> 

				
			    
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

<jsp:include page="${request.contextPath}/footer"></jsp:include>
<script src="${pageContext.request.contextPath}/resources/js.mine/function.mine.js"></script>
<script>