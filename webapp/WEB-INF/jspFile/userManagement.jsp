<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>



<script type="text/javascript">

var $list_username = [];

var app = angular.module('campaign', ['angularUtils.directives.dirPagination','angular-loading-bar', 'ngAnimate']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = false;
}]);
var self = this;
var user = '${userId}';
var curUserId = "";
var curUsername = "";
var str = "${roleDelete}";

app.controller('campController',['$scope','$http',function($scope, $http){

	$scope.listStatus = function(user){
		$http.get("${pageContext.request.contextPath}/user/startup/list").success(function(response){
			
			$scope.user = response.DATA;
			$scope.role = response.ROLE;
			$scope.action = "Save";
			$list_username = response.DATA;
			$scope.rowNum = 5;
			$scope.curentUser = "";
			$scope.curIndex = 0;
		});
	};
	
	
	
	$scope.saveUser =function(){
		if($scope.action == "Save"){
			$('#form_status').data('bootstrapValidator').validate();
			var statusAddPro = $("#form_status").data('bootstrapValidator').validate().isValid();
			if(statusAddPro){
				swal({   
					title: "<span style='font-size: 25px;'>You are about to create new user.</span>",
					text: "Click OK to continue or CANCEL to abort.",
					type: "info",
					html: true,
					showCancelButton: true,
					closeOnConfirm: false,
					showLoaderOnConfirm: true,		
				}, function(){ 
					setTimeout(function(){
						$.ajax({ 
							url : "${pageContext.request.contextPath}/user/add",
							type : "POST",
							data : JSON.stringify({ 
								  "userID": getValueStringById("userId"),
							      "username": getValueStringById("username"),
							      "password": getValueStringById("password"),
							      "status": getValueStringById("status"),
							      "parentID": user,
							      "role": getJsonById("roleId","role","str"),
							      "userApp": {"appId":"CRM", "userId":getValueStringById("userId")},
							      "createBy": user
							}),
							beforeSend: function(xhr) {
							    xhr.setRequestHeader("Accept", "application/json");
							    xhr.setRequestHeader("Content-Type", "application/json");
						    }, 
						    success: function(result){
								if(result.MESSAGE == "INSERTED"){	
				    				swal({
			    						title: "SUCCESSFUL",
			    					  	text: result.MSG,
			    					  	html: true,
			    					  	timer: 2000,
			    					  	type: "success"
			    					});
				    				$scope.clearFrom();
				    				$scope.listStatus();
				    				
								}else{
									alertMsgErrorSweetWithTxt(result.MSG);
								}
							},
				    		error:function(){
				    			alertMsgErrorSweet();
				    		} 
						});
					}, 500);
				});
			}		
		}else{
			
			
			$('#form_status').data('bootstrapValidator').validate();
			var statusAddPro = $("#form_status").data('bootstrapValidator').validate().isValid();
			if(statusAddPro){
				swal({   
					title: "<span style='font-size: 25px;'>You are about to update user.</span>",
					text: "Click OK to continue or CANCEL to abort.",
					type: "info",
					html: true,
					showCancelButton: true,
					closeOnConfirm: false,
					showLoaderOnConfirm: true,		
				}, function(){ 
					setTimeout(function(){
						$.ajax({ 
							url : "${pageContext.request.contextPath}/user/edit",
							type : "PUT",
							data : JSON.stringify({ 
								  "userID": getValueStringById("userId"),
							      "username": getValueStringById("username"),
							      "status": getValueStringById("status"),
							      "role": getJsonById("roleId","role","str"),
							      "userApp": {"appId":"CRM", "userId":getValueStringById("userId")},
							      "modifyBy": $.session.get("parentID")
							}),
							beforeSend: function(xhr) {
							    xhr.setRequestHeader("Accept", "application/json");
							    xhr.setRequestHeader("Content-Type", "application/json");
						    }, 
						    success: function(result){
								if(result.MESSAGE == "UPDATED"){	
				    				alertMsgSuccessSweetWithTxt(result.MSG);  
				    				$scope.listStatus();
				    				$scope.clearFrom();
								}else{
									alertMsgErrorSweetWithTxt(result.MSG);
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
	}
	
	$scope.clearFrom = function (){
		
		$("#userId").val("");
		$("#username").val("");
		$("#role").select2('val',"");
		$("#status").select2('val',1);
		$("#password").val("");
		$("#cpassword").val("");
		
		$('#form_status').data('bootstrapValidator').resetField($('#userId'));
		$('#form_status').data('bootstrapValidator').resetField($('#username'));
		$('#form_status').data('bootstrapValidator').resetField($('#password'));
		$('#form_status').data('bootstrapValidator').resetField($('#userId'));
		$('#form_status').data('bootstrapValidator').resetField($('#cpassword'));
		$('#form_status').data('bootstrapValidator').resetField($('#role'));
		$('#form_status').data('bootstrapValidator').resetField($('#status'));
		
	}
	
	$scope.listUserID = function(index){
		
		$scope.action = "Update";
		$scope.curIndex = index;
		
		$("#userId").val($scope.user[index].userID);
		$("#username").val($scope.user[index].username);
		$("#role").select2('val',$scope.user[index].roleId);
		$("#status").select2('val',$scope.user[index].status);
		$("#password").val("xxxxxxxxxxxxx");
		$("#cpassword").val("xxxxxxxxxxxxx");
		
		$('#form_status').data('bootstrapValidator').resetField($('#userId'));
		$('#form_status').data('bootstrapValidator').resetField($('#username'));
		$('#form_status').data('bootstrapValidator').resetField($('#password'));
		$('#form_status').data('bootstrapValidator').resetField($('#userId'));
		$('#form_status').data('bootstrapValidator').resetField($('#cpassword'));
		$('#form_status').data('bootstrapValidator').resetField($('#role'));
		$('#form_status').data('bootstrapValidator').resetField($('#status'));
		
		$("#userId").prop('disabled',true);
		$("#password").prop('disabled',true);
		$("#cpassword").prop('disabled',true);
		
		$scope.curentUser = $scope.user[index];
		curUserId = $scope.user[index].userID;
		curUsername = $scope.user[index].username;
		
	};
		
		
	$scope.sort = function(keyname){
	    $scope.sortKey = keyname;   //set the sortKey to the param passed
	    $scope.reverse = !$scope.reverse; //if true make it false and vice versa
	};
	
	
	$scope.deleteStat = function(leadID){
		if(str == "YES"){
			swal({   
				title: "<span style='font-size: 25px;'>You are about to delete user with ID: <span class='color_msg'>"+leadID+"</span>.</span>",   
				text: "Click OK to continue or CANCEL to abort.",   
				type: "info", 
				html: true,
				showCancelButton: true,   
				closeOnConfirm: false,   
				showLoaderOnConfirm: true, 
				
			}, function(){   
				setTimeout(function(){			
					$.ajax({ 
			    		url: "${pageContext.request.contextPath}/user/remove/"+leadID,
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
			    				$scope.clearFrom();  
			    				setTimeout(function(){		
			    					$scope.listStatus();
			    				},2000);
			    			}else{
			    				alertMsgErrorSweetWithTxt(result.MSG);
			    			}
			    		},
			    		error:function(){
			    			alertMsgErrorSweet();
			    		}		    	    
			    	});
				}, 500);
			});	
		}else{
			alertMsgNoPermision();
		}
		
	};
	
}]);


function userExist(user){	
	for(var i=0; i<$list_username.length; i++){
		if($list_username[i].username === user && curUsername != user){
			return true;
		}
	}	
	return false;
}
function userIDExist(user){	
	for(var i=0; i<$list_username.length; i++){
		if($list_username[i].userID === user && curUserId != user){
			return true;
		}
	}	
	return false;
}



$(document).ready(function(){
	
	$('#form_status').bootstrapValidator({
		message: 'This value is not valid',
		submitButtons: 'button[type="button"]',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			password: {
				validators: {
					notEmpty: {
						message: 'The password is required and can not be empty'
					},
					identical: {
						field: 'cpassword',
						message: 'The password and its confirm are not the same'
					},
					different: {
						field: 'username',
						message: 'The password can not be the same as username'
					},
					stringLength: {
						min: 6,
						max: 30,
						message: 'The password must be more than 6 and less than 30 characters long'
					}
				}
			},
			cpassword: {
				validators: {
					notEmpty: {
						message: 'The repeat password is required and can not be empty'
					},
					identical: {
						field: 'password',
						message: 'The password and its confirm are not the same'
					},
					different: {
						field: 'username',
						message: 'The password can not be the same as username'
					},
					stringLength: {
						min: 6,
						max: 30,
						message: 'The password must be more than 6 and less than 30 characters long'
					}
				}
			},
			
			userId:{
				validators: {
					notEmpty: {
						message: 'The user ID is required and can not be empty'
					},
					stringLength: {
						min: 2,
						max: 11,
						message: 'The user ID must be more than 2 and less than 11 characters long'
					},
					regexp: {
						regexp: /^[a-zA-Z0-9_\.]+$/,
						message: 'The user ID can only consist of alphabetical, number, dot and underscore'
					},
					callback:{
						message: 'The user ID already exists.',
						callback: function(value, validator, $field) {							
								if(value !== ''){									
									if(userIDExist(value)){
										return {
		                                    valid: false
		                                };
									}else{
										return {
		                                    valid: true
		                                };
									} 
								}                    
                            return true;
						}
					}
				}
			},
			username: {
				message: 'The username is not valid',
				validators: {
					notEmpty: {
						message: 'The username is required and can not be empty'
					},
					stringLength: {
						min: 2,
						max: 30,
						message: 'The username must be more than 2 and less than 30 characters long'
					},
					callback:{
						message: 'The username already exists.',
						callback: function(value, validator, $field) {							
								if(value !== ''){									
									if(userExist(value)){
										return {
		                                    valid: false
		                                };
									}else{
										return {
		                                    valid: true
		                                };
									} 
								}                    
                            return true;
						}
					}
				}
			},
			role: {
				message: 'The Role is not valid',
				validators: {
					notEmpty: {
						message: 'The role is required and can not be empty'
					}
				}
			},
			status: {
				message: 'The status is not valid',
				validators: {
					notEmpty: {
						message: 'The status is required and can not be empty'
					}
				}
			}
			
		}
	});	
});
</script>

<div class="content-wrapper" ng-app="campaign" id="campController" ng-controller="campController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>User Management</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>User Management</a></li>
		</ol>
	</section>
	
	<section class="content">
	
		<!-- Default box -->
		
		<div class="box">
		
			<div class="box-header with-border">
				<div style="background: #fff;margin-top: 15px;">
				<form id="form_status">
				 <div class="col-sm-12">
				 	<button type="button" class="btn btn-info btn-app ng-cloak" ng-click="saveUser()" id="btn_save" value="{{action}}"> <i class="fa fa-save"></i>{{action}}</button> 
				 	
					<a class="btn btn-info btn-app" id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
					
				 </div>
				
				
				 <div class="col-sm-12 ">
						
						<div class="col-sm-3">
							<label class="font-label">User ID <span class="requrie">(Required)</span></label>
							<div class="form-group" id="c_name">
								<input type="text" class="form-control" name="userId"  id="userId" >
							</div>
						</div>
						<div class="col-sm-3">
							<label class="font-label">Username <span class="requrie">(Required)</span></label>
							<div class="form-group" id="c_name">
								<input type="text" class="form-control" name="username"  id="username" >
							</div>
						</div>
						
						
						<div class="col-sm-3">
							<label class="font-label">Role <span class="requrie">(Required)</span></label>
							<div class="form-group" id="c_name">
								<select class="form-control select2" style="width:100%" id="role" name="role">
									<option value="">--SELECT A Role--</option>
									<option ng-repeat="rol in role" value="{{rol.roleId}}">[{{rol.roleId}}] {{rol.roleName}}</option>
								</select>
							</div>
						</div>
						<div class="col-sm-3">
							<label class="font-label">Status <span class="requrie">(Required)</span></label>
							<div class="form-group" id="c_name">
								<select class="form-control select2" style="width:100%" id="status" name="status">
									<option value="1">Active</option>
									<option value="0">Inactive</option>
								</select>
							</div>
						</div>
						<div class="clearfix"></div>
				 		<div class="col-sm-3">
							<label class="font-label">Password <span class="requrie">(Required)</span></label>
							<div class="form-group" id="c_name">
								<input type="password" class="form-control" name="password" id="password" >
								<input type="hidden" class="form-control" name="hpassword" value="{{userID.password}}" id="hpassword" >
							</div>
						</div>
						<div class="col-sm-3">
							<label class="font-label">Confirm Password <span class="requrie">(Required)</span></label>
							<div class="form-group" id="c_name">
								<input type="password" class="form-control" name="cpassword"  id="cpassword" >
								<input type="hidden" class="form-control" name="hcpassword" value="{{userID.password}}" id="hcpassword" >
							</div>
						</div>
					
				 </div>	
			 </form>
			</div>
			</div>
			
			<div class="box-body" style="background: url(${pageContext.request.contextPath}/resources/images/boxed-bg.jpg);padding:30px;">
				
			 
			<div class="clearfix"></div>

			<div class="panel panel-default" data-ng-init="listStatus()">
  				<div class="panel-body">
  					
				 	<div class="col-sm-3">
				        <div class="form-group">
				            <input type="text" ng-model="search" class="form-control" placeholder="Search">
				        </div>
				  	</div>
				 	<div class="col-sm-1">
				        <div class="form-group">
				            <select class="form-control" ng-model="rowNum" style="width:100%" id="rowNum" name="rowNum">
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
				  
			<div class="tablecontainer table-responsive"  > 
			
				<table class="table table-hover" >
						<tr>
							<th style="cursor: pointer;" ng-click="sort('userID')">User ID
								<span class="glyphicon sort-icon" ng-show="sortKey=='userID'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
						   <th style="cursor: pointer;" ng-click="sort('username')">Username
								<span class="glyphicon sort-icon" ng-show="sortKey=='username'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							
							<th style="cursor: pointer;" ng-click="sort('roleName')">Role Name
								<span class="glyphicon sort-icon" ng-show="sortKey=='role.roleName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('status')">Status
								<span class="glyphicon sort-icon" ng-show="sortKey=='role.roleName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
									
							<th>Action</th>
						</tr>

						<tr dir-paginate="cc in user |orderBy:sortKey:reverse |filter:search |itemsPerPage:rowNum">
							<td>{{cc.userID}}</td>
							<td>{{cc.username}}</td>
							<td>{{cc.roleName}}</td>
							<td>{{cc.status==1 ? 'Active' : 'Inactive'}}</td>						
							<td>
								<a ng-click="listUserID($index)" class="btn btn-success custom-width"><i class="fa fa-pencil" aria-hidden="true"></i></a>
								<button type="button" ng-click="deleteStat(cc.userID)" class="btn btn-danger custom-width"><i class="fa fa-times" aria-hidden="true"></i></button>
							</td>
						</tr>
				
				</table>
				<dir-pagination-controls
			       max-size="rowNum"
			       direction-links="true"
			       boundary-links="true" >
			    </dir-pagination-controls>
			</div>	
			
			  </div>
		</div>
			</div>
			<div class="box-footer"></div>
		</div>
		<div id="errors"></div>
	</section>
</div>
<jsp:include page="${request.contextPath}/footer"></jsp:include>

