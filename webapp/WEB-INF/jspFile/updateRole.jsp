<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>

<script src="${pageContext.request.contextPath}/resources/customJS/role.js"></script>

<style>
.no-margin{
margin-bottom:0;
}
</style>
<script type="text/javascript">



var data = ${role};
var result = data.body.DATA;
var self = this;

var app = angular.module('campaign', ['angularUtils.directives.dirPagination','oitozero.ngSweetAlert']);

app.directive('myRepeatDirective', function() {	
	
	 return function(scope, element, attrs) {
		 if (scope.$last){
			 
		  	$('.btn-on-off').bootstrapToggle(); 
		  		
		}			    
	};
});
				

app.controller('campController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){

	
	$scope.sort = function(keyname){
	    $scope.sortKey = keyname;   //set the sortKey to the param passed
	    $scope.reverse = !$scope.reverse; //if true make it false and vice versa
	};
	
	
	$scope.deleteStat = function(leadID){
		SweetAlert.swal({
            title: "Are you sure?", //Bold text
            text: "This Status will not be able to recover!", //light text
            type: "warning", //type -- adds appropiriate icon
            showCancelButton: true, // displays cancel btton
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Yes, delete!",
            closeOnConfirm: false, //do not close popup after click on confirm, usefull when you want to display a subsequent popup
            closeOnCancel: false
        }, 
        function(isConfirm){ //Function that triggers on user action.
            if(isConfirm){
	            $http.delete("${pageContext.request.contextPath}/camp_status/remove/"+leadID)
	            .success(function(){
	            		SweetAlert.swal({
			            		title:"Deleted",
			            		text:"Status have been deleted!",
			            		type:"success",  
			            		timer: 2000,   
			            		showConfirmButton: false
	            		});
	            		$scope.listStatus();
		            });
	           
            } else {
                SweetAlert.swal({
	                title:"Cancelled",
	                text:"This Status is safe!",
	                type:"error",
	                timer:2000,
	                showConfirmButton: false});
            }
        });
	};
	
}]);



function getRoleID(){


	var data = ${role};
	var result = data.body.DATA;
	
	$("#id").val(result.roleId);
	$("#name").val(result.roleName);
	$("#desc").val(result.description);
	
	$("#data_table_role").empty();
	
	$.each(result.roleDetails, function(key, value){


		var ac = "";
		if (value.roleAccess == "YES"){			
			ac = "checked='checked'";
		}else{
			
			ac = "";
			
		}
		
		
		var ed = "";
		if (value.roleEdit == "YES"){
			ed = "checked='checked'";
		}else{
			ed = "";
			
		}

		var de = "";
		if (value.roleDelete == "YES"){
			de = "checked='checked'";
		}else{
			de = "";
			
		}

		var ex = "";
		if (value.roleExport == "YES")
			ex = "checked='checked'";
		else
			ex = "";

		var inp = "";
		if (value.roleImport == "YES")
			inp = "checked='checked'";
		else
			inp = "";

		var li = "";
		if (value.roleList == "YES")
			li = "checked='checked'";
		else
			li = "";

		var vi = "";
		if (value.roleView == "YES")
			vi = "checked='checked'";
		else
			vi = "";

		
	
		var op_tr = "<tr my-repeat-directive >";
		var tr_module = "<td row-code='"+value.module.moduleId+"' >"+value.module.moduleName+"</td>";
		
		var tr_acc = "<td>"+
						  "<div class='form-group no-margin'>"+
				           "<label class='no-margin'>"+
				             "<input class='btn-on-off' data-on='YES' id='accID"+value.module.moduleId+"' data-off='NO' "+ac+" data-onstyle='success' data-offstyle='warning' data-size='small' type='checkbox'>"+
				            "</label>"+ 
				          "</div>"+	
						"</td>";
						
		var tr_ed = "<td>"+
						  "<div class='form-group no-margin'>"+
				           "<label class='no-margin'>"+
				             "<input class='btn-on-off' data-on='YES' id='editID"+value.module.moduleId+"' data-off='NO' "+ed+" data-onstyle='success' data-offstyle='warning' data-size='small' type='checkbox'>"+
				            "</label>"+ 
				          "</div>"+	
						"</td>";
						
		var tr_vi = "<td>"+
						  "<div class='form-group no-margin'>"+
				           "<label class='no-margin'>"+
				             "<input class='btn-on-off' data-on='YES' id='viewID"+value.module.moduleId+"' data-off='NO' "+vi+" data-onstyle='success' data-offstyle='warning' data-size='small' type='checkbox'>"+
				            "</label>"+ 
				          "</div>"+	
						"</td>";
						
		var tr_li = "<td>"+
						  "<div class='form-group no-margin'>"+
				           "<label class='no-margin'>"+
				             "<input class='btn-on-off' data-on='YES' id='listID"+value.module.moduleId+"' data-off='NO' "+li+" data-onstyle='success' data-offstyle='warning' data-size='small' type='checkbox'>"+
				            "</label>"+ 
				          "</div>"+	
						"</td>";
						
		var tr_de = "<td>"+
						  "<div class='form-group no-margin'>"+
				           "<label class='no-margin'>"+
				             "<input class='btn-on-off' data-on='YES' id='deleteID"+value.module.moduleId+"' data-off='NO' "+de+" data-onstyle='success' data-offstyle='warning' data-size='small' type='checkbox'>"+
				            "</label>"+ 
				          "</div>"+	
						"</td>";
						
		var tr_inp = "<td>"+
						  "<div class='form-group no-margin'>"+
				           "<label class='no-margin'>"+
				             "<input class='btn-on-off' data-on='YES' id='importID"+value.module.moduleId+"' data-off='NO' "+inp+" data-onstyle='success' data-offstyle='warning' data-size='small' type='checkbox'>"+
				            "</label>"+ 
				          "</div>"+	
						"</td>";
						
		var tr_ex = "<td>"+
						  "<div class='form-group no-margin'>"+
				           "<label class='no-margin'>"+
				             "<input class='btn-on-off' data-on='YES' id='exportID"+value.module.moduleId+"' data-off='NO' "+ex+" data-onstyle='success' data-offstyle='warning' data-size='small' type='checkbox'>"+
				            "</label>"+ 
				          "</div>"+	
						"</td>";
							
		var cl_tr = "</tr>";

		
		$("#data_table_role").append(op_tr+tr_module+tr_acc+tr_ed+tr_vi+tr_li+tr_de+tr_inp+tr_ex+cl_tr);
	}); 
	
	
}

function getRoleDetailByModule(element){
	var access = element.children().children().children().eq(0).attr("class");
	access = access.search("off");
	if(access>0){
		return "NO";
	}else{
		return "YES";
	}
}


$(document).ready(function(){
	$(".select2").select2();
	
	getRoleID();


	

	
	setTimeout(function(){

		var tr = $("#data_table_role").children();
		
		var access = getRoleDetailByModule(tr.eq(0).children().eq(1));
		if(access == "YES"){	
			enableCA();
		}else{
			turnOffCA();
			disableCA();
		}

		var access1 = getRoleDetailByModule(tr.eq(1).children().eq(1));
		
		if(access1 == "YES"){	
			enableLE();
		}else{	
			turnOffLE();
			disableLE();
		}


		var access2 = getRoleDetailByModule(tr.eq(2).children().eq(1));
		if(access2 == "YES"){	
			enableOP();
		}else{	
			turnOffOP();
			disableOP();
		}	


		
		var access3 = getRoleDetailByModule(tr.eq(3).children().eq(1));
		if(access3 == "YES"){	
			enableAC();
		}else{	
			turnOffAC();
			disableAC();
		}	


		var access4 = getRoleDetailByModule(tr.eq(4).children().eq(1));
		if(access4 == "YES"){	
			enableAC_EV();
		}else{	
			turnOffAC_EV();
			disableAC_EV();
		}	


		var access5 = getRoleDetailByModule(tr.eq(5).children().eq(1));
		if(access5 == "YES"){	
			enableAC_NO();
		}else{	
			turnOffAC_NO();
			disableAC_NO();
		}	

		var access6 = getRoleDetailByModule(tr.eq(6).children().eq(1));
		if(access6 == "YES"){	
			enableAC_TA();
		}else{	
			turnOffAC_TA();
			disableAC_TA();
		}	

		var access7 = getRoleDetailByModule(tr.eq(7).children().eq(1));
		if(access7 == "YES"){	
			enableAC_ME();
		}else{	
			turnOffAC_ME();
			disableAC_ME();
		}	


		var access8 = getRoleDetailByModule(tr.eq(8).children().eq(1));
		if(access8 == "YES"){	
			enableAC_CL();
		}else{	
			turnOffAC_CL();
			disableAC_CL();
		}


		var access9 = getRoleDetailByModule(tr.eq(9).children().eq(1));
		if(access9 == "YES"){	
			enableCS();
		}else{	
			turnOffCS();
			disableCS();
		}	


		var access10 = getRoleDetailByModule(tr.eq(10).children().eq(1));
		if(access10 == "YES"){	
			enableCO();
		}else{	
			turnOffCO();
			disableCO();
		}


		var access11= getRoleDetailByModule(tr.eq(11).children().eq(1));
		if(access11 == "YES"){	
			enableLOC();
		}else{	
			turnOffLOC();
			disableLOC();
		}	


		var access12 = getRoleDetailByModule(tr.eq(12).children().eq(1));
		if(access12 == "YES"){	
			enableCUST();
		}else{	
			turnOffCUST();
			disableCUST();
		}					

	},1000);


	setTimeout(function(){

		$("#accIDCA").change(function(){
			var tr = $("#data_table_role").children();
			var access = getRoleDetailByModule(tr.eq(0).children().eq(1));
			if(access == "YES"){	
				enableCA();
			}else{
				turnOffCA();
				disableCA();
			}	
		});

		
		$("#accIDLE").change(function(){
			var tr = $("#data_table_role").children();
			var access = getRoleDetailByModule(tr.eq(1).children().eq(1));
			if(access == "YES"){	
				enableLE();
			}else{	
				turnOffLE();
				disableLE();
			}	
		});


		
		$("#accIDOP").change(function(){
			var tr = $("#data_table_role").children();
			var access = getRoleDetailByModule(tr.eq(2).children().eq(1));
			if(access == "YES"){	
				enableOP();
			}else{	
				turnOffOP();
				disableOP();
			}	
		});

		$("#accIDAC").change(function(){
			var tr = $("#data_table_role").children();
			var access = getRoleDetailByModule(tr.eq(3).children().eq(1));
			if(access == "YES"){	
				enableAC();
			}else{	
				turnOffAC();
				disableAC();
			}	
		});

		$("#accIDAC_EV").change(function(){
			var tr = $("#data_table_role").children();
			var access = getRoleDetailByModule(tr.eq(4).children().eq(1));
			if(access == "YES"){	
				enableAC_EV();
			}else{	
				turnOffAC_EV();
				disableAC_EV();
			}	
		});

		$("#accIDAC_NO").change(function(){
			var tr = $("#data_table_role").children();
			var access = getRoleDetailByModule(tr.eq(5).children().eq(1));
			if(access == "YES"){	
				enableAC_NO();
			}else{	
				turnOffAC_NO();
				disableAC_NO();
			}	
		});

		$("#accIDAC_TA").change(function(){
			var tr = $("#data_table_role").children();
			var access = getRoleDetailByModule(tr.eq(6).children().eq(1));
			if(access == "YES"){	
				enableAC_TA();
			}else{	
				turnOffAC_TA();
				disableAC_TA();
			}	
		});

		$("#accIDAC_ME").change(function(){
			var tr = $("#data_table_role").children();
			var access = getRoleDetailByModule(tr.eq(7).children().eq(1));
			if(access == "YES"){	
				enableAC_ME();
			}else{	
				turnOffAC_ME();
				disableAC_ME();
			}	
		});

		$("#accIDAC_CL").change(function(){
			var tr = $("#data_table_role").children();
			var access = getRoleDetailByModule(tr.eq(8).children().eq(1));
			if(access == "YES"){	
				enableAC_CL();
			}else{	
				turnOffAC_CL();
				disableAC_CL();
			}	
		});

		$("#accIDCS").change(function(){
			var tr = $("#data_table_role").children();
			var access = getRoleDetailByModule(tr.eq(9).children().eq(1));
			if(access == "YES"){	
				enableCS();
			}else{	
				turnOffCS();
				disableCS();
			}	
		});

		$("#accIDCO").change(function(){
			var tr = $("#data_table_role").children();
			var access = getRoleDetailByModule(tr.eq(10).children().eq(1));
			if(access == "YES"){	
				enableCO();
			}else{	
				turnOffCO();
				disableCO();
			}	
		});

		$("#accIDLOC").change(function(){
			var tr = $("#data_table_role").children();
			var access = getRoleDetailByModule(tr.eq(11).children().eq(1));
			if(access == "YES"){	
				enableLOC();
			}else{	
				turnOffLOC();
				disableLOC();
			}	
		});


		$("#accIDCUST").change(function(){
			var tr = $("#data_table_role").children();
			var access = getRoleDetailByModule(tr.eq(12).children().eq(1));
			if(access == "YES"){	
				enableCUST();
			}else{	
				turnOffCUST();
				disableCUST();
			}	
		});
		


	}, 1000);

	
	
	
	$('.btn-on-off').bootstrapToggle(); 
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
		var currentDate = new Date();
		var day = currentDate.getDate();
		var month = currentDate.getMonth() + 1;
		var year = currentDate.getFullYear();

		
	
			var tr = $("#data_table_role").children();
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
				          "module":{"moduleId": moduleId},
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
					  "roleId": $("#id").val(),
				      "roleName": $("#name").val(),
				      "description": $("#desc").val(),
				      "roleDetails": roleDetails,
				      "modifyBy": $.session.get("parentID"),
				      "roleStatus": 1
					}),
				beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
						    },
				success:function(data){
					
						$("#form_status").bootstrapValidator('resetForm', 'true');
						$('#form_status')[0].reset();
						$('.btn-on-off').bootstrapToggle('off');
						
						swal({
		            		title:"Success",
		            		text:"User have been created new Role!",
		            		type:"success",  
		            		timer: 2000,   
		            		showConfirmButton: false
	        			});
						setTimeout(function(){
							window.location.href = "${pageContext.request.contextPath}/role-management";
						}, 2000);
						//angular.element("#campController").scope().listStatus();
					},
				error:function(){
					errorMessage();
					}
				});  
				
	});	
});
</script>

<div class="content-wrapper" ng-app="campaign" id="campController" ng-controller="campController">
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
				
				 <div class="col-sm-12">
				 	<button type="button" class="btn btn-info btn-app" id="btn_save" value="{{action}}"> <i class="fa fa-save"></i>Save</button> 
				 	
					<a class="btn btn-info btn-app" id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
					<a class="btn btn-info btn-app"  href="${pageContext.request.contextPath}/role-management"> <i class="fa fa-reply"></i> Back </a>
				 </div>
				 
				  
				  <div class="col-sm-12">
					<hr style="margin-bottom: 7px;;margin-top: 0px;" />
				 </div> 
				  
			</div>
			</div>
			
			<div class="box-body" >
			
				<div class="col-sm-12">
				 		
						 <input type="hidden" id="id" name="id">
						
						 <div class="col-sm-2">
							<label class="font-label">Role Name :</label>
						</div>
						<div class="col-sm-10">
							<div class="form-group" id="c_name">
								<input type="text" class="form-control" name="name" id="name" >
							</div>
						</div>
				 		<div class="col-sm-2">
							<label class="font-label">Description :</label>
						</div>
						<div class="col-sm-10">
							<div class="form-group">
								<textarea style="height: 120px" rows="" cols="" name="desc" id="desc"  class="form-control"></textarea>
							</div>
						</div>
						<div class="col-sm-12 table-responsive" >
							<table class="table" my-main-directive >
								<tr>
									<th >Module</th>
									<th >Access</th>
									<th >Edit</th>	
									<th >View</th>
									<th >List</th>
									<th >Delete</th>
									<th >Import</th>
									<th >Export</th>
								</tr>
								<tbody id="data_table_role">
								
								
								</tbody>
							</table>
						</div>
						
						
					
				 </div>
			
			</div>
			<!-- /.box-body -->
			<div class="box-footer"></div>
			<!-- /.box-footer-->
		</div>
		</form>
		<!-- /.box -->


	</section>
	<!-- /.content -->


</div>

<!-- /.content-wrapper -->

<script>
  $(function() {
    
  })
</script>
<jsp:include page="${request.contextPath}/footer"></jsp:include>

