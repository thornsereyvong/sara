<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>

<% String roleList = (String)request.getAttribute("role_list"); %>
<% String roleDelete = (String)request.getAttribute("role_delete"); %>

<script type="text/javascript">

var app = angular.module('article', ['angularUtils.directives.dirPagination','angular-loading-bar', 'ngAnimate']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = false;
}]);
var self = this;
app.controller('articleController',['$scope','$http',function($scope, $http){
	$scope.listArticle = function(){
		$http.get("${pageContext.request.contextPath}/article/list").success(function(response){
			$scope.article = response.DATA;				
		});
	};
	
	$scope.sort = function(keyname){
	    $scope.sortKey = keyname;   //set the sortKey to the param passed
	    $scope.reverse = !$scope.reverse; //if true make it false and vice versa
	};
	
	
	$scope.deleteArticle = function(articleId){
		var str = '<%=roleDelete%>';
		if(str == "YES"){
			swal({   
				title: "<span style='font-size: 25px;'>You are about to delete campaign with ID: <span class='color_msg'>"+articleId+"</span>.</span>",   
				text: "Click OK to continue or CANCEL to abort.",   
				type: "info", 
				html: true,
				showCancelButton: true,   
				closeOnConfirm: false,   
				showLoaderOnConfirm: true, 
				
			}, function(){   
				setTimeout(function(){			
					$.ajax({ 
			    		url: "${pageContext.request.contextPath}/article/remove/"+articleId,
			    		method: "POST",
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
			    					showConfirmButton: false
			    				});
			    				  
			    				setTimeout(function(){		
			    					$scope.listArticle();
			    				},2000);
			    			}else{
			    				swal("UNSUCCESSFUL", result.MSG, "error");
			    			}
			    		},
			    		error:function(){
			    			swal("UNSUCCESSFUL", "Please try again!", "error");
			    		}		    	    
			    	});
				}, 500);
			});	
		}else{
			alertMsgNoPermision();
		}
		
		
	}; 
	
}]);

</script>

<div class="content-wrapper" ng-app="article" ng-controller="articleController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Knowledge Base Articles</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"><i class="fa fa-dashboard"></i>Knowledge Base Articles</a></li>
		</ol>
	</section>

	<section class="content">

		<!-- Default box -->
		
		<div class="box box-danger">
			<div class="box-header with-border">
				<div style="background: #fff;margin-top: 15px;">
				 <div class="col-sm-12">
				 	<a href="${pageContext.request.contextPath}/create-article" class="btn btn-info btn-app" ><i class="fa fa-plus" aria-hidden="true"></i> Create</a>
				 	
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
			<div class="tablecontainer table-responsive" data-ng-init="listArticle()" > 
				<%				
				  // if(roleList.equals("YES")){
				%>
				
					<table class="table table-hover" >
						<tr>
							<th style="cursor: pointer;" ng-click="sort('articleId')">Article ID
								<span class="glyphicon sort-icon" ng-show="sortKey=='articleId'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('atricleTitle')">Subject
								<span class="glyphicon sort-icon" ng-show="sortKey=='atricleTitle'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							
							<th style="cursor: pointer;" ng-click="sort('itemName')">Product
								<span class="glyphicon sort-icon" ng-show="sortKey=='itemName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('convertCreateDate')">Create Date
								<span class="glyphicon sort-icon" ng-show="sortKey=='convertCreateDate'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('articleCreateBy')">Create By
								<span class="glyphicon sort-icon" ng-show="sortKey=='articleCreateBy'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
											
							<th>Action</th>
						</tr>

						<tr dir-paginate="art in article |orderBy:sortKey:reverse |filter:search |itemsPerPage:5" class="ng-cloak">
							<td>{{art.articleId}}</td>
							<td>{{art.articleTitle}}</td>
							<td>[{{art.item.itemId}}] {{art.item.itemName}}</td>
							<td>{{art.convertCreateDate}}</td>
							<td>{{art.articleCreateBy}}</td>	
							<td>
								<div class="col-sm-2">
									<div class="btn-group">
				                      <button type="button" class="btn btn-default btn-flat btn-sm" data-toggle="dropdown" aria-expanded="false">
				                        <span class="caret"></span>
				                        <span class="sr-only">Toggle Dropdown</span>
				                      </button>
				                      <ul class="dropdown-menu" role="menu">
				                        <li><a href="${pageContext.request.contextPath}/update-article/{{art.articleId}}"><i class="fa fa-pencil"></i> Edit</a></li>
				                        <li><a href="#" ng-click="deleteArticle(art.articleId)"><i class="fa fa-trash"></i> Delete</a></li>
				                        <li><a href="${pageContext.request.contextPath}/view-article/{{art.articleId}}"><i class="fa fa-eye"></i> View</a></li>
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
					
				<%	   
				  // }else{
					   
				%>
					<!-- <div class="alert alert-warning" role="alert"><i class="glyphicon glyphicon-cog"></i> You don't have permission list data</div> -->
				<%
				 //  }
				
				%>
				
				

			  </div>
		</div>
			</div>
			<!-- /.box-body -->
			<div class="box-footer"></div>
			<div id="errors"></div>
			<!-- /.box-footer-->
		</div>
		
		<!-- /.box -->


	</section>
	<!-- /.content -->


</div>

<!-- /.content-wrapper -->
				


<!-- /.content-wrapper -->





<jsp:include page="${request.contextPath}/footer"></jsp:include>

				