
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>


<script type="text/javascript">


var app = angular.module('marketSurveyApp', ['angularUtils.directives.dirPagination','angular-loading-bar', 'ngAnimate','ngMaterial']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = false;
}]);
var self = this;
var username = "${SESSION}";
var server = "${pageContext.request.contextPath}";
var noteId = "${noteId}";
app.controller('marketSurveyController',['$scope','$http',function($scope, $http){
	
	angular.element(document).ready(function () {				
		
    });
	
	/* $scope.item = [];
	$scope.item.customers = [];	
	$scope.item.competitors = []; */
	
	
	
	
	$scope.listCompetitors = function(){
		$http.get("${pageContext.request.contextPath}/hbu/competitor/list").success(function(response){
				$scope.competitors = response.COMPETITORS;
				$scope.length = $scope.competitors.length;
			});
		};

	$scope.listSurveys = function(){
		$http.get("${pageContext.request.contextPath}/hbu/market-survey/list").success(function(response){
				$scope.surveys = response.SURVEYS;
			});
		};
	
	$scope.startup = function(){				
		$http.get("${pageContext.request.contextPath}/hbu/market-survey/startup").success(function(response){
			$scope.items = response.ITEMS;
			$scope.customers = response.CUSTOMERS;
			//$scope.competitors = response.competitors;
			
			//dis(response)
			
			$scope.rowNum = 5;
			$scope.rowNumCom = 5;
			//$scope.customersCheck2 =[];
			//$scope.customersCheck = [];
		});
	};
	
	$scope.findCompetitorByItemId = function(itemId){
		$http.get("${pageContext.request.contextPath}/item/view/"+itemId).success(function(response){
			$scope.item = response.ITEM;
			//$scope.findMarketSurveyByItemId(itemId);
		});
	};

	$scope.findMarketSurveyById = function(msId){
		$http.get("${pageContext.request.contextPath}/hbu/market-survey/view/"+msId).success(function(response){
			$scope.survey = response.SURVEY;
			$scope.item = $scope.survey.item;
			setTimeout(function(){			
				if($scope.item != null){
					$("#msId").val($scope.survey.msId);
					var tr = $("#data-content-edit tr");
					if(tr.length>0){
						for(i=0;i<tr.length-1;i++){
							var custId = $scope.item.customers[i].custId;
							for(var j=0; j<$scope.item.competitors.length; j++){
								$.each($scope.survey.details, function(i, value){
									if(value.custId == custId && value.comId == $scope.item.competitors[j].comId){
										document.getElementById($scope.item.competitors[j].comId+""+custId+""+1).value = value.surveyValue;
									}
								})
							}
						}
						for(var i=0;i<tr.length-1;i++){
							var td = $("#data-content-edit").children();
							for(var index = 0; index < td.length; index++){
								var selectOpt = $("#data-content-edit").find("select[name='surveyValue"+index+"']");
								if(selectOpt.length>0){
									var total = 0;
									for(var i=0; i<selectOpt.length; i++){
										total += Number($(selectOpt.eq(i)).val()); 
									}
									$("#totalEdit"+index).text(total);
								}
							}
						}
					}
				}
				
			}, 1000);
			
		});
	};

	$scope.findMarketSurveyByItemId = function(itemId){
		$http.get("${pageContext.request.contextPath}/hbu/market-survey/find/"+itemId).success(function(response){
			$scope.survey = response.SURVEY;
			if($scope.survey != null){
				$("#msId").val($scope.survey.msId);
				$("#surveyDate").val($scope.survey.convertMsDate);
				var tr = $("#data-content tr");
				if(tr.length>0){
					for(i=0;i<tr.length;i++){
						var custId = $scope.item.customers[i].custId;
						for(var j=0; j<$scope.item.competitors.length; j++){
							$.each($scope.survey.details, function(i, value){
								if(value.custId == custId && value.comId == $scope.item.competitors[j].comId){
									document.getElementById($scope.item.competitors[j].comId+""+custId).value = value.surveyValue;
								}
							})
						}
					}
				}
			}else{
				$("#msId").val("");
			}
		});
	};

	$scope.calculateTotal = function(index){
		alert(index)
	}


	$scope.cancelCompetitor = function(){
		
		$("#frmAddCompetitorToProduct").modal('toggle');
	}

	$scope.cancelCustomer = function(){
		$("#frmAddCustomerToProduct").modal('toggle');
	}

	$scope.cancelSurvey = function(){
		$("#product").select2("val","");
		$("#surveyDate").val("");
		$('#frmSurveyDetail').bootstrapValidator('resetForm', true);
	}

	$scope.saveMarketSevey = function(){
		$('#frmSurveyDetail').data('bootstrapValidator').validate();
		var statusAddPro = $("#frmSurveyDetail").data('bootstrapValidator').validate().isValid();
		if(statusAddPro){
			var dataString = [];
			var tr = $("#data-content tr");
			if(tr.length>0){
				var objSurvey = [];
				for(i=0;i<tr.length-1;i++){
					var custId = $scope.item.customers[i].custId;
					for(var j=0; j<$scope.item.competitors.length; j++){
						var surveyVal = document.getElementById($scope.item.competitors[j].comId+""+custId).value;
						var dataIndex = {"custId":custId, "comId":$scope.item.competitors[j].comId, "surveyValue":surveyVal};
						objSurvey.push(dataIndex);
					}
				}
				swal({   
					title: "<span style='font-size: 25px;'>You are about to add market survey.</span>",
					text: "Click OK to continue or CANCEL to abort.",
					type: "info",
					html: true,
					showCancelButton: true,
					closeOnConfirm: false,
					showLoaderOnConfirm: true,		
				}, function(){ 
						setTimeout(function(){
							$http({
							    method: 'POST',
							    url: '${pageContext.request.contextPath}/hbu/market-survey/add',
							    data:{
							    	"msDate":$("#surveyDate").val(),
							    	"item":{"itemId":$("#product").val()},
							    	"details":objSurvey,
							    	"msCreateBy":username
								    },
							    headers: {
							    	'Accept': 'application/json',
							        'Content-Type': 'application/json'
							    }
							}).success(function(response) {	
								$("#product").select2('val','');
								$("#surveyDate").val('');
								$('#frmSurveyDetail').bootstrapValidator('resetForm', true);
								$scope.listSurveys();
								if(response.MESSAGE == "INSERTED"){						
									swal({
			    						title: "SUCCESSFUL",
			    					  	text: response.MSG,
			    					  	html: true,
			    					  	timer: 2000,
			    					  	type: "success"
			    					});
								}else{
									swal({
			    						title: "UNSUCCESSFUL",
			    					  	text: response.MSG,
			    					  	html: true,
			    					  	timer: 2000,
			    					  	type: "error"
			    					});
								}
							});
					}, 500);
				});
			}
		}
	}

	$scope.editMarketSurvey = function(msId,msDate,itemId){
		var dataString = [];
		var tr = $("#data-content-edit tr");
		if(tr.length>0){
			var objSurvey = [];
			for(i=0;i<tr.length-1;i++){
				var custId = $scope.item.customers[i].custId;
				for(var j=0; j<$scope.item.competitors.length; j++){
					var surveyVal = document.getElementById($scope.item.competitors[j].comId+""+custId+""+1).value;
					var dataIndex = {"custId":custId, "comId":$scope.item.competitors[j].comId, "surveyValue":surveyVal};
					objSurvey.push(dataIndex);
				}
				//alert(dataIndex.customer.custId);
			}
			swal({   
				title: "<span style='font-size: 25px;'>Are you sure to update market survey ID: "+msId+"?.</span>",
				text: "Click OK to continue or CANCEL to abort.",
				type: "info",
				html: true,
				showCancelButton: true,
				closeOnConfirm: false,
				showLoaderOnConfirm: true,		
			}, function(){ 
					setTimeout(function(){
						$http({
						    method: 'PUT',
						    url: '${pageContext.request.contextPath}/hbu/market-survey/edit',
						    data:{
							    "msId":msId,
						    	"msDate":msDate,
						    	"item":{"itemId":itemId},
						    	"details":objSurvey,
						    	"msModifiedBy":username
							    },
						    headers: {
						    	'Accept': 'application/json',
						        'Content-Type': 'application/json'
						    }
						}).success(function(response) {	
							$("#product").select2('val','');
							$("#surveyDate").val('');
							$('#frmEditSurveyDetail').bootstrapValidator('resetForm', true);
							
							$scope.listSurveys();
							if(response.MESSAGE == "UPDATED"){						
								swal({
		    						title: "SUCCESSFUL",
		    					  	text: response.MSG,
		    					  	html: true,
		    					  	timer: 2000,
		    					  	type: "success"
		    					});
							}else{
								swal({
		    						title: "UNSUCCESSFUL",
		    					  	text: response.MSG,
		    					  	html: true,
		    					  	timer: 2000,
		    					  	type: "error"
		    					});
							}
						});
				}, 500);
			});
		}
	}

	$scope.deleteMarketSurvey = function(msId){
		swal({   
			title: "<span style='font-size: 25px;'>Are you sure to delete market survey ID:"+msId+" ?</span>",
			text: "Click OK to continue or CANCEL to abort.",
			type: "info",
			html: true,
			showCancelButton: true,
			closeOnConfirm: false,
			showLoaderOnConfirm: true,		
		}, function(){ 
				setTimeout(function(){
					$http({
					    method: 'DELETE',
					    url: '${pageContext.request.contextPath}/hbu/market-survey/remove/'+msId,
					    headers: {
					    	'Accept': 'application/json',
					        'Content-Type': 'application/json'
					    }
					}).success(function(response) {	
						$scope.listSurveys();
						if(response.MESSAGE == "DELETED"){						
							swal({
	    						title: "SUCCESSFUL",
	    					  	text: response.MSG,
	    					  	html: true,
	    					  	timer: 2000,
	    					  	type: "success"
	    					});
						}else{
							swal({
	    						title: "UNSUCCESSFUL",
	    					  	text: response.MSG,
	    					  	html: true,
	    					  	timer: 2000,
	    					  	type: "error"
	    					});
						}
					});
			}, 500);
		});
	}

	
	$scope.addCustToPro = function(bool){
		var proId = getValueStringById("product");		
		//$http.get("${pageContext.request.contextPath}/item/view/"+proId).success(function(response){
			//$scope.item = response.ITEM;			
			$.each($scope.customers,function(i, cust){
				$scope.customers[i].meDataSource = false;
				$.each($scope.item.customers,function(y, c){
					if(c.custId == cust.custId){
						$scope.customers[i].meDataSource = true;
					}
				});
			});
			$scope.customersCheck = angular.copy($scope.item.customers);
			
			if(bool){
				$("#frmAddCustomerToProduct").modal('toggle');
			}
		//});		
	}

	$scope.customerIndexSet = function(bool,custId){
		var n = $scope.searchIndexByCustId(custId);
		if(n != false || n==0){
			$scope.customers[n].meDataSource = bool;
			if(bool){
				$scope.customersCheck.push(angular.copy($scope.customers[n]));
			}else{
				if($scope.customersCheck.length>0){				
					for(var i=0;i<$scope.customersCheck.length; i++){
						if(custId == $scope.customersCheck[i].custId){
							$scope.customersCheck.splice(i, 1);
						}
					}
				}
			}
		}
	}
	
	$scope.searchIndexByCustId = function(custId){		
		for(var i=0;i<$scope.customers.length; i++){
			if(custId == $scope.customers[i].custId){
				return i;
			}
		}		
		return false;
	}
	
	
	
	$scope.btnAddCust = function(){	
		//$('#frm_AddCustomerToProduct').data('bootstrapValidator').validate();
		//var statusAddPro = $("#frm_AddCustomerToProduct").data('bootstrapValidator').validate().isValid();
		
		var itemCustomer =[];
		$.each($scope.customersCheck,function(y, c){
			var custObj = {"custId": c.custId, "custName":c.custName};
			itemCustomer.push(custObj);
		});
		
		//if(statusAddPro){
			swal({   
				title: "<span style='font-size: 25px;'>You are about to add customers to product.</span>",
				text: "Click OK to continue or CANCEL to abort.",
				type: "info",
				html: true,
				showCancelButton: true,
				closeOnConfirm: false,
				showLoaderOnConfirm: true,		
			}, function(){ 
				setTimeout(function(){
					 $http({
					        method : "POST",
					        url : "${pageContext.request.contextPath}/item/add/customer",
					        data: JSON.stringify({
								  "itemId" : getValueStringById("product"),
								  "customers": itemCustomer
							})
					    }).then(function mySucces(result) {
					    	if(result.data.MESSAGE == "INSERTED"){						
								swal({
									title: "SUCCESSFUL",
								  	text: result.data.MSG,
								  	html: true,
								  	timer: 2000,
								  	type: "success"
								});
								$scope.item.customers = angular.copy($scope.customersCheck);
								setTimeout(function(){
									$("#frmAddCustomerToProduct").modal('toggle');
								}, 2000); 
							}else{
								swal({
									title: "UNSUCCESSFUL",
								  	text: result.data.MSG,
								  	html: true,
								  	timer: 2000,
								  	type: "error"
								});
							}
					    }, function myError(response) {
					    	alertMsgErrorSweet();
					    });	
				}, 500);
			}); 
			
		//}		
	}
	
	
	
	// competitor
	
	
	$scope.addComToPro = function(bool){
		var proId = getValueStringById("product");		
		$http.get("${pageContext.request.contextPath}/hbu/competitor/list").success(function(response){
			
			$scope.competitors = response.COMPETITORS;
			$.each($scope.competitors,function(i, com){
				$scope.competitors[i].meDataSource = false;
				$.each($scope.item.competitors,function(y, c){
					if(c.comId == com.comId){
						$scope.competitors[i].meDataSource = true;
					}
				});
			});
			$scope.competitorsCheck = angular.copy($scope.item.competitors);
			
			if(bool){
				$("#frmAddCompetitorToProduct").modal('toggle');
			}
		});		
	}
	
	
	
	$scope.competitorIndexSet = function(bool,comId){
		var n = $scope.searchIndexByComId(comId);		
		if(n != false || n==0){
			$scope.competitors[n].meDataSource = bool;			
			if(bool){
				$scope.competitorsCheck.push(angular.copy($scope.competitors[n]));
			}else{
				if($scope.competitorsCheck.length>0){				
					for(var i=0;i<$scope.competitorsCheck.length; i++){
						if(comId == $scope.competitorsCheck[i].comId){
							$scope.competitorsCheck.splice(i, 1);
						}
					}
				}
			}
		}
	}
	
	$scope.searchIndexByComId = function(comId){		
		for(var i=0;i<$scope.competitors.length; i++){
			if(comId == $scope.competitors[i].comId){
				return i;
			}
		}		
		return false;
	}
	
	$scope.btnComAdd = function(){	
		//$('#frm_AddCustomerToProduct').data('bootstrapValidator').validate();
		//var statusAddPro = $("#frm_AddCustomerToProduct").data('bootstrapValidator').validate().isValid();
		
		var itemCompetitor =[];
		$.each($scope.competitorsCheck,function(y, c){
			var comObj = {"comId": c.comId, "comName":c.comName};
			itemCompetitor.push(comObj);
		});
		
		
		//if(statusAddPro){
			swal({   
				title: "<span style='font-size: 25px;'>You are about to add competitor to product.</span>",
				text: "Click OK to continue or CANCEL to abort.",
				type: "info",
				html: true,
				showCancelButton: true,
				closeOnConfirm: false,
				showLoaderOnConfirm: true,		
			}, function(){ 
				setTimeout(function(){
					 $http({
					        method : "POST",
					        url : "${pageContext.request.contextPath}/item/add",
					        data: JSON.stringify({
								  "itemId" : getValueStringById("product"),
								  "competitors": itemCompetitor
							})
					    }).then(function mySucces(result) {
					    	if(result.data.MESSAGE == "INSERTED"){						
								swal({
									title: "SUCCESSFUL",
								  	text: result.data.MSG,
								  	html: true,
								  	timer: 2000,
								  	type: "success"
								});
								$scope.item.competitors = angular.copy($scope.competitorsCheck);
								setTimeout(function(){
									$("#frmAddCompetitorToProduct").modal('toggle');
								}, 2000); 
							}else{
								swal({
									title: "UNSUCCESSFUL",
								  	text: result.data.MSG,
								  	html: true,
								  	timer: 2000,
								  	type: "error"
								});
							}
					    }, function myError(response) {
					    	alertMsgErrorSweet();
					    });	
				}, 500);
			}); 
			
		//}		
	}
	
	
	
}]);

function calculateTotal(obj){
	var index = $(obj).attr("data-index");
	var selectOpt = $("#data-content").find("select[name='surveyValue"+index+"']");
	if(selectOpt.length>0){
		var total = 0;
		for(var i=0; i<selectOpt.length; i++){
			total += Number($(selectOpt.eq(i)).val()); 
		}
		$("#total"+index).text(total);
	}
}

function calculateTotalEdit(obj){
	var index = $(obj).attr("data-index");
	var selectOpt = $("#data-content-edit").find("select[name='surveyValue"+index+"']");
	if(selectOpt.length>0){
		var total = 0;
		for(var i=0; i<selectOpt.length; i++){
			total += Number($(selectOpt.eq(i)).val()); 
		}
		$("#totalEdit"+index).text(total);
	}
}



$(document).ready(function(){
	
	$('.date2').daterangepicker({
        singleDatePicker: true,
        showDropdowns: true,
        format: 'DD/MM/YYYY h:mm A',
        timePicker: true, 
        timePickerIncrement: 5
       
    }).on('change', function(e) {
		if($("#surveyDate").val() != ""){
			$('#form-call').bootstrapValidator('revalidateField', 'surveyDate');
		}
	});

	$("#addCustToPro").hide();
	$("#addCompetitor").hide();
	$("#surveyContent").hide();
	$("#product").change(function(){
		if($("#product").val() != ""){
			angular.element(document.getElementById('marketSurveyController')).scope().findCompetitorByItemId($("#product").val());
			$("#addCustToPro").show();
			$("#addCompetitor").show();
			$("#surveyContent").show();
		}else{
			$("#addCustToPro").hide();
			$("#addCompetitor").hide();
			$("#surveyContent").hide();
		}
	});


	$("input[name=checkAll]").change(function(){
		if($(this).is(':checked')){
			$("input[name=customer]:not(:checked)").each(function(){
				$(this).prop('checked',true);
			});
		}else{
			$("input[name=customer]:checked").each(function(){
				$(this).prop('checked',false);
			});
		}
	});

	function addCustomersToProduct(){
		var customers = [];
		$("input[name=customer]:checked").each(function(){
			customers.push({"custId":$(this).val()});
		});
		$('#frmAddCompetitorToProduct').bootstrapValidator({
			message: 'This value is not valid',
			feedbackIcons: {
				valid: 'glyphicon glyphicon-ok',
				invalid: 'glyphicon glyphicon-remove',
				validating: 'glyphicon glyphicon-refresh'
			},
			fields: {
				product: {
					validators: {
						notEmpty: {
							message: 'The product is required and can not be empty!'
						}
					}
				}
			}
		}).on('success.form.bv', function(e) {
			swal({   
				title: "<span style='font-size: 25px;'>You are about to add customers to product.</span>",
				text: "Click OK to continue or CANCEL to abort.",
				type: "info",
				html: true,
				showCancelButton: true,
				closeOnConfirm: false,
				showLoaderOnConfirm: true,		
			}, function(){ 
					setTimeout(function(){
						$.ajax({ 
							url : "${pageContext.request.contextPath}/item/add/customer",
							type : "POST",
							data : JSON.stringify({
								  "itemId" : getValueStringById("product"),
								  "customers": customers,
							}),
							beforeSend: function(xhr) {
							    xhr.setRequestHeader("Accept", "application/json");
							    xhr.setRequestHeader("Content-Type", "application/json");
						    }, 
						    success: function(result){	
						    	$("input[name=customer]:checked").attr('checked',false);
						    	$('#frmAddCustomerToProduct').bootstrapValidator('resetForm', true);
								if(result.MESSAGE == "INSERTED"){						
									swal({
			    						title: "SUCCESSFUL",
			    					  	text: result.MSG,
			    					  	html: true,
			    					  	timer: 2000,
			    					  	type: "success"
			    					});
									$("#frmAddCustomerToProduct").modal('toggle');
									angular.element(document.getElementById('marketSurveyController')).scope().findCompetitorByItemId(getValueStringById("product"));
								}else{
									swal({
			    						title: "UNSUCCESSFUL",
			    					  	text: result.MSG,
			    					  	html: true,
			    					  	timer: 2000,
			    					  	type: "error"
			    					});
								}
							},
				    		error:function(){
				    			alertMsgErrorSweet();
				    		} 
						});
				}, 500);
			});
		});
		$("#frmAddCompetitorToProduct").submit();
	}

	
	//$("#addCompetitor").click(function(){
		/* $("#frmAddCompetitorToProduct").modal('toggle');
		$("input[name=check-all]:checked").prop("checked", false);
		$("input[name=competitor]:checked").each(function(){
			 //$(this).prop("checked", false);
			this.checked = false;
		});
		if($("product").val() != ""){
			//angular.element(document.getElementById('marketSurveyController')).scope().findHBUItemById($("#product").val());
		} */
	//});

/* 	$("input[name=check-all]").change(function(){
		if($(this).is(':checked')){
			$("input[name=competitor]:not(:checked)").each(function(){
				$(this).prop('checked',true);
			});
		}else{
			$("input[name=competitor]:checked").each(function(){
				$(this).prop('checked',false);
			});
		}
	}); */
	
	
	/* $('#frm_AddCustomerToProduct').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			product: {
				validators: {
					notEmpty: {
						message: 'The product is required and can not be empty!'
					}
				}
			}
		}
	}); */
	
	
	/* function addCompetitorsToProduct(){
		var competitors = [];
		$("input[name=competitor]:checked").each(function(){
			competitors.push({"comId":$(this).val()});
		});
		$('#frmAddCompetitorToProduct').bootstrapValidator({
			message: 'This value is not valid',
			feedbackIcons: {
				valid: 'glyphicon glyphicon-ok',
				invalid: 'glyphicon glyphicon-remove',
				validating: 'glyphicon glyphicon-refresh'
			},
			fields: {
				ato_product: {
					validators: {
						notEmpty: {
							message: 'The product is required and can not be empty!'
						}
					}
				}
			}
		}).on('success.form.bv', function(e) {
			swal({   
				title: "<span style='font-size: 25px;'>You are about to add competitors to product.</span>",
				text: "Click OK to continue or CANCEL to abort.",
				type: "info",
				html: true,
				showCancelButton: true,
				closeOnConfirm: false,
				showLoaderOnConfirm: true,		
			}, function(){ 
					setTimeout(function(){
						$.ajax({ 
							url : "${pageContext.request.contextPath}/item/add",
							type : "POST",
							data : JSON.stringify({
								  "itemId" : getValueStringById("product"),
								  "competitors": competitors,
							}),
							beforeSend: function(xhr) {
							    xhr.setRequestHeader("Accept", "application/json");
							    xhr.setRequestHeader("Content-Type", "application/json");
						    }, 
						    success: function(result){	
						    	$("input[name=competitor]:checked").attr('checked',false);
						    	$('#frmAddCompetitorToProduct').bootstrapValidator('resetForm', true);
								if(result.MESSAGE == "INSERTED"){						
									swal({
			    						title: "SUCCESSFUL",
			    					  	text: result.MSG,
			    					  	html: true,
			    					  	timer: 2000,
			    					  	type: "success"
			    					});
									$("#frmAddCompetitorToProduct").modal('toggle');
									angular.element(document.getElementById('marketSurveyController')).scope().findCompetitorByItemId(getValueStringById("product"));
								}else{
									swal({
			    						title: "UNSUCCESSFUL",
			    					  	text: result.MSG,
			    					  	html: true,
			    					  	timer: 2000,
			    					  	type: "error"
			    					});
								}
							},
				    		error:function(){
				    			alertMsgErrorSweet();
				    		} 
						});
				}, 500);
			});
		});
		$("#frmAddCompetitorToProduct").submit();
	} */

	/* $("#btnAdd").click(function(){
		addCompetitorsToProduct();
	}); */

	/*End add competitor block*/


	/*Add Market Survey Block*/
	
	$('.date2').daterangepicker({
        singleDatePicker: true,
        showDropdowns: true,
        format: 'YYYY-MM-DD',
        timePicker: false, 
       
    }).on('change', function(e) {
		if($("#surveyDate").val() != ""){
			$('#frmSurveyDetail').bootstrapValidator('revalidateField', 'surveyDate');
		}
	});
	
	$('#frmSurveyDetail').bootstrapValidator({
			message: 'This value is not valid',
			feedbackIcons: {
				valid: 'glyphicon glyphicon-ok',
				invalid: 'glyphicon glyphicon-remove',
				validating: 'glyphicon glyphicon-refresh'
			},
			fields: {
				product: {
					validators: {
						notEmpty: {
							message: 'The product is required and can not be empty!'
						}
					}
				},
				surveyDate: {
					validators: {
						notEmpty: {
							message: 'The Survey Date is required and can not be empty!'
						},
						date: {
	                        format: 'YYYY-MM-DD',
	                        message: 'The value is not a valid date!'
						}
					}
				}
			}
		});

	/*End Market Survey Block*/
});

function clkCheck(obj){
	$("input[name=check-all]").prop('checked',false);
}

function clkCustomer(obj){
	var n = obj.getAttribute("data-index");
	var custId = obj.getAttribute("value");
	var bool = false;
	if ($(obj).is(':checked')) {
		bool = true;
	}
	angular.element(document.getElementById('marketSurveyController')).scope().customerIndexSet(bool,custId);	
}

function clkCompetitor(obj){
	var n = obj.getAttribute("data-index");
	var comId = obj.getAttribute("value");
	var bool = false;
	if ($(obj).is(':checked')) {
		bool = true;
	}
	angular.element(document.getElementById('marketSurveyController')).scope().competitorIndexSet(bool,comId);	
}



function backTap(obj){
	$("#btnEdit").parent().removeAttr('class', 'active');
}
</script>
<style>
.panel-heading1 h4 {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    line-height: normal;
    width: 75%;
    padding-top: 8px;
}
.trask-btn{
	color: #dd4b39 !important;
}

.like-btn{
	color: #3289c8 !important;
}
.unlike-btn{
}

.icon_color {
	color: #2196F3;
}
.iTable tbody{
	border-top: 1px solid #d2d6de !important;
}
.iTable thead, tr, td{
	border:0px !important;
}



.iTD-width-50 {
	width: 50px;
}

.show-edit {
	width: 70% !important;
	margin: -25px 30% -5px !important;
}

.iTD {
	text-align: center;
	vertical-align: middle;
}

.item_border {
	border: 1px solid #f0f0f0;
}

.font-size-icon-30 {
	font-size: 20px;
}

.pagination {
	display: inline-block;
	padding-left: 0;
	margin: 0px 0px 13px 0px;
	border-radius: 4px;
	margin-buttom: 10px;
}

.cusor_pointer {
	cursor: pointer;
}

.breadcrumb1 {
	padding: 0;
	background: #D4D4D4;
	list-style: none;
	overflow: hidden;
	margin: 10px;
}

.breadcrumb1>li+li:before {
	padding: 0;
}

.breadcrumb1 li {
	float: left;
}

.breadcrumb1 li.active a {
	background: brown; /* fallback color */
	background: rgb(75, 202, 129);
}

.breadcrumb1 li.completed a {
	background: brown; /* fallback color */
	background: hsl(192, 100%, 41%);
}

.breadcrumb1 li.active a:after {
	border-left: 30px solid rgb(75, 202, 129);
}

.breadcrumb1 li.dead a {
	background: brown; /* fallback color */
	background: red;
}

.breadcrumb1 li.dead a:after {
	border-left: 30px solid red;
}

.breadcrumb1 li.completed a:after {
	border-left: 30px solid hsl(192, 100%, 41%);
}

.breadcrumb1 li a {
	color: white;
	text-decoration: none;
	padding: 10px 0 10px 45px;
	position: relative;
	display: block;
	float: left;
}

.breadcrumb1 li a:after {
	content: " ";
	display: block;
	width: 0;
	height: 0;
	border-top: 50px solid transparent;
	/* Go big on the size, and let overflow hide */
	border-bottom: 50px solid transparent;
	border-left: 30px solid hsla(0, 0%, 83%, 1);
	position: absolute;
	top: 50%;
	margin-top: -50px;
	left: 100%;
	z-index: 2;
}

.breadcrumb1 li a:before {
	content: " ";
	display: block;
	width: 0;
	height: 0;
	border-top: 50px solid transparent;
	/* Go big on the size, and let overflow hide */
	border-bottom: 50px solid transparent;
	border-left: 30px solid white;
	position: absolute;
	top: 50%;
	margin-top: -50px;
	margin-left: 1px;
	left: 100%;
	z-index: 1;
}

.breadcrumb1 li:first-child a {
	padding-left: 15px;
}

.breadcrumb1 li a:hover {
	background: rgb(75, 202, 129);
}

.breadcrumb1 li a:hover:after {
	border-left-color: rgb(75, 202, 129) !important;
}

.widget-user .widget-user-header {
    padding: 20px;
    height: 70px !important;
    border-top-right-radius: 3px;
    border-top-left-radius: 3px;
}

.widget-user .widget-user-image {
    position: absolute;
    top: 14px;
    left: 50%;
    margin-left: -45px;
}

.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {
    padding: 8px;
    line-height: 1.42857143;
    vertical-align: middle !important;
    border-top: 1px solid #ddd;
}
</style>
<div class="content-wrapper" id="marketSurveyController" ng-app="marketSurveyApp" ng-controller="marketSurveyController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1><!-- Market Survey -->&nbsp;</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"><i class="fa fa-dashboard"></i>Market Survey</a></li>
		</ol>
	</section>

	<section class="content ng-cloak">
		<div class="row">
			<div class="col-md-12">
				<!-- Widget: user widget style 1 -->
				<div class="box box-widget widget-user">
					<div class="widget-user-header bg-aqua-active">
						<h1 class="widget-user-username">Market Survey</h1>
					</div>
					<div class="widget-user-image">
						<img class="img-circle"
							src="${pageContext.request.contextPath}/resources/images/module/Market-survey.png"
							alt="User Avatar">
					</div>
					<div class="box-footer">
						<div class="row">
							<div class="col-md-12">
								<div class="nav-tabs-custom">
									
									<div class="tab-content">
									
										<div class="tab-pane  in active" id="list_tap">
											<div class="row">
												<div class="col-sm-12">
													<div class="tablecontainer" data-ng-init="listSurveys()" > 
															<div class="box-header with-border row">
																<div style="background: #fff;">
																	<div class="">
																		<div class="col-sm-1">
																			<a href="#addSurvey_tap" class="btn btn-info btn-app"  data-toggle="tab" ng-click="startup()" id="surAdd"><i class="fa fa-plus"></i>Create</a> 
																		</div>
																	</div>
																</div>
															</div>
															<table class="table table-hover" >
																<tr>
																	<th style="cursor: pointer;" ng-click="sort('msId')">ID
																		<span class="glyphicon sort-icon" ng-show="sortKey=='msId'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
																	</th>
																	<th style="cursor: pointer;" ng-click="sort('item.itemId')">Product
																		<span class="glyphicon sort-icon" ng-show="sortKey=='item.itemId'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
																	</th>
																	<th style="cursor: pointer;" ng-click="sort('msDate')">Survey Date
																		<span class="glyphicon sort-icon" ng-show="sortKey=='msDate'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
																	</th>
																	<th style="cursor: pointer;" ng-click="sort('msCreateBy')">Create By
																		<span class="glyphicon sort-icon" ng-show="sortKey=='msCreateBy'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
																	</th>
																					
																	<th>Action</th>
																</tr>
										
																<tr dir-paginate="sur in surveys |orderBy:sortKey:reverse |filter:search |itemsPerPage:5" class="ng-cloak">
																	<td>{{sur.msId}}</td>
																	<td>[{{sur.item.itemId}}] {{sur.item.itemName}}</td>
																	<td>{{sur.msDate}}</td>
																	<td>{{sur.msCreateBy}}</td>
																	<td>
																		<div class="col-sm-2">
																			<div class="btn-group">
														                      <button type="button" class="btn btn-default dropdown-toggle btn-sm" data-toggle="dropdown" aria-expanded="false">
														                        <span class="caret"></span>
														                        <span class="sr-only">Toggle Dropdown</span>
														                      </button>
														                      <ul class="dropdown-menu" role="menu">
														                        <li><a href="#editSurvey_tap" data-toggle="tab" ng-click="findMarketSurveyById(sur.msId)"  id="btnEdit"><i class="fa fa-pencil"></i> Edit</a></li>
														                        <li ng-click="deleteMarketSurvey(sur.msId)"><a href="#"><i class="fa fa-trash"></i> Delete</a></li>
														                        <li><a href="${pageContext.request.contextPath}/view-lead/{{cc.leadID}}"><i class="fa fa-eye"></i> View</a></li>
														                      </ul>
														                    </div>
													                   	</div>	
																	</td>
																</tr>
														
														</table>
														<dir-pagination-controls
													       max-size="5"
													       direction-links="true"
													       boundary-links="true" >
													    </dir-pagination-controls>
													</div>	
												</div>
											</div>

										</div>
										
										<div class="tab-pane" id="addSurvey_tap">
											<div class="row">
												<div class="col-sm-12">
													<form id="frmSurveyDetail">
														<div class="row">
															<div class="box-header with-border">
																<div style="background: #fff;">
																	<div class="col-sm-1">
																		<a href="#list_tap" class="btn btn-info btn-app" id = "backToList" data-toggle="tab" aria-expanded="false" onClick="backTap(this)" ng-click="cancelSurvey();listSurveys()"><i class="fa fa-reply"></i> Back</a> 
																	</div>
																	<div class="col-sm-1">
																		<a class="btn btn-info btn-app" id="addCustToPro" ng-click="addCustToPro(true)" ><i class="fa fa-puzzle-piece" aria-hidden="true"></i> Add Customer</a> 
																	</div>
																	<div class="col-sm-1">
																		<a class="btn btn-info btn-app" id = "addCompetitor" ng-click="addComToPro(true)" ><i class="fa fa-puzzle-piece" aria-hidden="true"></i> Add Competitor</a> 
																	</div>
																</div>
															</div>
														</div>
														<div class="col-sm-6" style="margin-top: 15px;">
															<label class="font-label">Product <span class="requrie">(Required)</span></label>
															<div class="form-group">
																<select class="form-control select2"  name="product" id="product" style="width: 100%;">
											                      <option value="">[-- Select Product --]</option>
											                      <option ng-repeat="item in items" value="{{item.itemId}}">[{{item.itemId}}] {{item.itemName}}</option>            
											                    </select>
															</div>
														</div>
														<div class="col-sm-6" style="margin-top: 15px;">
															<label class="font-label">Survey Date <span class="requrie">(Required)</span></label>
															<div class="form-group">
																<div class="input-group">
																	<div class="input-group-addon">
																		<i class="fa fa-calendar"></i>
																	</div>
																	<input type="text" readonly="readonly" class="form-control pull-right date2" name="surveyDate" id="surveyDate">
																</div> 
															</div>
														</div>
														<div class="col-sm-12 table-responsive" id = "surveyContent">
															<table class="table table-striped">
																<tr>
																	<th class="col-sm-2">[{{item.itemId}}] {{item.itemName}}</th>
																	<th  ng-repeat = "com in item.competitors" class="text-center">{{com.comName}} ({{com.comStatus}})</th>
																</tr>
																<tbody id="data-content">
																<tr ng-repeat="cust in item.customers" data-index="{{$index}}">
																	<td>[{{cust.custId}}] {{cust.custName}}</td>
																	<td ng-repeat = "com in item.competitors" class="text-center">
																		<select name="surveyValue{{$index}}" data-index="{{$index}}" class="form-control" onChange="calculateTotal(this)" id="{{com.comId}}{{cust.custId}}"  style="width: 56px; display: inline-flex !important;">
																			<option value="0">0</option>
																			<option value="1">1</option>
																		</select>
																	</td>
																</tr>
																<tr>
																	<td><b>Total</b></td>
																	<td ng-repeat = "com in item.competitors" id="total{{$index}}" class="text-center">0</td>
																</tr>
																</tbody>
															</table>
															<div id="showBtnEditLead">
																<button type="button" class="btn btn-primary" ng-click="saveMarketSevey()">Save</button>
																<button type="reset" class="btn btn-danger" id="btnSurveyCancel" ng-click="cancelSurvey()">Cancel</button>
															</div>
														</div>
													</form>
												</div>
											</div>

										</div>
										
										<div class="tab-pane" id="editSurvey_tap">
											<div class="row">
												<div class="col-sm-12">
													<form id="frmEditSurveyDetail">
														<div class="col-sm-12">
															<div class="box-header with-border row">
																<div style="background: #fff;">
																	<div class="col-sm-1">
																		<a href="#list_tap" class="btn btn-info btn-app" id = "backToListTap" data-toggle="tab" aria-expanded="false" onClick="backTap(this)" ng-click="cancelSurvey();listSurveys()"><i class="fa fa-reply"></i> Back</a> 
																	</div>
																	<!-- <div class="col-sm-1">
																		<a class="btn btn-info btn-app" id = "addToPro"><i class="fa fa-puzzle-piece" aria-hidden="true"></i> Add Customer</a> 
																	</div>
																	<div class="col-sm-1">
																		<a class="btn btn-info btn-app" id = "addToCom"><i class="fa fa-puzzle-piece" aria-hidden="true"></i> Add Competitor</a> 
																	</div> -->
																</div>
															</div>
														</div>
														<div class="col-sm-6" style="margin-top: 15px;">
															<input type="hidden" id="msId"/>
															<label class="font-label">Product <span class="requrie">(Required)</span></label>
															<div class="form-group">
																<span>[{{item.itemId}}] {{item.itemName}}</span>
															</div>
														</div>
														<div class="col-sm-6" style="margin-top: 15px;">
															<label class="font-label">Survey Date <span class="requrie">(Required)</span></label>
															<div class="form-group">
																<div class="input-group">
																	<span>{{survey.msDate}}</span>
																</div> 
															</div>
														</div>
														<div class="col-sm-12 table-responsive" id = "surveyContentEdit">
															<table class="table table-bordered">
																<tr>
																	<th class="col-sm-2">[{{item.itemId}}] {{item.itemName}}</th>
																	<th  ng-repeat = "com in item.competitors" class="text-center">{{com.comName}}</th>
																</tr>
																<tbody id="data-content-edit">
																<tr ng-repeat="cust in item.customers" data-index="{{$index}}">
																	<td>[{{cust.custId}}] {{cust.custName}}</td>
																	<td ng-repeat = "com in item.competitors" class="text-center">
																		<select name="surveyValue{{$index}}" data-index="{{$index}}" class="form-control" id="{{com.comId}}{{cust.custId}}1" onChange="calculateTotalEdit(this)" style="width: 56px; display: inline-flex !important;">
																			<option value="0">0</option>
																			<option value="1">1</option>
																		</select>
																	</td>
																</tr>
																<tr>
																	<td><b>Total</b></td>
																	<td ng-repeat = "com in item.competitors" id="totalEdit{{$index}}" class="text-center">0</td>
																</tr>
																</tbody>
															</table>
															<div id="showBtnEditLead">
																<button type="button" class="btn btn-primary" ng-click="editMarketSurvey(survey.msId,survey.msDate,item.itemId)">Update</button>
																<button type="reset" class="btn btn-danger" id="btnSurveyCancel" ng-click="findMarketSurveyById(survey.msId)">Cancel</button>
															</div>
														</div>
													</form>
												</div>
											</div>

										</div>
									
									</div>
								</div>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div ng-controller="marketSurveyController" class="modal fade modal-default" id="frmAddCompetitorToProduct" role="dialog">
			<div class="modal-dialog  modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" ng-click="cancelCompetitor()" class="close"
							data-dismiss="modal">&times;</button>
						<h4 class="modal-title">
							<b  id="tCompetitorToProduct">Add Competitors to Product</b>
						</h4>
					</div>
					<div class="modal-body">
						<div class="row">
						
							<div class="col-sm-3">
						        <div class="form-group">
						            <input type="text" ng-model="searchCom" class="form-control" placeholder="Search">
						        </div>
						  	</div>
						 	<div class="col-sm-2">
						        <div class="form-group">
						            <select class="form-control" ng-model="rowNumCom" style="width:100%" id="rowNumCom" name="rowNumCom">
										<option value="5">5</option>
										<option value="10">10</option>
										<option value="15">15</option>
										<option value="20">20</option>
										<option value="50">50</option>
										<option value="100">100</option>
									</select>
						        </div>
				  			</div>
						  	<div class="clearfix"></div>
						
							<form id="">
								<div class="col-md-12">
									<div>
										<div class="form-group table-responsive">
											<table class="table table-bordered">
												<tr class="active info">
													<th><label>Competitor ID</label></th>
													<th><label>Competitor Name</label></th>
													<th class="text-center"></th>
												</tr>
												<tr ng-repeat = "com in competitors |orderBy:sortKey:reverse |filter:searchCom |itemsPerPage:rowNumCom" pagination-id="compRowId"><!-- dir-paginate = "com in competitors |orderBy:sortKey:reverse |filter:search |itemsPerPage:6" -->
													<td class="col-md-3">{{com.comId}}</td>
													<td>{{com.comName}}</td>
													<td class="col-md-1 text-center"><input type="checkbox" ng-checked="com.meDataSource" data-index="{{$index}}" onClick="clkCompetitor(this)"  name="competitor" value="{{com.comId}}" /></td>
												</tr>
											</table>
											<dir-pagination-controls
												pagination-id="compRowId" 
										       max-size="rowNumCom"
										       direction-links="true"
										       boundary-links="true" >
										    </dir-pagination-controls>
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" id="btnCancel"
							ng-click="cancelCompetitor()" name="btnCancel"
							class="btn btn-danger" data-dismiss="modal">Cancel</button>
						&nbsp;&nbsp;
						<button type="button" ng-click="btnComAdd()" class="btn btn-primary pull-right"
							id="btnAdd" name="btnAdd">Add</button>
					</div>
				</div>
			</div>
		</div>
		
		<div ng-controller="marketSurveyController" class="modal fade modal-default" id="frmAddCustomerToProduct" role="dialog">
			<div class="modal-dialog  modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" ng-click="cancelCustomer()" class="close"
							data-dismiss="modal">&times;</button>
						<h4 class="modal-title">
							<b  id="tCustomerToProduct">Add Customers to Product</b>
						</h4>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-sm-3">
						        <div class="form-group">
						            <input type="text" ng-model="search" class="form-control" placeholder="Search">
						        </div>
						  	</div>
						 	<div class="col-sm-2">
						        <div class="form-group">
						            <select class="form-control" ng-model="rowNum" style="width:100%" id="rowNum" name="rowNum">
										<option value="5">5</option>
										<option value="10">10</option>
										<option value="15">15</option>
										<option value="20">20</option>
										<option value="50">50</option>
										<option value="100">100</option>
									</select>
						        </div>
				  			</div>
						  	<div class="clearfix"></div>
							<form id="">
								<div class="col-md-12">
									<div class="form-group table-responsive">
										<table class="table table-bordered">
											<tr class="active info">
												<th><label>Customer ID</label></th>
												<th>Customer Name</th>
												<th class="text-center"></th>
												
											</tr>
											<tr dir-paginate="cust in customers |orderBy:sortKey:reverse |filter:search |itemsPerPage:rowNum" pagination-id="custRowId"   class="ng-cloak">
												<td class="col-md-3">{{cust.custId}} </td>
												<td>{{cust.custName}}</td>
												<td class="col-md-2 text-center"><input type="checkbox" ng-checked="cust.meDataSource" data-index="{{$index}}" onClick="clkCustomer(this)" ng-model="cust.checked"  name="customer" value="{{cust.custId}}" /></td>
											</tr>
											
										</table>
										<dir-pagination-controls
											pagination-id="custRowId" 
									       	max-size="rowNum"
									       	direction-links="true"
									       	boundary-links="true" >
									    </dir-pagination-controls>
									</div>
								</div>
							</form>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" id="btn-cancel" ng-click="cancelCustomer()" name="btn-cancel" class="btn btn-danger" data-dismiss="modal">Cancel</button>
						&nbsp;&nbsp;
						<button type="button" class="btn btn-primary pull-right" ng-click="btnAddCust()" id="btnAddCust" name="btnAddCust">Add</button>
					</div>
				</div>
			</div>
		</div>
	</section>
	<div id="errors"></div>
</div>

<jsp:include page="${request.contextPath}/footer"></jsp:include>
