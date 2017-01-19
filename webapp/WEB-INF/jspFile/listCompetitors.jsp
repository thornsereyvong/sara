<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>

<%
	String roleDelete = (String) request.getAttribute("roleDelete");
%>

<script type="text/javascript">
var app = angular.module('competitor', ['angularUtils.directives.dirPagination','angular-loading-bar', 'ngAnimate']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = false;
}]);
var self = this;
app.controller('competitorController',['$scope','$http',function($scope, $http){
	
	$scope.rowNumCompetitor = 1;
	
	$scope.listCompetitors = function(){
		$http.get("${pageContext.request.contextPath}/hbu/competitor/list").success(function(response){
				$scope.competitors = response.COMPETITORS;
				$scope.length = $scope.competitors.length;
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

	$scope.findHBUItemById = function(itemId){
		$http.get("${pageContext.request.contextPath}/item/view/"+itemId).success(function(response){
			$scope.item = response.ITEM;
			/* $.each($scope.item.competitors,function(i, com){
				$("input[name=competitor]:not(:checked)").each(function(){
					if($(this).val() == com.comId){
						$(this).prop('checked',true);
					}
				});
				
			}); */
			
			
			$.each($scope.competitors,function(i, com){
				$scope.competitors[i].meDataSource = false;
				$.each($scope.item.competitors,function(y, c){
					if(c.comId == com.comId){
						$scope.competitors[i].meDataSource = true;
					}
				});
			});
			$scope.competitorsCheck = angular.copy($scope.item.competitors);
			
		});
	}
	
	$scope.sort = function(keyname){
	    $scope.sortKey = keyname;   //set the sortKey to the param passed
	    $scope.reverse = !$scope.reverse; //if true make it false and vice versa
	};

	$scope.cancelAddCompetitor = function(){
		$('#frmCompetitor').bootstrapValidator('resetForm', true);
		$('#comName').val("");
		$("#comAddress").val("");
		$("input[name=competitor]:checked").prop('checked',false);
		$("input[name=check-all]:checked").prop('checked',false);
    	$("#ato_product").select2('val','');
    	$('#frmAddCompetitorToProduct').bootstrapValidator('resetForm', true);
	};
	
	$scope.deleteCompetitor = function(comId){
		var str = '<%=roleDelete%>';
		if(str == "YES"){
			swal({   
				title: "<span style='font-size: 25px;'>You are about to delete Competitor with ID: <span class='color_msg'>"+comId+"</span>.</span>",   
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
			    				$scope.listCompetitors();	    				
			    				swal({
			    					title:"SUCCESSFUL",
			    					text: result.MSG, 
			    					type:"success", 
			    					html: true,
			    					timer: 2000,
			    				});
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
	
	
// competitor add
	
	$scope.addComToPro = function(bool){
		//var proId = getValueStringById("product");		
		$http.get("${pageContext.request.contextPath}/hbu/competitor/list").success(function(response){
			
			$scope.addCompetitors = response.COMPETITORS;
			$scope.rowNumCompetitor = 1;
			/*
			$.each($scope.competitors,function(i, com){
				$scope.competitors[i].meDataSource = false;
				$.each($scope.item.competitors,function(y, c){
					if(c.comId == com.comId){
						$scope.competitors[i].meDataSource = true;
					}
				});
			});
			$scope.competitorsCheck = angular.copy($scope.item.competitors); */
			
			if(bool){
				$("#frmAddCompetitorToProduct").modal('toggle');
			}
		});		
	}
	
	
	
	$scope.competitorIndexSet = function(bool,comId){
		var n = $scope.searchIndexByComId(comId);		
		if(n != false || n==0){
			$scope.competitors[n].meDataSource = bool;			
			if(bool){
				$scope.competitorsCheck.push(angular.copy($scope.competitors[n]));
			}else{
				if($scope.competitorsCheck.length>0){				
					for(var i=0;i<$scope.competitorsCheck.length; i++){
						if(comId == $scope.competitorsCheck[i].comId){
							$scope.competitorsCheck.splice(i, 1);
						}
					}
				}
			}
		}
	}
	
	$scope.searchIndexByComId = function(comId){		
		for(var i=0;i<$scope.competitors.length; i++){
			if(comId == $scope.competitors[i].comId){
				return i;
			}
		}		
		return false;
	}
	
	$scope.btnComAdd = function(){	
		var itemCompetitor =[];
		$.each($scope.competitorsCheck,function(y, c){
			var comObj = {"comId": c.comId, "comName":c.comName};
			itemCompetitor.push(comObj);
		});
		
		swal({   
			title: "<span style='font-size: 25px;'>You are about to save competitor to product.</span>",
			text: "Click OK to continue or CANCEL to abort.",
			type: "info",
			html: true,
			showCancelButton: true,
			closeOnConfirm: false,
			showLoaderOnConfirm: true,		
		}, function(){ 
			setTimeout(function(){
				 $http({
				        method : "POST",
				        url : "${pageContext.request.contextPath}/item/add",
				        data: JSON.stringify({
							  "itemId" : getValueStringById("product"),
							  "competitors": itemCompetitor
						})
				    }).then(function mySucces(result) {
				    	if(result.data.MESSAGE == "INSERTED"){						
							swal({
								title: "SUCCESSFUL",
							  	text: result.data.MSG,
							  	html: true,
							  	timer: 2000,
							  	type: "success"
							});
							$scope.item.competitors = angular.copy($scope.competitorsCheck);
							setTimeout(function(){
								$("#frmAddCompetitorToProduct").modal('toggle');
							}, 2000); 
						}else{
							swal({
								title: "UNSUCCESSFUL",
							  	text: result.data.MSG,
							  	html: true,
							  	timer: 2000,
							  	type: "error"
							});
						}
				    }, function myError(response) {
				    	alertMsgErrorSweet();
			    	});	
			}, 500);
		}); 	
	}
	
	
	
	
}]);
</script>

<script>

	function clkCheck(obj){
		$("input[name=check-all]").prop('checked',false);
	}


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

		
		/*Add to product block*/
		
		$("#btnAddToProduct").click(function(){
			$("#frmAddCompetitorToProduct").modal('toggle');
		});

		
		$("input[name=check-all]").change(function(){
			if($(this).is(':checked')){
				$("input[name=competitor]:not(:checked)").each(function(){
					$(this).prop('checked',true);
				});
			}else{
				$("input[name=competitor]:checked").each(function(){
					$(this).prop('checked',false);
				});
			}
		});

		$("#ato_product").change(function(){
			/* $("input[name=competitor]:checked").each(function(){
				 //$(this).prop("checked", false);
				this.checked = false;
			}); */
			if($("#ato_product").val() != ""){
				angular.element(document.getElementById('competitorController')).scope().findHBUItemById($("#ato_product").val());
			}
		});

		function addCompetitorsToProduct(){
			var competitors = [];
			$("input[name=competitor]:checked").each(function(){
				competitors.push({"comId":$(this).val()});
			});
			$('#frmAddCompetitorToProduct').bootstrapValidator({
				message: 'This value is not valid',
				feedbackIcons: {
					valid: 'glyphicon glyphicon-ok',
					invalid: 'glyphicon glyphicon-remove',
					validating: 'glyphicon glyphicon-refresh'
				},
				fields: {
					ato_product: {
						validators: {
							notEmpty: {
								message: 'The product is required and can not be empty!'
							}
						}
					}
				}
			}).on('success.form.bv', function(e) {
				swal({   
					title: "<span style='font-size: 25px;'>You are about to add competitors to product.</span>",
					text: "Click OK to continue or CANCEL to abort.",
					type: "info",
					html: true,
					showCancelButton: true,
					closeOnConfirm: false,
					showLoaderOnConfirm: true,		
				}, function(){ 
						setTimeout(function(){
							$.ajax({ 
								url : "${pageContext.request.contextPath}/item/add",
								type : "POST",
								data : JSON.stringify({
									  "itemId" : getValueStringById("ato_product"),
									  "competitors": competitors,
								}),
								beforeSend: function(xhr) {
								    xhr.setRequestHeader("Accept", "application/json");
								    xhr.setRequestHeader("Content-Type", "application/json");
							    }, 
							    success: function(result){	
							    	$("input[name=competitor]:checked").attr('checked',false);
							    	$("#ato_product").select2('val','');
							    	$('#frmAddCompetitorToProduct').bootstrapValidator('resetForm', true);
									if(result.MESSAGE == "INSERTED"){						
										swal({
				    						title: "SUCCESSFUL",
				    					  	text: result.MSG,
				    					  	html: true,
				    					  	timer: 2000,
				    					  	type: "success"
				    					});
										$("#frmAddCompetitorToProduct").modal('toggle');
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
			});
			$("#frmAddCompetitorToProduct").submit();
		}

		$("#btnAdd").click(function(){
			addCompetitorsToProduct();
		});
		
		/*End add to product block*/

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
							      "comStatus": getValueStringById("comStatus"),
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
	
	
	function clkCompetitor(obj){
		var n = obj.getAttribute("data-index");
		var comId = obj.getAttribute("value");
		var bool = false;
		if ($(obj).is(':checked')) {
			bool = true;
		}
		angular.element(document.getElementById('marketSurveyController')).scope().competitorIndexSet(bool,comId);	
	}
	
	
	
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
						<a class="btn btn-info btn-app" id = "addToCom" ng-click="addComToPro(true)" ><i class="fa fa-puzzle-piece" aria-hidden="true"></i> Add To Product</a> 
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
							<div class="table-responsive">
								<table class="table table-hover" data-ng-init="listCompetitors()">
									<tr>
										<th style="cursor: pointer;" ng-click="sort('comId')">ID <span class="glyphicon sort-icon"
											ng-show="sortKey=='comId'"
											ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
										</th>
										<th style="cursor: pointer;" ng-click="sort('comName')">Name
											<span class="glyphicon sort-icon"
											ng-show="sortKey=='comName'"
											ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
										</th>
										<th style="cursor: pointer;" ng-click="sort('comStatus')">Status
											<span class="glyphicon sort-icon"
											ng-show="sortKey=='comStatus'"
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
									<tr dir-paginate="com in competitors |orderBy:sortKey:reverse |filter:search |itemsPerPage:5"   class="ng-cloak">
										<td>{{com.comId}}</td>
										<td>{{com.comName}}</td>
										<td>{{com.comStatus}}</td>
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
							<!-- <dir-pagination-controls
								 pagination-id="compListRowId" 
						       max-size="5"
						       direction-links="true"
						       boundary-links="true" >
							</dir-pagination-controls> -->
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
											<div class="col-md-6">
												<div class="form-group">
													<label>Name <span class="requrie">(Required)</span></label>
													<input id="comName" name="comName" class="form-control" type="text" placeholder="Competitor Name" ng-model="comName" >
												</div>
											</div>
											<!-- <div class="clearfix"></div> -->
											<div class="col-md-6">
												<div class="form-group">
													<label>Status<span class="requrie">(Required)</span></label>
													<select class="form-control select2" name="comStatus" id="comStatus" style="width: 100%;">
														<option value="Competitor">Competitor</option>
														<option value="Owner">Owner</option>
													</select>
												</div>
											</div>
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
				
				<input type="hidden" id="btnAddCompetitorToProduct" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="frmAddCompetitorToProduct" />
				<div ng-controller="competitorController" class="modal fade modal-default" id="frmAddCompetitorToProduct" role="dialog">
					<div class="modal-dialog  modal-lg" data-ng-init="listItems()">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" ng-click="cancelAddCompetitor()" class="close"
									data-dismiss="modal">&times;</button>
								<h4 class="modal-title">
									<b  id="tCompetitorToProduct">Add Competitors to Product</b>
								</h4>
							</div>
							<div class="modal-body">
								<div class="row">
									<form id="frm_AddCompetitorToProduct">
										<div class="col-md-12">
											<div class="row">
												<div class="col-sm-6">
											        <div class="form-group">
											            <select class="form-control select2" name="ato_product" id="ato_product" style="width: 100%;">
															<option value="">-- SELECT Product --</option>
															<option ng-repeat="item in items" value="{{item.itemId}}">[{{item.itemId}}] {{item.itemName}}</option>
														</select>
											        </div>
											  	</div>
												<div class="col-sm-4">
											        <div class="form-group">
											            <input type="text" ng-model="searchCom" class="form-control" placeholder="Search">
											        </div>
											  	</div>
											 	<div class="col-sm-2">
											        <div class="form-group">
											            <select class="form-control" ng-model="rowNumCompetitor" style="width:100%" id="rowNumCom" name="rowNumCom">
															<option value="1">1</option>
															<option value="5">5</option>
															<option value="10">10</option>
															<option value="15">15</option>
															<option value="20">20</option>
															<option value="50">50</option>
															<option value="100">100</option>
														</select>
											        </div>
									  			</div>
											  	<div class="clearfix"></div>
													<div class="col-md-12">
														<div class="form-group table-responsive">
															<table class="table table-bordered">
																<tr class="active info">
																	<th><label>Competitor ID</label></th>
																	<th><label>Competitor Name</label></th>
																	<th class="text-center"></th>
																</tr>
																<tr ng-repeat = "com in addCompetitors |orderBy:sortKey:reverse |filter:searchCom |itemsPerPage:rowNumCompetitor"  pagination-id="compRowID">
																	<td class="col-md-3">{{com.comId}}</td>
																	<td>{{com.comName}}</td>
																	<td class="col-md-1 text-center"><input type="checkbox" ng-checked="com.meDataSource" data-index="{{$index}}" onClick="clkCompetitor(this)"  name="competitor" value="{{com.comId}}" /></td>
																</tr>
															</table>
															<dir-pagination-controls
														       max-size="rowNumCompetitor"
														       pagination-id="compRowID" 
														       direction-links="true"
														       boundary-links="true" >
														    </dir-pagination-controls>
														</div>														
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
									id="btnAdd" name="btnAdd">Save</button>
							</div>
						</div>
					</div>
				</div>
			<div class="box-footer"></div>
			<div id="errors"></div>
		</div>
	</section>
</div>
<jsp:include page="${request.contextPath}/footer"></jsp:include>

