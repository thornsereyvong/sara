<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>
	<script type="text/javascript">

var app = angular.module('quoteApp', ['angularUtils.directives.dirPagination','angular-loading-bar', 'ngAnimate']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = false;
}]);
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

	$scope.pageSize = {};

	$scope.pageSize.rows = [ 
					{ value: "5", label: "5" },
    				{ value: "10", label: "10" },
            		{ value: "15", label: "15" },
            		{ value: "20", label: "20" },
            		{ value: "25", label: "25" },
            		{ value: "30", label: "30" },
            		];
	$scope.pageSize.row = $scope.pageSize.rows[1].value;
	
	$scope.deleteQuote = function(quoteId){ 
		swal({   
			title: "<span style='font-size: 25px;'>You are about to delete quotation with ID: <span class='color_msg'>"+quoteId+"</span>.</span>",   
			text: "Click OK to continue or CANCEL to abort.",   
			type: "info", 
			html: true,
			showCancelButton: true,   
			closeOnConfirm: false,   
			showLoaderOnConfirm: true, 
			
		}, function(){   
			setTimeout(function(){			
				$.ajax({ 
		    		url: "${pageContext.request.contextPath}/quote/delete-quote/"+quoteId,
		    		method: "DELETE",
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
		    					$scope.listQuote();
		    				},2000);
		    			}else{
		    				swal("Unsuccessful!", result.MSG, "error");
		    			}
		    		},
		    		error:function(){
		    			swal("Unsuccessful!", "Please try again!", "error");
		    		}		    	    
		    	});
			}, 500);
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
				<div style="background: #fff; margin-top:15px;">
					 <div class="col-sm-12" style="margin-left: -5px;">
					 	<a href="${pageContext.request.contextPath}/quote/add" class="btn btn-info btn-app" ><i class="fa fa-plus" aria-hidden="true"></i> Create</a>					 	
					 </div>
				</div>
			</div>
			
			<div class="box-body" style="background: url(${pageContext.request.contextPath}/resources/images/boxed-bg.jpg);padding-top:30px;">
				<div class="clearfix"></div>
				<div class="panel panel-default iPanel">
	  				<div class="panel-body">
	  					<div class="row">
		  					<div class="col-xs-9 col-sm-6 col-md-4 col-lg-4">
							  	<form class="form-inline">
							        <div class="form-group">
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
							<div class="col-xs-3 col-sm-2 col-sm-offset-4 col-md-offset-6 col-lg-2 col-lg-offset-6">
							  	<form class="form-inline">
							        <div class="form-group" style="float: right;">
							        	<div class="input-group">
							        		<select class="form-control" ng-model="pageSize.row" id ="row" ng-options="obj.value as obj.label for obj in pageSize.rows"></select>
							        	</div>
							        </div>
							    </form>
							    <br/>
							</div>
						</div>
						<div class="clearfix"></div>
						<div class="col-xs-12 col-sm-12 col-md-12">
							<div class="row">
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
															
											<th class="text-center">Action</th>
										</tr>
				
										<tr dir-paginate="qq in quotation |orderBy:sortKey:reverse |filter:search |itemsPerPage:pageSize.row" class="ng-cloak">
											<td>{{qq.saleId}}</td>
											<td ng-if="qq.saleReference == null">-</td>
											<td ng-if="qq.saleReference != null">{{qq.saleReference}}</td>
											<td>{{qq.saleDate | date:'dd-MMM-yyyy'}}</td>
											<td>[{{qq.custId}}] {{qq.custName}}</td>
											<td ng-if="qq.empId == null">-</td>
											<td ng-if="qq.empId != null">[{{qq.empId}}] {{qq.empName}}</td>
											<td class="dis-number">$ {{qq.netTotalAmt | number:2}}</td>	
											<td>{{qq.PostStatus}}</td>	
											<td class="text-center" style="min-width: 100px;">
												<a ng-if="qq.PostStatus != 'Converted'" href="${pageContext.request.contextPath}/quote/edit/{{qq.saleId}}"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="edit"><i class="fa fa-pencil text-primary"></i></button></a>
												<a ng-if="qq.PostStatus != 'Converted'" href="#" ng-click="deleteQuote(qq.saleId)"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="delete"><i class="fa fa-trash text-danger"></i></button></a>
											</td>
										</tr>
										<tr>
											<td colspan="8" class="pull-rigth">
												 <dir-pagination-controls
											       max-size="pageSize.row"
											       direction-links="true"
											       boundary-links="true" >
											    </dir-pagination-controls> 
											</td>
										</tr>
									</table>
								</div>	
							</div>
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