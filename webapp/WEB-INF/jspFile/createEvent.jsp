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
		<h1>Create Event</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Create Event</a></li>
		</ol>
	</section>
<script type="text/javascript">

var app = angular.module('campaign', ['oitozero.ngSweetAlert',]);
var self = this;
app.controller('campController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){

	$scope.listMeetignStatus = function(){
		$http.get("${pageContext.request.contextPath}/event_location/list")
		.success(function(response){
				$scope.status = response.DATA;
			});
		};	


}]);




$(document).ready(function() {

	
	 
	var data = ${users};
	$(".select2").select2();
	
	$('.date2').daterangepicker({
        singleDatePicker: true,
        showDropdowns: true,
        format: 'DD/MM/YYYY' 
    });


	userAllList(data,'#assignTo','');
	
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
				name: {
					validators: {
						notEmpty: {
							message: 'The Subject is required and can not be empty!'
						}
					}
				},
				startDate: {
					validators: {
						notEmpty: {
							message: 'The Start Date is required and can not be empty!'
						}
					}
				},
				endDate: {
					validators: {
						notEmpty: {
							message: 'The End Date is required and can not be empty!'
						}
					}
				}
				
			}
		}).on('success.form.bv', function(e) {

			var currentDate = new Date();
			var day = currentDate.getDate();
			var month = currentDate.getMonth() + 1;
			var year = currentDate.getFullYear();


			var createDate = $("#startDate").val();
			var newCreateDate = createDate.split("/").reverse().join("-");
			
			var endDate = $("#endDate").val();
			var endCreateDate = endDate.split("/").reverse().join("-");

			

		    var assign = "";	
			if($("#assignTo").val()  != ""){
				assign = {"userID": $("#assignTo").val()};
			}else{
				assign = null;
			}

			var location = "";	
			if($("#location").val()  != ""){
				location = {"loId": $("#location").val()};
			}else{
				location = null;
			}

			$.ajax({
				url : "${pageContext.request.contextPath}/event/add",
				type : "POST",
				data : JSON.stringify({
					  "evName": $("#name").val(),
				      "evlocation": location,
				      "evBudget": $("#budget").val(),
				      "evDes": $("#description").val(),
				      "evCreateBy":  $.session.get("parentID"),
				      "evDuration": $("#duration").val(),
				      "evStartDate": newCreateDate,
				      "evEndDate": endCreateDate,
				      "assignTo": assign,
				      "evCreateDate":  year+"-"+month+"-"+day 
					}),
				beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
						    },
				success:function(data){
					
						$("#form-call").bootstrapValidator('resetForm', 'true');
						$('#form-call')[0].reset();
						$("#location").select2("val","");
						$("#assignTo").select2("val","");
						$("#duration").select2("val","");
						
						swal({
		            		title:"Success",
		            		text:"User have been created new Event!",
		            		type:"success",  
		            		timer: 2000,   
		            		showConfirmButton: false
	        			});
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
				<a class="btn btn-info btn-app"  href="${pageContext.request.contextPath}/list-events"> <i class="fa fa-reply"></i> Back </a>

				<div class="clearfix"></div>

				<div class="col-sm-2">
					<h4>Overview</h4>
				</div>

				<div class="col-sm-12">
					<hr style="margin-top: 3px;" />
				</div>

				<div class="row">

					<div class="col-sm-6">

						

						<div class="col-sm-2">
							<label class="font-label">Name :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group" id="c_name">
								<input type="text" class="form-control" name="name" id="name">
							</div>
						</div>
						<div class="col-sm-2" data-ng-init="listMeetignStatus()">
							<label class="font-label">Location : </label>
						</div>
						<div class="col-sm-4" >
							<div class="form-group">
								<select class="form-control select2"  name="location" id="location" style="width: 100%;">
			                      <option value="">-- Select Location</option>
			                      <option ng-repeat="u in status" value="{{u.loId}}">{{u.loName}}</option>            
			                    </select>
							</div>
						</div>
						<div class="clearfix"></div>
						
						<div class="col-sm-2">
							<label class="font-label">Duration :</label>
						</div>
						<div class="col-sm-4">
							<div class="bootstrap-timepicker">
			                    <div class="form-group">
			                    	<select class="form-control select2"  name="duration" id="duration" style="width: 100%;">
				                      <option value="">--Select Duration--</option>   
				                      <option value="15 minutes">15 minutes</option>
				                      <option value="30 minutes">30 minutes</option>
				                      <option value="45 minutes">45 minutes</option> 
				                      <option value="1 hour">1 hour</option> 
				                      <option value="1:30 hours">1:30 hours</option> 
				                      <option value="2 hours">2 hours</option> 
				                      <option value="3 hours">3 hours</option> 
				                      <option value="6 hours">6 hours</option> 
				                      <option value="1 day">1 day</option>
				                      <option value="2 days">2 days</option>
				                      <option value="3 days">3 days</option>
				                      <option value="1 week">1 week</option>         
				                    </select>
			                    </div>
			                  </div>
						</div>
						<div class="col-sm-2">
							<label class="font-label">Assigned to : </label>
						</div>
						<div class="col-sm-4" >
							<div class="form-group">
								<select class="form-control select2"  name="assignTo" id="assignTo" style="width: 100%;">
			                      <option value=""></option>           
			                    </select>
							</div>
						</div>
						<div class="clearfix"></div>
						<div class="col-sm-2">
							<label class="font-label">Description :</label>
						</div>
						<div class="col-sm-10">
							<div class="form-group">
								<textarea style="height: 120px" rows="" cols="" name="description" id="description"	class="form-control"></textarea>
							</div>
						</div>
					</div>

					<div class="col-sm-6">
						<div class="col-sm-2">
							<label class="font-label">Start Date :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
									<input type="text" class="form-control pull-right date2" name="startDate" id="startDate">
								</div> 
							</div>
						</div>
						<div class="col-sm-2">
							<label class="font-label">End Date :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
									<input type="text" class="form-control pull-right date2" name="endDate" id="endDate">
								</div> 
							</div>
						</div>
						<div class="clearfix"></div>
						<div class="col-sm-2">
							<label class="font-label">Budget :</label>
						</div>
						<div class="col-sm-4">
							<div class="form-group" id="">
								<input type="text" class="form-control" name="budget" id="budget">
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

