<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>



<script type="text/javascript">

var $list_username = [];

var app = angular.module('campaign', ['angularUtils.directives.dirPagination','oitozero.ngSweetAlert']);
var self = this;

app.controller('campController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){

	$scope.listStatus = function(user){
		$http.get("${pageContext.request.contextPath}/user/list/subordinate/admin/"+user).success(function(response){
				$scope.user = response.DATA;
				$scope.action = "Save";
				$list_username = response.DATA
			});
		};

		$scope.listRole = function(){
			$http.get("${pageContext.request.contextPath}/role/list/").success(function(response){
					$scope.role = response.DATA;
					
				});
			};
			
	$scope.listUserID = function(id){
			$http.get("${pageContext.request.contextPath}/user/list/id/"+id).success(function(response){
					$scope.userID = response.DATA;
					jQuery('#role').select2("val",response.DATA.role.roleId);
					jQuery('#password').attr("disabled", true); 
					jQuery('#cpassword').attr("disabled", true);
					$scope.action = "Update";
				});
			};
		
		
	$scope.sort = function(keyname){
	    $scope.sortKey = keyname;   //set the sortKey to the param passed
	    $scope.reverse = !$scope.reverse; //if true make it false and vice versa
	};
	
	
	$scope.deleteStat = function(leadID){
		SweetAlert.swal({
            title: "Are you sure?", //Bold text
            text: "This user will not be able to recover!", //light text
            type: "warning", //type -- adds appropiriate icon
            showCancelButton: true, // displays cancel btton
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Yes, delete!",
            closeOnConfirm: false, //do not close popup after click on confirm, usefull when you want to display a subsequent popup
            closeOnCancel: false
        }, 
        function(isConfirm){ //Function that triggers on user action.
            if(isConfirm){
	            $http.delete("${pageContext.request.contextPath}/user/remove/"+leadID)
	            .success(function(){
	            		SweetAlert.swal({
			            		title:"Deleted",
			            		text:"User have been deleted!",
			            		type:"success",  
			            		timer: 2000,   
			            		showConfirmButton: false
	            		});
	            		$scope.listStatus($.session.get("parentID"));
		            });
	           
            } else {
                SweetAlert.swal({
	                title:"Cancelled",
	                text:"This User is safe!",
	                type:"error",
	                timer:2000,
	                showConfirmButton: false});
            }
        });
	};
	
}]);


function userExist(user){	
	for(var i=0; i<$list_username.length; i++){
		if($list_username[i].username === user){
			return true;
		}
	}	
	return false;
}
$(document).ready(function(){
	
	
	angular.element("#campController").scope().listStatus($.session.get("parentID"));
	
	$(".select2").select2();
	$("#btn_clear").click(function(){
		$("#form_status").bootstrapValidator('resetForm', 'true');
		$("#role").select2("val","");

		/* $("#div_role").find('i').remove('i');
		$("#div_role").find('small').remove('small');
		$("#div_role").removeClass("form-group has-feedback has-error").addClass("form-group has-feedback"); */
		$('#btn_save').attr("disabled", false);
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
			username: {
				message: 'The username is not valid',
				validators: {
					notEmpty: {
						message: 'The username is required and can not be empty'
					},
					stringLength: {
						min: 6,
						max: 30,
						message: 'The username must be more than 6 and less than 30 characters long'
					},
					regexp: {
						regexp: /^[a-zA-Z0-9_\.]+$/,
						message: 'The username can only consist of alphabetical, number, dot and underscore'
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
						message: 'The Role is required and can not be empty'
					}
				}
			}
			
		}
	}).on('success.form.bv', function(e) {
		var user = '${userId}';
		
		var currentDate = new Date();
		var day = currentDate.getDate();
		var month = currentDate.getMonth() + 1;
		var year = currentDate.getFullYear();

		
		if($("#btn_save").val() == "Save"){
			
			if($("#password").val() == $("#cpassword").val()){
				
				$.ajax({
					url : "${pageContext.request.contextPath}/user/add",
					type : "POST",
					data : JSON.stringify({ 
					      "username": $("#username").val(),
					      "password": $("#password").val(),
					      "status": 1,
					      "parentID": user,
					      "role": {"roleId": $("#role").val()},
					      "createBy": $.session.get("parentID"),
					      "createDate": year+"-"+month+"-"+day
						}),
					beforeSend: function(xhr) {
							    xhr.setRequestHeader("Accept", "application/json");
							    xhr.setRequestHeader("Content-Type", "application/json");
							    },
					success:function(data){
							$("#form_status").bootstrapValidator('resetForm', 'true');
							$('#form_status')[0].reset();
							$("#role").select2("val","");
							swal({
			            		title:"Success",
			            		text:"User have been created new User!",
			            		type:"success",  
			            		timer: 2000,   
			            		showConfirmButton: false
		        			});

							angular.element("#campController").scope().listStatus($.session.get("parentID"));
						},
					error:function(){
						errorMessage();
						}
					}); 
			}else{
				errorMessage();
			}
			
		}else{

			if($("#hpassword").val() == $("#hcpassword").val()){
			$.ajax({
				url : "${pageContext.request.contextPath}/user/edit",
				type : "PUT",
				data : JSON.stringify({ 
					  "userID": $("#id").val(),
				      "username": $("#username").val(),
				      "password": $("#hpassword").val(),
				      "status": 1,
				      "parentID": user,
				      "role": {"roleId": $("#role").val()},
				      "modifyBy": $.session.get("parentID")
					}),
				beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
						    },
				success:function(data){
					
						$("#form_status").bootstrapValidator('resetForm', 'true');
						$('#form_status')[0].reset();
						$("#role").select2("val","");
						jQuery('#password').attr("disabled", false); 
						jQuery('#cpassword').attr("disabled", false);
						swal({
		            		title:"Success",
		            		text:"User have been Updated Type!",
		            		type:"success",  
		            		timer: 2000,   
		            		showConfirmButton: false
	        			});

						angular.element("#campController").scope().listStatus($.session.get("parentID"));
					},
				error:function(){
					errorMessage();
					}
				}); 

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
				 	<button type="button" class="btn btn-info btn-app" id="btn_save" value="{{action}}"> <i class="fa fa-save"></i>{{action}}</button> 
				 	
					<a class="btn btn-info btn-app" id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
					
				 </div>
				 
				  
				  <div class="col-sm-12">
					<hr style="margin-bottom: 7px;;margin-top: 0px;" />
				 </div> 
				
				 <div class="col-sm-6 ">
				 		
						<input type="hidden" id="id" name="id" value="{{userID.userID}}" >
						
						 <div class="col-sm-3">
							<label class="font-label">Username :</label>
						</div>
						<div class="col-sm-9">
							<div class="form-group" id="">
								<input type="text" class="form-control" name="username" ng-model="userID.username" id="username" >
							</div>
						</div>
						
						 <div class="col-sm-3"  data-ng-init="listRole()">
							<label class="font-label">Role :</label>
						</div>
						<div class="col-sm-9" >
							<div class="form-group" id="div_role">
								<select class="form-control select2"  id="role" name="role">
									<option value="">--SELECT Role--</option>
									<option ng-repeat="rol in role" value="{{rol.roleId}}">{{rol.roleName}}</option>
								</select>
							</div>
						</div>
				 		
					
				 </div>
				 <div class="col-sm-6">
				 <div class="col-sm-3">
							<label class="font-label">Password :</label>
						</div>
						<div class="col-sm-9">
							<div class="form-group" id="">
								<input type="password" class="form-control" name="password" id="password" >
								<input type="hidden" class="form-control" name="hpassword" value="{{userID.password}}" id="hpassword" >
							</div>
						</div>
						<div class="col-sm-3">
							<label class="font-label">Confirm Password :</label>
						</div>
						<div class="col-sm-9">
							<div class="form-group" id="">
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
			<div class="tablecontainer table-responsive"  > 
			
				<table class="table table-hover" >
						<tr>
						   <th style="cursor: pointer;" ng-click="sort('username')">Username
								<span class="glyphicon sort-icon" ng-show="sortKey=='username'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('role.roleName')">Role Name
								<span class="glyphicon sort-icon" ng-show="sortKey=='role.roleName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('role.createDate')">Create Date
								<span class="glyphicon sort-icon" ng-show="sortKey=='role.createDate'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
									
							<th>Action</th>
						</tr>

						<tr dir-paginate="cc in user |orderBy:sortKey:reverse |filter:search |itemsPerPage:5">
							<td>{{cc.username}}</td>
							<td>{{cc.role.roleName}}</td>
							<td>{{cc.role.createDate | date:'dd-MM-yyyy'}}</td>							
							<td>
								<a ng-click="listUserID(cc.userID)" class="btn btn-success custom-width"><i class="fa fa-pencil" aria-hidden="true"></i></a>
								<button type="button" ng-click="deleteStat(cc.userID)" class="btn btn-danger custom-width"><i class="fa fa-times" aria-hidden="true"></i></button>
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

