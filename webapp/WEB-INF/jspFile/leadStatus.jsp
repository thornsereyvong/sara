<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>



<script type="text/javascript">

var app = angular.module('campaign', ['angularUtils.directives.dirPagination']);
var self = this;
app.controller('campController',['$scope','$http',function( $scope, $http){

	$scope.listStatus = function(){
		$http.get("${pageContext.request.contextPath}/lead_status/list").success(function(response){
				$scope.status = response.DATA;
				$scope.action = "Save";
			});
		};


	$scope.listStatusID = function(id){
			$http.get("${pageContext.request.contextPath}/lead_status/list/"+id).success(function(response){
					$scope.statusID = response.DATA;
					$scope.action = "Update";
				});
			};
		
		
	$scope.sort = function(keyname){
	    $scope.sortKey = keyname;   //set the sortKey to the param passed
	    $scope.reverse = !$scope.reverse; //if true make it false and vice versa
	};
	
	
	$scope.deleteStat = function(leadID){
		swal({
            title: "Are you sure?", 
            text: "This Status will not be able to recover!",
            type: "warning", //type -- adds appropiriate icon
            showCancelButton: true, // displays cancel btton
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Yes, delete!",
            closeOnConfirm: false, //do not close popup after click on confirm, usefull when you want to display a subsequent popup
            closeOnCancel: false
        }, 
        function(isConfirm){ //Function that triggers on user action.
            if(isConfirm){
	            $http.delete("${pageContext.request.contextPath}/lead_status/remove/"+leadID)
	            .success(function(){
	            		swal({
			            		title:"Deleted",
			            		text:"Status have been deleted!",
			            		type:"success",  
			            		timer: 2000,   
			            		showConfirmButton: false
	            		});
	            		$scope.listStatus();
		            });
	           
            } else {
                swal({
	                title:"Cancelled",
	                text:"This Status is safe!",
	                type:"error",
	                timer:2000,
	                showConfirmButton: false});
            }
        });
	};
	
}]);



$(document).ready(function(){
	
	$("#btn_clear").click(function(){
		$("#form_status").bootstrapValidator('resetForm', 'true');
	});
	 
	 $("#btn_save").click(function(){
		$("#form_status").submit();
	});
	
	$('#form_status').bootstrapValidator({
		message: 'This value is not valid',
		submitButtons: 'button[type="button"]',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			name: {
				validators: {
					notEmpty: {
						message: 'The Name is required and can not be empty!'
					}
				}
			}
			
		}
	}).on('success.form.bv', function(e) {
		if($("#btn_save").val() == "Save"){
			$.ajax({
				url : "${pageContext.request.contextPath}/lead_status/add",
				type : "POST",
				data : JSON.stringify({ 
				      "statusName": $("#name").val(),
				      "description": $("#desc").val()
					}),
				beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
						    },
				success:function(data){
					
						$("#form_status").bootstrapValidator('resetForm', 'true');
						$('#form_status')[0].reset();
						
						swal({
		            		title:"Success",
		            		text:"User have been created new Status!",
		            		type:"success",  
		            		timer: 2000,   
		            		showConfirmButton: false
	        			});

						angular.element("#campController").scope().listStatus();
					},
				error:function(){
					errorMessage();
					}
				}); 
		}else{
			
			$.ajax({
				url : "${pageContext.request.contextPath}/lead_status/edit",
				type : "PUT",
				data : JSON.stringify({
					  "statusID": $("#id").val(), 
				      "statusName": $("#name").val(),
				      "description": $("#desc").val()
					}),
				beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
						    },
				success:function(data){
					
						$("#form_status").bootstrapValidator('resetForm', 'true');
						$('#form_status')[0].reset();
						
						swal({
		            		title:"Success",
		            		text:"User have been Updated Status!",
		            		type:"success",  
		            		timer: 2000,   
		            		showConfirmButton: false
	        			});

						angular.element("#campController").scope().listStatus();
					},
				error:function(){
					errorMessage();
					}
				}); 
		}
		
		
		
	});	
});
</script>

<div class="content-wrapper" ng-app="campaign" id="campController" ng-controller="campController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Lead Status</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>Lead Status</a></li>
		</ol>
	</section>

	<section class="content">

		<!-- Default box -->
		
		<div class="box">
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
				<form id="form_status">
				 <div class="col-sm-12">
				 	<button type="button" class="btn btn-info btn-app ng-cloak" id="btn_save" value="{{action}}"> <i class="fa fa-save"></i>{{action}}</button> 
				 	
					<a class="btn btn-info btn-app" id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
					<a class="btn btn-info btn-app"  href="${pageContext.request.contextPath}/category-type"> <i class="fa fa-reply"></i> Back </a>
				 </div>
				 
				  
				  <div class="col-sm-12">
					<hr style="margin-bottom: 7px;;margin-top: 0px;" />
				 </div> 
				 
				 <div class="col-sm-12 ng-cloak">
				 		
							<input type="hidden" id="id" name="id" value="{{statusID.statusID}}" ng-model="statusID.statusID">
						    <input type="hidden" id="name" name="name" value="{{statusID.statusName}}" ng-model="statusID.statusName">
						 <div class="col-sm-2">
							<label class="font-label">Status Name :</label>
						</div>
						<div class="col-sm-10">
							<div class="form-group ng-cloak" id="c_name">
								<label>{{statusID.statusName}}&nbsp;</label>
							</div>
						</div>
				 		<div class="col-sm-2">
							<label class="font-label">Description :</label>
						</div>
						<div class="col-sm-10">
							<div class="form-group">
								<textarea style="height: 120px" rows="" cols="" name="desc" id="desc" ng-model="statusID.description" class="form-control"></textarea>
							</div>
						</div>
					
				 </div>
				 </form>
				 
				 
				 
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
			<div class="tablecontainer table-responsive" data-ng-init="listStatus()" > 
			
				<table class="table table-hover" >
						<tr>
						<th style="cursor: pointer;" ng-click="sort('statusID')">Status ID
								<span class="glyphicon sort-icon" ng-show="sortKey=='statusID'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('statusName')">Status Name
								<span class="glyphicon sort-icon" ng-show="sortKey=='statusName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('description')">Description
								<span class="glyphicon sort-icon" ng-show="sortKey=='description'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							
											
							<th>Action</th>
						</tr>

						<tr dir-paginate="cc in status |orderBy:sortKey:reverse |filter:search |itemsPerPage:5" class="ng-cloak">
							<td>{{cc.statusID}}</td>
							<td>{{cc.statusName}}</td>
							<td>{{cc.description}}</td>
							
							<td>
								<a ng-click="listStatusID(cc.statusID)" class="btn btn-success custom-width"><i class="fa fa-pencil" aria-hidden="true"></i></a>
								<button type="button" ng-click="deleteStat(cc.statusID)" class="btn btn-danger custom-width"><i class="fa fa-times" aria-hidden="true"></i></button>
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

<!-- /.content-wrapper -->



<!-- /.content-wrapper -->





<jsp:include page="${request.contextPath}/footer"></jsp:include>

