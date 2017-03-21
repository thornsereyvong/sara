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
				for(var i=0; i<$scope.module.length;i++){
					if($scope.module[i].groupType != "Report"){
						if($scope.module[i].access == 'YES'){
							
						}
						if($scope.module[i].edit == 'YES'){
							
						}
						if($scope.module[i].view == 'YES'){
							
						}
						if($scope.module[i].list == 'YES'){
							
						}
						if($scope.module[i].delete == 'YES'){
							
						}
						if($scope.module[i].import == 'YES'){
							
						}
						if($scope.module[i].export == 'YES'){
							
						}						
					}else{
						if($scope.module[i].access == 'YES'){
							
						}
					}				
				}				
			},1000);
			
		});
	};
		
	$scope.sort = function(keyname){
	    $scope.sortKey = keyname;
	    $scope.reverse = !$scope.reverse;
	};
	
	$scope.ckrAll = function(){	
		var status = false;
		if($("#ckrAll").is(':checked')){
			status = true;
		}					
		for(var i=0; i<$scope.module.length; i++){
			if($scope.module[i].groupType != "Report"){
				$scope.module[i].access = status;
				$scope.module[i].edit = status;
				$scope.module[i].delete = status;
				$scope.module[i].view = status;			
				$scope.module[i].list = status;
				$scope.module[i].export = status;
				$scope.module[i].import = status;
				$scope.disabled(i,!status);
			}
		}
		$("input[name='ckr']").prop('checked',status);
	}
	
	$scope.ckrReportAll = function(){
		var status = false;
		if($("#ckrReportAll").is(':checked')){
			status = true;
		}					
		for(var i=0; i<$scope.module.length; i++){
			if($scope.module[i].groupType == "Report"){
				$scope.module[i].access = status;
				$scope.module[i].edit = status;
				$scope.module[i].delete = status;
				$scope.module[i].view = status;			
				$scope.module[i].list = status;
				$scope.module[i].export = status;
				$scope.module[i].import = status;
				$scope.disabled(i,!status);
			}
		}
		$("input[name='ckrReport']").prop('checked',status);
	}
	
	$scope.checkStatusAll = function(){
		var status = true;
		for(var i=0; i<$scope.module.length; i++){
			
			if($scope.module[i].groupType != "Report"){			
				if($scope.module[i].access == null || $scope.module[i].access == false || $scope.module[i].access == "NO"){
					status = false; 
					break;
				}			
				if($scope.module[i].edit == null || $scope.module[i].edit == false || $scope.module[i].edit == "NO"){
					status = false;
					break;
				}
				if($scope.module[i].view == null || $scope.module[i].view == false || $scope.module[i].view == "NO"){
					status = false;
					break;
				}
				if($scope.module[i].list == null || $scope.module[i].list == false || $scope.module[i].list == "NO"){
					status = false;
					break;
				}
				if($scope.module[i].delete == null || $scope.module[i].delete == false || $scope.module[i].delete == "NO"){
					status = false;
					break;
				}
				if($scope.module[i].export == null || $scope.module[i].export == false || $scope.module[i].export == "NO"){
					status = false;
					break;
				}
				if($scope.module[i].import == null || $scope.module[i].import == false || $scope.module[i].import == "NO"){
					status = false;
					break;
				}
			}
		}
		$("#ckrAll").prop('checked',status);	
	}
		
	$scope.ckrAllByRow = function(index){
		if($("#ckrAllByRow"+index).is(':checked')){			
			$scope.ckecked(index,true);			
			$scope.disabled(index, false);
			$scope.updateByRow(index,true);
		}else{
			$scope.ckecked(index,false);
			$scope.disabled(index,true);
			$scope.updateByRow(index, false);
		}		
		$scope.checkStatusAll();	
	}
	
	$scope.disabled = function(index,status){
		$("#ckrEdit"+index).prop('disabled',status);
		$("#ckrDelete"+index).prop('disabled',status);
		$("#ckrView"+index).prop('disabled',status);
		$("#ckrList"+index).prop('disabled',status);
		$("#ckrImport"+index).prop('disabled',status);
		$("#ckrExport"+index).prop('disabled',status);
	}
	
	$scope.ckecked = function(index,status){
		$("#ckrAccess"+index).prop('checked',status);
		$("#ckrEdit"+index).prop('checked',status);
		$("#ckrDelete"+index).prop('checked',status);
		$("#ckrView"+index).prop('checked',status);
		$("#ckrList"+index).prop('checked',status);
		$("#ckrImport"+index).prop('checked',status);
		$("#ckrExport"+index).prop('checked',status);
	}
	
	$scope.ckrDetailClickAccess = function(index){
		if($("#ckrAccess"+index).is(':checked')){			
			$scope.disabled(index,false);
			$scope.module[index].access = true;
		}else{
			$scope.module[index].access = false;
			$scope.disabled(index,true);
			$scope.ckecked(index,false);
			$scope.updateByRow(index,false);
		}		
		$scope.checkStatusAllByRow(index);
		$scope.checkStatusAll();
	}
	$scope.ckrDetailClickEdit = function(index){
		if($("#ckrEdit"+index).is(':checked')){
			$scope.module[index].edit = true;
		}else{
			$scope.module[index].edit = false;
		}
		$scope.checkStatusAllByRow(index);
		$scope.checkStatusAll();
	}
	$scope.ckrDetailClickList = function(index){
		if($("#ckrList"+index).is(':checked')){
			$scope.module[index].list = true;
		}else{
			$scope.module[index].list = false;
		}
		$scope.checkStatusAllByRow(index);
		$scope.checkStatusAll();
	}
	$scope.ckrDetailClickDelete = function(index){
		if($("#ckrDelete"+index).is(':checked')){
			$scope.module[index].delete = true;
		}else{
			$scope.module[index].delete = false;
		}
		$scope.checkStatusAllByRow(index);
		$scope.checkStatusAll();
	}
	$scope.ckrDetailClickView = function(index){
		if($("#ckrView"+index).is(':checked')){
			$scope.module[index].view = true;
		}else{
			$scope.module[index].view = false;
		}
		$scope.checkStatusAllByRow(index);
		$scope.checkStatusAll();
	}
	$scope.ckrDetailClickImport = function(index){
		if($("#ckrImport"+index).is(':checked')){
			$scope.module[index].import = true;
		}else{
			$scope.module[index].import = false;
		}
		$scope.checkStatusAllByRow(index);
		$scope.checkStatusAll();
	}
	$scope.ckrDetailClickExport = function(index){
		if($("#ckrExport"+index).is(':checked')){
			$scope.module[index].export = true;
		}else{
			$scope.module[index].export = false;
		}
		$scope.checkStatusAllByRow(index);
		$scope.checkStatusAll();
	}
	
	$scope.updateByRow = function(index,status){
		$scope.module[index].access = status;
		$scope.module[index].edit = status;
		$scope.module[index].delete = status;
		$scope.module[index].view = status;			
		$scope.module[index].list = status;
		$scope.module[index].export = status;
		$scope.module[index].import = status;		
	}
	$scope.checkStatusAllByRow = function(i){
		var status = true;
		if($scope.module[i].access == null || $scope.module[i].access == false || $scope.module[i].access == "NO"){
			status = false; 
		}			
		if($scope.module[i].edit == null || $scope.module[i].edit == false || $scope.module[i].edit == "NO"){
			status = false;
		}
		if($scope.module[i].view == null || $scope.module[i].view == false || $scope.module[i].view == "NO"){
			status = false;
		}
		if($scope.module[i].list == null || $scope.module[i].list == false || $scope.module[i].list == "NO"){
			status = false;
		}
		if($scope.module[i].delete == null || $scope.module[i].delete == false || $scope.module[i].delete == "NO"){
			status = false;
		}
		if($scope.module[i].export == null || $scope.module[i].export == false || $scope.module[i].export == "NO"){
			status = false;
		}
		if($scope.module[i].import == null || $scope.module[i].import == false || $scope.module[i].import == "NO"){
			status = false;
		}
		$("#ckrAllByRow"+i).prop('checked',status);
	}
	
	
	// report 
	
	$scope.ckrDetailClickReportAccess = function(index){
		if($("#ckrReportAccess"+index).is(':checked')){
			$scope.module[index].access = true;
		}else{
			$scope.module[index].access = false;
		}
		$scope.checkStatusReportAll();
	}
	
	$scope.checkStatusReportAll = function(){
		var status = true;
		for(var i=0; i<$scope.module.length; i++){			
			if($scope.module[i].groupType == "Report"){			
				if($scope.module[i].access == null || $scope.module[i].access == false || $scope.module[i].access == "NO"){
					status = false; 
					break;
				}
			}
		}
		$("#ckrReportAll").prop('checked',status);
	}
	
	$scope.checkBool = function(status){
		if(status == null || status == false || status == "NO")
			return "NO";
		else
			return "YES";
	}
	
	$scope.btnClickSave = function(){		
		$('#form_status').data('bootstrapValidator').validate();
		var statusAddRole = $("#form_status").data('bootstrapValidator').validate().isValid();
		if(statusAddRole){
			swal({   
				title: "<span style='font-size: 25px;'>You are about to create new role.</span>",
				text: "Click OK to continue or CANCEL to abort.",
				type: "info",
				html: true,
				showCancelButton: true,
				closeOnConfirm: false,
				showLoaderOnConfirm: true,		
			}, function(){ 
				setTimeout(function(){
					var roleDetails = [];
					for(var i=0; i<$scope.module.length; i++){
						roleDetails.push({
					          "module": {"moduleId": $scope.module[i].moduleId},
					          "roleAccess": $scope.checkBool($scope.module[i].access),
					          "roleDelete": $scope.checkBool($scope.module[i].delete),
					          "roleEdit": $scope.checkBool($scope.module[i].edit),
					          "roleExport": $scope.checkBool($scope.module[i].export),
					          "roleImport": $scope.checkBool($scope.module[i].import),
					          "roleList": $scope.checkBool($scope.module[i].list),
					          "roleView": $scope.checkBool($scope.module[i].view)
				        });
					}
								
					$.ajax({ 
						url : "${pageContext.request.contextPath}/role/add",
						type : "POST",
						data : JSON.stringify({ 
						      "roleName": getValueStringById("name"),
						      "description": getValueStringById("desc"),
						      "roleDetails": roleDetails,
						      "createBy": username,				      
						      "roleStatus": 1
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


$(document).ready(function(){

	$("#btn_clear").click(function(){location.reload();});	 
	$("#btn_save").click(function(){$("#form_status").submit();});	
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

				<div class="box-body">

					<div class="col-sm-12">
						
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
						
						<div class="nav-tabs-custom" data-ng-init="listModule()">
							<ul class="nav nav-tabs ui-sortable-handle">
								<li class="active"><a href="#tabModule" class="ng-cloak" data-toggle="tab">Module</a></li>
								<li class=""><a href="#tabReport" class="ng-cloak" data-toggle="tab">Report</a></li>
							</ul>
							<div class="tab-content no-padding">
								<div class="chart tab-pane active" id="tabModule">
									<div class="col-sm-12 table-responsive">
										<table class="table" my-main-directive>
											<tr>
												<th class="width-80 td-center">
													<div class="icheckbox icheckbox-primary"><input name="ckr" ng-click="ckrAll()" id="ckrAll" class="styled" type="checkbox"><label class="cursor-pointer" for="ckrAll"></label></div>
												</th>
												<th>Module Name</th>
												<th class="th-center">Access</th>
												<th class="th-center">Edit</th>
												<th class="th-center">View</th>
												<th class="th-center">List</th>
												<th class="th-center">Delete</th>
												<th class="th-center">Import</th>
												<th class="th-center">Export</th>
											</tr>
											<tbody id="data_table_role">
												<tr ng-repeat="u in module" ng-if="u.moduleName != 'Report' && u.groupType!= 'Report' && u.groupModule!= 'Report'" my-repeat-directive >
													<td class="td-center">
														<div class="icheckbox icheckbox-primary"><input name="ckr" ng-click="ckrAllByRow($index)" id="ckrAllByRow{{$index}}" class="styled" type="checkbox"><label class="cursor-pointer" for="ckrAllByRow{{$index}}"></label></div>
													</td>
													<td row-code="{{u.moduleId}}">{{u.moduleName}}</td>
													<td class="td-center">
														<div class="icheckbox icheckbox-primary"><input name="ckr" ng-click="ckrDetailClickAccess($index)" id="ckrAccess{{$index}}" class="styled" type="checkbox"><label class="cursor-pointer" for="ckrAccess{{$index}}"></label></div>
													</td>
													<td class="td-center">
														<div class="icheckbox icheckbox-primary"><input disabled name="ckr" ng-click="ckrDetailClickEdit($index)" id="ckrEdit{{$index}}" class="styled" type="checkbox"><label class="cursor-pointer" for="ckrEdit{{$index}}"></label></div>
													</td>
													<td class="td-center">
														<div class="icheckbox icheckbox-primary"><input disabled name="ckr" ng-click="ckrDetailClickView($index)" id="ckrView{{$index}}" class="styled" type="checkbox"><label class="cursor-pointer" for="ckrView{{$index}}"></label></div>
													</td>
													<td class="td-center">
														<div class="icheckbox icheckbox-primary"><input disabled name="ckr" ng-click="ckrDetailClickList($index)" id="ckrList{{$index}}" class="styled" type="checkbox"><label class="cursor-pointer" for="ckrList{{$index}}"></label></div>
													</td>
													<td class="td-center">
														<div class="icheckbox icheckbox-primary"><input disabled name="ckr" ng-click="ckrDetailClickDelete($index)" id="ckrDelete{{$index}}" class="styled" type="checkbox"><label class="cursor-pointer" for="ckrDelete{{$index}}"></label></div>
													</td>
													<td class="td-center">
														<div class="icheckbox icheckbox-primary"><input disabled name="ckr" ng-click="ckrDetailClickImport($index)" id="ckrImport{{$index}}" class="styled" type="checkbox"><label class="cursor-pointer" for="ckrImport{{$index}}"></label></div>
													</td>
													<td class="td-center">
														<div class="icheckbox icheckbox-primary"><input disabled name="ckr" ng-click="ckrDetailClickExport($index)" id="ckrExport{{$index}}" class="styled" type="checkbox"><label class="cursor-pointer" for="ckrExport{{$index}}"></label></div>
													</td>
													
												</tr>
			
											</tbody>
										</table>
									</div>
								</div>
								<div class="chart tab-pane" id="tabReport">
									<div class="col-sm-12 table-responsive">
										<table class="table" my-main-directive>
											<tr>
												<th class="width-80 td-center">
													<div class="icheckbox icheckbox-primary"><input name="ckrReport" ng-click="ckrReportAll()" id="ckrReportAll" class="styled" type="checkbox"><label class="cursor-pointer" for="ckrReportAll"></label></div>
												</th>
												<th>Report Name</th>
											</tr>
											<tbody id="data_table_role_report">
												<tr ng-repeat="u in module" ng-if="u.moduleName == 'Report' || u.groupType == 'Report' || u.groupModule == 'Report'" my-repeat-directive >
													<td class="td-center">
														<div class="icheckbox icheckbox-primary"><input name="ckrReport" ng-click="ckrDetailClickReportAccess($index)" id="ckrReportAccess{{$index}}" class="styled" type="checkbox"><label class="cursor-pointer" for="ckrReportAccess{{$index}}"></label></div>
													</td>
													<td row-code="{{u.moduleId}}">{{u.moduleName}}</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
						
					</div>
				</div>
			</div>
		</form>
		<div id="errors"></div>
	</section>
</div>
<jsp:include page="${request.contextPath}/footer"></jsp:include>

