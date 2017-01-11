<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>


<script
	src="${pageContext.request.contextPath}/resources/customJS/role.js"></script>


<style>
.no-margin {
	margin-bottom: 0;
}
</style>
<script type="text/javascript">

var app = angular.module('campaign', ['angularUtils.directives.dirPagination']).directive('myRepeatDirective', function() {
	return function(scope, element, attrs) {
    	if (scope.$last){
	    	$('.btn-on-off').bootstrapToggle();				    	
	    }
  	};
});
				
var self = this;
var username = "${SESSION}";
var roleId = "${roleId}"
app.controller('campController',['$scope','$http',function($scope, $http){

	$scope.listModule = function(){
		$http.get("${pageContext.request.contextPath}/module/list/"+roleId).success(function(response){
			
			$scope.module = response.DATA;
			$scope.action = "Save";
			
			$scope.roleName = $scope.module[0].roleName;
			$scope.roleDecription = $scope.module[0].roleDescription;
			
			
			setTimeout(function(){
				var tr = $("#data_table_role tr");
				for(var i=0; i<$scope.module.length;i++){
					if($scope.module[i].access == 'YES'){
						disableCheck("accID"+i,false);
						$("#accID"+i).next().click();
					}
					if($scope.module[i].edit == 'YES'){
						disableCheck("editID"+i,false);
						$("#editID"+i).next().click();
					}
					if($scope.module[i].view == 'YES'){
						disableCheck("viewID"+i,false);
						$("#viewID"+i).next().click();
					}
					if($scope.module[i].list == 'YES'){
						disableCheck("listID"+i,false);
						$("#listID"+i).next().click();
					}
					if($scope.module[i].delete == 'YES'){
						disableCheck("deleteID"+i,false);
						$("#deleteID"+i).next().click();
					}
					if($scope.module[i].import == 'YES'){
						disableCheck("importID"+i,false);
						$("#importID"+i).next().click();
					}
					if($scope.module[i].export == 'YES'){
						disableCheck("exportID"+i,false);
						$("#exportID"+i).next().click();
					}
				}
			},1000);
			
			
			
		});
	};
	
	$scope.sort = function(keyname){
	    $scope.sortKey = keyname;   //set the sortKey to the param passed
	    $scope.reverse = !$scope.reverse; //if true make it false and vice versa
	};
	
	$scope.btnClickSave = function(){
		
		$('#form_status').data('bootstrapValidator').validate();
		var statusAddRole = $("#form_status").data('bootstrapValidator').validate().isValid();
		if(statusAddRole){
			swal({   
				title: "<span style='font-size: 25px;'>You are about to update role.</span>",
				text: "Click OK to continue or CANCEL to abort.",
				type: "info",
				html: true,
				showCancelButton: true,
				closeOnConfirm: false,
				showLoaderOnConfirm: true,		
			}, function(){ 
				setTimeout(function(){
					var tr = $("#data_table_role tr");
					var roleDetails = [];
					
					if(tr.length>0){
						for(var i=0; i<tr.length; i++){
							var moduleId = tr.eq(i).children().eq(0).attr("row-code");
							var access = getRoleDetailByModule(tr.eq(i).children().eq(1));
							var edit = getRoleDetailByModule(tr.eq(i).children().eq(2));
							var view = getRoleDetailByModule(tr.eq(i).children().eq(3));
							var list = getRoleDetailByModule(tr.eq(i).children().eq(4));
							var del = getRoleDetailByModule(tr.eq(i).children().eq(5));
							var imp = getRoleDetailByModule(tr.eq(i).children().eq(6));
							var exp = getRoleDetailByModule(tr.eq(i).children().eq(7));					
							roleDetails.push({
						          "module": {"moduleId": moduleId},
						          "roleAccess": access,
						          "roleDelete": del,
						          "roleEdit": edit,
						          "roleExport": exp,
						          "roleImport": imp,
						          "roleList": list,
						          "roleView": view
					        });
						}	
					}
					
					$.ajax({ 
						url : "${pageContext.request.contextPath}/role/edit",
						type : "PUT",
						data : JSON.stringify({ 
							  "roleId": roleId,
						      "roleName": getValueStringById("name"),
						      "description": getValueStringById("desc"),
						      "roleDetails": roleDetails,
						      "modifyBy": username,				      
						      "roleStatus": 1
						}),
						beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
					    }, 
					    success: function(result){
							if(result.MESSAGE == "UPDATED"){	
			    				swal({
		    						title: "SUCCESSFUL",
		    					  	text: result.MSG,
		    					  	html: true,
		    					  	timer: 2000,
		    					  	type: "success"
		    					});
			    				
			    				reloadForm(2000);
			    				
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
		}
	}
	
	
}]);

function getRoleDetailByModule(element){
	var access = element.children().children().children().eq(0).attr("class");
	access = access.search("off");
	if(access>0){
		return "NO";
	}else{
		return "YES";
	}
}


function accessClick(a){
	var n= $(a).attr('data-index');
	if ($(a).is(':checked')) {
		disableCheck("editID"+n,false);
		disableCheck("viewID"+n,false);
		disableCheck("listID"+n,false);
		disableCheck("deleteID"+n,false);
		disableCheck("importID"+n,false);
		disableCheck("exportID"+n,false);
	}else{
		disableCheck("editID"+n,true);
		disableCheck("viewID"+n,true);
		disableCheck("listID"+n,true);
		disableCheck("deleteID"+n,true);
		disableCheck("importID"+n,true);
		disableCheck("exportID"+n,true);
	}
	
}

function disableCheck(id, status){	
	if(status == true){
		if ($("#"+id).is(':checked')) {
			$("#"+id).next().click();
		}
	}
	$("#"+id).parent().attr("disabled",status);
	$("#"+id).prop("disabled",status);
}

$(document).ready(function(){

	$("#btn_clear").click(function(){
		location.reload();
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
	});
});
</script>

<div class="content-wrapper" ng-app="campaign" id="campController"
	ng-controller="campController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Update Role Management</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>Update Role Management</a></li>
		</ol>
	</section>

	<section class="content">

		<!-- Default box -->
		<form id="form_status">
			<div class="box">
				<div class="box-header with-border">

					<div style="background: #fff; margin-top: 15px;">

						<div class="col-sm-12">
							<button type="button" ng-click="btnClickSave()" class="btn btn-info btn-app"  value="{{action}}">
								<i class="fa fa-save"></i>{{action}}
							</button>
							<a class="btn btn-info btn-app" id="btn_clear"> 
								<i class="fa fa-refresh" aria-hidden="true"></i>Clear
							</a> 
							<a class="btn btn-info btn-app" href="${pageContext.request.contextPath}/role-management"> 
								<i class="fa fa-reply"></i> Back
							</a>
						</div>
					</div>
				</div>

				<div class="box-body" data-ng-init="listModule()">

					<div class="col-sm-12">

						<input type="hidden" id="id" name="id">

						<div class="col-sm-2">
							<label class="font-label">Role Name :</label>
						</div>
						<div class="col-sm-10">
							<div class="form-group" id="c_name">
								<input type="text" class="form-control ng-cloak" value="{{roleName}}" name="name" id="name" >
							</div>
						</div>
						<div class="col-sm-2">
							<label class="font-label">Description :</label>
						</div>
						<div class="col-sm-10">
							<div class="form-group">
								<textarea style="height: 120px" rows="" cols="" name="desc"
									id="desc" class="form-control ng-cloak">{{roleDecription}}</textarea>
							</div>
						</div>
						<div class="col-sm-12 table-responsive">
							<table class="table" my-main-directive>
								<tr>
									<th>Module</th>
									<th>Access</th>
									<th>Edit</th>
									<th>View</th>
									<th>List</th>
									<th>Delete</th>
									<th>Import</th>
									<th>Export</th>
								</tr>
								<tbody id="data_table_role">
									<tr ng-repeat="u in module" my-repeat-directive >
										<td row-code="{{u.moduleId}}">{{u.moduleName}}</td>
										<td>
											<div class="form-group no-margin">
												<label class="no-margin"> 
													<input class="btn-on-off"  data-index="{{$index}}" onchange="accessClick(this)" id="accID{{$index}}" data-on="YES"
													data-onstyle="success" data-offstyle="warning"
													data-off="NO" data-size="small" type="checkbox">
												</label>
											</div>
										</td>
										<td>
											<div class="form-group no-margin">
												<label class="no-margin"> 
												<input class="btn-on-off "
													id="editID{{$index}}" disabled="disabled" data-on="YES"
													data-onstyle="success" data-offstyle="warning"
													data-off="NO" data-size="small" type="checkbox">
												</label>
											</div>
										</td>
										<td>
											<div class="form-group no-margin">
												<label class="no-margin"> <input class="btn-on-off"
													id="viewID{{$index}}" data-on="YES"
													data-onstyle="success" disabled="disabled" data-offstyle="warning"
													data-off="NO" data-size="small" type="checkbox">
												</label>
											</div>
										</td>
										<td>
											<div class="form-group no-margin">
												<label class="no-margin"> <input class="btn-on-off"
													id="listID{{$index}}" data-on="YES"
													data-onstyle="success" disabled="disabled" data-offstyle="warning"
													data-off="NO" data-size="small" type="checkbox">
												</label>
											</div>
										</td>
										<td>
											<div class="form-group no-margin">
												<label class="no-margin"> <input class="btn-on-off"
													id="deleteID{{$index}}" data-on="YES"
													data-onstyle="success" disabled="disabled" data-offstyle="warning"
													data-off="NO" data-size="small" type="checkbox">
												</label>
											</div>
										</td>
										<td>
											<div class="form-group no-margin">
												<label class="no-margin"> <input class="btn-on-off"
													id="importID{{$index}}" data-on="YES"
													data-onstyle="success" disabled="disabled" data-offstyle="warning"
													data-off="NO" data-size="small" type="checkbox">
												</label>
											</div>
										</td>
										<td>
											<div class="form-group no-margin">
												<label class="no-margin"> <input class="btn-on-off"
													id="exportID{{$index}}" data-on="YES"
													data-onstyle="success" disabled="disabled" data-offstyle="warning"
													data-off="NO" data-size="small" type="checkbox">
												</label>
											</div>
										</td>
									</tr>

								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</form>
		<div id="errors"></div>
	</section>
</div>
<jsp:include page="${request.contextPath}/footer"></jsp:include>

