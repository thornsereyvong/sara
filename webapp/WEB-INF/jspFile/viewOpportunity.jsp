<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>
<%
	String roleDelete = (String) request.getAttribute("role_delete");
%>


<script type="text/javascript">

var permission = ${permission};
var curAssign = "";
var ownerItem = "";

var app = angular.module('viewOpportunity', ['angularUtils.directives.dirPagination']);
var self = this;

var username = "${SESSION}";
var server = "${pageContext.request.contextPath}";

var leadId = "${leadId}";

var lLead = "";

var oppId = "${oppId}";
var lOpportunity = "";

var typeModule = "Opportunity";

var itemChangeStatus1 = true;
var itemChangeStatus2 = true;

var btnSaveProductStatus = false;
var indexItem = 0;
var noteIdEdit = "";
var response=[];
var LEAD = [];
var OPPORTUNITY = [];

var callIdForEdit = null;
var meetIdForEdit = null;
var taskIdForEdit = null;
var eventIdForEdit = null;

var leadStatusData = ["Prospecting", "Qualification", "Analysis", "Proposal", "Negotiation","Close"];
var opportunityStatusData = ["Prospecting", "Qualification", "Analysis", "Proposal", "Negotiation","Close"];



app.controller('viewOpportunityController',['$scope','$http',function($scope, $http){
	
	angular.element(document).ready(function () {				
		$("#oppStage").select2('val',response.OPPORTUNITY.osId);
		$("#oppType").select2('val',response.OPPORTUNITY.otId);
		$("#oppLeadSource").select2('val',response.OPPORTUNITY.sourceID);
		$("#oppCustomer").select2('val',response.OPPORTUNITY.custID);
		$("#oppCampaign").select2('val',response.OPPORTUNITY.campID);
		$("#oppAssignTo").select2('val',response.OPPORTUNITY.userId);
		$("#oppPriceCode").select2('val',response.OPPORTUNITY.priceCode);
		$("#oppClass").select2('val',response.OPPORTUNITY.classId);
		
		$('#frmOpportDetail').data('bootstrapValidator').resetField($('#oppPriceCode'));
		$('#frmOpportDetail').data('bootstrapValidator').resetField($('#oppCustomer'));
		$('#frmOpportDetail').data('bootstrapValidator').resetField($('#oppStage'));
		
    });
	
	$scope.collaborates = [];
	$scope.tags = [];
	$scope.username = username; 
	
	
	
	
	
	$scope.listLeads = function(){
			response = getLeadData();	
			
			OPPORTUNITY = response.OPPORTUNITY;
			$scope.oppLeadSource = response.LEAD_SOURCE;
			$scope.oppType = response.OPP_TYPES;
			$scope.oppAssignTo = response.ASSIGN_TO;
			$scope.oppCampaign = response.CAMPAIGNS;
			$scope.oppStage = response.OPP_STAGES;
			$scope.oppCustomer = response.CUSTOMERS;			
			$scope.opportunity = response.OPPORTUNITY;			
			$scope.listNote1(response.NOTES);
					
			userAllList($scope.oppAssignTo,'#callAssignTo','');
			userAllList($scope.oppAssignTo,'#meetAssignTo','');
			userAllList($scope.oppAssignTo,'#taskAssignTo','');
			userAllList($scope.oppAssignTo,'#eventAssignTo','');
			
			
			displayStatusLead(OPPORTUNITY.osId);
			
			//dis(OPPORTUNITY)
			
			
			curAssign = fmNull(response.OPPORTUNITY.username);
			ownerItem = fmNull(response.OPPORTUNITY.opCreateBy);
			
			
			
			$scope.listAllCallByLeadId(response.CALLS);	
			$scope.listAllMeetByLeadId(response.MEETINGS);	
			$scope.listAllTaskByLeadId(response.TASKS);
			$scope.listAllEventByLeadId(response.EVENTS);
			
			$scope.contact = response.CONTACTS;
			$scope.quote = response.QUOTATIONS;
			$scope.saleOrder = response.SALE_ORDERS;
			
			
			
			$scope.allContact = response.ALL_CONTACTS;
			$scope.allQuote = response.ALL_QUOTATIONS;
			$scope.allSaleOrder = response.ALL_SALE_ORDERS;
			
			$scope.listAllEmailByLeadId = function(){	
				$scope.listAllEmailByLead = [];	
			}
			
			$scope.listCollab(response.COLLABORATIONS);							
			$scope.callStatusStartup = response.CALL_STATUS;
			$scope.taskStatusStartup = response.TASK_STATUS;
			$scope.taskContactStartup = response.ALL_CONTACT;	
			$scope.eventLocationStartup = response.EVENT_LOCATION;
			$scope.meetStatusStartup = response.MEETING_STATUS;				
			$scope.tags = response.TAG_TO;
			
			addContactToTask(response.CONTACTS);
			
			$scope.oppPriceCode = 	response.PRICE_CODE;
			$scope.oppClass = 	response.OPPORTUNITY_DETAILS_STARTUP.CLASSES;
			
			
			// frm add opportunity
			$scope.oppLocation = response.OPPORTUNITY_DETAILS_STARTUP.LOCATION;
			$scope.oppItem = response.OPPORTUNITY_DETAILS_STARTUP.ITEMS;
			$scope.oppUom = response.OPPORTUNITY_DETAILS_STARTUP.UOM;			
			$scope.opportunityDetail = response.OPPORTUNITY_DETAILS;
			
			//dis($scope.opportunity)
			
	}
	
	
	$scope.sort = function(keyname){
	    $scope.sortKey = keyname;   //set the sortKey to the param passed
	    $scope.reverse = !$scope.reverse; //if true make it false and vice versa
	};
	
	
	// tab product 
	
	
	$scope.oppQty = "";
	$scope.oppUnitPrice = "";
	$scope.oppPriceFactor = "";
	$scope.oppReportPrice = "";	
	$scope.oppTAmount = "";	
	$scope.oppDisPer = "";
	$scope.oppDisDol = "";
	$scope.oppVatPer = "";
	$scope.oppVatDol = "";
	$scope.oppSTPer = "";
	$scope.oppSTDol = "";	
	$scope.oppNetTAmount="";
	
	
	$scope.cancelProductClick = function(){
		$("#frmAddProduct").bootstrapValidator('resetForm', 'true');		
	}
	
	$scope.product_click = function(){ 
		btnSaveProductStatus =  true;
		
		$scope.oppQty = "";
		$scope.oppUnitPrice = "";
		$scope.oppPriceFactor = "";
		$scope.oppReportPrice = "";	
		$scope.oppTAmount = "";	
		$scope.oppDisPer = "";
		$scope.oppDisDol = "";
		$scope.oppVatPer = "";
		$scope.oppVatDol = "";
		$scope.oppSTPer = "";
		$scope.oppSTDol = "";	
		$scope.oppNetTAmount="";
		
		$scope.oppItemModel = "";
		
		$scope.resetSelect2("oppItem");
		$scope.resetSelect2("oppClassDetail");
		$scope.resetSelect2("oppUom");
		$scope.resetSelect2("oppLocation");
		
		
		setValueById('oppTAmount',"");
		setValueById('oppNetTAmount',"");
		
		
		$("#frmAddProduct").bootstrapValidator('resetForm', 'true');
		$('#frmAddProduct')[0].reset();
		
		
		$('#frmAddProduct').data('bootstrapValidator').resetField($('#oppItem'));
		$('#frmAddProduct').data('bootstrapValidator').resetField($('#oppUom'));
		$('#frmAddProduct').data('bootstrapValidator').resetField($('#oppLocation'));
		
		$("#tProduct").text("Add An Item");
		$("#btn_show_product").click();
	}
	
	
	$scope.oppItemChange1 = function(item){ 		
		if(itemChangeStatus1 == true && itemChangeStatus2 == true){
			$("#oppUom").select2('val', '');
	    	var priceCode = OPPORTUNITY.priceCode;
	    	if(item != ""){
	    		$.ajax({ 
				    url: server+"/quote/itemChange", 
				    type: 'POST',
				    data: JSON.stringify({"itemId" : item, "priceCode" : priceCode}),
				    beforeSend: function(xhr) {
		                xhr.setRequestHeader("Accept", "application/json");
		                xhr.setRequestHeader("Content-Type", "application/json");
		            },
				    success: function(data) {
				    	 if(data.MESSAGE == 'SUCCESS'){
				    		 $("#oppUom").select2('val', data.DATA.UOM);
				    		 setValueById('oppUnitPrice',formatNumByLength(data.DATA.up, 6));
				    		 setValueById('oppReportPrice',formatNumByLength(data.DATA.rp, 6));
				    		 setValueById('oppPriceFactor',"1.0000");
				    		 
				    		 $scope.assignValuePro(data);
				    		 
				    		 $scope.calculateProduct();
				    		 
				    	 }else{
				    		 $("#oppUom").select2('val', '');
				    	 }			    	 			    	 
				    },
				    error:function() {}
				});
	    	}
			
		}else{
			
		}
    	
		
	}
	
	$scope.assignValuePro = function(data){
		$scope.oppReportPrice = formatNumByLength(data.DATA.rp, 6);
		$scope.oppPriceFactor = "1.0000";
		$scope.oppUnitPrice = formatNumByLength(data.DATA.up, 6);
	}
	
	$scope.calculateProduct = function(){
		$scope.oppTAmount = formatNumByLength((toNum($scope.oppQty) * toNum($scope.oppUnitPrice) * toNum($scope.oppPriceFactor)), 2);
		
		$scope.oppDisDol = "0.00";
		$scope.oppVatDol = "0.00";
		$scope.oppSTDol = "0.00";
		
		
		if(toNum($scope.oppTAmount) != 0){
			$scope.oppDisDol = formatNumByLength(((toNum($scope.oppTAmount) * toNum($scope.oppDisPer)) / 100), 2) ;					
			$scope.oppVatDol = formatNumByLength((((toNum($scope.oppTAmount)-toNum($scope.oppDisDol)) * toNum($scope.oppVatPer)) / 100), 2) ;
			$scope.oppSTDol = formatNumByLength((((toNum($scope.oppTAmount)-toNum($scope.oppDisDol)) * toNum($scope.oppSTPer)) / 100), 2) ;			
		}
				
		$scope.oppNetTAmount = formatNumByLength((toNum($scope.oppTAmount) - toNum($scope.oppDisDol) + toNum($scope.oppVatDol) + toNum($scope.oppSTDol)), 2);
				
		setValueById('oppTAmount',$scope.oppTAmount);
		setValueById('oppNetTAmount',$scope.oppNetTAmount);						
	}
	
	$scope.oppQtyChange = function(){			
		$scope.calculateProduct();
	}
		
	$scope.oppUnitePriceChange = function(){
		$scope.calculateProduct();
	}
	
	$scope.oppPriceFactorChange = function(){
		$scope.calculateProduct();
	}
	
	$scope.fToNumber = function(event, num, l){ 
		$(event.target).val(formatNumByLength(toNum(num),l));
	}
	
	
	$scope.oppDisPerChange = function(){		
		$scope.calculateProduct();						
	}
	$scope.oppDisDolChange = function(){
		$scope.oppDisPer = "0.00";
		if(toNum($scope.oppTAmount) != 0 && toNum($scope.oppDisDol) != 0){
			$scope.oppDisPer = formatNumByLength(((toNum($scope.oppDisDol) * 100) / toNum($scope.oppTAmount)),5) ;
		}
		
		if(toNum($scope.oppTAmount) != 0){
								
			$scope.oppVatDol = formatNumByLength((((toNum($scope.oppTAmount)-toNum($scope.oppDisDol)) * toNum($scope.oppVatPer)) / 100), 2) ;
			$scope.oppSTDol = formatNumByLength((((toNum($scope.oppTAmount)-toNum($scope.oppDisDol)) * toNum($scope.oppSTPer)) / 100), 2) ;			
		}
				
		$scope.oppNetTAmount = formatNumByLength((toNum($scope.oppTAmount) - toNum($scope.oppDisDol) + toNum($scope.oppVatDol) + toNum($scope.oppSTDol)), 2);		
	}
	
	
	$scope.oppVatPerChange = function(){		
		$scope.calculateProduct();						
	}
	$scope.oppVatDolChange = function(){
		$scope.oppVatPer = "0.00";
		if(toNum($scope.oppTAmount) != 0 && toNum($scope.oppVatDol) != 0){
			$scope.oppVatPer = formatNumByLength(((toNum($scope.oppVatDol) * 100) / (toNum($scope.oppTAmount)-toNum($scope.oppDisDol))),5) ;
		}
		
		if(toNum($scope.oppTAmount) != 0){
			$scope.oppDisDol = formatNumByLength(((toNum($scope.oppTAmount) * toNum($scope.oppDisPer)) / 100), 2) ;					
			
			$scope.oppSTDol = formatNumByLength((((toNum($scope.oppTAmount)-toNum($scope.oppDisDol)) * toNum($scope.oppSTPer)) / 100), 2) ;			
		}
		$scope.oppNetTAmount = formatNumByLength((toNum($scope.oppTAmount) - toNum($scope.oppDisDol) + toNum($scope.oppVatDol) + toNum($scope.oppSTDol)), 2);
	
	}
	
	
	$scope.oppSTPerChange = function(){		
		$scope.calculateProduct();						
	}
	$scope.oppSTDolChange = function(){
		$scope.oppSTPer = "0.00";
		if(toNum($scope.oppTAmount) != 0 && toNum($scope.oppSTDol) != 0 && (toNum($scope.oppTAmount)-toNum($scope.oppDisDol)) != 0){
			$scope.oppSTPer = formatNumByLength(((toNum($scope.oppSTDol) * 100) / (toNum($scope.oppTAmount)-toNum($scope.oppDisDol))),5) ;
		}
		
		if(toNum($scope.oppTAmount) != 0){
			$scope.oppDisDol = formatNumByLength(((toNum($scope.oppTAmount) * toNum($scope.oppDisPer)) / 100), 2) ;					
			$scope.oppVatDol = formatNumByLength((((toNum($scope.oppTAmount)-toNum($scope.oppDisDol)) * toNum($scope.oppVatPer)) / 100), 2) ;
						
		}
		$scope.oppNetTAmount = formatNumByLength((toNum($scope.oppTAmount) - toNum($scope.oppDisDol) + toNum($scope.oppVatDol) + toNum($scope.oppSTDol)), 2);
		
	}
	
	$scope.resetSelect2 = function(ID){
		$("#"+ID).select2('val','');
	}
	
	$scope.btnProductSave = function(){
		
		$('#frmAddProduct').data('bootstrapValidator').validate();
		var statusAddPro = $("#frmAddProduct").data('bootstrapValidator').validate().isValid();
		if(statusAddPro){
			
			if(btnSaveProductStatus){
			
				var uomIndex = $("#oppUom").find(":selected").attr("data-index");					
				var dataFrm = {
						"opDetailsId" : null,
						"opId":oppId,
						"lineNo" : 1,
						"item" : getValFromSelect("oppItem","itemId", "itemName"),
						"uom" : $scope.getUomByKey(uomIndex),
						"location" : getValFromSelect("oppLocation","locationId", "locationName"),
						"ameClass" :  getValFromSelect("oppClassDetail","classId", "className"),
						"saleQty" : toNum($scope.oppQty),
						"unitPrice" : toNum($scope.oppUnitPrice),
						"totalAmt" : toNum($scope.oppTAmount),
						"netTotalAmt" : toNum($scope.oppNetTAmount),
						"disDol" : toNum($scope.oppDisDol),
						"disPer" : toNum($scope.oppDisPer),
						"sTaxDol" : toNum($scope.oppSTDol),
						"sTaxPer" : toNum($scope.oppSTPer),
						"vTaxDol" : toNum($scope.oppVatDol),
						"vTaxPer" : toNum($scope.oppVatPer),
						"reportPrice" : toNum($scope.oppReportPrice),
						"factor" : toNum($scope.oppPriceFactor)					
				};						
				
				
				$scope.opportunityDetail.push(dataFrm);
				$scope.opportunity.totalVTax = 0;
				$scope.opportunity.totalSTax = 0;
				$scope.opportunity.totalAmt = 0;
				angular.forEach($scope.opportunityDetail, function(value, key) {				
					$scope.opportunity.totalVTax += toNum(value.vTaxDol);
					$scope.opportunity.totalSTax += toNum(value.sTaxDol);	
					$scope.opportunity.totalAmt += toNum(value.netTotalAmt);
				});
				$scope.opportunity.disInvDol = toNum($scope.opportunity.totalAmt) * toNum($scope.opportunity.disInvPer) / 100;	
				$scope.opportunity.opAmount = toNum($scope.opportunity.totalAmt) - toNum($scope.opportunity.disInvDol);
				
				$scope.oppQty = "";
				$scope.oppUnitPrice = "";
				$scope.oppPriceFactor = "";
				$scope.oppReportPrice = "";	
				$scope.oppTAmount = "";	
				$scope.oppDisPer = "";
				$scope.oppDisDol = "";
				$scope.oppVatPer = "";
				$scope.oppVatDol = "";
				$scope.oppSTPer = "";
				$scope.oppSTDol = "";	
				$scope.oppNetTAmount="";
				
				$scope.oppItemModel = "";
				
				$scope.resetSelect2("oppItem");
				$scope.resetSelect2("oppClassDetail");
				$scope.resetSelect2("oppUom");
				$scope.resetSelect2("oppLocation");
				
				
				setValueById('oppTAmount',"");
				setValueById('oppNetTAmount',"");
				
				
				$("#frmAddProduct").bootstrapValidator('resetForm', 'true');
				$('#frmAddProduct')[0].reset();
			}else{
				
				var uomIndex = $("#oppUom").find(":selected").attr("data-index");	
				
				$scope.opportunityDetail[indexItem].item = getValFromSelect("oppItem","itemId", "itemName");
				$scope.opportunityDetail[indexItem].location = getValFromSelect("oppLocation","locationId", "locationName");
				$scope.opportunityDetail[indexItem].uom = $scope.getUomByKey(uomIndex);
				$scope.opportunityDetail[indexItem].ameClass = getValFromSelect("oppClassDetail","classId", "className"),
				
				$scope.opportunityDetail[indexItem].saleQty = toNum($scope.oppQty);
				$scope.opportunityDetail[indexItem].unitPrice = toNum($scope.oppUnitPrice);
				$scope.opportunityDetail[indexItem].totalAmt = toNum($scope.oppTAmount);
				$scope.opportunityDetail[indexItem].netTotalAmt = toNum($scope.oppNetTAmount);
				$scope.opportunityDetail[indexItem].disDol = toNum($scope.oppDisDol);
				$scope.opportunityDetail[indexItem].disPer = toNum($scope.oppDisPer);
				$scope.opportunityDetail[indexItem].sTaxDol = toNum($scope.oppSTDol);
				$scope.opportunityDetail[indexItem].sTaxPer = toNum($scope.oppSTPer);
				$scope.opportunityDetail[indexItem].vTaxDol = toNum($scope.oppVatDol);
				$scope.opportunityDetail[indexItem].vTaxPer = toNum($scope.oppVatPer);
				$scope.opportunityDetail[indexItem].reportPrice = toNum($scope.oppReportPrice);
				$scope.opportunityDetail[indexItem].factor = toNum($scope.oppPriceFactor);
				
				
				$scope.opportunity.totalVTax = 0;
				$scope.opportunity.totalSTax = 0;
				$scope.opportunity.totalAmt = 0;
				angular.forEach($scope.opportunityDetail, function(value, key) {				
					$scope.opportunity.totalVTax += toNum(value.vTaxDol);
					$scope.opportunity.totalSTax += toNum(value.sTaxDol);	
					$scope.opportunity.totalAmt += toNum(value.netTotalAmt);
				});
				$scope.opportunity.disInvDol = toNum($scope.opportunity.totalAmt) * toNum($scope.opportunity.disInvPer) / 100;	
				$scope.opportunity.opAmount = toNum($scope.opportunity.totalAmt) - toNum($scope.opportunity.disInvDol);
				
				
				$scope.oppQty = "";
				$scope.oppUnitPrice = "";
				$scope.oppPriceFactor = "";
				$scope.oppReportPrice = "";	
				$scope.oppTAmount = "";	
				$scope.oppDisPer = "";
				$scope.oppDisDol = "";
				$scope.oppVatPer = "";
				$scope.oppVatDol = "";
				$scope.oppSTPer = "";
				$scope.oppSTDol = "";	
				$scope.oppNetTAmount="";
				
				$scope.oppItemModel = "";
				
				$scope.resetSelect2("oppItem");
				$scope.resetSelect2("oppClassDetail");
				$scope.resetSelect2("oppUom");
				$scope.resetSelect2("oppLocation");
				
				
				setValueById('oppTAmount',"");
				setValueById('oppNetTAmount',"");
				
				
				$("#frmAddProduct").bootstrapValidator('resetForm', 'true');
				$('#frmAddProduct')[0].reset();
				
				$("#frmProduct").modal('toggle');
				
			}
		}else{
			// error
			
			
		}
		
		
	}
	
	
	$scope.getUomByKey = function(key){
		return $scope.oppUom[key];
	}
	
	var toggleDisInv = true;
	
	$scope.editDisInvClick = function(){		
		if(toggleDisInv){
			$(".show-text-disInv").hide();
			$(".show-disInv").show();
		}else{
			$(".show-text-disInv").show();
			$(".show-disInv").hide();
		}		
		toggleDisInv = !toggleDisInv;		
	}
	
	
	$scope.oppDisInvPerChange = function(){	
		$scope.opportunity.disInvDol = toNum($scope.opportunity.totalAmt) * toNum($scope.opportunity.disInvPer) / 100;		
		$scope.opportunity.opAmount = toNum($scope.opportunity.totalAmt) - toNum($scope.opportunity.disInvDol);
	}
	
	
	
	$scope.deleteProductClick = function(key){
		
		$scope.opportunityDetail.splice(key, 1);     
		
		$scope.opportunity.totalVTax = 0;
		$scope.opportunity.totalSTax = 0;
		$scope.opportunity.totalAmt = 0;
		
		
		angular.forEach($scope.opportunityDetail, function(value, key) {
			$scope.opportunity.totalVTax += toNum(value.vTaxDol);
			$scope.opportunity.totalSTax += toNum(value.sTaxDol);	
			$scope.opportunity.totalAmt += toNum(value.netTotalAmt);
		});
		$scope.opportunity.disInvDol = toNum($scope.opportunity.totalAmt) * toNum($scope.opportunity.disInvPer) / 100;	
		$scope.opportunity.opAmount = toNum($scope.opportunity.totalAmt) - toNum($scope.opportunity.disInvDol);				
		
	}
	
	$scope.editProductClick = function(key){
		$("#tProduct").text("Edit Item");
		indexItem = key;
		btnSaveProductStatus =  false;
		itemChangeStatus2 = false;
		$("#btn_show_product").click();
		
		var item = "["+$scope.opportunityDetail[key].item.itemId+"] "+$scope.opportunityDetail[key].item.itemName;
		var loc = "["+$scope.opportunityDetail[key].location.locationId+"] "+$scope.opportunityDetail[key].location.locationName;
		var cla = "";
		
		if($scope.opportunityDetail[key].ameClass != null){
			cla = "["+$scope.opportunityDetail[key].ameClass.classId+"] "+$scope.opportunityDetail[key].ameClass.className;
		}
		
		$("#oppItem").select2('val', item);
		
		$("#oppUom").select2('val', $scope.opportunityDetail[key].uom.uomId);		
		$("#oppLocation").select2('val', loc);
		$("#oppClassDetail").select2('val', cla);
		
		
		$scope.oppQty = formatNumByLength($scope.opportunityDetail[key].saleQty,4);
		$scope.oppUnitPrice = formatNumByLength($scope.opportunityDetail[key].unitPrice,6);
		$scope.oppPriceFactor = formatNumByLength($scope.opportunityDetail[key].factor,4);
		$scope.oppReportPrice = formatNumByLength($scope.opportunityDetail[key].reportPrice,4);
		$scope.oppTAmount = formatNumByLength($scope.opportunityDetail[key].totalAmt,2);	
		$scope.oppDisPer = formatNumByLength($scope.opportunityDetail[key].disPer,5);
		$scope.oppDisDol = formatNumByLength($scope.opportunityDetail[key].disDol,2);
		$scope.oppVatPer = formatNumByLength($scope.opportunityDetail[key].vTaxPer,5);
		$scope.oppVatDol = formatNumByLength($scope.opportunityDetail[key].vTaxDol,2);
		$scope.oppSTPer = formatNumByLength($scope.opportunityDetail[key].sTaxPer,5);
		$scope.oppSTDol = formatNumByLength($scope.opportunityDetail[key].sTaxDol,2);
		$scope.oppNetTAmount= formatNumByLength($scope.opportunityDetail[key].netTotalAmt,2);	
		
		setValueById('oppQty',$scope.oppQty);
		setValueById('oppUnitPrice',$scope.oppUnitPrice);
		setValueById('oppPriceFactor',$scope.oppPriceFactor);
		setValueById('oppReportPrice',$scope.oppReportPrice);
		setValueById('oppTAmount',$scope.oppTAmount);
		setValueById('oppDisPer',$scope.oppDisPer);
		setValueById('oppDisDol',$scope.oppDisDol);
		setValueById('oppVatPer',$scope.oppVatPer);
		setValueById('oppVatDol',$scope.oppVatDol);		
		setValueById('oppSTPer',$scope.oppSTPer);
		setValueById('oppSTDol',$scope.oppSTDol);
		setValueById('oppNetTAmount',$scope.oppNetTAmount);
		
		
		itemChangeStatus2 = true;
	}
	
	
	$scope.btnSaveClick = function(){
		
		swal({   
			title: "<span style='font-size: 25px;'>You are about to save prouduct.</span>",
			text: "Click OK to continue or CANCEL to abort.",
			type: "info",
			html: true,
			showCancelButton: true,
			closeOnConfirm: false,
			showLoaderOnConfirm: true,		
		}, function(){ 
			setTimeout(function(){
				
				var tr = $("#listItem tr");		
				var dataDetail = [];
				$scope.opportunity.totalDis = 0;
				if(tr.length>0){
					var n = "";
					for(var i=0;i<tr.length;i++){
						n =tr.eq(i).attr('data-row-index');
						$scope.opportunityDetail[n].lineNo = i+1;
						dataDetail.push($scope.opportunityDetail[n]);
						$scope.opportunity.totalDis += toNum($scope.opportunityDetail[n].disDol);
					}
				}		
				
				var dataFrm = {
					"opId" : oppId,
					"totalAmount" : toNum($scope.opportunity.totalAmt),
					"totalVTax" : toNum($scope.opportunity.totalVTax),
					"totalSTax" : toNum($scope.opportunity.totalSTax),
					"disInvDol" : toNum($scope.opportunity.disInvDol),
					"disInvPer" : toNum($scope.opportunity.disInvPer),
					"opAmount" : toNum($scope.opportunity.opAmount),
					"totalDis" : toNum($scope.opportunity.totalDis),
					"details" : dataDetail
				}
				
				$.ajax({ 
					method: 'PUT',
					url: "${pageContext.request.contextPath}/opportunity/edit/custom",
				    data: JSON.stringify(dataFrm),
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
		
	}
	
	
	
	// end tab product
	
	
	
	
	
	
	
// Tab Collaborate***************************
	
	$scope.listCollab = function(response){
		$scope.collaborates = response;		
	}
		
	$scope.listCollabByLeadByUser = function(){
		$http({
		    method: 'POST',
		    url: "${pageContext.request.contextPath}/collaborate/list/lead/user",
		    headers: {
		    	'Accept': 'application/json',
		        'Content-Type': 'application/json'
		    },
		    data: {"moduleId":oppId, "username":username}
		}).success(function(response) {		
			$scope.listCollab(response.DATA);		
		});	
	}
	
	$scope.resetFrmCollab = function(){
		collabIdEdit = "";
		$("#collabTags").select2("val","");
		$('#frmCollab').bootstrapValidator('resetForm', true);
	}
	
	$scope.addCollab = function(){
		$('#frmCollab').submit();
	}
	
	$scope.postLike = function(key,collabId){		
		var status = $scope.collaborates[key].checkLike;
		status = (status == true) ? false : true ;   		
		$http({
		    method: 'POST',
		    url: "${pageContext.request.contextPath}/collaborate/like",
		    headers: {
		    	'Accept': 'application/json',
		        'Content-Type': 'application/json'
		    },
		    data: {"collapId":collabId, "username":username,"likeStatus":status.toString()}
		}).success(function(response) {	
			$scope.collaborates[key].checkLike = status;		
		});
	} 
		
	
	$scope.newcomment = {};
    $scope.postCommand = function(key,colId){
    	var txtComment = $.trim($scope.newcomment[key].comment);
    	if(txtComment != ""){
    		$http({
    		    method: 'POST',
    		    url: "${pageContext.request.contextPath}/collaborate/add/comment",
    		    headers: {
    		    	'Accept': 'application/json',
    		        'Content-Type': 'application/json'
    		    },
    		    data: {"postId":colId, "username":username,"comment":txtComment}
    		}).success(function(response) {					
    			$scope.collaborates[key].details.push(response.COMMENTS);
    	      	$scope.newcomment = {};			
    		});
    	}     	
    };
	
    
$scope.btnDeleteCollabCom = function(keyParent,keyChild,comId){	    	
    	
    	swal({
            title: "<span style='font-size: 25px;'>You are about to delete comment.</span>",
            text: "Click OK to continue or CANCEL to abort.",
            type: "info",
			html: true,
			showCancelButton: true,
			closeOnConfirm: false,
			showLoaderOnConfirm: true,
        }, 
        function(isConfirm){ 
        	  if(isConfirm){        		
        		  $http.delete("${pageContext.request.contextPath}/collaborate/comment/remove/"+comId).success(function(){
	        		 swal({
	              		title:"Deleted",
	              		text:"The comment have been deleted!",
	              		type:"success",  
	              		timer: 2000,   
	              		showConfirmButton: false
      			  	  }); 	        		 
        		  });
        		  $scope.collaborates[keyParent].details.splice(keyChild, 1);
        	  }else{
        		 swal({
  	                title:"Cancelled",
  	                text:"This comment is safe!",
  	                type:"error",
  	                timer:2000,
  	                showConfirmButton: false});
        	  }        	        	        	       		
        });
    }
    
	$scope.btnDeleteCollabPost = function(key,postId){
    	swal({
    		 title: "<span style='font-size: 25px;'>You are about to delete post.</span>",
             text: "Click OK to continue or CANCEL to abort.",
             type: "info",
 			html: true,
 			showCancelButton: true,
 			closeOnConfirm: false,
 			showLoaderOnConfirm: true,
        }, 
        function(isConfirm){              	
        	 if(isConfirm){
	       		  $http.delete("${pageContext.request.contextPath}/collaborate/delete/"+postId).success(function(){
		        		  swal({
		              		title:"Deleted",
		              		text:"The post have been deleted!",
		              		type:"success",  
		              		timer: 2000,   
		              		showConfirmButton: false
	     			  	  }); 
		        		  $scope.collaborates.splice(key, 1);
	       		  }); 
	       	  }else{
	       		  swal({
	 	                title:"Cancelled",
	 	                text:"This post is safe!",
	 	                type:"error",
	 	                timer:2000,
	 	                showConfirmButton: false});
	       	  }         			
        });    	    	    	
    }	
	
	// End Collaborate***************************
	
	
	
	
	
	
	// note
	$scope.addNote = function(){
		$('#frmAddNote').submit();
	}
	$scope.editNoteById = function(noteId){
		$scope.getNoteById(noteId); 
	}
	$scope.deleteNoteById = function(noteId){
		$scope.resetFrmNote();
		
		if(getPermissionByModule("AC_NO","delete") == "YES"){
			swal({   
				title: "<span style='font-size: 25px;'>You are about to delete note with ID: <span class='color_msg'>"+noteId+"</span>.</span>",
				text: "Click OK to continue or CANCEL to abort.",
				type: "info",
				html: true,
				showCancelButton: true,
				closeOnConfirm: false,
				showLoaderOnConfirm: true,		
			}, function(){ 
				setTimeout(function(){
					$.ajax({ 
						url : "${pageContext.request.contextPath}/note/remove/"+noteId,
						type : "DELETE",
						beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
					    }, 
					    success: function(result){					    						    
							if(result.MESSAGE == "DELETED"){						
								$scope.getListNoteByLead();
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
		}else{
			alertMsgNoPermision();
		}		
	}
	
	$scope.resetFrmNote = function(){
		noteIdEdit = "";
		$("#btnAddNote").text('Note');
		$('#frmAddNote').bootstrapValidator('resetForm', true);
	}
	$scope.listNote1 = function(data){
		$scope.notes = data;		
	};
	var indexedTeams = [];
    
    $scope.noteToFilter = function() {
        indexedTeams = [];
        return $scope.notes;
    }
    
    $scope.filterNote = function(note) {
        var teamIsNew = indexedTeams.indexOf(note.noteCreateDate) == -1;
        if (teamIsNew) {
            indexedTeams.push(note.noteCreateDate);
        }
        return teamIsNew;
    }
	
    $scope.getNoteById = function(noteId){
    	 angular.forEach($scope.notes, function(value, key) {
	   		if(value.noteId === noteId) {
	   			noteIdEdit = noteId;
    	        $("#note_subject").val(value.noteSubject);
    	        $("#note_description").val(value.noteDes);
    	        $("#btnAddNote").text('Update');
    	   	}
   		});
    }
    $scope.getListNoteByLead = function(){    	
		$http.get("${pageContext.request.contextPath}/note/list/opp/"+oppId).success(function(response){ 
			$scope.listNote1(response.NOTES);
		});
	};
    
	
	
	// lead
	
	
	$scope.editDetailLead = function(){
		$(".show-edit").show();
		$(".show-edit-non-style").show();
		
		$(".show-text-detail").hide();
		$("#showBtnEditLead").show();
		
		addDataToDetailLead();
	}
	
	$scope.saveEditDetailLead = function(){		
		$('#frmOpportDetail').submit();
	}
	
	$scope.cancelEditDetailLead = function(){
		$('#frmOpportDetail').bootstrapValidator('resetForm', true);
		$(".show-edit").hide();
		$(".show-edit-non-style").hide();
		$(".show-text-detail").show();
		$("#showBtnEditLead").hide();
	}
	
    
	// Call path
	$scope.listAllCallByLeadId = function(data){
		$scope.listAllCallByLead = data;	
	}
	$scope.listDataCallByRalateType = function(){
		$http.get("${pageContext.request.contextPath}/call/list-by-opportunity/"+oppId).success(function(response){	
			$scope.listAllCallByLeadId(response.CALLS);	
		});	
	}
	
	$scope.call_click = function(){
		$("#btn_show_call").click();
	}
	$scope.actEditCall = function(callId){
		$http.get("${pageContext.request.contextPath}/call/list/"+callId).success(function(response){
			addDataCallToForm(response.DATA);
			callIdForEdit = callId;
			$("#btnCallSave").text("Update");
			$("#tCall").text("Update Call");
			$("#btn_show_call").click();
		});		
	}
	$scope.actDeleteCall = function(callId){
		if(getPermissionByModule("AC_CL","delete") == "YES"){
			swal({   
				title: "<span style='font-size: 25px;'>You are about to delete call with ID: <span class='color_msg'>"+callId+"</span>.</span>",
				text: "Click OK to continue or CANCEL to abort.",
				type: "info",
				html: true,
				showCancelButton: true,
				closeOnConfirm: false,
				showLoaderOnConfirm: true,		
			}, function(){ 
				setTimeout(function(){
					$.ajax({ 
						url : "${pageContext.request.contextPath}/call/remove/"+callId,
						type : "DELETE",
						beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
					    }, 
					    success: function(result){					    						    
							if(result.MESSAGE == "DELETED"){						
								$scope.listDataCallByRalateType();
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
		}else{
			alertMsgNoPermision();
		}
		
		
	}
	// end call path
	
	// meeting path
	
	$scope.listAllMeetByLeadId = function(data){
		$scope.listAllMeetByLead = data;	
	}
	
	$scope.listDataMeetByRalateType = function(){
		$http.get("${pageContext.request.contextPath}/meeting/list-by-opportunity/"+oppId).success(function(response){		
			$scope.listAllMeetByLeadId(response.MEETINGS);	
		});	
	}
	
	$scope.meet_click = function(){
		$("#btn_show_meet").click();
	}
	$scope.actEditMeeting = function(meetingId){				
		$http.get("${pageContext.request.contextPath}/meeting/list/"+meetingId).success(function(response){			
			addDataMeetToForm(response.DATA);
			meetIdForEdit = meetingId;
			$("#btnMeetSave").text("Update");
			$("#tMeet").text("Update Meeting");
			$("#btn_show_meet").click();
		});		
	}
$scope.actDeleteMeeting = function(meetingId){	
		
		if(getPermissionByModule("AC_ME","delete") == "YES"){
			swal({   
				title: "<span style='font-size: 25px;'>You are about to delete meeting with ID: <span class='color_msg'>"+meetingId+"</span>.</span>",
				text: "Click OK to continue or CANCEL to abort.",
				type: "info",
				html: true,
				showCancelButton: true,
				closeOnConfirm: false,
				showLoaderOnConfirm: true,		
			}, function(){ 
				setTimeout(function(){
					$.ajax({ 
						url : "${pageContext.request.contextPath}/meeting/remove/"+meetingId,
						type : "DELETE",
						beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
					    }, 
					    success: function(result){					    						    
							if(result.MESSAGE == "DELETED"){						
								$scope.listDataMeetByRalateType();
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
		}else{
			alertMsgNoPermision();
		}
		
		
	}
	
	
	
	// end meeting path
	
	// Task path
	
	$scope.task_click = function(){
		$("#btn_show_task").click();
	}
	$scope.listAllTaskByLeadId = function(data){
		$scope.listAllTaskByLead = data;	
	}
	$scope.listDataTaskByRalateType = function(){
		$http.get("${pageContext.request.contextPath}/task/list-by-opportunity/"+oppId).success(function(response){		
			$scope.listAllTaskByLeadId(response.TASKS);	
		});	
	}
	$scope.actEditTask = function(taskId){				
		$http.get("${pageContext.request.contextPath}/task/list/"+taskId).success(function(response){			
			addDataTaskToForm(response.DATA);
			taskIdForEdit = taskId;
			$("#btnTaskSave").text("Update");
			$("#tTask").text("Update Task");
			$("#btn_show_task").click();
		});		
	}
	
$scope.actDeleteTask = function(taskId){						
		
		if(getPermissionByModule("AC_TA","delete") == "YES"){
			swal({   
				title: "<span style='font-size: 25px;'>You are about to delete task with ID: <span class='color_msg'>"+taskId+"</span>.</span>",
				text: "Click OK to continue or CANCEL to abort.",
				type: "info",
				html: true,
				showCancelButton: true,
				closeOnConfirm: false,
				showLoaderOnConfirm: true,		
			}, function(){ 
				setTimeout(function(){
					$.ajax({ 
						url : "${pageContext.request.contextPath}/task/remove/"+taskId,
						type : "DELETE",
						beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
					    }, 
					    success: function(result){					    						    
							if(result.MESSAGE == "DELETED"){						
								$scope.listDataTaskByRalateType();
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
		}else{
			alertMsgNoPermision();
		}
		
	}
	
	
	
	// end Task path
	
	
	
	
	
	// event path
	
	
	$scope.event_click = function(){
		$("#btn_show_event").click();
	}

	$scope.listAllEventByLeadId = function(data){
		$scope.listAllEventByLead = data;	
	}
	$scope.listDataEventByRalateType = function(){
		$http.get("${pageContext.request.contextPath}/event/list-by-opportunity/"+oppId).success(function(response){
			$scope.listAllEventByLeadId(response.EVENTS);	
		});	
	}
	$scope.actEditEvent = function(eventId){				
		$http.get("${pageContext.request.contextPath}/event/list/"+eventId).success(function(response){			
			addDataEventToForm(response.DATA);
			eventIdForEdit = eventId;
			$("#btnEventSave").text("Update");
			$("#tEvent").text("Update Event");
			$("#btn_show_event").click();
		});		
	}
	
$scope.actDeleteEvent = function(eventId){				
		
		if(getPermissionByModule("AC_EV","delete") == "YES"){
			swal({   
				title: "<span style='font-size: 25px;'>You are about to delete event with ID: <span class='color_msg'>"+eventId+"</span>.</span>",
				text: "Click OK to continue or CANCEL to abort.",
				type: "info",
				html: true,
				showCancelButton: true,
				closeOnConfirm: false,
				showLoaderOnConfirm: true,		
			}, function(){ 
				setTimeout(function(){
					$.ajax({ 
						url : "${pageContext.request.contextPath}/event/remove/"+eventId,
						type : "DELETE",
						beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
					    }, 
					    success: function(result){					    						    
							if(result.MESSAGE == "DELETED"){						
								$scope.listDataEventByRalateType();
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
		}else{
			alertMsgNoPermision();
		}
		
		
	}
	
	
	
	// end event path
	
	
	
	
	$scope.email_click = function(){
		$("#btn_show_email").click();
	}
	
	// contact
	
	$scope.contact_click = function(){
		$("#btn_show_contact").click();
	}
	
	
	$scope.cancelContactClick = function(){		
		$("#ConContact").select2("val","");
		$('#frmAddContact').data('bootstrapValidator').resetField($('#ConContact'));
	}
	
	$scope.saveContactClick = function(){
		$("#frmAddContact").data('bootstrapValidator').validate();		
		var boolContact = $("#frmAddContact").data('bootstrapValidator').validate().isValid();
		if(boolContact == true){
			$http({
			    method: 'POST',
			    url: "${pageContext.request.contextPath}/opportunity/contact/add",
			    headers: {
			    	'Accept': 'application/json',
			        'Content-Type': 'application/json'
			    },
			    data: {"opId":oppId, "conId":getValueStringById("ConContact"), "opConType": getValueStringById("ConType")}
			}).success(function(response) {
				if(response.MESSAGE == "INSERTED"){
					swal({
	            		title:"Successful",
	            		text:"You have been added a new contact!",
	            		type:"success",  
	            		timer: 2000,   
	            		showConfirmButton: false
	    			});	
					
					$scope.contact.push(response.DATA); 
					
					setTimeout(function(){			
						$scope.cancelContactClick();
						$('#frmContact').modal('toggle');
					}, 2000);
					
										
				}else if(response.MESSAGE == "EXIST"){
					swal({
	            		title:"Warning!",
	            		text:"This contact is already exist!",
	            		type:"error",  
	            		timer: 2000,   
	            		showConfirmButton: false
	    			});
				}else{
					alertMsgErrorSweet();
				}				
			}).error(function(){
				alertMsgErrorSweet();
			});
		}
	}
	
	$scope.deleteContactClick = function(conID, key){
		$http({
		    method: 'DELETE',
		    url: "${pageContext.request.contextPath}/opportunity/contact/delete/"+conID,
		    headers: {
		    	'Accept': 'application/json',
		        'Content-Type': 'application/json'
		    }
		}).success(function(response){			
			if(response.MESSAGE == "DELETED"){
				swal({
	            		title:"Deleted",
	            		text:"Contact have been deleted!",
	            		type:"success",  
	            		timer: 2000,   
	            		showConfirmButton: false
     			});
				$scope.contact.splice(key,1);					
			}else{
				alertMsgErrorSweet();
			}			
		}).error(function(){
			alertMsgErrorSweet();
		});
	}
	
	
	// end contact
	
	
	// start quote
	
	$scope.quote_click = function(){
		$("#btn_show_quote").click();
	}
	
	$scope.cancelQuoteClick = function(){		
		$("#QuoteQuote").select2("val","");
		$('#frmAddQuote').data('bootstrapValidator').resetField($('#QuoteQuote'));
	}
	
	$scope.saveQuoteClick = function(){
		$("#frmAddQuote").data('bootstrapValidator').validate();		
		var boolContact = $("#frmAddQuote").data('bootstrapValidator').validate().isValid();
		if(boolContact == true){
			$http({
			    method: 'POST',
			    url: "${pageContext.request.contextPath}/opportunity/quote/add",
			    headers: {
			    	'Accept': 'application/json',
			        'Content-Type': 'application/json'
			    },
			    data: {"opId":oppId, "quoteId":getValueStringById("QuoteQuote")}
			}).success(function(response) {
				if(response.MESSAGE == "INSERTED"){
					swal({
	            		title:"Successful",
	            		text:"You have been added a new quote!",
	            		type:"success",  
	            		timer: 2000,   
	            		showConfirmButton: false
	    			});	
					
					$scope.quote.push(response.DATA); 
					
					setTimeout(function(){			
						$scope.cancelQuoteClick();
						$('#frmQuote').modal('toggle');
					}, 2000);
					
										
				}else if(response.MESSAGE == "EXIST"){
					swal({
	            		title:"Warning!",
	            		text:"This quote is already exist!",
	            		type:"error",  
	            		timer: 2000,   
	            		showConfirmButton: false
	    			});
				}else{
					alertMsgErrorSweet();
				}				
			}).error(function(){
				alertMsgErrorSweet();
			});
		}
	}
	
	$scope.deleteQuoteClick = function(opQuoteId, key,quoteId){
		$http({
		    method: 'DELETE',
		    url: "${pageContext.request.contextPath}/opportunity/quote/delete/"+opQuoteId,
		    headers: {
		    	'Accept': 'application/json',
		        'Content-Type': 'application/json'
		    }
		}).success(function(response){			
			if(response.MESSAGE == "DELETED"){
				swal({
	            		title:"Deleted",
	            		text:"Quote have been deleted!",
	            		type:"success",  
	            		timer: 2000,   
	            		showConfirmButton: false
     			});
				$scope.quote.splice(key,1);	
			}else{
				alertMsgErrorSweet();
			}			
		}).error(function(){
			alertMsgErrorSweet();
		});
	}
	
	
	
	// end quote
	
	// sale order
	$scope.sale_order_click = function(){
		$("#btn_show_sale_order").click();
	}
	$scope.cancelSaleOrderClick = function(){		
		$("#SaleSaleOrder").select2("val","");
		$('#frmAddSaleOrder').data('bootstrapValidator').resetField($('#SaleSaleOrder'));
	}
	
	$scope.saveSaleOrderClick = function(){
		$("#frmAddSaleOrder").data('bootstrapValidator').validate();		
		var boolContact = $("#frmAddSaleOrder").data('bootstrapValidator').validate().isValid();
		if(boolContact == true){
			$http({
			    method: 'POST',
			    url: "${pageContext.request.contextPath}/opportunity/sale_order/add",
			    headers: {
			    	'Accept': 'application/json',
			        'Content-Type': 'application/json'
			    },
			    data: {"opId":oppId, "saleId":getValueStringById("SaleSaleOrder")}
			}).success(function(response) {
				if(response.MESSAGE == "INSERTED"){
					swal({
	            		title:"Successful",
	            		text:"You have been added a new sale order!",
	            		type:"success",  
	            		timer: 2000,   
	            		showConfirmButton: false
	    			});	
					
					$scope.saleOrder.push(response.DATA); 
					
					setTimeout(function(){			
						$scope.cancelSaleOrderClick();
						$('#frmSaleOrder').modal('toggle');
					}, 2000);
					
										
				}else if(response.MESSAGE == "EXIST"){
					swal({
	            		title:"Warning!",
	            		text:"This sale order is already exist!",
	            		type:"error",  
	            		timer: 2000,   
	            		showConfirmButton: false
	    			});
				}else{
					alertMsgErrorSweet();
				}				
			}).error(function(){
				alertMsgErrorSweet();
			});
		}
	}
	
	$scope.deleteSaleOrderClick = function(opSaleId, key){
		$http({
		    method: 'DELETE',
		    url: "${pageContext.request.contextPath}/opportunity/sale_order/delete/"+opSaleId,
		    headers: {
		    	'Accept': 'application/json',
		        'Content-Type': 'application/json'
		    }
		}).success(function(response){			
			if(response.MESSAGE == "DELETED"){
				swal({
	            		title:"Deleted",
	            		text:"Sale order have been deleted!",
	            		type:"success",  
	            		timer: 2000,   
	            		showConfirmButton: false
     			});
				$scope.saleOrder.splice(key,1);	
			}else{
				alertMsgErrorSweet();
			}			
		}).error(function(){
			alertMsgErrorSweet();
		});
	}
	
	// end sale order	
	
}]);


app.controller('callController',['$scope','$http',function( $scope, $http){
	$scope.startupCallForm = function(){
		/* $http.get("${pageContext.request.contextPath}/call_status/list")
			.success(function(response){
				$scope.callStatusStartup = response.DATA;
	    }); */
	}
	$scope.cancelCallClick = function(){
		callIdForEdit = null;
		$("#callStatus").select2('val',"");
		$("#callAssignTo").select2('val',"");	
		$("#btnCallSave").text("Save");
		$("#tCall").text("Create Call");
		$('#frmAddCall').bootstrapValidator('resetForm', true);
	}	
}]);



app.controller('meetController',['$scope','$http',function( $scope, $http){
	$scope.startupMeetForm = function(){
		/* $http.get("${pageContext.request.contextPath}/meeting_status/list").success(function(response){
			$scope.meetStatusStartup = response.DATA;
	    }); */
	}
	$scope.cancelMeetClick = function(){
		 meetIdForEdit = null;
		$("#meetDuration").select2('val',"");
		$("#meetStatus").select2('val',"");
		$("#meetAssignTo").select2('val',"");	
		$("#btnMeetSave").text("Save");
		$("#tMeet").text("Create Meeting");
		$('#frmAddMeet').bootstrapValidator('resetForm', true);
	}	
}]);

app.controller('taskController',['$scope','$http',function( $scope, $http){
	
	$scope.startupTaskForm = function(){
	/* 	$http.get("${pageContext.request.contextPath}/task_status/list").success(function(response){
			$scope.taskStatusStartup = response.DATA;
		});

		$http.get("${pageContext.request.contextPath}/contact/list").success(function(response){
			$scope.taskContactStartup = response.DATA;
		}); */
		
	}
	
	$scope.cancelTaskClick = function(){
		taskIdForEdit = null;
		$("#taskPriority").select2('val',"");
		$("#taskContact").select2('val',"");
		$("#taskStatus").select2('val',"");
		$("#taskAssignTo").select2('val',"");	
		$("#btnTaskSave").text("Save");
		$("#tTask").text("Create Task");
		$('#frmAddTask').bootstrapValidator('resetForm', true);
	}	
}]);

app.controller('eventController',['$scope','$http',function( $scope, $http){
	
	$scope.startupEventForm = function(){
		/* $http.get("${pageContext.request.contextPath}/event_location/list").success(function(response){
			$scope.eventLocationStartup = response.DATA;
		}); */
	}
	
	$scope.cancelEventClick = function(){
		eventIdForEdit = null;
		$("#eventDuration").select2('val',"");
		$("#eventLocation").select2('val',"");
		$("#eventAssignTo").select2('val',"");	
		$("#btnEventSave").text("Save");
		$("#tEvent").text("Create Event");
		$('#frmAddEvent').bootstrapValidator('resetForm', true);
	}	
}]);


app.controller('contactController',['$scope','$http',function( $scope, $http){
	
	$scope.startupEventForm = function(){
		/* $http.get("${pageContext.request.contextPath}/event_location/list").success(function(response){
			$scope.eventLocationStartup = response.DATA;
		}); */
	}
	
	$scope.cancelEventClick = function(){
		eventIdForEdit = null;
		$("#eventDuration").select2('val',"");
		$("#eventLocation").select2('val',"");
		$("#eventAssignTo").select2('val',"");	
		$("#btnEventSave").text("Save");
		$('#frmAddEvent').bootstrapValidator('resetForm', true);
	}	
}]);



function addContactToTask(data){
	if(data.length>0){
		for(var i=0; i< data.length; i++){
			$("#taskContact").append("<option value='"+data[i].conID+"'>"+data[i].conSalutation+" "+data[i].conFirstname+" "+data[i].conLastname+"</option>");
		}
	}
}

function addDataCallToForm(data){
	$("#callStatus").select2('val',data.callStatusId);
	$("#callAssignTo").select2('val',data.userID);	
	
	setValueById('callStartDate', data.callStartDate);
	setValueById('callSubject', data.callSubject);
	setValueById('callDescription', data.callDes);
	setValueById('callDuration', data.callDuration);
}

function addDataMeetToForm(data){
	
	$("#meetStatus").select2('val',data.statusId);
	$("#meetAssignTo").select2('val',data.userID);	
	$("#meetDuration").select2('val',data.meetingDuration);
	
	setValueById('meetEndDate', data.meetingEndDate);
	setValueById('meetStartDate', data.meetingStartDate);
	setValueById('meetSubject', data.meetingSubject);
	setValueById('meetDescription', data.meetingDes);
	setValueById('meetLocation', data.meetingLocation);
}

function addDataTaskToForm(data){
	
	$("#taskStatus").select2('val',data.taskStatusId);
	$("#taskAssignTo").select2('val',data.userID);	
	$("#taskPriority").select2('val',data.taskPriority);
	$("#taskContact").select2('val',data.conID);
	
	setValueById('taskEndDate', data.taskDueDate);
	setValueById('taskStartDate', data.taskStartDate);
	setValueById('taskSubject', data.taskSubject);
	setValueById('taskDescription', data.taskDes);
}

function addDataEventToForm(data){
	
	$("#eventDuration").select2('val',data.evDuration);
	$("#eventAssignTo").select2('val',data.userID);	
	$("#eventLocation").select2('val',data.locateId);
	
	setValueById('eventEndDate', data.evEndDate);
	setValueById('eventStartDate', data.evStartDate);
	setValueById('eventSubject', data.evName);
	setValueById('eventDescription', data.evDes);
	setValueById('eventBudget', data.evBudget);
}


function getLeadData(){	
	var data = JSON.parse(
		$.ajax({
			method: 'POST',
		    url: '${pageContext.request.contextPath}/opportunity/view',
		    async: false,
		    headers: {
		    	'Accept': 'application/json',
		        'Content-Type': 'application/json'
		    },
		    data: JSON.stringify({
		    	"username":username,
		    	"opId":oppId
		    })
		}).responseText);	
	return data;	
}

function getLeadById(){
	var data = JSON.parse(
		$.ajax({
			method: 'GET',
		    url: '${pageContext.request.contextPath}/opportunity/list/'+oppId,
		    async: false
		}).responseText);	
	return data;
}

function clickStatus(num){
	/* if(num == 4){
		window.location.href = server+"/convert-lead/"+leadId;
	} */
}

function displayStatusLead(Status){	
	var obj = "";	
	for(var i=1; i<=leadStatusData.length+1; i++){		
		if(i<Status && i<6){
			obj += "<li onClick='clickStatus("+i+")' class='completed'><a href='#'><i class='fa fa-check-circle'></i> "+leadStatusData[i-1]+"</a></li>";	
		}else if(i==Status && i<6){
			obj += "<li onClick='clickStatus("+i+")' class='completed'><a href='#'><i class='fa fa-check-circle'></i> "+leadStatusData[i-1]+"</a></li>";
		}else if(i==6 || i==7){
			if(Status == 6 && i==6){
				obj += "<li onClick='clickStatus("+i+")' class='active'><a href='#'><i class='fa fa-check-circle'></i> "+leadStatusData[i-1]+" Won</a></li>";i++;i++;
			}else if(Status == 7 && i==7 ){	
				obj += "<li onClick='clickStatus("+i+")' class='dead'><a href='#'><i class='fa fa-check-circle'></i> "+leadStatusData[i-2]+" Lose</a></li>";
			}else if(Status != 6 && Status != 7){
				obj += "<li onClick='clickStatus("+i+")' class=''><a href='#'><i class='fa fa-lock'></i> "+leadStatusData[i-1]+"</a></li>";i++;i++;
			}
		}else{
			obj += "<li onClick='clickStatus("+i+")' class=''><a href='#'><i class='fa fa-lock'></i> "+leadStatusData[i-1]+"</a></li>";
		}
	}
	$("#objStatus").append(obj);
}

function addDataToDetailLead(){
	
	
	$("#oppStage").select2('val', OPPORTUNITY.osId);
	$("#oppType").select2('val', OPPORTUNITY.otId);
	$("#oppLeadSource").select2('val', OPPORTUNITY.sourceID);
	$("#oppCustomer").select2('val', OPPORTUNITY.custID);
	$("#oppCampaign").select2('val', OPPORTUNITY.campID);
	$("#oppAssignTo").select2('val', OPPORTUNITY.userID);
	
	$("#oppPriceCode").select2('val',OPPORTUNITY.priceCode);
	$("#oppClass").select2('val',OPPORTUNITY.classId);
	
	
	setValueById('oppName', OPPORTUNITY.opName);
	setValueById('oppAmout', OPPORTUNITY.opAmount);
	setValueById('oppCloseDate', conDateSqlToNormal(OPPORTUNITY.opCloseDate,'/'));
	setValueById('oppNextStep', OPPORTUNITY.opNextStep);
	setValueById('appProbability', OPPORTUNITY.opProbability);
	setValueById('appDescription', OPPORTUNITY.opDes);
	
	$('#frmOpportDetail').data('bootstrapValidator').resetField($('#oppPriceCode'));
	$('#frmOpportDetail').data('bootstrapValidator').resetField($('#oppCustomer'));
	$('#frmOpportDetail').data('bootstrapValidator').resetField($('#oppStage'));
	
}

function oppItemChange(){
	itemChangeStatus1 = true;
	angular.element(document.getElementById('viewOpportunityController')).scope().oppItemChange1(iSplitBySplintById("oppItem"));
}
function getValFromSelect(ID,key1,key2){ 
	var obj = $("#"+ID).val();
	if(obj !== null && obj != ""){
		obj = obj.split("]");
		return JSON.parse('{"'+key1+'" : "'+obj[0].replace('[','')+'", "'+key2+'" : "'+$.trim(obj[1])+'"}');
	}else{
		return null;
	}
	
}
function iSplitBySplintById(ID){
	var obj = $("#"+ID).val();
	if(obj != ""){ 
		obj = obj.split("]");
		return obj[0].replace('[','');
	}else{
		return "";
	}
}
function iSplitBySplint(obj){
	if(obj != ""){
		obj = obj.split("]");
		return obj[0].replace('[','');
	}else{
		return "";
	}
}

</script>
<style>
.show-text-disInv{
	font-weight: bold;
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
.iTable tfoot{
	border-top: 2px solid #d2d6de !important;
}



.iTable thead, tr, td{
	border:0px !important;
}

.iText-right{
	text-align:right !important;
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
</style>
<div class="content-wrapper" id="viewOpportunityController" ng-app="viewOpportunity"
	ng-controller="viewOpportunityController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>View Opportunity</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"><i class="fa fa-dashboard"></i>View Opportunity</a></li>
		</ol>
	</section>

	<section class="content" data-ng-init="listLeads()">
		<div class="row">

			<div class="col-md-12">
				<!-- Widget: user widget style 1 -->
				<div class="box box-widget widget-user">
					<!-- Add the bg color to the header using any of the bg-* classes -->
					<div class="widget-user-header bg-aqua-active">
						<h3 class="widget-user-username ng-cloak">[{{opportunity.opId}}] {{opportunity.opName}}</h3>
						<h6 class="widget-user-desc">NAME</h6>
					</div>
					<div class="widget-user-image">
						<img class="img-circle"
							src="${pageContext.request.contextPath}/resources/images/module/Opportunity.png"
							alt="User Avatar">
					</div>
					<div class="box-footer">
						<div class="row">
							<div class="col-sm-3">
								<div class="description-block">
									<h5 class="description-header ng-cloak">[{{opportunity.custID}}] {{opportunity.custName}}</h5>
									<span class="description-text">Company</span>
								</div>
							</div>
							<div class="col-sm-3 border-right">
								<div class="description-block">
									<h5 class="description-header ng-cloak">{{opportunity.opCloseDate | date:'dd/MM/yyyy' }}</h5>
									<span class="description-text">Close Date</span>
								</div>
							</div>
							<div class="col-sm-3 border-right">
								<div class="description-block">
									<h5 class="description-header ng-cloak">{{opportunity.opAmount | number:2}}</h5>
									<span class="description-text">Amount</span>
								</div>
							</div>
							<div class="col-sm-3 border-right">
								<div class="description-block">
									<h5 class="description-header ng-cloak">{{opportunity.username}}</h5>
									<span class="description-text">Assign To</span>
								</div>
							</div>
							

							<div class="col-sm-12">
								<ul class="breadcrumb1" id="objStatus">
								</ul>
							</div>

							<div class="clearfix"></div>
							<br />
							<div class="col-md-12">
								<div id="note" class="nav-tabs-custom">
									<ul class="nav nav-tabs">
										<li class="active"><a href="#activity" data-toggle="tab"
											aria-expanded="true">ACTIVITY</a></li>
										<li class=""><a href="#collaborate" data-toggle="tab"
											aria-expanded="false">COLLABORATE</a></li>
										<li class=""><a href="#note_tap" data-toggle="tab"
											aria-expanded="false">NOTES</a></li>
										<li class=""><a href="#detail_tap" data-toggle="tab"
											aria-expanded="false">DETAILS</a></li>
										<li class=""><a href="#product_tap" data-toggle="tab"
										aria-expanded="false">PRODUCTS</a></li>
										<li class=""><a href="#related_tap" data-toggle="tab"
											aria-expanded="false">RELATED</a></li>
									</ul>
									<div class="tab-content">
									
										<div class="tab-pane active" id="activity">
											<div class="row">

												<div class="col-md-12" >
													<a style="margin-left: 0px;" class="btn btn-app" ng-click="call_click()"> 
														<i class="fa fa-phone"></i> Call
													</a> 
													<a class="btn btn-app" ng-click="meet_click()"> 
														<i class="fa fa-users"></i> Meeting
													</a> 
													<a class="btn btn-app" ng-click="task_click()"> 
														<i class="fa fa-list-alt "></i> Task
													</a> 
													<a class="btn btn-app" ng-click="event_click()"> 
														<i class="fa  fa-calendar-check-o"></i> Event
													</a> 
													<a class="btn btn-app" ng-click="email_click()"> 
														<i class="fa fa-envelope"></i> Email
													</a>
												</div>
												<div class="col-md-12">
													<div class="panel-group" id="accordion">
														<div class="panel panel-default">
															<div class="panel-heading">
																<h4 class="panel-title">
																	<a data-toggle="collapse" data-parent="#accordion" href="#collapse1">Calls</a>
																	<span class="badge bg-blue pull-right ng-cloak">{{listAllCallByLead.length <= 0 ? '' : listAllCallByLead.length }}</span>
																</h4>
															</div>
															<div id="collapse1" class="panel-collapse collapse">
																<div class="panel-body">
																	<div class="mailbox-messages">
																			<table class="table iTable"> 					
																				<thead>
																					<tr>
																						<th>#</th>
																						<th colspan="2">Subject</th>
																						<th>Start Date</th>
																						<th>Duration</th>
																						<th>Assign To</th>
																						<th>Create By</th>
																					</tr>
																				</thead>
																				<tbody ng-repeat="call in listAllCallByLead">
																					<tr>
																						<td class="iTD-width-50">
																							{{call.callId}}
																						</td>
																						<td colspan="2">{{call.callSubject}}</td>
																						<td> 
																							{{call.callStartDate | date:'dd/MM/yyyy'}}
																						</td>
																						<td>{{call.callDuration}}</td>
																						<td>{{call.username}}</td>
																						<td>{{call.callCreateBy}}</td>
																					</tr>
																					<tr>
																						<td colspan="6">
																							<a href="#">{{call.callDes | limitTo:200}}{{call.callDes.length <= 200 ? '' : '...'}}</a>
																						</td>
																						<td class="mailbox-date">
																							<div class="col-sm-2">
																								<div class="btn-group">
																									<button type="button"
																										class="btn btn-default dropdown-toggle btn-sm"
																										data-toggle="dropdown" aria-expanded="false">
																										<span class="caret"></span> <span class="sr-only">Toggle
																											Dropdown</span>
																									</button>
																									<ul class="dropdown-menu" role="menu">
																										<li><a href="#" ng-click="actEditCall(call.callId)"><i class="fa fa-pencil"></i> Edit</a></li>
																										<li ng-click="actDeleteCall(call.callId)"><a href="#"><i class="fa fa-trash"></i> Delete</a></li>
																										<li><a href="${pageContext.request.contextPath}/view-call/{{call.callId}}"><i class="fa fa-eye"></i> View</a></li>
					
																									</ul>
																								</div>
																							</div>
																						</td>
																					</tr>
																			</table>
																		</div>
																</div>
															</div>
														</div>
														<div class="panel panel-default">
															<div class="panel-heading">
																<h4 class="panel-title">
																	<a data-toggle="collapse" data-parent="#accordion" href="#collapse2"> Meetings</a>
																	<span class="badge bg-blue pull-right ng-cloak">{{listAllMeetByLead.length <= 0 ? '' : listAllMeetByLead.length }}</span>
																</h4>
															</div>
															<div id="collapse2" class="panel-collapse collapse">
																<div class="panel-body">
																	<div class="mailbox-messages">
																		<table class="table iTable"> 
																			<thead>
																				<tr>
																					<th>#</th>
																					<th colspan="2">Subject</th>
																					<th>Status</th>
																					<th>Start Date</th>
																					<th>End Date</th>
																					<th>Assign To</th>
																					<th>Create By</th>
																				</tr>
																			</thead>
																			<tbody ng-repeat="meet in listAllMeetByLead">
																				<tr>
																					<td class="iTD-width-50">
																						{{meet.meetingId}}
																					</td>
																					<td colspan="2">{{meet.meetingSubject}}</td>
																					<td>{{meet.statusName}}</td>
																					<td>{{meet.meetingStartDate | date:'dd/MM/yyyy'}}</td>
																					<td>{{meet.meetingEndDate | date:'dd/MM/yyyy'}}</td>
																					<td>{{meet.username}}</td>
																					<td>{{meet.meetingCreateBy}}</td>
																				</tr>
																				<tr>
																					<td colspan="7">
																						<a href="#">{{meet.meetingDes | limitTo:200}}{{meet.meetingDes.length <= 200 ? '' : '...'}}</a>
																					</td>
																					<td class="mailbox-date">
																						<div class="col-sm-2">
																							<div class="btn-group">
																								<button type="button"
																									class="btn btn-default dropdown-toggle btn-sm"
																									data-toggle="dropdown" aria-expanded="false">
																									<span class="caret"></span> <span class="sr-only">Toggle
																										Dropdown</span>
																								</button>
																								<ul class="dropdown-menu" role="menu">
																									<li ng-click="actEditMeeting(meet.meetingId)">
																										<a href="#"><i class="fa fa-pencil"></i> Edit</a>
																									</li>
																									<li ng-click="actDeleteMeeting(meet.meetingId)">
																										<a href="#"><i class="fa fa-trash"></i> Delete</a></li>
																									<li><a href="${pageContext.request.contextPath}/view-meeting/{{meet.meetingId}}"><i class="fa fa-eye"></i> View</a></li>
				
																								</ul>
																							</div>
																						</div>
																					</td>
																				</tr>
																			</tbody>
																		</table>
																	</div>																
																</div>
															</div>
														</div>
														<div class="panel panel-default">
															<div class="panel-heading">
																<h4 class="panel-title">
																	<a data-toggle="collapse" data-parent="#accordion" href="#collapse3"> Tasks</a>
																	<span class="badge bg-blue pull-right ng-cloak">{{listAllTaskByLead.length <= 0 ? '' : listAllTaskByLead.length }}</span>
																</h4>
															</div>
															<div id="collapse3" class="panel-collapse collapse">
																<div class="panel-body">
																	<div class="mailbox-messages">
																		<table class="table iTable"> 
																			<thead>
																				<tr>
																					<th>#</th>
																					<th colspan="2">Subject</th>
																					<th>Status</th>
																					<th>Start Date</th>
																					<th>End Date</th>
																					<th>Assign To</th>
																					<th>Create By</th>
																				</tr>
																			</thead>
																			<tbody ng-repeat="task in listAllTaskByLead">
																				<tr>
																					<td class="iTD-width-50">
																						{{task.taskId}}
																					</td>
																					<td colspan="2">{{task.taskSubject}}</td>
																					<td>{{task.taskStatusName}}</td>
																					<td>{{task.taskStartDate | date:'dd/MM/yyyy'}}</td>
																					<td>{{task.taskDueDate | date:'dd/MM/yyyy'}}</td>
																					<td>{{task.username}}</td>
																					<td>{{task.taskCreateBy}}</td>
																				</tr>
																				<tr>
																					<td colspan="7">
																						<a href="#">{{task.taskDes | limitTo:200}}{{task.taskDes.length <= 200 ? '' : '...'}}</a>
																					</td>
																					<td class="mailbox-date">
																						<div class="col-sm-2">
																							<div class="btn-group">
																								<button type="button"
																									class="btn btn-default dropdown-toggle btn-sm"
																									data-toggle="dropdown" aria-expanded="false">
																									<span class="caret"></span> <span class="sr-only">Toggle
																										Dropdown</span>
																								</button>
																								<ul class="dropdown-menu" role="menu">
																									<li ng-click="actEditTask(task.taskId)">
																										<a href="#"><i class="fa fa-pencil"></i> Edit</a>
																									</li>
																									<li ng-click="actDeleteTask(task.taskId)">
																										<a href="#"><i class="fa fa-trash"></i> Delete</a></li>
																									<li><a href="${pageContext.request.contextPath}/view-task/{{task.taskId}}"><i class="fa fa-eye"></i> View</a></li>
				
																								</ul>
																							</div>
																						</div>
																					</td>
																				</tr>
																			</tbody>
																		</table>
																	</div>
																</div>
															</div>
														</div>
														<div class="panel panel-default">
															<div class="panel-heading">
																<h4 class="panel-title">
																	<a data-toggle="collapse" data-parent="#accordion" href="#collapse4"> Events</a>
																	<span class="badge bg-blue pull-right ng-cloak">{{listAllEventByLead.length <= 0 ? '' : listAllEventByLead.length }}</span>
																</h4>
															</div>
															<div id="collapse4" class="panel-collapse collapse">
																<div class="panel-body">
																	<div class="mailbox-messages">
																		<table class="table iTable"> 
																			<thead>
																				<tr>
																					<th>#</th>
																					<th colspan="2">Name</th>
																					<th>Location</th>
																					<th>Start Date</th>
																					<th>End Date</th>
																					<th>Assign To</th>
																					<th>Create By</th>
																				</tr>
																			</thead>
																			<tbody ng-repeat="event in listAllEventByLead">
																				<tr>
																					<td class="iTD-width-50">
																						{{event.evId}}
																					</td>
																					<td colspan="2">{{event.evName}}</td>
																					<td>{{event.locateName}}</td>
																					<td>{{event.evStartDate | date:'dd/MM/yyyy'}}</td>
																					<td>{{event.evEndDate | date:'dd/MM/yyyy'}}</td>
																					<td>{{event.username}}</td>
																					<td>{{event.evCreateBy}}</td>
																				</tr>
																				<tr>
																					<td colspan="7">
																						<a href="#">{{event.evDes | limitTo:200}}{{event.evDes.length <= 200 ? '' : '...'}}</a>
																					</td>
																					<td class="mailbox-date">
																						<div class="col-sm-2">
																							<div class="btn-group">
																								<button type="button"
																									class="btn btn-default dropdown-toggle btn-sm"
																									data-toggle="dropdown" aria-expanded="false">
																									<span class="caret"></span> <span class="sr-only">Toggle
																										Dropdown</span>
																								</button>
																								<ul class="dropdown-menu" role="menu">
																									<li ng-click="actEditEvent(event.evId)">
																										<a href="#"><i class="fa fa-pencil"></i> Edit</a>
																									</li>
																									<li ng-click="actDeleteEvent(event.evId)">
																										<a href="#"><i class="fa fa-trash"></i> Delete</a></li>
																									<li><a href="${pageContext.request.contextPath}/view-event/{{event.evId}}"><i class="fa fa-eye"></i> View</a></li>
				
																								</ul>
																							</div>
																						</div>
																					</td>
																				</tr>
																			</tbody>
																		</table>
																	</div>
																</div>
															</div>
														</div>
														<div class="panel panel-default">
															<div class="panel-heading">
																<h4 class="panel-title">
																	<a data-toggle="collapse" data-parent="#accordion" href="#collapse5"> Emails</a>
																	<span class="badge bg-blue pull-right ng-cloak">{{listAllEmailByLead.length <= 0 ? '' : listAllEmailByLead.length }}</span>
																</h4>
															</div>
															<div id="collapse5" class="panel-collapse collapse">
																<div class="panel-body">
																	<div class="mailbox-messages">
																		<table class="table iTable" data-ng-init="listAllEmailByLeadId()"> 
																			<thead>
																				<tr>
																					<th>#</th>
																					<th colspan="2">Subject</th>
																					<th>Sent To</th>
																					<th>Date</th>
																					<th>Status</th>
																					<th>Assign To</th>
																					<th>Create By</th>
																				</tr>
																			</thead>
																			<tbody ng-repeat="email in listAllEmailByLead">
																				<tr>
																					<td class="iTD-width-50">
																						{{event.evId}}
																					</td>
																					<td colspan="2">{{event.evName}}</td>
																					<td>{{event.locateName}}</td>
																					<td>{{event.evStartDate | date:'dd/MM/yyyy'}}</td>
																					<td>{{event.evEndDate | date:'dd/MM/yyyy'}}</td>
																					<td>{{event.username}}</td>
																					<td>{{event.evCreateBy}}</td>
																				</tr>
																				<tr>
																					<td colspan="7">
																						<a href="#">{{event.evDes | limitTo:200}}{{event.evDes.length <= 200 ? '' : '...'}}</a>
																					</td>
																					<td class="mailbox-date">
																						<div class="col-sm-2">
																							<div class="btn-group">
																								<button type="button"
																									class="btn btn-default dropdown-toggle btn-sm"
																									data-toggle="dropdown" aria-expanded="false">
																									<span class="caret"></span> <span class="sr-only">Toggle
																										Dropdown</span>
																								</button>
																								<ul class="dropdown-menu" role="menu">
																									<li ng-click="actEditEvent(event.evId)">
																										<a href="#"><i class="fa fa-pencil"></i> Edit</a>
																									</li>
																									<li ng-click="actDeleteEvent(event.evId)">
																										<a href="#"><i class="fa fa-trash"></i> Delete</a></li>
																									<li><a href="${pageContext.request.contextPath}/view-event/{{event.evId}}"><i class="fa fa-eye"></i> View</a></li>
				
																								</ul>
																							</div>
																						</div>
																					</td>
																				</tr>
																			</tbody>
																		</table>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>

										<div class="tab-pane" id="collaborate">

											<div class="col-md-12" style="padding-right: 0px; padding-left: 0px;">
												<form id="frmCollab">													
													<div class="col-sm-12"  style="padding-right: 0px; padding-left: 0px;">
														<div class="form-group">
															<label>Post <span class="requrie">(Required)</span></label> 
															<textarea rows="3" cols="" name="collabPostDescription" id="collabPostDescription" class="form-control" placeholder=""></textarea>
														</div>
													</div>
													<div class="col-sm-12"  style="padding-right: 0px; padding-left: 0px;">
														<div class="form-group">
															<label>Tags </label> 
															<select  class="form-control" multiple name="collabTags" id="collabTags" style="width: 100%;">
																<option ng-repeat="tag in tags" value="{{tag.username}}">{{tag.username}}</option>																
															</select>
														</div>
													</div>
												</form>
												<div class="col-sm-12"  style="padding-right: 0px; padding-left: 0px;">
													<button style="margin-top: 10px; margin-left: 10px;" ng-click="resetFrmCollab()" type="button" class="btn btn-danger pull-right">Reset</button>
													<button type="button" style="margin-top: 10px;" ng-click="addCollab()" name="collabBtnPost" id="collabBtnPost" class="btn btn-primary pull-right">POST</button>
												</div>
											</div>
											<div class="clearfix"></div>
											<br>
											<!-- content collab -->
											
											<div class="post clearfix" ng-repeat="(key_post,collab) in collaborates track by $index">
												<div class="user-block">
													<img class="img-circle img-bordered-sm" src="${pageContext.request.contextPath}/resources/images/av.png" alt="user image"> 
													<span class="username"> 
														<a href="#">{{collab.colUser}}</a> <a style="color: #999;font-size: 13px;">on {{collab.createDate}}</a>
														<span ng-if="collab.colOwn == 'true'" ng-click="btnDeleteCollabPost(key_post,collab.colId)" class="pull-right btn-box-tool cusor_pointer"><button class="btn btn-default btn-sm"><i class="fa fa-trash trask-btn"></i></button></span>
													</span> 													
													<span class="description"><i ng-if="collab.tags.length > 0 " class="fa fa-tags"></i> <span ng-repeat="t in collab.tags">{{t.username}} </span></span>
												</div>
												<p>{{collab.colDes}}</p>																													
												
												<ul class="list-inline">
													<li>
														<span href="#" class="link-black text-sm ">																													
															<span ng-if="collab.checkLike == true"><button ng-click="postLike(key_post,collab.colId)" class="btn btn-default btn-sm"><i  class="fa fa-thumbs-up like-btn"></i></button>&nbsp;&nbsp;&nbsp;You  {{collab.like <= 0 ? "" : collab.like==1 ? "and 1 other" : "and "+collab.like+" others"}}</span>
															<span ng-if="collab.checkLike == false"><button ng-click="postLike(key_post,collab.colId)" class="btn btn-default btn-sm"><i  class="fa fa-thumbs-o-up unlike-btn"></i></button>&nbsp;&nbsp;&nbsp;{{collab.like <= 0 ? "" : collab.like}}</span> 														
														</span>
													</li>
													<li class="pull-right">
														<a href="#" class="link-black text-sm"><i class="fa fa-comments-o margin-r-5"></i> <span> Comments{{collab.details.length <= 0 ? "" : "("+collab.details.length+")"}}</span></a>
													</li>
												</ul>
												
												
												<div style="padding-top: 15px;" class="box-footer box-comments">													
													<div class="box-comment" ng-repeat="(key_comment, com) in collab.details">
														<img class="img-circle img-sm" src="${pageContext.request.contextPath}/resources/images/av.png" alt="user image">
														<div class="comment-text">
															<span class="username"> 
																<span> {{com.username}} <span class="text-muted"> on {{com.formatCreateDate}}</span></span> 
																<span ng-if="com.username == username" ng-click="btnDeleteCollabCom(key_post, key_comment,com.commentId)"  class="pull-right btn-box-tool cusor_pointer"><button class="btn btn-default btn-sm"><i class="fa fa-trash trask-btn"></i></button></span>
															</span>
															{{com.comment}}
														</div>
													</div>
												</div>
												
																							
												<form id="" ng-submit="postCommand(key_post, collab.colId)">
													<div class="form-group">
														<input ng-model="newcomment[key_post].comment" id="txtComment"  class="form-control input-sm" type="text" placeholder="Type a comment">
													</div>
												</form>
												
											</div>
											
											
											
											
											<!-- end content collab -->
										</div>

										<div class="tab-pane" id="note_tap">
											<div class="post clearfix">
												<form id="frmAddNote">
													<div class="form-group">
														<input ng-model="note_subject" data-ng-init="note_subject"
															style="margin-top: 10px;" type="text"
															class="form-control" name="note_subject"
															id="note_subject" placeholder="Subject">
													</div>
													<div class="form-group">
														<textarea ng-model="note_description"
															data-ng-init="note_description" style="margin-top: 10px;"
															rows="3" cols="" name="note_description"
															id="note_description" class="form-control"
															placeholder="Description"></textarea>
													</div>
													<button style="margin-top: 10px; margin-left: 10px;"
														ng-click="resetFrmNote()" type="button"
														ng-click="resetNote()" class="btn btn-danger pull-right">Reset</button>
													<button style="margin-top: 10px;" type="button"
														id="btnAddNote" ng-click="addNote()"
														class="btn btn-primary pull-right">Note</button>
												</form>
											</div>
											<div class="clearfix"></div>
											<ul class="timeline timeline-inverse"
												ng-repeat="notePerDate in noteToFilter() | filter:filterNote">

												<!-- START DATE -->
												<li class="time-label"><span class="bg-red">{{notePerDate.noteCreateDate}}</span>
												</li>
												<li
													ng-repeat="note in notes | filter:{noteCreateDate: notePerDate.noteCreateDate}">
													<i class="fa  fa-edit bg-blue"></i>
													<div class="timeline-item">
														<span class="time"><i class="fa fa-clock-o"></i>
															&nbsp;{{notePerDate.noteTime}}</span>
														<h3 class="timeline-header">
															{{note.noteSubject}} <a>by {{note.noteCreateBy}}</a>
														</h3>
														<div class="timeline-body">{{note.noteDes}}</div>
														<div class="timeline-footer">
															<a class="btn btn-primary btn-xs"
																ng-click="editNoteById(note.noteId)">Edit</a> <a
																class="btn btn-danger btn-xs"
																ng-click="deleteNoteById(note.noteId)">Delete</a>
														</div>
													</div>
												</li>


											</ul>
										</div>


										<div class="tab-pane " id="detail_tap">
											<div class="row">
												<form id="frmOpportDetail">
													<div class="col-md-4">
														<ul class="list-group list-group-unbordered">
															<li class="list-group-item"><b>Overview</b> <a
																class="pull-right cusor_pointer"
																ng-click="editDetailLead()"><i class="fa fa-pencil"></i>
																	Edit</a></li>

															<li class="list-group-item item_border">Opportunity Name <a
																class="pull-right show-text-detail">{{opportunity.opName}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<input type="text" name="oppName"
																		id="oppName" class="form-control"
																		value="{{opportunity.opName}}">
																	<div class="clearfix"></div>
																</div>
															</li>
															<li class="list-group-item item_border">Amount <a
																class="pull-right show-text-detail">{{opportunity.opAmount | number:2}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<input type="text" name="oppAmount"
																		id="oppAmount" class="form-control"
																		value="{{opportunity.opAmount}}">
																</div>
															</li>
															<li class="list-group-item item_border">Close Date <a
																class="pull-right show-text-detail">{{opportunity.opCloseDate | date:'dd/MM/yyyy'}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<div class="input-group">
																		<div class="input-group-addon">
																			<i class="fa fa-calendar"></i>
																		</div>
																		<input type="text" value="{{opportunity.opCloseDate | date:'dd/MM/yyyy'}}" class="form-control pull-right" name="oppCloseDate" id="oppCloseDate">
																	</div> 
																</div>
															</li>
															<li class="list-group-item item_border">Next Step <a
																class="pull-right show-text-detail">{{opportunity.opNextStep}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<input type="text" name="oppNextStep"
																		id="oppNextStep" class="form-control"
																		value="{{opportunity.opNextStep}}">
																</div>
															</li>
															<li class="list-group-item item_border">Lead Source <a
																class="pull-right show-text-detail">{{opportunity.sourceName}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<select class="form-control select2" name="oppLeadSource"
																		id="oppLeadSource" style="width: 100%;">
																		<option value="">-- SELECT A Lead source --</option>
																		<option ng-repeat="source in oppLeadSource"
																			value="{{source.sourceID}}">{{source.sourceName}}</option>
																	</select>
																</div>
															</li>
															<li class="list-group-item item_border">Type <a
																class="pull-right show-text-detail">{{opportunity.otName}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<select class="form-control select2"
																		name="oppType" id="oppType"
																		style="width: 100%;">
																		<option value="">-- SELECT A Type --</option>
																		<option ng-repeat="type in oppType"
																			value="{{type.otId}}">{{type.otName}}</option>
																	</select>
																</div>
															</li>
															
															<li class="list-group-item item_border">Campaign <a
																class="pull-right show-text-detail">{{opportunity.campName}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<select class="form-control select2"
																		name="oppCampaign" id="oppCampaign" style="width: 100%;">
																		<option value="">-- SELECT A Campaign --</option>
																		<option ng-repeat="camp in oppCampaign"
																			value="{{camp.campID}}">{{camp.campName}}</option>
																	</select>
																</div>
															</li>
															
															
														</ul>
													</div>
													<div class="col-md-4">
														<ul class="list-group list-group-unbordered">
															<li class="list-group-item"><b>&nbsp;</b> <a
																class="pull-right cusor_pointer"
																ng-click="editDetailLead()"><i class="fa fa-pencil"></i>
																	Edit</a></li>
															<li class="list-group-item item_border">Stage <a
																class="pull-right show-text-detail">{{opportunity.osName}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<select class="form-control select2"
																		name="oppStage" id="oppStage" style="width: 100%;">
																		<option value="">-- SELECT A Stage --</option>
																		<option ng-repeat="stage in oppStage"
																			value="{{stage.osId}}">{{stage.osName}}</option>
																	</select>
																</div>
															</li>
															<li class="list-group-item item_border">Probability (%) <a
																class="pull-right show-text-detail">{{opportunity.opProbability}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<input type="text" name="oppProbability" id="oppProbability"
																		class="form-control" value="{{opportunity.opProbability}}">
																</div>
															</li>
															<li class="list-group-item item_border">Customer <a
																class="pull-right show-text-detail">[{{opportunity.custID}}] {{opportunity.custName}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<select class="form-control select2"
																		name="oppCustomer" id="oppCustomer" style="width: 100%;">
																		<option value="">-- SELECT A Customer --</option>
																		<option ng-repeat="cust in oppCustomer"
																			value="{{cust.custID}}">{{cust.custName}}</option>
																	</select>
																</div>
															</li>
															<li class="list-group-item item_border">Price Code <a
																class="pull-right show-text-detail">[{{opportunity.priceCode}}] {{opportunity.priceCodeName}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<select class="form-control select2"
																		name="oppPriceCode" id="oppPriceCode" style="width: 100%;">
																		<option value="">-- SELECT Price Code --</option>
																		<option ng-repeat="price in oppPriceCode"
																			value="{{price.priceCode}}">[{{price.priceCode}}] {{price.des}}</option>
																	</select>
																</div>
															</li>
															<li class="list-group-item item_border">Class <a
																class="pull-right show-text-detail" ng-if="opportunity.classId != null">[{{opportunity.classId}}] {{opportunity.className}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<select class="form-control select2"
																		name="oppClass" id="oppClass" style="width: 100%;">
																		<option value="">-- SELECT Class --</option>
																		<option ng-repeat="cl in oppClass"
																			value="{{cl.classId}}">[{{cl.classId}}] {{cl.des}}</option>
																	</select>
																</div>
															</li>
															
														</ul>
													</div>
													<div class="col-md-4">
														<ul class="list-group list-group-unbordered">
															<li class="list-group-item"><b>Others</b> 
																	<a class="pull-right cusor_pointer"
																ng-click="editDetailLead()"><i class="fa fa-pencil"></i>
																	Edit</a></li>
															
															<li class="list-group-item item_border">Assign To <a
																class="pull-right show-text-detail">{{opportunity.username}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<select class="form-control select2"
																		name="oppAssignTo" id="oppAssignTo"
																		style="width: 100%;">
																		<option value="">-- SELECT A Assign To --</option>
																		<option ng-repeat="user in oppAssignTo"
																			value="{{user.userID}}">{{user.username}}</option>
																	</select>
																</div>

															</li>
														</ul>
													</div>
													<div class="col-md-12">
														<ul class="list-group list-group-unbordered">
															<li style="border-top: 0px;" class="list-group-item"><b>Description</b>
																<a class="pull-right cusor_pointer"
																ng-click="editDetailLead()"><i class="fa fa-pencil"></i>
																	Edit</a></li>
														</ul>
													</div>
													<div class="col-md-12">
														<div class="show-text-detail">{{opportunity.opDes}}</div>
														<div class="form-group show-edit-non-style"
															style="display: none;">
															<textarea rows="3" cols="" name="oppDescription"
																id="oppDescription" class="form-control"
																placeholder="Description">{{opportunity.opDes}}</textarea>
														</div>
													</div>
													<br>
													<div class="col-md-12 text-center" id="showBtnEditLead"
														style="display: none;">
														<button class="btn btn-primary" type="button"
															ng-click="saveEditDetailLead()">Save</button>
														<button type="button" class="btn btn-danger"
															ng-click="cancelEditDetailLead()">Cancel</button>
													</div>
												</form>

											</div>

										</div>

										
										<div class="tab-pane " id="product_tap">
											<div class="row">
												<div class="col-md-12" >
													<a style="margin-left: 0px;" class="btn btn-app" ng-click="btnSaveClick()"> 
														<i class="fa fa-save"></i> Save
													</a> 
												</div>
												<div class="col-md-12">
													<div class="panel-group" id="proGroup">														
														<div class="panel panel-default">
															<div class="panel-heading" style="display: none;">
																<h4 class="panel-title pull-left">
																	<a data-toggle="collapse" data-parent="" href="#ProFrm">Products  </a>																	
																</h4>
																<span class="badge bg-blue pull-right">{{product.length <= 0 ? '' : product.length }}</span>
																<%-- <a href="${pageContext.request.contextPath}/create-contact" class="btn btn-default pull-right">New</a> --%>
																<div class="clearfix"></div>
															</div>
															<div id="ProFrm" class="panel-collapse collapse in">
																<div class="panel-body">
																	<div class="mailbox-messages table-responsive">
																			<table class="table iTable"> 					
																				<tbody>
																					<tr>
																						<th>Item</th>
																						<th>Location</th>
																						<th>Class</th>
																						<th>UOM</th>
																						<th>Quantity</th>
																						<th>Unit Price</th>
																						<th>Price Factor</th>
																						<th>Report Price</th>
																						<th>Total Amount</th>
																						<th>Discount %</th>
																						<th>Discount $</th>
																						<th>VAT %</th>
																						<th>VAT $</th>
																						<th>ST %</th>
																						<th>ST $</th>
																						<th>Net Total Amount</th>
																						<th></th>
																					</tr>
																				</tbody>
																				<tbody id="listItem" >
																					<tr class="cursor_move" data-row-index="{{key}}" ng-repeat="(key, oppDetail) in opportunityDetail">
																						<td>[{{oppDetail.item.itemId}}] {{oppDetail.item.itemName.trunc(15)}}</td>
																						<td>[{{oppDetail.location.locationId}}] {{oppDetail.location.locationName.trunc(10)}}</td>
																						<td><span ng-if="oppDetail.ameClass != null">[{{oppDetail.ameClass.classId}}] {{oppDetail.ameClass.className.trunc(10)}}</span></td>
																						<td>[{{oppDetail.uom.uomId}}] {{oppDetail.uom.des.trunc(10)}}</td>
																						<td class="iText-right">{{oppDetail.saleQty | number:4}}</td>
																						<td class="iText-right">{{oppDetail.unitPrice | number:6}}</td>
																						<td class="iText-right">{{oppDetail.factor | number:4}}</td>
																						<td class="iText-right">{{oppDetail.reportPrice | number:6}}</td>
																						<td class="iText-right">{{oppDetail.totalAmt | number:2}}</td>
																						<td class="iText-right">{{oppDetail.disPer | number:5}}</td>
																						<td class="iText-right">{{oppDetail.disDol | number:2}}</td>
																						<td class="iText-right">{{oppDetail.vTaxPer | number:5}}</td>
																						<td class="iText-right">{{oppDetail.vTaxDol | number:2}}</td>
																						<td class="iText-right">{{oppDetail.sTaxPer | number:5}}</td>
																						<td class="iText-right">{{oppDetail.sTaxDol | number:2}}</td>
																						<td class="iText-right">{{oppDetail.netTotalAmt | number:2}}</td>
																						<td>
																							<div class="col-sm-2">
																								<div class="btn-group">
																									<button type="button"
																										class="btn btn-default dropdown-toggle btn-sm"
																										data-toggle="dropdown" aria-expanded="false">
																										<span class="caret"></span> <span class="sr-only">Toggle
																											Dropdown</span>
																									</button>
																									<ul class="dropdown-menu" role="menu">
																										<li>
																											<a href="#" ng-click="editProductClick(key)" ><i class="fa fa-pencil"></i> Edit </a>
																										</li>
																										<li>
																											<a href="#" ng-click="deleteProductClick(key)" ><i class="fa fa-trash"></i> Delete </a>
																										</li>																										
																															
																									</ul>
																								</div>
																							</div>
																						</td>
																					</tr>
																				</tbody>
																				<tbody>
																					<tr>
																						<th colspan="17">
																							<button type="button" ng-click="product_click()" class="btn btn-primary">
																								Add An Item
																							</button>
																						</th>
																					</tr>																					
																				</tbody>
																				<tfoot>
																					<tr>
																						<th colspan="12"></th>
																						<th colspan="3" class="iText-right">Total VAT: </th>
																						<th class="iText-right">{{opportunity.totalVTax | number:2}}</th>
																						<th></th>
																					</tr>
																					<tr>
																						<th colspan="12"></th>
																						<th colspan="3" class="iText-right">Total ST: </th>
																						<th class="iText-right">{{opportunity.totalSTax | number:2}}</th>
																						<th></th>
																					</tr>
																					<tr>
																						<th colspan="12"></th>
																						<th colspan="3" class="iText-right">Total Amount: </th>
																						<th class="iText-right">{{opportunity.totalAmt | number:2}}</th>
																						<th></th>
																					</tr>
																					<tr>
																						<th colspan="12"></th>
																						<th colspan="3" class="iText-right">Discount:</th>
																						<td class="iText-right">
																							<span class="pull-right show-text-disInv">{{opportunity.disInvDol | number:2}}</span>
																							<div ng-blur="fToNumber($event, opportunity.disInvDol, 2)" class="pull-right form-group show-disInv" style="display: none; margin-bottom: 0px;">																																																	
																								<div class="input-group">
																				                    <input ng-model="opportunity.disInvPer" ng-change="oppDisInvPerChange()" onkeypress='return isPersent(this,event)' style="width: 80px;" type="text" name="oppDisInv"
																									id="oppDisInv" class="form-control"
																									value="{{opportunity.disInvPer | number:2}}">
																									<span class="input-group-addon btn">%</span>
																			                  	</div>
																							</div>
																						</td>
																						<th>
																							<a class="cusor_pointer" ng-click="editDisInvClick()"><i class="fa fa-pencil"></i>&nbsp;Edit</a>
																						</th>
																					</tr>
																					<tr>
																						<th colspan="12"></th>
																						<th colspan="3" class="iText-right">Net Total Amount: </th>
																						
																						<th class="iText-right"><span ng-if="opportunityDetail.length != 0">{{opportunity.opAmount | number:2}}</span><span ng-if="opportunityDetail.length == 0">0.00</span></th>
																						<th></th>
																					</tr>
																				</tfoot>	
																			</table>
																		</div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
										
										
										<div class="tab-pane " id="related_tap">
											<div class="row">
												<div class="col-md-12" >
														<a style="margin-left: 0px;" class="btn btn-app" ng-click="contact_click()"> 
															<i class="fa fa-user"></i> Contact
														</a> 
														<a class="btn btn-app" ng-click="quote_click()"> 
															<i class="fa fa-file-code-o"></i> Quote
														</a> 
														<a class="btn btn-app" ng-click="sale_order_click()"> 
															<i class="fa fa-file-text-o"></i> Sale Order
														</a> 
														
												</div>
												<div class="col-md-12">
																																																	
													<div class="panel-group" id="relatedGroup">														
														<div class="panel panel-default">
															<div class="panel-heading">
																<h4 class="panel-title pull-left">
																	<a data-toggle="collapse" data-parent="relatedGroup" href="#RContact">Contacts  </a>																	
																</h4>
																<span class="badge bg-blue pull-right">{{contact.length <= 0 ? '' : contact.length }}</span>
																<%-- <a href="${pageContext.request.contextPath}/create-contact" class="btn btn-default pull-right">New</a> --%>
																<div class="clearfix"></div>
															</div>
															<div id="RContact" class="panel-collapse collapse">
																<div class="panel-body">
																	<div class="mailbox-messages">
																			<table class="table iTable"> 					
																				<thead>
																					<tr>
																						<th class="text-center">#</th>
																						<th>Name</th>
																						<th>Title</th>
																						<th>Department</th>
																						<th>Phone</th>
																						<th>Email</th>
																						<th>Type</th>
																						<th></th>
																					</tr>
																				</thead>
																				<tbody ng-repeat="(key, con) in contact">
																					<tr>
																						<td class="iTD-width-50">
																							<a href="#">
																								<img style="width:30px;" class="img-circle" src="${pageContext.request.contextPath}/resources/images/module/Contact.png" alt="User Avatar">
																							</a>
																						</td>
																						<td>{{con.conName}}</td>
																						<td>{{con.conTitle}}</td>
																						<td>{{con.conDepartment}}</td>
																						<td>{{con.conPhone}}</td>
																						<td>{{con.conEmail}}</td>
																						<td>{{con.Type}}</td>
																						<td class="mailbox-date">
																							<div class="col-sm-2">
																								<div class="btn-group">
																									<button type="button"
																										class="btn btn-default dropdown-toggle btn-sm"
																										data-toggle="dropdown" aria-expanded="false">
																										<span class="caret"></span> <span class="sr-only">Toggle
																											Dropdown</span>
																									</button>
																									<ul class="dropdown-menu" role="menu">
																										<li>
																											<a href="#" ng-click="deleteContactClick(con.id, key)" ><i class="fa fa-trash"></i> Delete </a>
																										</li>																										
																										<li>
																											<a href="${pageContext.request.contextPath}/view-contact/{{con.conID}}"> <i class="fa fa-eye"></i> View</a>
																										</li>					
																									</ul>
																								</div>
																							</div>
																						</td>
																					</tr>
																					
																			</table>
																		</div>
																</div>
															</div>
														</div>
														
														<div class="panel panel-default">
															<div class="panel-heading">
																<h4 class="panel-title pull-left">
																	<a data-toggle="collapse" data-parent="relatedGroup" href="#RQuote">Quotations  </a>																	
																</h4>
																<%-- <a href="${pageContext.request.contextPath}/create-case" class="btn btn-default pull-right">New</a> --%>
																<span class="badge bg-blue pull-right">{{quote.length <= 0 ? '' : quote.length }}</span>
																<div class="clearfix"></div>
															</div>
															<div id="RQuote" class="panel-collapse collapse">
																<div class="panel-body">
																	<div class="mailbox-messages">
																			<table class="table iTable"> 					
																				<thead>
																					<tr>
																						<th class="text-center">#</th>
																						<th>Entry No</th>
																						<th>Quote Date</th>
																						<th>Start Date</th>
																						<th>Expire Date</th>
																						<th>Employee</th>
																						<th>Total Amount</th>
																						<th></th>
																					</tr>
																				</thead>
																				<tbody ng-repeat="(key, q) in quote">
																					<tr>
																						<td class="iTD-width-50">
																							<a href="#">
																								<img style="width:30px;" class="img-circle" src="${pageContext.request.contextPath}/resources/images/module/Opportunity.png" alt="User Avatar">
																							</a>
																						</td>
																						<td>{{q.quoteId}}</td>
																						<td>{{q.quoteDate | date:'dd/MM/yyyy h:mm a'}}</td>
																						<td>{{q.startDate | date:'dd/MM/yyyy'}}</td>
																						<td>{{q.expireDate | date:'dd/MM/yyyy'}}</td>
																						<td>[{{q.empId}}] {{q.empName}}</td>
																						<td>{{q.totalAmmount | number:2}}</td>
																						<td class="mailbox-date">
																							<div class="col-sm-2">
																								<div class="btn-group">
																									<button type="button"
																										class="btn btn-default dropdown-toggle btn-sm"
																										data-toggle="dropdown" aria-expanded="false">
																										<span class="caret"></span> <span class="sr-only">Toggle
																											Dropdown</span>
																									</button>
																									<ul class="dropdown-menu" role="menu">
																										
																										<li><a href="#" ng-click="deleteQuoteClick(q.opQuoteId, key, q.quoteId)"  >
																												<i class="fa fa-trash"></i> Delete
																										</a></li>																									
																										<li><a href="${pageContext.request.contextPath}/quote/edit/{{q.quoteId}}"> <i class="fa fa-eye"></i>
																												View
																										</a></li>
					
																									</ul>
																								</div>
																							</div>
																						</td>
																					</tr>
																					
																			</table>
																		</div>
																</div>
															</div>
														</div>
														<div class="panel panel-default">
															<div class="panel-heading">
																<h4 class="panel-title pull-left">
																	<a data-toggle="collapse" data-parent="relatedGroup" href="#RSaleOrder">Sale Orders  </a>																	
																</h4>
																<%-- <a href="${pageContext.request.contextPath}/create-case" class="btn btn-default pull-right">New</a> --%>
																<span class="badge bg-blue pull-right">{{saleOrder.length <= 0 ? '' : saleOrder.length }}</span>
																<div class="clearfix"></div>
															</div>
															<div id="RSaleOrder" class="panel-collapse collapse">
																<div class="panel-body">
																	<div class="mailbox-messages">
																			<table class="table iTable"> 					
																				<thead>
																					<tr>
																						<th class="text-center">#</th>
																						<th>Entry No</th>
																						<th>Sale Date</th>
																						<th>Due Date</th>
																						<th>Employee</th>
																						<th>Total Amount</th>
																						<th></th>
																					</tr>
																				</thead>
																				<tbody ng-repeat="(key, s) in saleOrder">
																					<tr>
																						<td class="iTD-width-50">
																							<a href="#">
																								<img style="width:30px;" class="img-circle" src="${pageContext.request.contextPath}/resources/images/module/Opportunity.png" alt="User Avatar">
																							</a>
																						</td>
																						<td>{{s.saleOrderId}}</td>
																						<td>{{s.saleOrderDate | date:'dd/MM/yyyy'}}</td>
																						<td>{{s.saleDueDate | date:'dd/MM/yyyy'}}</td>
																						<td>[{{s.empId}}] {{s.empName}}</td>
																						<td>{{s.totalAmount | number:2}}</td>
																						<td class="mailbox-date">
																							<div class="col-sm-2">
																								<div class="btn-group">
																									<button type="button"
																										class="btn btn-default dropdown-toggle btn-sm"
																										data-toggle="dropdown" aria-expanded="false">
																										<span class="caret"></span> <span class="sr-only">Toggle
																											Dropdown</span>
																									</button>
																									<ul class="dropdown-menu" role="menu">
																										
																										<li><a href="#" ng-click="deleteSaleOrderClick(s.opSaleOrderId, key)" >
																												<i class="fa fa-trash"></i> Delete
																										</a></li>																											
																										<li><a href="${pageContext.request.contextPath}/sale-order/edit/{{s.saleOrderId}}"> <i class="fa fa-eye"></i>
																												View
																										</a></li>
					
																									</ul>
																								</div>
																							</div>
																						</td>
																					</tr>
																					
																			</table>
																		</div>
																</div>
															</div>
														</div>
														
													</div>
												</div>
											</div>
										</div>
									
									
									</div>
									<!-- /.tab-content -->
								</div>
							</div>

						</div>
						<!-- /.row -->
					</div>
				</div>
				<!-- /.widget-user -->
			</div>
		</div>
	</section>
	
	
	<input type="hidden" id="btn_show_product" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#frmProduct" />
	<div class="modal fade modal-default" id="frmProduct" role="dialog">
		<div class="modal-dialog  modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" ng-click="cancelProductClick()" class="close"
						data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						<b  id="tProduct">Add An Item</b>
					</h4>
				</div>
				<form id="frmAddProduct" method="post">
				<div class="modal-body">
					<div class="row">
							<div class="col-md-12">
								<div class="col-md-6">
									<div class="form-group">
										<label>Item <span class="requrie">(Required)</span></label>
										<select onChange="oppItemChange()" class="form-control select2" name="oppItem"
												id="oppItem" style="width: 100%;">
											<option value="" selected></option>
											<option data-index="{{key}}" ng-repeat="(key,item) in oppItem track by $index" value="[{{item.itemId}}] {{item.itemName}}">[{{item.itemId}}] {{item.itemName}}</option>
										</select>
									</div>
								</div>
								<div class="col-md-6">
									<div class="bootstrap-timepicker">
										<div class="form-group">
											<label>UOM ID <span class="requrie">(Required)</span></label>
											<select class="form-control select2" name="oppUom"
												id="oppUom" style="width: 100%;">
												<option value=""></option>
												<option data-index="{{key}}" ng-repeat="(key,uom) in oppUom"
													value="{{uom.uomId}}">[{{uom.uomId}}] {{uom.des}}</option>
											</select>
										</div>
									</div>
								</div>
								
								<div class="clearfix"></div>
								<div class="col-md-6">
									<div class="bootstrap-timepicker">
										<div class="form-group">
											<label>Location ID <span class="requrie">(Required)</span></label>
											<select class="form-control select2" name="oppLocation"
												id="oppLocation" style="width: 100%;">
												<option value=""></option>
												<option data-index="{{key}}" ng-repeat="(key,loc) in oppLocation"
													value="[{{loc.locationId}}] {{loc.locationName}}">[{{loc.locationId}}] {{loc.locationName}}</option>
											</select>
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="bootstrap-timepicker">
										<div class="form-group">
											<label>Class ID </label>
											<select class="form-control select2" name="oppClassDetail"
												id="oppClassDetail" style="width: 100%;">
												<option value=""></option>
												<option ng-repeat="cl in oppClass"
													value="[{{cl.classId}}] {{cl.des}}">[{{cl.classId}}] {{cl.des}}</option>
											</select>
										</div>
									</div>
								</div>
								
								<div class="clearfix"></div>
								<div class="col-md-6">
									<div class="form-group">
										<label>Quatity <span class="requrie">(Required)</span></label>
										<input id="oppQty" ng-blur="fToNumber($event, oppQty, 4)" ng-change="oppQtyChange()" ng-model="oppQty" onkeypress='return isNumeric(this,event)' name="oppQty" class="form-control" type="text"
										placeholder="">
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label>Unit Price <span class="requrie">(Required)</span></label>
										<input ng-model="oppUnitPrice" ng-blur="fToNumber($event, oppUnitPrice, 6)" ng-change="oppUnitePriceChange()" onkeypress='return isNumeric(this,event)' id="oppUnitPrice" name="oppUnitPrice" class="form-control" type="text"
										placeholder="">
									</div>
								</div>
								
								<div class="clearfix"></div>
								<div class="col-md-6">
									<div class="form-group">
										<label>Price Factor<span class="requrie">(Required)</span></label>
										<input id="oppPriceFactor" ng-blur="fToNumber($event, oppPriceFactor, 4)" onkeypress='return isNumeric(this,event)' ng-model="oppPriceFactor" ng-change="oppPriceFactorChange()" name="oppPriceFactor" class="form-control" type="text"
										placeholder="">
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label>Report Price</label>
										<input id="oppReportPrice" ng-model="oppReportPrice" disabled="disabled"  name="oppReportPrice" class="form-control" type="text"
										placeholder="">
									</div>
								</div>
								<div class="clearfix"></div>
								<div class="col-md-6"></div>
								<div class="col-md-6">
									<div class="form-group">
										<label>Total Amount</label>
										<input id="oppTAmount"   ng-model="oppTAmount" disabled="disabled" name="oppTAmount" class="form-control" type="text"
										placeholder="">
									</div>
								</div>
								
								<div class="clearfix"></div>
								<div class="col-md-6">
									<div class="form-group">
										<label>Dicount %</label>
										<input ng-model="oppDisPer" ng-blur="fToNumber($event, oppDisPer, 5)" ng-change="oppDisPerChange()" onkeypress='return isPersent(this,event)' id="oppDisPer" name="oppDisPer" class="form-control" type="text"
										placeholder="">
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label>Discount $</label>
										<input ng-model="oppDisDol" ng-blur="fToNumber($event, oppDisDol, 2)" ng-change="oppDisDolChange()" id="oppDisDol" onkeypress='return isNumeric(this,event)' name="oppDisDol" class="form-control" type="text"
										placeholder="">
									</div>
								</div>
								<div class="clearfix"></div>
								<div class="col-md-6">
									<div class="form-group">
										<label>VAT %</label>
										<input ng-model="oppVatPer" ng-blur="fToNumber($event, oppVatPer, 5)" ng-change="oppVatPerChange()" onkeypress='return isPersent(this,event)' id="oppVatPer" name="oppVatPer" class="form-control" type="text"
										placeholder="">
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label>VAT $</label>
										<input ng-model="oppVatDol" ng-blur="fToNumber($event, oppVatDol, 2)" ng-change="oppVatDolChange()" id="oppVatDol" onkeypress='return isNumeric(this,event)' name="oppVatDol" class="form-control" type="text"
										placeholder="">
									</div>
								</div>
								<div class="clearfix"></div>
								<div class="col-md-6">
									<div class="form-group">
										<label>ST %</label>
										<input ng-model="oppSTPer" ng-blur="fToNumber($event, oppSTPer, 5)" ng-change="oppSTPerChange()" onkeypress='return isPersent(this,event)' id="oppSTPer" name="oppSTPer" class="form-control" type="text"
										placeholder="">
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label>ST $</label>
										<input ng-model="oppSTDol" ng-blur="fToNumber($event, oppSTDol, 2)" ng-change="oppSTDolChange()" id="oppSTDol" onkeypress='return isNumeric(this,event)' name="oppSTDol" class="form-control" type="text"
										placeholder="">
									</div>
								</div>
								<div class="clearfix"></div>
								<div class="col-md-6"></div>
								<div class="col-md-6">
									<div class="form-group">
										<label>Net Total Amount</label>
										<input ng-model="oppNetTAmount" id="oppNetTAmount" disabled="disabled" name="oppNetTAmount" class="form-control" type="text"
										placeholder="">
									</div>
								</div>
								<div class="clearfix"></div>
							</div>						
					</div>				
				</div>
				</form>
				<div class="modal-footer">
					<button type="button" id="btnProductCancel"
						ng-click="cancelProductClick()" name="btnProductCancel"
						class="btn btn-danger" data-dismiss="modal">Cancel</button>
					&nbsp;&nbsp;
					<button type="button" ng-click="btnProductSave()" class="btn btn-primary pull-right"
						id="btnProductSave" name="btnProductSave">Save</button>

				</div>
			</div>
		</div>
	</div>
	
	
	<input type="hidden" id="btn_show_contact" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#frmContact" />
	<div class="modal fade modal-default" id="frmContact" role="dialog">
		<div class="modal-dialog  modal-md">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" ng-click="cancelContactClick()" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title"><b>Add Contact</b></h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<form id="frmAddContact">
						<div class="col-md-12">
							
							<div class="col-md-12">
								<div class="form-group">
									<label>Contact<span class="requrie"> (Required)</span></label>
									<select class="form-control select2" name="ConContact" id="ConContact" style="width: 100%;">
											<option value="">-- SELECT Contact --</option>
											<option ng-repeat="a in allContact" value="{{a.conID}}">{{a.conSalutation}}{{a.conFirstname}} {{a.conLastname}}</option>
										</select>
								</div>
							</div>							
							<div class="clearfix"></div>
							<div class="col-md-12">
								<div class="form-group">
									<label>Type</label>
									<select class="form-control select2" name="ConType" id="ConType" style="width: 100%;">
										<option value="Normal">Normal</option>
										<option value="Primary">Primary</option>
									</select>
								</div>
							</div>
							
						</div>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" id="btnContactCancel" ng-click="cancelContactClick()" name="btnContactCancel" class="btn btn-danger" data-dismiss="modal">Cancel</button>
					&nbsp;&nbsp;
					<button type="button" ng-click="saveContactClick()" id="btnContactSave" name="btnContactSave"  class="btn btn-primary pull-right">Save</button>

				</div>
			</div>
		</div>
	</div>
	
	<input type="hidden" id="btn_show_quote" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#frmQuote" />
	<div class="modal fade modal-default" id="frmQuote" role="dialog">
		<div class="modal-dialog  modal-md">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" ng-click="cancelQuoteClick()" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title"><b>Add Quote</b></h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<form id="frmAddQuote">
						<div class="col-md-12">
							
							<div class="col-md-12">
								<div class="form-group">
									<label>Quote<span class="requrie"> (Required)</span></label>
									<select class="form-control select2" name="QuoteQuote" id="QuoteQuote" style="width: 100%;">
										<option value="">-- SELECT Quote --</option>
										<option ng-repeat="q in allQuote" value="{{q.quoteId}}">{{q.quoteId}}</option>										
									</select>
								</div>
							</div>							
							
						</div>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" id="btnQuoteCancel" ng-click="cancelQuoteClick()" name="btnQuoteCancel" class="btn btn-danger" data-dismiss="modal">Cancel</button>
					&nbsp;&nbsp;
					<button type="button" ng-click="saveQuoteClick()" id="btnQuoteSave" name="btnQuoteSave"  class="btn btn-primary pull-right">Save</button>

				</div>
			</div>
		</div>
	</div>
	
	<input type="hidden" id="btn_show_sale_order" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#frmSaleOrder" />
	<div class="modal fade modal-default" id="frmSaleOrder" role="dialog">
		<div class="modal-dialog  modal-md">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" ng-click="cancelSaleOrderClick()" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title"><b>Add Sale Order</b></h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<form id="frmAddSaleOrder">
						<div class="col-md-12">
							
							<div class="col-md-12">
								<div class="form-group">
									<label>Sale Order<span class="requrie"> (Required)</span></label>
									<select class="form-control select2" name="SaleSaleOrder" id="SaleSaleOrder" style="width: 100%;">
										<option value="">-- SELECT Sale Order --</option>
										<option ng-repeat="s in allSaleOrder" value="{{s.saleId}}">{{s.saleId}}</option>	
									</select>
								</div>
							</div>							
							
						</div>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" id="btnSaleOrderCancel" ng-click="cancelSaleOrderClick()" name="btnSaleOrderCancel" class="btn btn-danger" data-dismiss="modal">Cancel</button>
					&nbsp;&nbsp;
					<button type="button" ng-click="saveSaleOrderClick()" id="btnSaleOrderSave" name="btnSaleOrderSave"  class="btn btn-primary pull-right">Save</button>

				</div>
			</div>
		</div>
	</div>

	<input type="hidden" id="btn_show_call" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#frmCall" />
	<div ng-controller="callController" class="modal fade modal-default" id="frmCall" role="dialog">
		<div class="modal-dialog  modal-lg" data-ng-init="startupCallForm()">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" ng-click="cancelCallClick()" class="close"
						data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						<b  id="tCall">Create Call</b>
					</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<form id="frmAddCall">
							<div class="col-md-12">
								<div class="col-md-12">
									<div class="form-group">
										<label>Subject <span class="requrie">(Required)</span></label>
										<input id="callSubject" name="callSubject"
											class="form-control" type="text" placeholder="">
									</div>
								</div>
								<div class="clearfix"></div>
								<div class="col-md-6">
									<div class="form-group">
										<label>Start Date<span class="requrie">(Required)</span></label>
										<div class="input-group">
											<div class="input-group-addon">
												<i class="fa fa-calendar"></i>
											</div>
											<input value="" name="callStartDate" id="callStartDate"
												type="text" class="form-control date pull-right active">
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="bootstrap-timepicker">
										<div class="form-group">
											<label>Duration <span class="requrie">(Required)</span></label>
											<div class="input-group">
												<div class="input-group-addon">
													<i class="fa fa-clock-o"></i>
												</div>
												<input type="text" class="form-control timepicker active"
													name="callDuration" id="callDuration" placeholder="hours:minutes">
											</div>
										</div>
									</div>
								</div>
								<div class="clearfix"></div>
								<div class="col-md-6">
									<div class="form-group">
										<label>Status <span class="requrie">(Required)</span></label>
										<select class="form-control select2" name="callStatus"
											id="callStatus" style="width: 100%;">
											<option value="">--SELECT A Status</option>
											<option ng-repeat="st in callStatusStartup"
												value="{{st.callStatusId}}">{{st.callStatusName}}</option>
										</select>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label>Assign To </label> <select class="form-control select2"
											name="callAssignTo" id="callAssignTo" style="width: 100%;">
											<option value="">--SELECT A Assign To</option>
										</select>
									</div>
								</div>
								<div class="clearfix"></div>
								<div class="col-md-12">
									<div class="form-group">
										<label>Description </label>
										<textarea rows="5" cols="" name="callDescription"
											id="callDescription" class="form-control"></textarea>
									</div>
								</div>
							</div>
						</form>
					</div>



				</div>
				<div class="modal-footer">
					<button type="button" id="btnCallCancel"
						ng-click="cancelCallClick()" name="btnCallCancel"
						class="btn btn-danger" data-dismiss="modal">Cancel</button>
					&nbsp;&nbsp;
					<button type="button" class="btn btn-primary pull-right"
						id="btnCallSave" name="btnCallSave">Save</button>

				</div>
			</div>
		</div>
	</div>
	
	<input type="hidden" id="btn_show_meet" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#frmMeet" />
	<div ng-controller="meetController"  class="modal fade modal-default" id="frmMeet" role="dialog">
		<div class="modal-dialog  modal-lg" data-ng-init="startupMeetForm()">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" ng-click="cancelMeetClick()" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title"><b id="tMeeting">Create Meeting</b></h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<form id="frmAddMeet">
						<div class="col-md-12">
							<div class="col-md-6">
								<div class="form-group">
									<label>Subject <span class="requrie">(Required)</span></label>
									<input id="meetSubject" name="meetSubject" class="form-control" type="text"
										placeholder="">
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Duration <span class="requrie">(Required)</span></label>
									<select class="form-control select2" name="meetDuration"
										id="meetDuration" style="width: 100%;">
										<option value="">-- Select A Duration --</option>
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

							<div class="clearfix"></div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Start Date<span class="requrie">(Required)</span></label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input value="" name="meetStartDate" id="meetStartDate" type="text" class="form-control meet-data-time pull-right active">
									</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>End Date<span class="requrie">(Required)</span></label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input name="meetEndDate" id="meetEndDate" type="text" class="form-control meet-data-time pull-right active">
									</div>
								</div>
							</div>

							<div class="clearfix"></div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Assign To </label> 
									<select class="form-control select2" name="meetAssignTo" id="meetAssignTo" style="width: 100%;">
										<option value="">-- SELECT A Assign To --</option>
									</select>
								</div>
							</div>

							<div class="col-md-6">
								<div class="form-group">
									<label>Status</label> 
									<select class="form-control select2" name="meetStatus" id="meetStatus" style="width: 100%;">
										<option value="">-- SELECT A Status --</option>
										<option ng-repeat="st in meetStatusStartup" value="{{st.statusId}}">{{st.statusName}}</option>
									</select>
								</div>
							</div>

							<div class="clearfix"></div>
							<div class="col-md-12">
								<div class="form-group">
									<label>Location </label> 
									<input id="meetLocation" name="meetLocation" class="form-control" type="text" placeholder="">
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="col-md-12">
								<div class="form-group">
									<label>Description </label>
									<textarea rows="4" cols="" name="meetDescription" id="meetDescription" class="form-control"></textarea>
								</div>
							</div>
						</div>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" id="btnMeetCancel" ng-click="cancelMeetClick()" name="btnMeetCancel" class="btn btn-danger" data-dismiss="modal">Cancel</button>
					&nbsp;&nbsp;
					<button type="button" id="btnMeetSave" name="btnMeetSave" class="btn btn-primary pull-right">Save</button>
				</div>
			</div>
		</div>
	</div>
	
	<input type="hidden" id="btn_show_task" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#frmTask" />
	<div ng-controller="taskController" class="modal fade modal-default" id="frmTask" role="dialog">
		<div class="modal-dialog  modal-lg" data-ng-init="startupTaskForm()">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" ng-click="cancelTaskClick()" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title"><b  id="tTask">Create Task</b></h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<form id="frmAddTask">
						<div class="col-md-12">
							<div class="col-md-12">
								<div class="form-group">
									<label>Subject <span class="requrie">(Required)</span></label>
									<input id="taskSubject" name="taskSubject" class="form-control" type="text"
										placeholder="">
								</div>
							</div>
							

							<div class="clearfix"></div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Start Date</label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input value="" name="taskStartDate" id="taskStartDate" type="text" class="form-control task-data-time pull-right active">
									</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Due Date</label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input name="taskEndDate" id="taskEndDate" type="text" class="form-control task-data-time pull-right active">
									</div>
								</div>
							</div>
								
							<div class="clearfix"></div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Priority <span class="requrie">(Required)</span></label>
									<select class="form-control select2" id="taskPriority" name="taskPriority"  style="width: 100%;">
										<option value="">-- Select A Priority --</option>
										<option value="High">High</option>
										<option value="Medium">Medium</option>
										<option value="Low">Low</option>
									</select>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Status <span class="requrie">(Required)</span></label> 
									<select class="form-control select2" name="taskStatus" id="taskStatus" style="width: 100%;">
										<option value="">-- SELECT A Status --</option>
										<option ng-repeat="st in taskStatusStartup" value="{{st.taskStatusId}}">{{st.taskStatusName}}</option>
									</select>
								</div>
							</div>
							
							<div class="clearfix"></div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Assign To </label> 
									<select class="form-control select2" name="taskAssignTo" id="taskAssignTo" style="width: 100%;">
										<option value="">-- SELECT A Assign To --</option>
									</select>
								</div>
							</div>

							<div class="col-md-6">
								<div class="form-group">
									<label>Contact</label> 
									<select class="form-control select2" name="taskContact" id="taskContact" style="width: 100%;">
										<option value="">-- SELECT A Contact --</option>
										<option ng-repeat="st in taskContactStartup" value="{{st.conID}}">{{st.conFirstname}} {{st.conLastName}}</option>
									</select>
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="col-md-12">
								<div class="form-group">
									<label>Description </label>
									<textarea rows="4" cols="" name="taskDescription" id="taskDescription"
										class="form-control"></textarea>
								</div>
							</div>
						</div>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" id="btnTaskCancel" ng-click="cancelTaskClick()" name="btnTaskCancel" class="btn btn-danger" data-dismiss="modal">Cancel</button>
					 &nbsp;&nbsp;
					<button type="button" id="btnTaskSave" name="btnTaskSave" class="btn btn-primary pull-right" >Save</button>
				</div>
			</div>
		</div>
	</div>
	
	<input type="hidden" id="btn_show_event" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#frmEvent" />
	<div ng-controller="eventController" class="modal fade modal-default" id="frmEvent" role="dialog">
		<div class="modal-dialog  modal-lg" data-ng-init="startupEventForm()">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" ng-click="cancelEventClick()" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title"><b id="tEvent">Create Event</b></h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<form id="frmAddEvent">
						<div class="col-md-12">
							<div class="col-md-12">
								<div class="form-group">
									<label>Subject <span class="requrie">(Required)</span></label>
									<input id="eventSubject" name="eventSubject" class="form-control" type="text" placeholder="">
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Start Date<span class="requrie">(Required)</span></label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input  name="eventStartDate" id="eventStartDate" type="text" class="form-control event-date-time pull-right active">
									</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>End Date<span class="requrie">(Required)</span></label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input name="eventEndDate" id="eventEndDate" type="text" class="form-control event-date-time pull-right active">
									</div>
								</div>
							</div>

							<div class="clearfix"></div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Duration <span class="requrie">(Required)</span></label>
									<select class="form-control select2" name="eventDuration" id="eventDuration" style="width: 100%;">
										<option value="">-- SELECT A Duration --</option>
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
							<div class="col-md-6">
								<div class="form-group">
									<label>Assign To </label> 
									<select class="form-control select2" name="eventAssignTo" id="eventAssignTo" style="width: 100%;">
										<option value="">-- SELECT A Assign To --</option>
									</select>
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Budget</label> 
									<input id="eventBudget" name="eventBudget" class="form-control" type="text" placeholder="">
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Location </label> 
									<select class="form-control select2" name="eventLocation" id="eventLocation" style="width: 100%;">
										<option value="">-- SELECT A Location --</option>
										<option ng-repeat="loc in eventLocationStartup" value="{{loc.loId}}">{{loc.loName}}</option>
									</select>
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="col-md-12">
								<div class="form-group">
									<label>Description </label>
									<textarea rows="4" cols="" name="eventDescription" id="eventDescription" class="form-control"></textarea>
								</div>
							</div>
						</div>
						</form>
					</div>



				</div>
				<div class="modal-footer">
					<button type="button" id="btnEventCancel" ng-click="cancelEventClick()" name="btnEventCancel" class="btn btn-danger" data-dismiss="modal">Cancel</button>
					&nbsp;&nbsp;
					<button type="button" id="btnEventSave" name="btnEventSave"  class="btn btn-primary pull-right">Save</button>

				</div>
			</div>
		</div>
	</div>
	
	
	<div id="errors"></div>
</div>

<jsp:include page="${request.contextPath}/footer"></jsp:include>
<script src="${pageContext.request.contextPath}/resources/js.mine/opportunity/viewOpport.js"></script>
