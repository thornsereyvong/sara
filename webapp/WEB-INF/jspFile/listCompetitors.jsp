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
	

	
	$scope.listCompetitors = function(){
		$http.get("${pageContext.request.contextPath}/hbu/competitor/list").success(function(response){
				$scope.competitors = response.COMPETITORS;
				$scope.length = $scope.competitors.length;
			});
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

	$scope.comSize = {};

	$scope.comSize.rows = [ 
					{ value: "5", label: "5" },
    				{ value: "10", label: "10" },
            		{ value: "15", label: "15" },
            		{ value: "20", label: "20" },
            		{ value: "25", label: "25" },
            		{ value: "30", label: "30" },
            		];
	$scope.comSize.row = $scope.comSize.rows[1].value;

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
			
			$.each($scope.addCompetitors,function(i, com){
				$scope.addCompetitors[i].meDataSource = false;
				$.each($scope.item.competitors,function(y, c){
					if(c.comId == com.comId){
						$scope.addCompetitors[i].meDataSource = true;
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
			$scope.competitorsCheck = [];
			if(bool){
				$("#frmAddCompetitorToProduct").modal({backdrop: "static"});
			}
			$scope.listItems();
		});
		
		
	}
	
	$scope.cancelAddCompetitor = function(){
		$("#ato_product").select2('val','');
		$('#frm_addComToPro').bootstrapValidator('resetForm', true);
    	//$('#frmAddCompetitorToProduct').bootstrapValidator('resetForm', true);
	};
	
	$scope.competitorIndexSet = function(bool,comId){
		var n = $scope.searchIndexByComId(comId);		
		if(n != false || n==0){
			$scope.addCompetitors[n].meDataSource = bool;	
									
			if(bool){
				$scope.competitorsCheck.push(angular.copy($scope.addCompetitors[n]));
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
		for(var i=0;i<$scope.addCompetitors.length; i++){
			if(comId == $scope.addCompetitors[i].comId){
				return i;
			}
		}		
		return false;
	}
	
	
	
	
	$scope.btnSaveToAddComToPro = function(){
		$('#frm_addComToPro').data('bootstrapValidator').validate();
		var statusAddPro = $("#frm_addComToPro").data('bootstrapValidator').validate().isValid();
		if(statusAddPro){
			var itemCompetitor =[];
			$.each($scope.competitorsCheck,function(y, c){
				var comObj = {"comId": c.comId, "comName":c.comName};
				itemCompetitor.push(comObj);
			});
						
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
							  "competitors": itemCompetitor,
						}),
						beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
					    }, 
					    success: function(result){							    	
					    	$("#ato_product").select2('val','');
					    	$('#frm_addComToPro').bootstrapValidator('resetForm', true);
							if(result.MESSAGE == "INSERTED"){						
								swal({
		    						title: "SUCCESSFUL",
		    					  	text: result.MSG,
		    					  	html: true,
		    					  	timer: 2000,
		    					  	type: "success"
		    					});

								setTimeout(function(){
									$("#frmAddCompetitorToProduct").modal('toggle');										
								},2000);
								
								
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

		
		
		$('#frm_addComToPro').bootstrapValidator({
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
			var itemId = getValueStringById("ato_product");
			if(itemId != ""){
				angular.element(document.getElementById('competitorController')).scope().findHBUItemById(itemId);
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

		/* $("#btnAdd").click(function(){
			addCompetitorsToProduct();
		}); */
		
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
		angular.element(document.getElementById('competitorController')).scope().competitorIndexSet(bool,comId);	
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
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<div style="background: #fff; margin-top: 10px;">
						<div class="col-sm-12">
							<a class="btn btn-info btn-app" id = "btn-create"><i class="fa fa-plus" aria-hidden="true"></i> Create</a> 					
							<a class="btn btn-info btn-app" id = "addToCom" ng-click="addComToPro(true)" ><i class="fa fa-puzzle-piece" aria-hidden="true"></i> Add To Product</a> 
						</div>
					</div>
				</div>
			</div>
			<div data-ng-init="listCompetitors()" class="box-body " style="background: url(${pageContext.request.contextPath}/resources/images/boxed-bg.jpg);padding:30px;">
				<div class="clearfix"></div>
					<div class="panel panel-default">
						<div class="panel-body">
							<div class="row">
								<div class="col-xs-9 col-sm-6 col-md-4 col-lg-2">
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
								<div class="col-xs-3 col-sm-2 col-sm-offset-4 col-md-offset-6 col-lg-1 col-lg-offset-9">
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
							<div class="table-responsive">
								<table class="table table-hover" >
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
										<th style="cursor: pointer;" ng-click="sort('comStatus')">Type
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
	
										<th class="text-center">Action</th>
									</tr>
									<tr dir-paginate="com in competitors |orderBy:sortKey:reverse |filter:search |itemsPerPage:pageSize.row"  pagination-id="compListRowId" class="ng-cloak">
										<td>{{com.comId}}</td>
										<td>{{com.comName}}</td>
										<td>{{com.comStatus}}</td>
										<td>{{com.comAddress}}</td>
										<td>{{com.comCreateBy}}</td>
										<td class="text-center">
											<a href="#" ng-click="findCompetitorById(com.comId)"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="edit"><i class="fa fa-pencil text-primary"></i></button></a>
											<a href="#" ng-click="deleteCompetitor(com.comId)"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="delete"><i class="fa fa-trash text-danger"></i></button></a>
										</td>
									</tr>
								</table>
							</div>
							<dir-pagination-controls
								 pagination-id="compListRowId" 
						       	max-size="pageSize.row"
						       direction-links="true"
						       boundary-links="true" >
							</dir-pagination-controls>
						</div>
					</div>
				</div>
				
				
				<input type="hidden" id="btn-add-competitor" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#frmCompetitor" />
				<div ng-controller="competitorController" class="modal fade modal-default" id="frmCompetitor" role="dialog">
					<div class="modal-dialog  modal-lg">
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
													<label>Type<span class="requrie">(Required)</span></label>
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
									id="btnCompetitorSave"  name="btnCompetitorSave">Save</button>
							</div>
						</div>
					</div>
				</div>
				<input type="hidden" id="btnAddCompetitorToProduct" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="frmAddCompetitorToProduct" />
				<div ng-controller="competitorController" class="modal fade modal-default" id="frmAddCompetitorToProduct" role="dialog">
					<div class="modal-dialog  modal-lg">
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
									<form id="frm_addComToPro">
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
											        <div class="input-group">
										        		 <span class="input-group-btn">
												       	 	<button class="btn btn-default" type="button" disabled="disabled"><i class="fa fa-search" aria-hidden="true"></i></button>
												      	</span>
										        		<input type="text" ng-model="searchCom" class="form-control" placeholder="Search">
										        	</div>
											  	</div>
											 	<div class="col-sm-2">
											        <div class="form-group">
											            <select class="form-control" ng-model="comSize.row" style="width:100%" id="rowNumCom" name="rowNumCom" ng-options="obj.value as obj.label for obj in comSize.rows"></select>
											        </div>
									  			</div>
											  	<div class="clearfix"></div>
													<div class="col-md-12">
														<div class="form-group table-responsive">
															<table class="table table-bordered">
																<tr class="active info">
																	<th>ID</th>
																	<th>Name</th>
																	<th>Type</th>
																	<th class="text-center"></th>
																</tr>
																<tr dir-paginate = "com in addCompetitors |orderBy:sortKey:reverse |filter:searchCom |itemsPerPage:comSize.row"  pagination-id="compRowID">
																	<td class="col-md-3">{{com.comId}}</td>
																	<td>{{com.comName}}</td>
																	<td>{{com.comStatus}}</td>
																	<td class="col-md-1 text-center"><input type="checkbox" ng-checked="com.meDataSource" data-index="{{$index}}" onClick="clkCompetitor(this)"  name="competitor" value="{{com.comId}}" /></td>
																</tr>
															</table>
															<dir-pagination-controls
														       max-size="comSize.row"
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
								<button type="button"  class="btn btn-primary pull-right"
									id="btnAdd" ng-click="btnSaveToAddComToPro()"  name="btnAdd">Save</button>
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

