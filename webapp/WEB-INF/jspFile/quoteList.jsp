<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>
	<script type="text/javascript">

var app = angular.module('quoteApp', ['angularUtils.directives.dirPagination']);
var self = this;
app.controller('quoteController',['$scope','$http',function($scope, $http){
	$scope.listQuote = function(){
		$http.get("${pageContext.request.contextPath}/quote/list-all-quote").success(function(response){			
			$scope.quotation = response.DATA;			
		});
	} ;
	
	$scope.sort = function(keyname){
	    $scope.sortKey = keyname;   //set the sortKey to the param passed
	    $scope.reverse = !$scope.reverse; //if true make it false and vice versa
	};
	
	$scope.deleteQuote = function(quoteId){ alert(quoteId)
		swal({
            title: "", //Bold text
            text: "Are you sure you want to delete the quotation: "+quoteId+" from the system?", //light text
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
	            		$http.delete("${pageContext.request.contextPath}/quote/delete-quote/"+quoteId)
	    	            .success(function(data){
	    	            		if(data.MESSAGE == "DELETED"){
	    	            			swal({
	    			            		title:"Deleted",
	    			            		text:"The quotation:"+quoteId+" was successfully deleted!",
	    			            		type:"success",  
	    			            		timer: 2000,   
	    			            		showConfirmButton: false
		    	            		});
		    	            		$scope.listQuote();
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
	                text:"This quotation is safe!",
	                type:"error",
	                timer:2000,
	                showConfirmButton: false});
            }
        });
	};
	
}]);

</script>

<div class="content-wrapper" ng-app="quoteApp" ng-controller="quoteController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Quotations</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"><i class="fa fa-dashboard"></i>Quotations</a></li>
		</ol>
	</section>

	<section class="content">

		<!-- Default box -->
		
		<div class="box box-danger">
			<div class="box-header with-border">
				
				<div style="background: #fff;margin-top: 0px;">
					 <div class="col-sm-12">
					 	<a href="${pageContext.request.contextPath}/quote/add" class="btn btn-info btn-app" ><i class="fa fa-plus" aria-hidden="true"></i> Create</a>					 	
					 </div>
				</div>
			</div>
			
			<div class="box-body" style="background: url(${pageContext.request.contextPath}/resources/images/boxed-bg.jpg);padding:30px;">
				
			 
			<div class="clearfix"></div>

			<div class="panel panel-default iPanel">
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
			<div class="tablecontainer table-responsive" data-ng-init="listQuote()" > 				
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

						<tr dir-paginate="qq in quotation |orderBy:sortKey:reverse |filter:search |itemsPerPage:5">
							<td>{{qq.saleId}}</td>
							<td>{{qq.saleReference}}</td>
							<td>{{qq.saleDate | date:'dd-MMM-yyyy'}}</td>
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
				                        <li ng-if="qq.PostStatus != 'Converted'"><a href="${pageContext.request.contextPath}/quote/edit/{{qq.saleId}}"><i class="fa fa-pencil"></i> Edit</a></li>
				                        <li ng-if="qq.PostStatus != 'Converted'"><a href="#" ng-click="deleteQuote(qq.saleId)"><i class="fa fa-trash"></i> Delete</a></li>
				                        <li><a href="#" ng-click="printQuote(qq.saleId)"><i class="fa fa-print"></i>Print</a></li>
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
			
			<div id="errors"></div>
			
		</div>
	</section>
	<!-- /.content -->
	
</div>

<jsp:include page="${request.contextPath}/footer"></jsp:include>
<script src="${pageContext.request.contextPath}/resources/js.mine/function.mine.js"></script>
<script>