<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
    <h1>Create Campaign</h1>
    <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li class="active"><a href="#">Create Campaign</a></li>
    </ol>
  </section>
  <script type="text/javascript">
		var app = angular.module('campaign', [ 'oitozero.ngSweetAlert', ]);
		var self = this;
		app.controller('campController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http) {
				$scope.startupAddPage = function(username) {
					$http({
					    method: 'POST',
					    url: '${pageContext.request.contextPath}/campaign/startup',
					    headers: {
					    	'Accept': 'application/json',
					        'Content-Type': 'application/json'
					    },
					    data: {
					    	"username":username
					    }
					}).success(function(response) {
						$scope.camp_parents = response.CAMP_PARENT;
						$scope.users = response.ASSIGN_TO;
						$scope.camp_status = response.CAMP_STATUS;
						$scope.camp_type = response.CAMP_TYPE;
					});
				};
			}]);
		$(document).ready(function() {
			$(".select2").select2();
			$("#cam_name").change(function() {
				var name = $("#cam_name").val();
				$.ajax({
					url : "${pageContext.request.contextPath}/campaign/list/validate/"+ name,
					method : "GET",
					header : "application/json",
					statusCode : {
								404 : function(xhr) {
									var i = '<i class="form-control-feedback bv-no-label glyphicon glyphicon-ok" data-bv-icon-for="cam_name" style="display: block;"></i>';
									$("#div_camName").find("i").remove();
									$("#div_camName").find("small").remove();
									$("#div_camName").removeClass("form-group has-feedback has-error").addClass("form-group has-feedback has-success");
									$("#div_camName").append(i);
									$("#btn_save").removeAttr("disabled");
								}
															},
					success : function(data) {
						var dataObject = data.MESSAGE;
						if (dataObject == "EXIST") {
							var i = '<i class="form-control-feedback bv-no-label glyphicon glyphicon-remove" data-bv-icon-for="cam_name" style="display: block;"></i>';
							var small = '<small class="help-block" data-bv-validator="notEmpty" data-bv-for="cam_name" data-bv-result="INVALID" style="">The Campaign Name is already exit ! </small>';
							$("#div_camName").find("i").remove();
							$("#div_camName").find("small").remove();
							$("#div_camName").removeClass("form-group has-feedback has-success").addClass("form-group has-feedback has-error");
							$("#div_camName").append(i+ small);
							$("#btn_save").attr("disabled","disabled");
					}
				}
			});
		});
		$("#btn_clear").click(function() {
			$("#form-campaigns").bootstrapValidator('resetForm', 'true');
		});
		$("#btn_save").click(function() {
			$("#form-campaigns").submit();
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
						data-toggle="tooltip" title="Collapse"> <i class="fa fa-minus"></i> </button>
          <button class="btn btn-box-tool" data-widget="remove"
						data-toggle="tooltip" title="Remove"> <i class="fa fa-times"></i> </button>
        </div>
      </div>
      <div class="box-body" data-ng-init = "startupAddPage('${SESSION}')">
        <form method="post" id="form-campaigns">
          <button type="button" class="btn btn-info btn-app" id="btn_save"> <i class="fa fa-save"></i> Save </button>
          <a class="btn btn-info btn-app" id="btn_clear"> <i
						class="fa fa-refresh" aria-hidden="true"></i>Clear </a> <a class="btn btn-info btn-app"
						href="${pageContext.request.contextPath}/list-campaigns"> <i
						class="fa fa-reply"></i> Back </a>
          <div class="clearfix"></div>
          <div class="col-sm-2">
            <h4>Overview</h4>
          </div>
          <div class="col-sm-12">
            <hr style="margin-top: 3px;" />
          </div>
          <div class="row">
            <div class="col-sm-6">
              <div class="col-sm-6">
                <label class="font-label">Name <span class="requrie">(Required)</span></label>
                <div class="form-group" id="div_camName">
                  <input type="text" class="form-control" name="cam_name" id="cam_name">
                </div>
              </div>
              <div class="col-sm-6">
                <label class="font-label">Start date </label>
                <div class="form-group">
                  <div class="input-group">
                    <div class="input-group-addon"> <i class="fa fa-calendar"></i> </div>
                    <input type="text" class="form-control pull-right" name="cam_startDate" id="cam_startDate">
                  </div>
                </div>
              </div>
              <div class="clearfix"></div>
              <div class="col-sm-6">
                <label class="font-label">End date <span class="requrie">(Required)</span></label>
                <div class="form-group">
                  <div class="input-group">
                    <div class="input-group-addon"> <i class="fa fa-calendar"></i> </div>
                    <input type="text" class="form-control pull-right" name="cam_endDate" id="cam_endDate">
                  </div>
                </div>
              </div>
              <div class="clearfix"></div>
              <div class="col-sm-12">
                <label class="font-label">Description </label>
                <div class="form-group">
                  <textarea style="height: 120px" rows="" cols="" name="cam_description" id="cam_description" class="form-control"></textarea>
                </div>
              </div>
              <div class="col-sm-6">
                <label class="font-label">Assigned to  </label>
                <div class="form-group">
                  <select class="form-control select2" name="cam_assignTo" id="cam_assignTo" style="width: 100%;">
                    <option value="">-- SELECT User --</option>
                    <option ng-repeat="user in users" value="{{user.userID}}">{{user.username}}</option>
                  </select>
                </div>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="col-sm-6">
                <label class="font-label">Status <span class="requrie">(Required)</span></label>
                <div class="form-group">
                  <select class="form-control select2" name="cam_status" style="width:100%;"
										id="cam_status">
                    <option value="">-- SELECT Status --</option>
                    <option ng-repeat="stat in camp_status" value="{{stat.statusID}}">{{stat.statusName}}</option>
                  </select>
                </div>
              </div>
              <div class="col-sm-6">
                <label class="font-label">Type <span class="requrie">(Required)</span></label>
                <div class="form-group">
                  <select class="form-control select2" name="cam_type" style="width: 100%;" id="cam_type">
                    <option value="">-- SELECT Type --</option>
                    <option ng-repeat="ty in camp_type" value="{{ty.typeID}}">{{ty.typeName}}</option>
                  </select>
                </div>
              </div>
              <div class="col-sm-6">
                <label class="font-label">Parent campaign </label>
                <div class="form-group">
                  <select class="form-control select2" name="cam_parent" style="width: 100%;" id="cam_parent">
                    <option value="">-- SELECT Parent --</option>
                    <option ng-repeat="cam in camp_parents" value="{{cam.campID}}">{{cam.campName}}</option>
                  </select>
                </div>
              </div>
            </div>
            <div class="clearfix"></div>
          </div>
          <div class="clearfix"></div>
          <div class="col-sm-2">
            <h4>Budget</h4>
          </div>
          <div class="col-sm-12">
            <hr />
          </div>
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
                <input type="text" class="form-control" name="cam_expectedCost"
									id="cam_expectedCost">
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

<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$('#form-campaigns')
								.bootstrapValidator(
										{
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
															max: 255,
															message: 'The name must be less than 255 characters long.'
														}
													}
												},
												
												cam_status : {
													validators : {
														notEmpty : {
															message : 'The tatus is required and can not be empty!'
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
														
														numeric: {
											                message: 'The value is not a number',
											                // The default separators
											                thousandsSeparator: '',
											                decimalSeparator: '.'
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
										})
								.on(
										'success.form.bv',
										function(e) {
											var currentDate = new Date();
											var day = currentDate.getDate();
											var month = currentDate.getMonth() + 1;
											var year = currentDate
													.getFullYear();
											var createDate = $("#cam_startDate")
													.val();
											var newCreateDate = createDate
													.split("/").reverse().join(
															"-");
											var endDate = $("#cam_endDate")
													.val();
											var endCreateDate = endDate.split(
													"/").reverse().join("-");
											var parentID = "";
											if ($("#cam_parent").val() != "") {
												parentID = {
													"campID" : $("#cam_parent")
															.val()
												};
											} else {
												parentID = null;
											}
											var status = "";
											if ($("#cam_status").val() != "") {
												status = {
													"statusID" : $(
															"#cam_status")
															.val()
												};
											} else {
												status = null;
											}
											var type = "";
											if ($("#cam_type").val() != "") {
												type = {
													"typeID" : $("#cam_type")
															.val()
												};
											} else {
												type = null;
											}
											var assign = "";
											if ($("#cam_assignTo").val() != "") {
												assign = {
													"userID" : $(
															"#cam_assignTo")
															.val()
												};
											} else {
												assign = null;
											}
											$
													.ajax({
														url : "${pageContext.request.contextPath}/campaign/add",
														type : "POST",
														data : JSON
																.stringify({
																	"campName" : $(
																			"#cam_name")
																			.val(),
																	"startDate" : newCreateDate,
																	"endDate" : endCreateDate,
																	"status" : status,
																	"type" : type,
																	"description" : $(
																			"#cam_description")
																			.val(),
																	"parent" : parentID,
																	"budget" : $(
																			"#cam_budget")
																			.val(),
																	"assignTo" : assign,
																	"actualCost" : $(
																			"#cam_actualCost")
																			.val(),
																	"expectedCost" : $(
																			"#cam_expectedCost")
																			.val(),
																	"expectedRevenue" : $(
																			"#cam_expectedRevenue")
																			.val(),
																	"numSend" : $(
																			"#cam_numSend")
																			.val(),
																	"expectedResponse" : $(
																			"#cam_expectedResponse")
																			.val(),
																	"createdBy" : $.session
																			.get("parentID"),
																	"createdDate" : year
																			+ "-"
																			+ month
																			+ "-"
																			+ day
																}),
														beforeSend : function(xhr) {
															xhr.setRequestHeader("Accept","application/json");
															xhr.setRequestHeader("Content-Type","application/json");
														},
														success : function(data) {
															$("#form-campaigns")
																	.bootstrapValidator(
																			'resetForm',
																			'true');
															$('#form-campaigns')[0]
																	.reset();
															$("#cam_parent")
																	.select2(
																			"val",
																			"");
															$("#cam_assignTo")
																	.select2(
																			"val",
																			"");
															$("#cam_status")
																	.select2(
																			"val",
																			"");
															$("#cam_type")
																	.select2(
																			"val",
																			"");
															swal({
																title : "Success",
																text : "User have been created new campaign!",
																type : "success",
																timer : 2000,
																showConfirmButton : false
															});
														},
														error : function() {
															errorMessage();
														}
													});
										});
					});
</script>
<jsp:include page="${request.contextPath}/footer"></jsp:include>