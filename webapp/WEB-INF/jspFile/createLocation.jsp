<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>




<style type="text/css">
.font-label {
	font-size: 13px;
	padding-top: 4px;
}


.input-group-btn select {
	border-color: #ccc;
	margin-top: 0px;
    margin-bottom: 0px;
    padding-top: 7px;
    padding-bottom: 7px;
}
.padding-right{
padding-right: 10px;
}

</style>

<div class="content-wrapper" ng-app="campaign" ng-controller="campController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Create Location</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-dashboard"></i> Home</a></li>
			<li><a href="#">Create Location</a></li>
		</ol>
	</section>


<script type="text/javascript">

var app = angular.module('campaign', ['angular-loading-bar', 'ngAnimate']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = false;
}]);
var self = this;
app.controller('campController',['$scope','$http',function($scope, $http){


}]);



$(document).ready(function() {
	

	$("#btn_clear").click(function(){
		$("#form-contact").bootstrapValidator('resetForm', 'true');
		$('#form-contact')[0].reset();
	});
	
	$("#btn_save").click(function(){
		$("#form-contact").submit();
	});
	
	$('#form-contact').bootstrapValidator({
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
					      "loName": getValueStringById("name"),
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
							$("#form-contact").bootstrapValidator('resetForm', 'true');
							$('#form-contact')[0].reset();
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
	
});
</script>
	<section class="content">
		<!-- Default box -->
		<div class="box box-danger">
			<div class="box-body">
			<form method="post" id="form-contact">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-left: -5px;">
					<button type="button" class="btn btn-info btn-app" id="btn_save"> <i class="fa fa-save"></i> Save</button> 
					<a class="btn btn-info btn-app" id="btn_clear"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
					<a class="btn btn-info btn-app" href="${pageContext.request.contextPath}/list-locations"> <i class="fa fa-reply"></i> Back </a>
				</div>
				<div class="clearfix"></div>
				<div class="col-sm-12">
					<hr style="margin-top: 1px;" />
				</div>
				<div class="col-sm-2"><h4>Address </h4></div>
				<div class="col-sm-12">
						<hr style="margin-top: 1px;" />
				</div>
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-6">
						<label class="font-label">Location Name <span class="requrie">(Required)</span></label>
						<div class="form-group">
							<input type="text"  class="form-control" id="name" name="name">
						</div>	
					</div>
					<div class="clearfix hidden-lg"></div>
					<div class="col-xs-12 col-sm-6 col-md-6 col-lg-3">
							<label class="font-label">No </label>
							<div class="form-group">
								<input type="text"  class="form-control" id="no" name="no">
							</div>	
						</div>
					<div class="col-xs-12 col-sm-6 col-md-6 col-lg-3">
						<label class="font-label">Street </label>
						<div class="form-group">
							<input type="text"  class="form-control" id="street" name="street">
						</div>	
					</div>
					<div class="clearfix"></div>
					<div class="col-xs-12 col-sm-6 col-md-6 col-lg-3">
						<label class="font-label">Village </label>
						<div class="form-group">
							<input type="text"  class="form-control" id="village" name="village">
						</div>	
					</div>
					
					<div class="col-xs-12 col-sm-6 col-md-6 col-lg-3">
						<label class="font-label">Commune </label>
						<div class="form-group">
							<input type="text"  class="form-control" id="commune" name="commune">
						</div>	
					</div>	
					<div class="col-xs-12 col-sm-6 col-md-6 col-lg-3">
						<label class="font-label">District </label>
						<div class="form-group">
							<input type="text"  class="form-control" id="district" name="district">
						</div>	
					</div>
					
					<div class="col-xs-12 col-sm-6 col-md-6 col-lg-3">
						<label class="font-label">City </label>
						<div class="form-group">
							<input type="text"  class="form-control" id="city" name="city">
						</div>	
					</div>
					
					<div class="col-xs-12 col-sm-6 col-md-6 col-lg-3">
						<label class="font-label">State </label>
						<div class="form-group">
							<input type="text"  class="form-control" id="state" name="state">
						</div>
					</div>
					
					<div class="col-xs-12 col-sm-6 col-md-6 col-lg-3">
						<label class="font-label">Country </label>
						<div class="form-group">
							<input type="text"  class="form-control" id="country" name="country">
						</div>
					</div>
				</div>
			</form>
			</div>
			<!-- /.box-body -->
			<div class="box-footer">
				<div id="errors"></div>
			</div>
			<!-- /.box-footer-->
		</div>
		<!-- /.box -->
	</section>
	<!-- /.content -->
</div>
<!-- /.content-wrapper -->
<jsp:include page="${request.contextPath}/footer"></jsp:include>
