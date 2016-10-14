<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>
<script type="text/javascript">

var app = angular.module('objApp', ['angularUtils.directives.dirPagination']);
var self = this;
app.controller('objController',['$scope','$http',function($scope, $http){
	
	
	$scope.searchBtnClick = function(){		
		swal({   
			title: "Ajax request example",   
			text: "Submit to run ajax request",   
			type: "info",   
			showCancelButton: true,   
			closeOnConfirm: false,   
			showLoaderOnConfirm: true, 
		}, function(){   
						
			setTimeout(function(){     
				$http.get("${pageContext.request.contextPath}/campaign/list").success(function(response){
					$scope.campaigns = response.DATA;
					dis($scope.campaigns)
					swal("Ajax request finished!");   
				});   
			}, 2000);
			
			
			
		});	
	}	
}]);

</script>
<div class="content-wrapper" ng-app="objApp" ng-controller="objController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Top Campaign</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"> Top Campaign</a></li>
		</ol>
	</section>

	<section class="content">
		
		<div class="row">
			<div class="col-md-12">
				<div class="box box-primary">	
					<div class="box-header with-border">
		        		<h3 class="box-title">Filter</h3>
		              	<div class="box-tools pull-right">
		               		<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
		               	</div>
		          	</div>
					<div class="box-body">
						<form method="post" id="frmFilter">	
							<div class="row">
								<div class="col-sm-12">
									
								</div>								
							</div>
						</form>
					</div>
					<div class="box-footer">						
						<button ng-click="searchBtnClick()" type="button" name="btnPrint" id="btnPrint" class="btn btn-default">
							<i class="fa fa-print"></i> &nbsp;Print
						</button>						
						<button ng-click="searchBtnClick()" type="button" name="btnsearch" id="btnsearch" class="btn btn-info pull-right">
							<i class="fa fa-search"></i> &nbsp;Search
						</button>
					</div>
				</div>
			</div>
			<div id="errors"></div>
		</div>
	
		
				
	</section>
</div>
<jsp:include page="${request.contextPath}/footer"></jsp:include>

