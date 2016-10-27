<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>
	<script type="text/javascript">

var app = angular.module('saleOrderApp', ['angularUtils.directives.dirPagination']);
var self = this;
app.controller('saleOrderController',['$scope','$http',function($scope, $http){
	$scope.listSaleOrder = function(){
		$http.get("${pageContext.request.contextPath}/sale-order/list-all-sale-order").success(function(response){			
			$scope.saleOrder = response.DATA;			
			});
		};
	
	$scope.sort = function(keyname){
	    $scope.sortKey = keyname;   //set the sortKey to the param passed
	    $scope.reverse = !$scope.reverse; //if true make it false and vice versa
	};
	
	$scope.deleteSaleOder = function(saleId){
		swal({
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
	    	            			swal({
	    			            		title:"Deleted",
	    			            		text:"The sale order:"+saleId+" was successfully deleted!",
	    			            		type:"success",  
	    			            		timer: 2000,   
	    			            		showConfirmButton: false
		    	            		});
	    	            			$scope.listSaleOrder();
	    	            		}else{
	    	            			swal({
	    				                title:"Unsuccessfully",
	    				                text:"data.MESSAGE",
	    				                type:"error",
	    				                timer:2000,
	    				                showConfirmButton: false});
	    	            		}
	    	            	
	    	            		
	    		            });
					}else{
						swal({
			                title:"Cancelled",
			                text:"You don't have permission delete!",
			                type:"error",
			                timer:2000,
			                showConfirmButton: false});
					}
	                 
            } else {
                swal({
	                title:"Cancelled",
	                text:"This sale order is safe!",
	                type:"error",
	                timer:2000,
	                showConfirmButton: false});
            }
        });
	};
	$scope.authorizeSaleOder = function(saleId){
		
		swal({
            title: "Authorization",
            text: "",
            imageUrl: "${pageContext.request.contextPath}/resources/images/module/key.svg",
            showCancelButton: true,          
            confirmButtonText: "Approve",
            cancelButtonText: "Cancel",
            closeOnConfirm: false, 
            closeOnCancel: false
        }, 
        function(isConfirm){
        	 if(isConfirm){
        		 $http.get("${pageContext.request.contextPath}/sale-order/status/"+saleId+"/Authorized").success(function(response){			
       				if(response.MESSAGE == 'UPDATED'){
       					swal({
       	            		title:"Authorization",
       	            		text:"The sale order:"+saleId+" was successfully authorized.",
       	            		type:"success",  
       	            		timer: 2000,
       	            		showConfirmButton: false
       	        		});
       	    			$scope.listSaleOrder();
       				}else{
       					alertMsgErrorSweet();
       				}	
    			}).error(function(){
       				alertMsgErrorSweet();
       			});
        	 }else{
        		 swal({
	            		title: "Authorization",
	            		text: "The sale order:"+saleId+" was cancelled.",
	            		type: "error",  
	            		timer: 2000,
	            		showConfirmButton: false
	        		});
        	 }
        });
	
	}
}]);

</script>

<div class="content-wrapper" ng-app="saleOrderApp" ng-controller="saleOrderController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Sale Orders</h1>
		<ol class="breadcrumb">
		<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"><i class="fa fa-dashboard"></i>List Sale Order</a></li>
		</ol>
	</section>

	<section class="content">

		<!-- Default box -->
		
		<div class="box box-danger">
			<div class="box-header with-border">
				<div style="background: #fff;margin-top: 15px;">
					 <div class="col-sm-12">
					 	<a href="${pageContext.request.contextPath}/sale-order/add" class="btn btn-info btn-app" ><i class="fa fa-plus" aria-hidden="true"></i> Create</a>
					 	
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
							
							<th style="cursor: pointer;" ng-click="sort('custName')">Customer
								<span class="glyphicon sort-icon" ng-show="sortKey=='custName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('empName')">Employee
								<span class="glyphicon sort-icon" ng-show="sortKey=='empName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('netTotalAmt')">Total Amount
								<span class="glyphicon sort-icon" ng-show="sortKey=='netTotalAmt'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							
							<th style="cursor: pointer;" ng-click="sort('PostStatus')">Status
								<span class="glyphicon sort-icon" ng-show="sortKey=='PostStatus'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
											
							<th>Action</th>
						</tr>

						<tr dir-paginate="qq in saleOrder |orderBy:sortKey:reverse |filter:search |itemsPerPage:5" class="ng-cloak">
							<td>{{qq.saleId}}</td>
							<td>{{qq.saleReference}}</td>
							<td>{{qq.saleDate | date:'dd-MM-yyyy'}}</td>							
							<td>[{{qq.custId}}] {{qq.custName}}</td>
							<td>[{{qq.empId}}] {{qq.empName}}</td>
							<td class="dis-number">{{qq.netTotalAmt | number:2}}</td>	
							<td>{{qq.PostStatus}}</td>	
							<td>
								
								<div class="col-sm-2">
									<div class="btn-group">
				                      <button type="button" class="btn btn-default btn-flat btn-sm" data-toggle="dropdown" aria-expanded="false">
				                        <span class="caret"></span>
				                        <span class="sr-only">Toggle Dropdown</span>
				                      </button>
				                      <ul class="dropdown-menu" role="menu">
				                        <li ng-if="qq.PostStatus == 'Open'"><a href="${pageContext.request.contextPath}/sale-order/edit/{{qq.saleId}}"><i class="fa fa-pencil"></i> Edit</a></li>
				                        <li ng-if="qq.PostStatus == 'Open'"><a href="#" ng-click="deleteSaleOder(qq.saleId)"><i class="fa fa-trash"></i> Delete</a></li>
				                        <li><a href="#" ng-click="printSaleOder(qq.saleId)"><i class="fa fa-print"></i>Print</a></li>
				                        <li ng-if="qq.PostStatus == 'Open'"><a href="#" ng-click="authorizeSaleOder(qq.saleId)"><i class="fa fa-key"></i>Authorize</a></li>
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

				
			    
			</div>	
				

			  </div>
		</div>
			</div>
			<!-- /.box-body -->
			<div class="box-footer"></div>
			<!-- /.box-footer-->
		</div>
		
		<!-- /.box -->
		<div id="errors"></div>

	</section>
	<!-- /.content -->
	
</div>

<jsp:include page="${request.contextPath}/footer"></jsp:include>
<script src="${pageContext.request.contextPath}/resources/js.mine/function.mine.js"></script>
<script>