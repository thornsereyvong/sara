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


<div class="content-wrapper" ng-app="event" ng-controller="eventController" id="eventController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Create Event</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"> Create Event</a></li>
		</ol>
	</section>
<script type="text/javascript">
var app = angular.module('event', ['angular-loading-bar', 'ngAnimate']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = false;
}]);
var self = this;
app.controller('eventController',['$scope','$http',function($scope, $http){
	$scope.listLocations= function(){
		$http.get("${pageContext.request.contextPath}/event_location/list")
		.success(function(response){
				$scope.locations = response.DATA;
			});
		};	

	$scope.popupLocationForm = function(){
		$("#btn_add_location").click();
		
	}

	$scope.clearLocationData = function(){
		$("#frmAddLocation").bootstrapValidator('resetForm', 'true');
		$('#frmAddLocation')[0].reset();
	}
}]);

$(function() {
	  $('#hiddenTooltip').tooltip({
	    trigger: 'manual'
	  });
	  $("#hiddenTooltip").on('click', function() {
	    $('#hiddenTooltip').tooltip('toggle');
	  });
});

$(document).ready(function() {
	var data = ${users};
	$(".select2").select2();
	
	$("#relateTo").change(function(){
		var relate = $("#relateTo").val();
		funcRelateTo("#reportType",relate,"");
	});

	$('.date2').daterangepicker({
        singleDatePicker: true,
        showDropdowns: true,
        format: 'DD/MM/YYYY h:mm A',
        timePicker: true, 
        timePickerIncrement: 5
       
    }).on('change', function(e) {
		if($("#startDate").val() != ""){
			$('#formEvent').bootstrapValidator('revalidateField', 'startDate');
		}
		if($("#endDate").val() != ""){
			$('#formEvent').bootstrapValidator('revalidateField', 'endDate');
		}
	});
	userAllList(data,'#assignTo','');
	
	$("#btn_clear").click(function(){
		$("#formEvent").bootstrapValidator('resetForm', 'true');
	});
	
	 $("#btn_save").click(function(){
		$("#formEvent").submit();
	});
		
	$('#formEvent').bootstrapValidator({
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
							message: 'The event name is required and can not be empty!'
						},
						stringLength: {
							max: 255,
							message: 'The Subject must be less than 255 characters long.'
						}
					}
				},
				description: {
					validators: {
						stringLength: {
							max: 255,
							message: 'The description must be less than 255 characters long.'
						}
					}
				},
				duration: {
					validators: {
						notEmpty: {
							message: 'The duration is required and can not be empty!'
						}
					}
				},
				startDate: {
					validators: {
						notEmpty: {
							message: 'The Start Date is required and can not be empty!'
						},
						date: {
	                        format: 'DD/MM/YYYY h:mm A',
	                        message: 'The value is not a valid date!'
						}
					}
				},
				endDate: {
					validators: {
						notEmpty: {
							message: 'The End Date is required and can not be empty!'
						},
						date: {
	                        format: 'DD/MM/YYYY h:mm A',
	                        message: 'The value is not a valid date!'
						}
					}
				},
				budget : {
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
			swal({   
				title: "<span style='font-size: 25px;'>You are about to create event.</span>",
				text: "Click OK to continue or CANCEL to abort.",
				type: "info",
				html: true,
				showCancelButton: true,
				closeOnConfirm: false,
				showLoaderOnConfirm: true,		
			}, function(){ 
				setTimeout(function(){
					$.ajax({ 
						url : "${pageContext.request.contextPath}/event/add",
						type : "POST",
						data : JSON.stringify({
							  "evName": getValueStringById("name"),
						      "evLocation": getJsonById("loId","location","str"),
						      "evBudget": getValueStringById("budget"),
						      "evDes": getValueStringById("description"),
						      "evCreateBy":  $.session.get("parentID"),
						      "evDuration": getValueStringById("duration"),
						      "startDate": getValueStringById("startDate"),
						      "endDate": getValueStringById("endDate"),
						      "assignTo": getJsonById("userID","assignTo","str"), 
						      "evRelatedToModuleId" : getValueStringById("reportType"),
						      "evRelatedToModuleType" : getValueStringById("relateTo")
						}),
						beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
					    }, 
					    success: function(result){					    						    
							if(result.MESSAGE == "INSERTED"){						
								$("#relateTo").select2("val","");
								$("#reportType").select2("val","");
								$("#location").select2("val","");
								$("#assignTo").select2("val","");
								$("#formEvent").bootstrapValidator('resetForm', 'true');
								$('#formEvent')[0].reset();
								swal({
		    						title: "SUCCESSFUL",
		    					  	text: result.MSG,
		    					  	html: true,
		    					  	timer: 2000,
		    					  	type: "success"
		    					});		
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
	// ./end event block

	//add location block

	$("#btnLocationSave").click(function(){
		$("#frmAddLocation").submit();
	});
	
	$('#frmAddLocation').bootstrapValidator({
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
						message: 'The location is required and can not be empty!'
					},
					stringLength: {
						max: 255,
						message: 'The name must be less than 255 characters long.'
					}
				}
			},
			no: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The no must be less than 255 characters long.'
					}
				}
			},
			street: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The street must be less than 255 characters long.'
					}
				}
			}
			,
			village: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The village must be less than 255 characters long.'
					}
				}
			},
			commune: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The commune must be less than 255 characters long.'
					}
				}
			},
			district: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The district must be less than 255 characters long.'
					}
				}
			},
			state: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The state must be less than 255 characters long.'
					}
				}
			},
			city: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The city must be less than 255 characters long.'
					}
				}
			},
			country: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The country must be less than 255 characters long.'
					}
				}
			}
		}
	}).on('success.form.bv', function(e) {
		swal({   
			title: "<span style='font-size: 25px;'>You are about to create location.</span>",
			text: "Click OK to continue or CANCEL to abort.",
			type: "info",
			html: true,
			showCancelButton: true,
			closeOnConfirm: false,
			showLoaderOnConfirm: true,		
		}, function(){ 
			setTimeout(function(){
				$.ajax({ 
					url : "${pageContext.request.contextPath}/event_location/add",
					type : "POST",
					data : JSON.stringify({
					      "loName": getValueStringById("lo_name"),
					      "loNo":  getValueStringById("no"),
					      "loStreet":  getValueStringById("street"),
					      "village":  getValueStringById("village"),
					      "loCommune": getValueStringById("commune"),
					      "loDistrict": getValueStringById("district"),
					      "loCity": getValueStringById("city"),
					      "loState": getValueStringById("state"),
					      "loCountry": getValueStringById("country"),
					      "loCreateBy":  $.session.get("parentID")
					      
					    }),	
					beforeSend: function(xhr) {
					    xhr.setRequestHeader("Accept", "application/json");
					    xhr.setRequestHeader("Content-Type", "application/json");
				    }, 
				    success: function(result){					    						    
						if(result.MESSAGE == "INSERTED"){						
							$("#frmAddLocation").bootstrapValidator('resetForm', 'true');
							$('#frmAddLocation')[0].reset();
							swal({
	    						title: "SUCCESSFUL",
	    					  	text: result.MSG,
	    					  	html: true,
	    					  	timer: 2000,
	    					  	type: "success"
	    					});		
							angular.element(document.getElementById('eventController')).scope().listLocations();
							angular.element(document.getElementById('eventController')).scope().popupLocationForm();																			
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
			<form method="post" id="formEvent">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-left: -5px;">
					<button type="button" class="btn btn-info btn-app" id="btn_save" > <i class="fa fa-save"></i> Save</button> 
					<a class="btn btn-info btn-app" id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
					<a class="btn btn-info btn-app"  href="${pageContext.request.contextPath}/list-events"> <i class="fa fa-reply"></i> Back </a>
				</div>
				<div class="clearfix"></div>
				<div class="col-sm-2">
					<h4>Overview</h4>
				</div>
				<div class="col-sm-12">
					<hr style="margin-top: 3px;" />
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
							<label class="font-label">Name <span class="requrie">(Required)</span></label>
							<div class="form-group" id="c_name">
								<input type="text" class="form-control" name="name" id="name">
							</div>
						</div>
						
						<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4" data-ng-init="listLocations()">
							<label class="font-label">Location  </label>
							<div class="form-group">
								<div class="input-group">
									<span class="input-group-addon" ng-click="popupLocationForm()" id="hiddenTooltip" data-toggle="tooltip" title="Add Location" style="cursor: pointer;"><i class="fa fa-plus" aria-hidden="true"></i></span>
									<select class="form-control select2" name="location" id="location" style="width: 100%; position: absolute;">
				                      <option value="">-- Select Location --</option>
				                      <option ng-repeat="l in locations" value="{{l.loId}}">[{{l.loId}}]{{l.loName}}</option> 
				                    </select>
								</div>
							</div>
						</div>
						<div class="clearfix hidden-lg"></div>
						<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
							<label class="font-label">Budget </label>
							<div class="form-group" id="">
								<input type="text" class="form-control" name="budget" id="budget">
							</div>
						</div>
						<div class="clearfix hidden-sm hidden-md"></div>
						<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
							<label class="font-label">Start date <span class="requrie">(Required)</span></label>
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
									<input type="text" class="form-control pull-right date2" name="startDate" id="startDate" readonly="readonly" onchange="calculateMeetingDuration('startDate','endDate','duration','formEvent')">
								</div> 
							</div>
						</div>
						<div class="clearfix hidden-lg"></div>
						<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
							<label class="font-label">End date <span class="requrie">(Required)</span></label>
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
									<input type="text" class="form-control pull-right date2" name="endDate" id="endDate" readonly="readonly" onchange="calculateMeetingDuration('startDate','endDate','duration','formEvent')">
								</div> 
							</div>
						</div>
						<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
							<label class="font-label">Duration <span class="requrie">(Required)</span></label>
							<div class="bootstrap-timepicker">
			                    <div class="form-group">
				                    <input class="form-control" name="duration" id="duration">
			                    </div>
			                  </div>
						</div>
						<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
							<label class="font-label">Related to </label>
							<div class="form-group">								
								<select class="form-control select2" name="relateTo" id="relateTo" style="width: 100%;">
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
						
						<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
						<label class="font-label">&nbsp; </label>
							<div class="form-group">
								<select class="form-control select2" name="reportType" id="reportType" style="width: 100%">
									<option value="">--SELECT--</option>
								</select>
							</div>
						</div>
						<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
							<label class="font-label">Assigned to</label>
							<div class="form-group">
								<select class="form-control select2"  name="assignTo" id="assignTo" style="width: 100%;">
			                      <option value=""></option>           
			                    </select>
							</div>
						</div>
						<div class="clearfix hidden-lg"></div>
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<label class="font-label">Description :</label>
							<div class="form-group">
								<textarea style="height: 120px" rows="" cols="" name="description" id="description"	class="form-control"></textarea>
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
		<input type="hidden" id="btn_add_location" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#frmLocation" />
		<div ng-controller="eventController" class="modal fade modal-default" id="frmLocation" role="dialog">
			<div class="modal-dialog  modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" ng-click="clearLocationData()" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"><b id="tMeet">Create Location</b></h4>
					</div>
					<div class="modal-body">
						<div class="row">
							<form id="frmAddLocation">
								<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
									<div class="col-xs-12 col-sm-12 col-md-12">
										<label class="font-label">Location Name <span class="requrie">(Required)</span></label>
										<div class="form-group">
											<input type="text"  class="form-control" id="lo_name" name="lo_name">
										</div>	
									</div>
									<div class="clearfix"></div>
									<div class="col-xs-12 col-sm-6">
										<label class="font-label">No </label>
										<div class="form-group">
											<input type="text"  class="form-control" id="no" name="no">
										</div>	
									</div>
									<div class="col-xs-12 col-sm-6">
										<label class="font-label">Street </label>
										<div class="form-group">
											<input type="text"  class="form-control" id="street" name="street">
										</div>	
									</div>
									<div class="col-xs-12 col-sm-6">
										<label class="font-label">Village </label>
										<div class="form-group">
											<input type="text"  class="form-control" id="village" name="village">
										</div>	
									</div>
									<div class="col-xs-12 col-sm-6">
										<label class="font-label">Commune </label>
										<div class="form-group">
											<input type="text"  class="form-control" id="commune" name="commune">
										</div>	
									</div>	
									<div class="col-xs-12 col-sm-6">
										<label class="font-label">District </label>
										<div class="form-group">
											<input type="text"  class="form-control" id="district" name="district">
										</div>	
									</div>
									<div class="col-xs-12 col-sm-6">
										<label class="font-label">City </label>
										<div class="form-group">
											<input type="text"  class="form-control" id="city" name="city">
										</div>	
									</div>
									<div class="col-xs-12 col-sm-6">
										<label class="font-label">State </label>
										<div class="form-group">
											<input type="text"  class="form-control" id="state" name="state">
										</div>
									</div>
									<div class="col-xs-12 col-sm-6">
										<label class="font-label">Country </label>
										<div class="form-group">
											<input type="text"  class="form-control" id="country" name="country">
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" id="btnCancel"
							ng-click="clearLocationData()" name="btnCancel"
							class="btn btn-danger" data-dismiss="modal">Cancel</button>
						&nbsp;&nbsp;
						<button type="button" id="btnLocationSave" name="btnLocationSave"
							class="btn btn-primary pull-right">Save</button>
					</div>
				</div>
			</div>
		</div>
		
		<!-- /.box -->
	</section>
	<!-- /.content -->
</div>
<!-- /.content-wrapper -->
<jsp:include page="${request.contextPath}/footer"></jsp:include>