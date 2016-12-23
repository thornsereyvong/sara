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
var app = angular.module('competitor', ['angularUtils.directives.dirPagination','angular-loading-bar', 'ngAnimate']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = false;
}]);
var self = this;
app.controller('competitorController',['$scope','$http',function($scope, $http){
	$scope.listCompetitors = function(){
		$http.get("${pageContext.request.contextPath}/hbu/competitor/list").success(function(response){
				$scope.competitors = response.COMPETITORS;
			});
		};

	$scope.listItems = function(){
		$http.get("${pageContext.request.contextPath}/hbu/competitor/startup").success(function(response){
				$scope.items = response.ITEMS;
			});
		};

	$scope.findCompetitorById = function(comId){
			$http.get("${pageContext.request.contextPath}/hbu/competitor/view/"+comId).success(function(response){
				$scope.competitor = response.COMPETITOR;
				$("#btn-add-competitor").click();
				$("#tCompetitor").text("Update Competitor");
				$("#comId").val($scope.competitor.comId);
				$("#comName").val($scope.competitor.comName);
				$("#comAddress").val($scope.competitor.comAddress);
				$("#btnCompetitorSave").text("Update");
			});
		};
	
	$scope.sort = function(keyname){
	    $scope.sortKey = keyname;   //set the sortKey to the param passed
	    $scope.reverse = !$scope.reverse; //if true make it false and vice versa
	};

	$scope.cancelAddCompetitor = function(){
		$('#frmCompetitor').bootstrapValidator('resetForm', true);
		$('#comName').val("");
		$("#comAddress").val("");
	};
	
	$scope.deleteCompetitor = function(comId){
		var str = '<%=roleDelete%>';
		if(str == "YES"){
			swal({   
				title: "<span style='font-size: 25px;'>You are about to delete task with ID: <span class='color_msg'>"+comId+"</span>.</span>",   
				text: "Click OK to continue or CANCEL to abort.",   
				type: "info", 
				html: true,
				showCancelButton: true,   
				closeOnConfirm: false,   
				showLoaderOnConfirm: true, 
			}, function(){   
				setTimeout(function(){			
					$.ajax({ 
			    		url: "${pageContext.request.contextPath}/hbu/competitor/remove/"+comId,
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
			    					$scope.listCompetitors();
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

<script>
	$(document).ready(function() {
		$('.table-responsive').on('show.bs.dropdown', function () {
		     $('.table-responsive').css( "overflow", "inherit" );
		});
	
		$('.table-responsive').on('hide.bs.dropdown', function () {
		     $('.table-responsive').css( "overflow", "auto" );
		});

		$("#btn-create").click(function(){
			$("#tCompetitor").text("Create Competitor");
			$("#btnCompetitorSave").text("Save");
			angular.element(document.getElementById('competitorController')).scope().cancelAddCompetitor();
			$("#btn-add-competitor").click();
		});

		$('#btnCompetitorSave').click(function(){
			$("#frmCompetitor").submit();
		});

		$('#frmCompetitor').bootstrapValidator({
			message: 'This value is not valid',
			feedbackIcons: {
				valid: 'glyphicon glyphicon-ok',
				invalid: 'glyphicon glyphicon-remove',
				validating: 'glyphicon glyphicon-refresh'
			},
			fields: {
				comName: {
					validators: {
						notEmpty: {
							message: 'The Competitor name is required and can not be empty!'
						},
						stringLength: {
							max: 255,
							message: 'The Subject must be less than 255 characters long.'
						}
					}
				},
				product: {
					validators: {
						notEmpty: {
							message: 'The product is required and can not be empty!'
						}
					}
				}
			}
		}).on('success.form.bv', function(e) {
			if($("#btnCompetitorSave").text() === "Save"){		
			swal({   
				title: "<span style='font-size: 25px;'>You are about to create competitor.</span>",
				text: "Click OK to continue or CANCEL to abort.",
				type: "info",
				html: true,
				showCancelButton: true,
				closeOnConfirm: false,
				showLoaderOnConfirm: true,		
			}, function(){ 
				setTimeout(function(){
					/* var items = [];
					$.each($("#product").val(), function(i, item){
						items.push({"itemId":item});
					}); */
						$.ajax({ 
							url : "${pageContext.request.contextPath}/hbu/competitor/add",
							type : "POST",
							data : JSON.stringify({
								  "comName": getValueStringById("comName"),
							      /* "items": items, */
							      "comAddress": getValueStringById("comAddress"),
							      "comCreateBy":"${SESSION}"
							}),
							beforeSend: function(xhr) {
							    xhr.setRequestHeader("Accept", "application/json");
							    xhr.setRequestHeader("Content-Type", "application/json");
						    }, 
						    success: function(result){	
							    
								if(result.MESSAGE == "INSERTED"){						
									$('#comName').val("");
									$("#comAddress").val("");
									$('#frmCompetitor').bootstrapValidator('resetForm', true);
									angular.element(document.getElementById('competitorController')).scope().listCompetitors();
									swal({
			    						title: "SUCCESSFUL",
			    					  	text: result.MSG,
			    					  	html: true,
			    					  	timer: 2000,
			    					  	type: "success"
			    					});
								}else{
									swal("UNSUCCESSFUL", result.MSG, "error");
								}
							},
				    		error:function(){
				    			alertMsgErrorSweet();
				    		} 
						});
				}, 500);
			});
		}else{
				swal({   
					title: "<span style='font-size: 25px;'>You are about to update competitor.</span>",
					text: "Click OK to continue or CANCEL to abort.",
					type: "info",
					html: true,
					showCancelButton: true,
					closeOnConfirm: false,
					showLoaderOnConfirm: true,		
				}, function(){ 
					setTimeout(function(){
						/* var items = [];
						$.each($("#product").val(), function(i, item){
							items.push({"itemId":item});
						}); */
							$.ajax({ 
								url : "${pageContext.request.contextPath}/hbu/competitor/edit",
								type : "PUT",
								data : JSON.stringify({
									  "comId" : getValueStringById("comId"),
									  "comName": getValueStringById("comName"),
								      /* "items": items, */
								      "comAddress": getValueStringById("comAddress"),
								      "comModifiedBy":"${SESSION}"
								}),
								beforeSend: function(xhr) {
								    xhr.setRequestHeader("Accept", "application/json");
								    xhr.setRequestHeader("Content-Type", "application/json");
							    }, 
							    success: function(result){	
								    
									if(result.MESSAGE == "UPDATED"){						
										angular.element(document.getElementById('competitorController')).scope().listCompetitors();
										swal({
				    						title: "SUCCESSFUL",
				    					  	text: result.MSG,
				    					  	html: true,
				    					  	timer: 2000,
				    					  	type: "success"
				    					});
										$("#frmCompetitor").modal('toggle');
									}else{
										swal({
				    						title: "UNSUCCESSFUL",
				    					  	text: result.MSG,
				    					  	html: true,
				    					  	timer: 2000,
				    					  	type: "error"
				    					});
									}
								},
					    		error:function(){
					    			alertMsgErrorSweet();
					    		} 
							});
					}, 500);
				});
			}	 
		});	
		
	}); 
</script>

<div class="content-wrapper" ng-app="competitor" id="competitorController" ng-controller="competitorController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Competitors</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"><i class="fa fa-dashboard"></i>Competitors</a></li>
		</ol>
	</section>

	<section class="content">

		<!-- Default box -->
		<div class="box box-danger">
			<div class="box-header with-border">
				<div style="background: #fff; margin-top: 15px;">
					<div class="col-sm-12">
						<a class="btn btn-info btn-app" id = "btn-create"><i class="fa fa-plus" aria-hidden="true"></i> Create</a> 
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
								<table class="table table-hover" data-ng-init="listCompetitors()">
									<tr>
										<th style="cursor: pointer;" ng-click="sort('comId')">ID <span class="glyphicon sort-icon"
											ng-show="sortKey=='comId'"
											ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
										</th>
										<th style="cursor: pointer;" ng-click="sort('comName')">Competitor
											<span class="glyphicon sort-icon"
											ng-show="sortKey=='comName'"
											ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
										</th>
										<th style="cursor: pointer;" ng-click="sort('comAddress')">Address<span class="glyphicon sort-icon"
											ng-show="sortKey=='comAddress'"
											ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
										</th>
										<!-- <th style="cursor: pointer;" ng-click="sort('')">Items <span class="glyphicon sort-icon"
											ng-show="sortKey=='taskDueDate'"
											ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
										</th> -->
	
										<th style="cursor: pointer;" ng-click="sort('comCreateBy')">Create By
											<span class="glyphicon sort-icon"
											ng-show="sortKey=='comCreateBy'"
											ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
										</th>
	
										<th>Action</th>
									</tr>
									<tr dir-paginate="com in competitors |orderBy:sortKey:reverse |filter:search |itemsPerPage:5" class="ng-cloak">
										<td>{{com.comId}}</td>
										<td>{{com.comName}}</td>
										<td>{{com.comAddress}}</td>
										<!-- <td><span ng-repeat = "item in com.items">[{{item.itemId}}] {{item.itemName}}<br/></span></td> -->
										<td>{{com.comCreateBy}}</td>
										<td>
											<div class="col-sm-2">
												<div class="btn-group">
							                      <button type="button" class="btn btn-default dropdown-toggle btn-sm" data-toggle="dropdown" aria-expanded="false">
							                        <span class="caret"></span>
							                        <span class="sr-only">Toggle Dropdown</span>
							                      </button>
							                      <ul class="dropdown-menu" role="menu">
							                       <li><a href="#" ng-click="findCompetitorById(com.comId)"><i
															class="fa fa-pencil"></i> Edit</a></li>
													<li><a href="#" ng-click="deleteCompetitor(com.comId)"><i
															class="fa fa-trash"></i> Delete</a></li>
													<%-- <li><a href="${pageContext.request.contextPath}/view-competitor/{{com.comId}}"><i class="fa fa-eye"></i> View</a></li> --%>
							                      </ul>
							                    </div>
						                   	</div>	
										</td>
									</tr>
								</table>
							</div>
							<dir-pagination-controls
						       max-size="5"
						       direction-links="true"
						       boundary-links="true" >
							</dir-pagination-controls>
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
				<input type="hidden" id="btn-add-competitor" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#frmCompetitor" />
				<div ng-controller="competitorController" class="modal fade modal-default" id="frmCompetitor" role="dialog">
					<div class="modal-dialog  modal-lg" data-ng-init="">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" ng-click="cancelAddCompetitor()" class="close"
									data-dismiss="modal">&times;</button>
								<h4 class="modal-title">
									<b  id="tCompetitor">Create Competitor</b>
								</h4>
							</div>
							<div class="modal-body">
								<div class="row">
									<form id="frmAddCompetitor">
										<div class="col-md-12">
											<input type="hidden" name="comId" id="comId">
											<div class="col-md-12">
												<div class="form-group">
													<label>Competitor <span class="requrie">(Required)</span></label>
													<input id="comName" name="comName" class="form-control" type="text" placeholder="Competitor Name" ng-model="comName" >
												</div>
											</div>
											<!-- <div class="clearfix"></div>
											<div class="col-md-12">
												<div class="form-group">
													<label>Products <span class="requrie">(Required)</span></label>
													<select class="form-control select2" multiple name="product" id="product" style="width: 100%;">
														<option value="">-- SELECT Products --</option>
														<option ng-repeat="item in items" value="{{item.itemId}}">[{{item.itemId}}] {{item.itemName}}</option>
													</select>
												</div>
											</div> -->
											<div class="clearfix"></div>
											<div class="col-md-12">
												<div class="form-group">
													<label>Address </label>
													<textarea rows="5" cols="" name="comAddress" id="comAddress" class="form-control" ng-model="comAddress"></textarea>
												</div>
											</div>
										</div>
									</form>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" id="btnCancel"
									ng-click="cancelAddCompetitor()" name="btnCancel"
									class="btn btn-danger" data-dismiss="modal">Cancel</button>
								&nbsp;&nbsp;
								<button type="button" class="btn btn-primary pull-right"
									id="btnCompetitorSave" name="btnCompetitorSave">Save</button>
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
<jsp:include page="${request.contextPath}/footer"></jsp:include>

