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
    	<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
    	<li class="active"><a href="#">Create Campaign</a></li>
    </ol>
  </section>
  <script type="text/javascript">
		var app = angular.module('campaign', ['angular-loading-bar', 'ngAnimate']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
		    cfpLoadingBarProvider.includeSpinner = false;
		}]);
		var self = this;
		var username = "${SESSION}";
		app.controller('campController',['$scope','$http',function($scope, $http) {
				$scope.startupAddPage = function(username) {
					$http({
					    method: 'GET',
					    url: '${pageContext.request.contextPath}/add/startup/'+username,
					    headers: {
					    	'Accept': 'application/json',
					        'Content-Type': 'application/json'
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
			
			$('#cam_endDate').daterangepicker({
		        singleDatePicker: true,
		        showDropdowns: true,
		        format: 'DD/MM/YYYY' 
		    }).on('change', function(e) {
				if($("#cam_endDate").val() != ""){
					$('#form-campaigns').bootstrapValidator('revalidateField', 'cam_endDate');
				}			  
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
			
			
			
		$("#btn_clear").click(function() {
			$("#cam_parent").select2('val',"");
			$("#cam_type").select2('val',"");
			$("#cam_status").select2('val',"");
			$("#cam_assignTo").select2('val',"");
			$("#form-campaigns").bootstrapValidator('resetForm', 'true');
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
			var dataFrm = {"campName" : getValueStringById("cam_name"),
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
					   "createdBy" : username
			};
			swal({   
				title: "<span style='font-size: 25px;'>You are about to create campaign.</span>",
				text: "Click OK to continue or CANCEL to abort.",
				type: "info",
				html: true,
				showCancelButton: true,
				closeOnConfirm: false,
				showLoaderOnConfirm: true,		
			}, function(){ 
				setTimeout(function(){
					$.ajax({ 
						url : "${pageContext.request.contextPath}/campaign/add",
						type : "POST",
					    data: JSON.stringify(dataFrm),
						beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
					    }, 
					    success: function(result){					    						    
							if(result.MESSAGE == "INSERTED"){
								$("#cam_parent").select2('val',"");
								$("#cam_type").select2('val',"");
								$("#cam_status").select2('val',"");
								$("#cam_assignTo").select2('val',"");
								$("#form-campaigns").bootstrapValidator('resetForm', 'true');
								
								alertMsgSuccessSweetWithTxt(result.MSG)
							}else{
								alertMsgErrorSweetWithTxt(result.MSG)
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
          	<div class="col-sm-12">
            <div class="col-sm-6">
              <div class="col-sm-12">
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
                    <input type="text" class="form-control pull-right date2" name="cam_startDate" id="cam_startDate">
                  </div>
                </div>
              </div>

              <div class="col-sm-6">
                <label class="font-label">End date <span class="requrie">(Required)</span></label>
                <div class="form-group">
                  <div class="input-group">
                    <div class="input-group-addon"> <i class="fa fa-calendar"></i> </div>
                    <input type="text" class="form-control pull-right date2" name="cam_endDate" id="cam_endDate">
                  </div>
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
                    <option ng-repeat="cam in camp_parents" value="{{cam.campID}}">[{{cam.campID}}] {{cam.campName}}</option>
                  </select>
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
            <div class="clearfix"></div>
            <div class="col-sm-12">
              <div class="col-sm-12">
                <label class="font-label">Description </label>
                <div class="form-group">
                  <textarea rows="4" cols="" name="cam_description" id="cam_description" class="form-control"></textarea>
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
            <div class="clearfix"></div>
            <div class="col-sm-6">
              <label class="font-label">Number send</label>
              <div class="form-group">
                <input type="text" class="form-control" name="cam_numSend"
									id="cam_numSend">
              </div>
            </div>
            <div class="col-sm-6">
              <label class="font-label">Expected response (%)</label>
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
            <div class="clearfix"></div>
          </div>
        </form>
      </div>
      <div id="errors"></div>
      <div class="box-footer"></div>
    </div>
  </section>
</div>
<jsp:include page="${request.contextPath}/footer"></jsp:include>
