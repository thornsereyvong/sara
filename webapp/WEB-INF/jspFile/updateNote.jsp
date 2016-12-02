<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>




<style>
.font-label {
	font-size: 13px;
	padding-top: 4px;
}
</style>


<div class="content-wrapper" ng-app="campaign" ng-controller="campController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Update Note</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"><i class="fa fa-dashboard"></i> Update Note</a></li>
		</ol>
	</section>
<script type="text/javascript">

var app = angular.module('campaign', []);
var self = this;

var noteId = '';

app.controller('campController',['$scope','$http',function($scope, $http){


}]);



function listDataByCampID(){
	var data = ${note};
	var result = data.body.DATA;
	
	noteId = result.noteId;
        
	$("#me_id").val(result.noteId);
	$("#me_subject").val(result.noteSubject);
	$("#me_description").val(result.noteDes);


	if(result.noteRelatedToModuleType == null || result.noteRelatedToModuleType == ""){
		$("#me_relateTo").select2("val","");
	}else{
		$("#me_relateTo").select2("val",result.noteRelatedToModuleType);
	}
	
	funcRelateTo("#me_reportType",result.noteRelatedToModuleType, result.noteRelatedToModuleId);
	
	
}

$(document).ready(function() {
	$(".select2").select2();
	listDataByCampID();
	$("#me_relateTo").change(function(){
		var relate = $("#me_relateTo").val();
		funcRelateTo("#me_reportType",relate,"");
	});
	
	$('.date2').daterangepicker({
        singleDatePicker: true,
        showDropdowns: true,
        format: 'DD/MM/YYYY' 
    });

    
	$(".timepicker").timepicker({
        showInputs: false,
        defaultTime: false
      });
    
	
	
	$("#btn_clear").click(function(){
		location.reload();
	});
	
	 $("#btn_save").click(function(){
		$("#form-note").submit();
	});


		
	$('#form-note').bootstrapValidator({
			message: 'This value is not valid',
			feedbackIcons: {
				valid: 'glyphicon glyphicon-ok',
				invalid: 'glyphicon glyphicon-remove',
				validating: 'glyphicon glyphicon-refresh'
			},
			fields: {
				me_subject: {
					validators: {
						notEmpty: {
							message: 'The Subject is required and can not be empty!'
						},
						stringLength: {
							max: 255,
							message: 'The Subject must be less than 255 characters long.'
						}
					}
				},
				me_description: {
					validators: {
						stringLength: {
							max: 1000,
							message: 'The description must be less than 1000 characters long.'
						}
					}
				}
				
			}
		}).on('success.form.bv', function(e) {
			
			swal({   
				title: "<span style='font-size: 25px;'>You are about to update note.</span>",
				text: "Click OK to continue or CANCEL to abort.",
				type: "info",
				html: true,
				showCancelButton: true,
				closeOnConfirm: false,
				showLoaderOnConfirm: true,		
			}, function(){ 
				setTimeout(function(){
					$.ajax({ 
						url : "${pageContext.request.contextPath}/note/edit",
						type : "PUT",
						data : JSON.stringify({
							  "noteId": noteId,
							  "noteSubject": getValueStringById("me_subject"),
						      "noteRelatedToModuleType":  getValueStringById("me_relateTo"),
						      "noteRelatedToModuleId": getValueStringById("me_reportType"),
						      "noteDes": getValueStringById("me_description"),
						      "noteCreateBy": $.session.get("parentID")						     
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
								setTimeout(function(){
									window.location.href = "${pageContext.request.contextPath}/list-notes";
								}, 2000);
																															
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
		});	
});
</script>
	<section class="content">

		<!-- Default box -->
		
		<div class="box box-danger">
			
			<div class="box-body">
			
			<form method="post" id="form-note">
				
				<button type="button" class="btn btn-info btn-app" id="btn_save" > <i class="fa fa-save"></i> Save</button> 
				<a class="btn btn-info btn-app" id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
				<a class="btn btn-info btn-app"  href="${pageContext.request.contextPath}/list-notes"> <i class="fa fa-reply"></i> Back </a>

				<div class="clearfix"></div>

				<div class="col-sm-2">
					<h4>Overview</h4>
				</div>

				<div class="col-sm-12">
					<hr style="margin-top: 3px;" />
				</div>

				<div class="row">
					<div class="col-sm-12">
					<div class="col-sm-6">

						

						<div class="col-sm-12">
							<label class="font-label">Subject <span class="requrie">(Required)</span></label>
							<div class="form-group" id="c_name">
								<input type="text" class="form-control" name="me_subject" id="me_subject">
							</div>
						</div>
						
						<div class="clearfix"></div>
						
						
						
						
					</div>

					<div class="col-sm-6">

						<div class="clearfix"></div>
						<div class="col-sm-6">
							<label class="font-label">Related To :</label>
							<div class="form-group">
								<select class="form-control select2" name="me_relateTo" id="me_relateTo">
									<option value="">--SELECT Related--</option>
									<optgroup label="Marketing">
										<option value="Campaign">Campaign</option>
										<option value="Lead">Lead</option>
									</optgroup>
									<optgroup label="Sales">
										<option value="Customer">Customer</option>
										<option value="Contact">Contact</option>
										<option value="Opportunity">Opportunity</option>
									</optgroup>
									<optgroup label="Activities">
										<option value="Task">Tasks</option>
									</optgroup>
									<optgroup label="Support">
										<option value="Case">Case</option>
									</optgroup>
									
								</select>
							</div>
						</div>
						
						<div class="col-sm-6">
							<label class="font-label">&nbsp;</label>
							<div class="form-group">
								<select class="form-control select2" name="me_reportType" id="me_reportType">
									<option value="">--SELECT--</option>
								</select>
							</div>
						</div>

					</div>
					
					<div class="clearfix"></div>
					<div class="col-sm-12">
						<div class="col-sm-12">
							<label class="font-label">Description </label>
							<div class="form-group">
								<textarea style="height: 120px" rows="" cols="" name="me_description" id="me_description"	class="form-control"></textarea>
							</div>
						</div>
					</div>
					<div class="clearfix"></div>
					
					</div>

				</div>

			</form>
			</div>
			<!-- /.box-body -->
			<div class="box-footer"><div id="test_div"></div></div>
			<!-- /.box-footer-->
		</div>
		
		<!-- /.box -->


	</section>
	<!-- /.content -->


</div>

<!-- /.content-wrapper -->


<jsp:include page="${request.contextPath}/footer"></jsp:include>

