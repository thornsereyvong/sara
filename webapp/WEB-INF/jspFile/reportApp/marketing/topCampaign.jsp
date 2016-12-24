<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>
<script type="text/javascript">

var app = angular.module('objApp', ['angularUtils.directives.dirPagination']);
var self = this;
app.controller('objController',['$scope','$http',function($scope, $http){	
	$scope.searchBtnClick = function(){		
		swal({   
			title: "Ajax request example",   
			text: "Submit to run ajax request",   
			type: "info",   
			showCancelButton: true,   
			closeOnConfirm: false,   
			showLoaderOnConfirm: true, 
		}, function(){   
						
			setTimeout(function(){     
				$http.get("${pageContext.request.contextPath}/campaign/list").success(function(response){
					$scope.campaigns = response.DATA;
					dis($scope.campaigns)
					swal("Ajax request finished!");   
				});   
			}, 2000);
		});	
	}	
}]);

$(function(){
	$('#todate').daterangepicker({
        singleDatePicker: true,
        showDropdowns: true,
        format: 'DD/MM/YYYY' 
    }).on('change', function(e) {
		if($("#todate").val() != ""){
			$('#form-campaigns').bootstrapValidator('revalidateField', 'todate');
		}			  
	});
	
	$('#startdate').daterangepicker({
        singleDatePicker: true,
        showDropdowns: true,
        format: 'DD/MM/YYYY' 
    }).on('change', function(e) {
		if($("#startdate").val() != ""){
			$('#form-campaigns').bootstrapValidator('revalidateField', 'startdate');
		}		  
	});
	
	
	$("#datafilter").change(function(){
		var action = $("#datafilter").val();
		switch(action) {
		    case 'All':
		        $('#startdate').prop("disabled", true);  
		        $('#todate').prop("disabled", true);
		        $('#startdate').val($('#startdate').attr('data-default-date'));  
		        $('#todate').val($('#todate').attr('data-default-date'));  
		        break;
		    case 'range':
		    	$('#startdate').prop("disabled", false);  
		        $('#todate').prop("disabled", false);
		        $('#startdate').val("");  
		        $('#todate').val("");
		        break;
		    case 'today':
		    	 $('#startdate').prop("disabled", true);  
			     $('#todate').prop("disabled", true); 				     				    
			     $('#startdate').val(moment().format('D/MMM/YYYY'));  
			     $('#todate').val(moment().format('D/MMM/YYYY'));
		        break;
		    case 'this period':
		    	 $('#startdate').prop("disabled", true);  
			     $('#todate').prop("disabled", true);
			     $('#startdate').val("01/"+moment().format('MMM')+"/"+(new Date()).getFullYear());  
			     $('#todate').val(getLastDayOfMonth()+"/"+moment().format('MMM')+"/"+(new Date()).getFullYear()); 
		        break;
		    case 'this year':
		    	 $('#startdate').prop("disabled", true);  
			     $('#todate').prop("disabled", true);
			     $('#startdate').val("01/Jan/"+(new Date()).getFullYear());  
			     $('#todate').val("31/Dec/"+(new Date()).getFullYear()); 
		        break;
		}				
	});
	
	
	
});

</script>
<div class="content-wrapper" ng-app="objApp" ng-controller="objController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Top Campaign</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"> Top Campaign</a></li>
		</ol>
	</section>

	<section class="content">
		
		<div class="row">
			<div class="col-md-12">
				<div class="box box-primary">	
					<div class="box-header with-border">
		        		<h3 class="box-title">Filter</h3>
		              	<div class="box-tools pull-right">
		               		<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
		               	</div>
		          	</div>
					<div class="box-body">
						<form method="post" id="frmFilter">	
							<div class="row">
								<div class="col-sm-12">
									
									<div class="col-md-3">
										<div class="form-group">
											<label>Date Filter</label> <select name="datafilter"
												id="datafilter" class="form-control select2 input-lg"
												style="width: 100%;">
												<option value="All">All</option>
												<option value="range">Range</option>
												<option value="today">Today</option>
												<option value="this period">This Period</option>
												<option value="this year">This Year</option>
											</select>
										</div>
									</div>
									
									<div class="col-sm-3">
						                <label class="font-label">Start date </label>
						                <div class="form-group">
					                  		<div class="input-group">
				                    			<div class="input-group-addon"> <i class="fa fa-calendar"></i> </div>
					                    		<input type="text" class="form-control pull-right date2" name="startdate" id="startdate">
					                 	 	</div>
						                </div>
					              	</div>
						
					              	<div class="col-sm-3">
					                	<label class="font-label">End date</label>
					                	<div class="form-group">
					                  		<div class="input-group">
						                    	<div class="input-group-addon"> <i class="fa fa-calendar"></i> </div>
						                    	<input type="text" class="form-control pull-right date2" name="todate" id="todate">
						                  	</div>
				                		</div>
					              	</div>
					              	
					              	<div class="col-sm-3">
										<label class="font-label">Status</label>
										<div class="form-group">
											<select class="form-control select2" name="cam_status"
												style="width: 100%;" id="cam_status">
												<option value="">-- SELECT Status --</option>
												<option ng-repeat="stat in camp_status" value="{{stat.statusID}}">{{stat.statusName}}</option>
											</select>
										</div>
									</div>
									<div class="col-sm-3">
										<label class="font-label">Type</label>
										<div class="form-group">
											<select class="form-control select2" name="cam_type"
												style="width: 100%;" id="cam_type">
												<option value="">-- SELECT Type --</option>
												<option ng-repeat="ty in camp_type" value="{{ty.typeID}}">{{ty.typeName}}</option>
											</select>
										</div>
									</div>
									<div class="col-sm-3">
										<label class="font-label">Parent campaign </label>
										<div class="form-group">
											<select class="form-control select2" name="cam_parent"
												style="width: 100%;" id="cam_parent">
												<option value="">-- SELECT Parent --</option>
												<option ng-repeat="cam in camp_parents" value="{{cam.campID}}">[{{cam.campID}}]
													{{cam.campName}}</option>
											</select>
										</div>
									</div>
									<div class="col-sm-3">
										<label class="font-label">Assigned to </label>
										<div class="form-group">
											<select class="form-control select2" name="cam_assignTo"
												id="cam_assignTo" style="width: 100%;">
												<option value="">-- SELECT User --</option>
												<option ng-repeat="user in users" value="{{user.userID}}">{{user.username}}</option>
											</select>
										</div>
									</div>
					              	
					              	
					              	
								</div>								
							</div>
						</form>
					</div>
					<div class="box-footer">						
						<button ng-click="searchBtnClick()" type="button" name="btnPrint" id="btnPrint" class="btn btn-default">
							<i class="fa fa-print"></i> &nbsp;Print
						</button>						
						<button ng-click="searchBtnClick()" type="button" name="btnsearch" id="btnsearch" class="btn btn-info pull-right">
							<i class="fa fa-search"></i> &nbsp;Search
						</button>
					</div>
				</div>
			</div>
			
			<div class="col-md-12">
				<div class="box box-success">
					<div class="box-body">
						<div class="tablecontainer table-responsive">
							<table class="table table-hover">
								<thead>
									<tr>
										<th>Campaign ID</th>
										<th>Campaign Name</th>
										<th>Type</th>
										<th>Status</th>
										<th>Start Date</th>
										<th>End Date</th>
										<th>Num Sent</th>
									</tr>
								</thead>
								<tbody>
									<tr>
								
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			
			
			
			
			
			<div id="errors"></div>
		</div>
	
		
				
	</section>
</div>
<jsp:include page="${request.contextPath}/footer"></jsp:include>

