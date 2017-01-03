<%@page import="com.app.entities.CrmCampaign"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>

<style>
.font-label {
	font-size: 13px;
	padding-top: 4px;
}
</style>
<div class="content-wrapper" ng-app="campaign"
	ng-controller="campController" id="campController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Update Campaign</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i
					class="fa fa-home"></i> Home</a></li>
			<li><a href="#"> Update Campaign</a></li>
		</ol>
	</section>
	<script type="text/javascript">
		var app = angular.module('campaign', ['angular-loading-bar', 'ngAnimate']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
		    cfpLoadingBarProvider.includeSpinner = false;
		}]);
		var self = this;
		var campId = "${campId}";
		var username = "${SESSION}";
		app.controller('campController',['$scope','$http',function($scope, $http) {
			$scope.editCampaignOnStartup = function() {
				$http({
						method : 'GET',
						url : '${pageContext.request.contextPath}/edit/startup/'+campId+'/'+username,
						headers : {
							'Accept' : 'application/json',
							'Content-Type' : 'application/json'
						}
				}).success(function(response) {
					addCampaignDataToForm(response);
					if (response.CHILD == "EXIST") {}
				});
			};
		}]);

		function listCampaignStatus(statusId, status) {
			$("#cam_status").empty().append(
					'<option value="">-- SELECT Status --</option>');
			$.each(status, function(key, value) {
				var div = "<option value='"+value.statusID+"' >"
						+ value.statusName + "</option>";
				$("#cam_status").append(div);
			});
			$("#cam_status").select2("val", statusId);
		}

		function listCampaignType(typeId, type) {
			$("#cam_type").empty().append(
					'<option value="">-- SELECT Type --</option>');
			$.each(type, function(key, value) {
				var div = "<option value='"+value.typeID+"' >" + value.typeName
						+ "</option>";
				$("#cam_type").append(div);
			});
			$("#cam_type").select2("val", typeId);
		}

		function listParentCampaign(campId, parentCampaign) {
			$("#cam_parent").empty().append(
					'<option value="">-- SELECT Parent --</option>');
			if (parentCampaign != "") {
				$.each(parentCampaign, function(key, value) {
					var div = "<option value='"+value.campID+"' >"
							+'['+ value.campID+'] '+value.campName + "</option>";
					$("#cam_parent").append(div);
				});
				$("#cam_parent").select2("val", campId);
			}
			$("#cam_parent").select2("val", "");
		}

		function addCampaignDataToForm(response) {

			var result = response.CAMPAIGN;
			$("#cam_id").val(result.campID);
			$("#cam_name").val(result.campName);
			$("#cam_startDate").val(conDateSqlToNormal(result.startDate, "/"));
			$("#cam_endDate").val(conDateSqlToNormal(result.endDate, "/"));
			$("#cam_description").val(result.description);
			$("#cam_budget").val(result.budget);
			$("#cam_actualCost").val(result.actualCost);
			$("#cam_expectedCost").val(result.expectedCost);
			$("#cam_expectedRevenue").val(result.expectedRevenue);
			$("#cam_numSend").val(result.numSend);
			$("#cam_expectedResponse").val(result.expectedResponse);

			userAllList(response.ASSIGN_TO, '#cam_assignTo', result.userID);

			if (result.statusID == null || result.statusID == "") {
				listCampaignStatus("", response.CAMP_STATUS);
			} else {
				listCampaignStatus(result.statusID, response.CAMP_STATUS);
			}

			if (result.typeID == null || result.typeID == "") {
				listCampaignType("", response.CAMP_TYPE);
			} else {
				listCampaignType(result.typeID, response.CAMP_TYPE);
			}

			if (result.parentID == null || result.parentID == "") {
				listParentCampaign("", response.CAMP_PARENT);
			} else {
				listParentCampaign(result.campID, response.CAMP_PARENT);
			}
			
			
			$('#form-campaigns').data('bootstrapValidator').resetField($('#cam_status'));
			$('#form-campaigns').data('bootstrapValidator').resetField($('#cam_type'));
			
		}

		$(document).ready(function() {
			$(".select2").select2();
			$('#cam_startDate').daterangepicker({
				singleDatePicker : true,
				showDropdowns : true,
				format : 'DD/MM/YYYY'
			}).on('change',function(e) {
				$('#form-campaigns').bootstrapValidator('revalidateField','cam_startDate');
			});
			$('#cam_endDate').daterangepicker({
				singleDatePicker : true,
				showDropdowns : true,
				format : 'DD/MM/YYYY'
			}).on('change',function(e) {
				$('#form-campaigns').bootstrapValidator('revalidateField','cam_endDate');
			});
			$('#cam_startDate').daterangepicker({
		        singleDatePicker: true,
		        showDropdowns: true,
		        format: 'DD/MM/YYYY' 
		    }).on('change', function(e) {

				if($("#cam_startDate").val() != ""){
					$('#form-campaigns').bootstrapValidator('revalidateField', 'cam_startDate');
				}	
		  
			});
			
			function clearForm() {
				$("#cam_startDate").val("");
				$("#cam_parent").val("");
				$("#cam_description").val("");
				$("#cam_assignTo").val("");
			}

			
			$("#btn_clear").click(function() {
				location.reload();
			});

			$("#btn_save").click(function() {
				$("#form-campaigns").submit();
			});
			$('#form-campaigns').bootstrapValidator({
				message : 'This value is not valid',
				feedbackIcons : {
					valid : 'glyphicon glyphicon-ok',
					invalid : 'glyphicon glyphicon-remove',
					validating : 'glyphicon glyphicon-refresh'
				},
				fields : {
					cam_name : {
						validators : {
							notEmpty : {
								message : 'The name is required and can not be empty!'
							},
							stringLength: {
								max: 255,
								message: 'The name must be less than 255 characters long.'
							}
						}
					},
					cam_description : {
						validators : {
							
							stringLength: {
								max: 1000,
								message: 'The description must be less than 1000 characters long.'
							}
						}
					},
					
					cam_status : {
						validators : {
							notEmpty : {
								message : 'The status is required and can not be empty!'
							}
						}
					},
					cam_type : {
						validators : {
							notEmpty : {
								message : 'The type is required and can not be empty!'
							}
						}
					},
					cam_endDate : {
						validators : {
							notEmpty : {
								message : 'The  end date is required and can not be empty!'
							},
							date: {
		                        format: 'DD/MM/YYYY',
		                        message: 'The value is not a valid date'
		                    }
						}
					},
					cam_startDate : {
						validators : {	
							date: {
		                        format: 'DD/MM/YYYY',
		                        message: 'The value is not a valid date'
		                    }
						}
					},
					cam_budget : {
						validators : {
							numeric: {
				                message: 'The value is not a number',
				                // The default separators
				                thousandsSeparator: '',
				                decimalSeparator: '.'
				            }
						}
					},
					cam_actualCost : {
						validators : {
							numeric: {
				                message: 'The value is not a number',
				                // The default separators
				                thousandsSeparator: '',
				                decimalSeparator: '.'
				            }
						}
					},
					cam_numSend : {
						validators : {
							numeric: {
				                message: 'The value is not a number',
				                // The default separators
				                thousandsSeparator: '',
				                decimalSeparator: '.'
				            }
						}
					},
					cam_expectedResponse : {
						validators : {
							between: {
		                        min: 0,
		                        max: 100,
		                        message: 'The expected response must be between 0 and 100'
		                    }
						}
					},
					cam_expectedCost : {
						validators : {
							numeric: {
				                message: 'The value is not a number',
				                // The default separators
				                thousandsSeparator: '',
				                decimalSeparator: '.'
				            }
						}
					},
					cam_expectedRevenue : {
						validators : {
							numeric: {
				                message: 'The value is not a number',
				                // The default separators
				                thousandsSeparator: '',
				                decimalSeparator: '.'
				            }
						}
					}
				}
			}).on('success.form.bv', function(e) {
				
				var dataFrm = {"campID" : campId,
							   "campName" : getValueStringById("cam_name"),								
							   "startDate" : getDateByFormat("cam_startDate"),
				               "endDate" : getDateByFormat("cam_endDate"),
				               "status" : getJsonById("statusID","cam_status","int"),
				               "type" : getJsonById("typeID","cam_type","int"),
				               "description" : getValueStringById("cam_description"),
				               "parent" : getJsonById("campID","cam_parent","str"),
				               "budget" : getInt("cam_budget"),
				               "assignTo" : getJsonById("userID","cam_assignTo","str"),
				               "actualCost" : getInt("cam_actualCost"),
							   "expectedCost" : getInt("cam_expectedCost"),
				               "expectedRevenue" : getInt("cam_expectedRevenue"),
				               "numSend" : getInt("cam_numSend"),
							   "expectedResponse" : getInt("cam_expectedResponse"),
							   "modifyBy" : username
				};
				swal({   
					title: "<span style='font-size: 25px;'>You are about to update campaign.</span>",
					text: "Click OK to continue or CANCEL to abort.",
					type: "info",
					html: true,
					showCancelButton: true,
					closeOnConfirm: false,
					showLoaderOnConfirm: true,		
				}, function(){ 
					setTimeout(function(){
						$.ajax({ 
							url : "${pageContext.request.contextPath}/campaign/edit",
							type : "PUT",
							data : JSON.stringify(dataFrm),
							beforeSend: function(xhr) {
							    xhr.setRequestHeader("Accept", "application/json");
							    xhr.setRequestHeader("Content-Type", "application/json");
						    }, 
						    success: function(result){					    						    
								if(result.MESSAGE == "UPDATED"){
									alertMsgSuccessSweetWithTxt(result.MSG);
									reloadForm(2000);
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
				
			});
		});
	</script>
	<section class="content">

		<!-- Default box -->

		<div class="box box-danger">
			<div class="box-body" data-ng-init="editCampaignOnStartup()">

				<form method="post" id="form-campaigns">

					<button type="button" class="btn btn-info btn-app" id="btn_save">
						<i class="fa fa-save"></i> Save
					</button>
					<a class="btn btn-info btn-app" id="btn_clear"> <i
						class="fa fa-refresh" aria-hidden="true"></i>Reload
					</a> <a class="btn btn-info btn-app"
						href="${pageContext.request.contextPath}/list-campaigns"> <i
						class="fa fa-reply"></i> Back
					</a>

					<div class="clearfix"></div>

					<div class="col-sm-2">
						<h4>Overview</h4>
					</div>

					<div class="col-sm-12">
						<hr style="margin-top: 3px;" />
					</div>


					<div class="row">
						<div class="col-sm-12">
							<input type="hidden" name="cam_id" id="cam_id">
							<div class="col-sm-6">
								<div class="col-sm-12">
									<label class="font-label">Name <span class="requrie">(Required)</span></label>
									<div class="form-group" id="div_camName">
										<input type="text" class="form-control" name="cam_name"
											id="cam_name" value="">
									</div>
								</div>

								<div class="col-sm-6">
									<label class="font-label">Start date </label>
									<div class="form-group">
										<div class="input-group">
											<div class="input-group-addon">
												<i class="fa fa-calendar"></i>
											</div>
											<input type="text" class="form-control pull-right"
												name="cam_startDate" id="cam_startDate">
										</div>
									</div>
								</div>

								<div class="col-sm-6">
									<label class="font-label">End date <span
										class="requrie">(Required)</span></label>
									<div class="form-group">
										<div class="input-group">
											<div class="input-group-addon">
												<i class="fa fa-calendar"></i>
											</div>
											<input type="text" class="form-control pull-right"
												name="cam_endDate" id="cam_endDate">
										</div>
									</div>
								</div>

								<div class="clearfix"></div>
								

								

							</div>

							<div class="col-sm-6">

								<div class="col-sm-6">
									<label class="font-label">Status <span class="requrie">(Required)</span></label>
									<div class="form-group">
										<select class="form-control select2" name="cam_status"
											id="cam_status" style="width: 100%;">

										</select>
									</div>
								</div>

								<div class="col-sm-6">
									<label class="font-label">Type <span class="requrie">(Required)</span></label>
									<div class="form-group">
										<select class="form-control select2" name="cam_type"
											id="cam_type" style="width: 100%;">

										</select>
									</div>
								</div>

								<div class="clearfix"></div>
								<div class="col-sm-6">
									<label class="font-label">Parent campaign </label>
									<div class="form-group">
										<select class="form-control select2" name="cam_parent"
											id="cam_parent" style="width: 100%;">
												
										</select>
									</div>
								</div>
								<div class="col-sm-6">
									<label class="font-label">Assigned to</label>
									<div class="form-group">
										<select class="form-control select2" name="cam_assignTo"
											id="cam_assignTo" style="width: 100%;">
											<option value=""></option>
										</select>
									</div>
								</div>
							</div>


							<div class="clearfix"></div>
							<div class="col-sm-12">
								<div class="col-sm-12">
									<label class="font-label">Description </label>
									<div class="form-group">
										<textarea rows="4" cols=""
											name="cam_description" id="cam_description"
											class="form-control"></textarea>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="clearfix"></div>

					<div class="col-sm-2">
						<h4>Budget</h4>
					</div>

					<div class="col-sm-12">
						<hr />
					</div>
					<div class="row">
						<div class="col-sm-12">
							<div class="col-sm-6">

								<div class="col-sm-6">
									<label class="font-label">Budget</label>
									<div class="form-group">
										<input type="text" class="form-control" name="cam_budget"
											id="cam_budget">
									</div>
								</div>

								<div class="col-sm-6">
									<label class="font-label">Actual cost</label>
									<div class="form-group">
										<input type="text" class="form-control" name="cam_actualCost"
											id="cam_actualCost">
									</div>
								</div>


								<div class="col-sm-6">
									<label class="font-label">Number send</label>
									<div class="form-group">
										<input type="text" class="form-control" name="cam_numSend"
											id="cam_numSend">
									</div>
								</div>


								<div class="col-sm-6">
									<label class="font-label">Expected response</label>
									<div class="form-group">
										<input type="text" class="form-control"
											name="cam_expectedResponse" id="cam_expectedResponse">
									</div>
								</div>



							</div>

							<div class="col-sm-6">

								<div class="col-sm-6">
									<label class="font-label">Expected cost</label>
									<div class="form-group">
										<input type="text" class="form-control"
											name="cam_expectedCost" id="cam_expectedCost">
									</div>
								</div>

								<div class="col-sm-6">
									<label class="font-label">Expected revenue</label>
									<div class="form-group">
										<input type="text" class="form-control"
											name="cam_expectedRevenue" id="cam_expectedRevenue">
									</div>
								</div>

							</div>
						</div>
					</div>
				</form>
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




<jsp:include page="${request.contextPath}/footer"></jsp:include>