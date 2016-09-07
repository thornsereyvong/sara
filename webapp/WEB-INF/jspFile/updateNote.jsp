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
		<h1>Create Note</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Create Note</a></li>
		</ol>
	</section>
<script type="text/javascript">

var app = angular.module('campaign', ['oitozero.ngSweetAlert',]);
var self = this;
app.controller('campController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){


}]);


function listDataByCampID(){
	var data = ${note};
	var result = data.body.DATA;
	
	
        
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
		$("#form-call").bootstrapValidator('resetForm', 'true');
	});
	
	 $("#btn_save").click(function(){
		$("#form-call").submit();
	});


		
	$('#form-call').bootstrapValidator({
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
							max: 255,
							message: 'The description must be less than 255 characters long.'
						}
					}
				}
				
			}
		}).on('success.form.bv', function(e) {

			var currentDate = new Date();
			var day = currentDate.getDate();
			var month = currentDate.getMonth() + 1;
			var year = currentDate.getFullYear();


		

			$.ajax({
				url : "${pageContext.request.contextPath}/note/edit",
				type : "PUT",
				data : JSON.stringify({
					  "noteId": $("#me_id").val(),
				      "noteSubject": $("#me_subject").val(),
				      "noteRelatedToModuleType":  $("#me_relateTo").val(),
				      "noteRelatedToModuleId": $("#me_reportType").val(),
				      "noteDes": $("#me_description").val(),
				      "noteModifiedBy": $.session.get("parentID")
				     
					}),
				beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
						    },
				success:function(data){
					
						$("#form-call").bootstrapValidator('resetForm', 'true');
						$('#form-call')[0].reset();
						
						$("#me_relateTo").select2("val","");
						$("#me_reportType").select2("val","");
						
						swal({
		            		title:"Success",
		            		text:"User have been Update Note!",
		            		type:"success",  
		            		timer: 2000,   
		            		showConfirmButton: false
	        			});
						setTimeout(function(){
							window.location.href = "${pageContext.request.contextPath}/list-notes/";
						}, 2000);
					},
				error:function(){
					errorMessage();
					}
				});  
			
		});	


		
	
	
});
</script>
	<section class="content">

		<!-- Default box -->
		
		<div class="box box-danger">
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
			</div>
			<div class="box-body">
			
			<form method="post" id="form-call">
				
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

					<div class="col-sm-6">

						
						<input type="hidden" id="me_id">
						<div class="col-sm-12">
							<label class="font-label">Subject <span class="requrie">(Required)</span></label>
							<div class="form-group" id="c_name">
								<input type="text" class="form-control" name="me_subject" id="me_subject">
							</div>
						</div>
						
						<div class="clearfix"></div>
						
						
						<div class="clearfix"></div>
						<div class="col-sm-12">
							<label class="font-label">Description </label>
							<div class="form-group">
								<textarea style="height: 120px" rows="" cols="" name="me_description" id="me_description"	class="form-control"></textarea>
							</div>
						</div>
						
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

