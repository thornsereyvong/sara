//var curentQuoteId = "";


var app = angular.module('quoteApp', ['angularUtils.directives.dirPagination','oitozero.ngSweetAlert']);
var self = this;
app.controller('quoteController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){
	
	$scope.curentQuoteId = "";
	
	$scope.listQuote = function(){
		$http.get(server+"quote/list-all-quote").success(function(response){			
			$scope.quotation = response.DATA;
		});
	};
	
	$scope.sort = function(keyname){
	    $scope.sortKey = keyname;   //set the sortKey to the param passed
	    $scope.reverse = !$scope.reverse; //if true make it false and vice versa
	};
	
	$scope.selectQuote = function(saleId){
		$http.get(server+"quote/list/"+saleId).success(function(response){
			if(response.MESSAGE == "SUCCESS"){
				if(listDataSalOrdFromQuote(response.DATA)){
					$scope.curentQuoteId = saleId;
					 $('#ConQuote').modal('toggle');
				}
			}
		});
	};
	
}]);

function listDataSalOrdFromQuote(data){
	if(data != ""){
		//setValueById('entryNo', data.saleId);
		$("#customer").select2('val',data.custId);
		$("#employee").select2('val',data.empId);
		$("#priceCode").select2('val',data.priceCode);
		$("#classCodeMaster").select2('val',data.classId);
		
		//setValueById('quoteDate', convertFromSQLToDate(data.saleDate));
		//setValueById('startDate', convertFromSQLToDate(data.startDate));
		//setValueById('expireDate', convertFromSQLToDate(data.expireDate));
		
		setValueById('reference', data.saleReference);
		setValueById('remark', data.remark);
							
		$("#shipToAdd").select2('val',data.shipTo);
		
		index=0;
		$("#listItem").empty();		
		for(var i=0;i<data.quoteDetails.length;i++){
			index++;
			$("#listItem").append(addAnItem());
			select2Init("item"+index);
			select2Init("location"+index);
			$("#item"+index).select2('val',data.quoteDetails[i].itemId);
			$("#location"+index).select2('val',data.quoteDetails[i].locationId);
			
			$("#classCode"+index+" option[value='"+data.quoteDetails[i].classId+"']").attr('selected','selected');	
			$("#uom"+index+" option[value='"+data.quoteDetails[i].uomId+"']").attr('selected','selected');
			
			$("#qty"+index).val(formatNumByLength(data.quoteDetails[i].saleQuantity, 5));
			$("#up"+index).val(formatNumByLength(data.quoteDetails[i].unitPrice, 2));
			
			$("#disP"+index).val(formatNumByLength(data.quoteDetails[i].disPer, 5));
			$("#disDol"+index).val(formatNumByLength(data.quoteDetails[i].disDol, 2));
			$("#reportPrice"+index).val(formatNumByLength(data.quoteDetails[i].reportPrice, 6));
			$("#priceFactor"+index).val(formatNumByLength(data.quoteDetails[i].factor, 4));
			$("#vatP"+index).val(formatNumByLength(data.quoteDetails[i].vtaxPer, 5));
			$("#vatDol"+index).val(formatNumByLength(data.quoteDetails[i].vtaxDol, 2));
			$("#stP"+index).val(formatNumByLength(data.quoteDetails[i].staxPer, 5));
			$("#stDol"+index).val(formatNumByLength(data.quoteDetails[i].staxDol, 2));
			
			$("#tAmt"+index).val(formatNumByLength(data.quoteDetails[i].totalAmt,2));
			$("#nTAmt"+index).val(formatNumByLength(data.quoteDetails[i].netTotalAmt,2));
		}
		
		setValueById('txtTSalOrd', formatNumAccByLength(data.totalAmt,2));
		setValueById('txtInvDis', formatNumAccByLength(data.disInvDol,2));
		setValueById('txtDisInv', data.disInvPer);
		setValueById('txtNetInv', formatNumAccByLength(data.netTotalAmt,2));
		
		setValueById('txtTPTDate', formatNumAccByLength(data.pmtToDate,2));
		setValueById('txtAmtDue', formatNumAccByLength(data.netTotalAmt,2));
		
		
		setValueById('txtTST', formatNumAccByLength(data.totalSTax,2));
		setValueById('txtTVAT', formatNumAccByLength(data.totalVTax,2));
		
		return true;	
	}
} 

function listDataSalOrdById(data){
	if(data != ""){
		setValueById('entryNo', data.saleId);
		$("#customer").select2('val',data.custId);
		$("#employee").select2('val',data.empId);
		$("#priceCode").select2('val',data.priceCode);
		$("#classCodeMaster").select2('val',data.classId);
		
		orDateOld = convertFromSQLToDate(data.saleDate);
		duedateOld = convertFromSQLToDate(data.dueDate);
		
		setValueById('orderDate', orDateOld);
		setValueById('duedate', duedateOld);			
		
		
		setValueById('reference', data.saleReference);
		setValueById('remark', data.remark);
							
		$("#shipToAdd").select2('val',data.shipTo);
		//TermNetDueIn = toNum(cust[0].TermNetDueIn);
		
		index=0;
		$("#listItem").empty();		
		for(var i=0;i<data.saleOrderDetails.length;i++){
			index++;
			$("#listItem").append(addAnItem());
			select2Init("item"+index);
			select2Init("location"+index);
			$("#item"+index).select2('val',data.saleOrderDetails[i].itemId);
			$("#location"+index).select2('val',data.saleOrderDetails[i].locationId);
			
			$("#classCode"+index+" option[value='"+data.saleOrderDetails[i].classId+"']").attr('selected','selected');	
			$("#uom"+index+" option[value='"+data.saleOrderDetails[i].uomId+"']").attr('selected','selected');
			
			$("#qty"+index).val(formatNumByLength(data.saleOrderDetails[i].saleQuantity, 5));
			$("#up"+index).val(formatNumByLength(data.saleOrderDetails[i].unitPrice, 2));
			
			$("#disP"+index).val(formatNumByLength(data.saleOrderDetails[i].disPer, 5));
			$("#disDol"+index).val(formatNumByLength(data.saleOrderDetails[i].disDol, 2));
			$("#reportPrice"+index).val(formatNumByLength(data.saleOrderDetails[i].reportPrice, 6));
			$("#priceFactor"+index).val(formatNumByLength(data.saleOrderDetails[i].factor, 4));
			$("#vatP"+index).val(formatNumByLength(data.saleOrderDetails[i].vtaxPer, 5));
			$("#vatDol"+index).val(formatNumByLength(data.saleOrderDetails[i].vtaxDol, 2));
			$("#stP"+index).val(formatNumByLength(data.saleOrderDetails[i].staxPer, 5));
			$("#stDol"+index).val(formatNumByLength(data.saleOrderDetails[i].staxDol, 2));
			
			$("#tAmt"+index).val(formatNumByLength(data.saleOrderDetails[i].totalAmt,2));
			$("#nTAmt"+index).val(formatNumByLength(data.saleOrderDetails[i].netTotalAmt,2));
		}
		
		setValueById('postStatus', data.postStatus);				
		setValueById('txtTSalOrd', formatNumAccByLength(data.totalAmount,2));
		setValueById('txtInvDis', formatNumAccByLength(data.disInvDol,2));
		setValueById('txtDisInv', data.disInvPer);
		setValueById('txtNetInv', formatNumAccByLength(data.netTotalAmt,2));
		
		setValueById('txtTPTDate', formatNumAccByLength(data.pmtToDate,2));
		setValueById('txtAmtDue', formatNumAccByLength(data.netTotalAmt,2));
		
		
		setValueById('txtTST', formatNumAccByLength(data.totalSTax,2));
		setValueById('txtTVAT', formatNumAccByLength(data.totalVTax,2));
		
		return true;	
	}
} 



var rowDelete='';
var styUom= "";
var styQty = "";
var orDateOld = moment().format('D-MMM-YYYY');
var duedateOld = moment().format('D-MMM-YYYY');
var TermNetDueIn = 0;
var entryCheck = true;


var disOnChangeAct = 0;
var disDolOnChangeAct = 0;

var vatOnChangeAct = 0;
var vatDolOnChangeAct = 0;

var stOnChangeAct = 0;
var stDolOnChangeAct = 0;


// START READY
$(function(){
	$('#orderDate').datepicker(); $('#orderDate').val(moment().format('D-MMM-YYYY'));
	$('#duedate').datepicker(); $('#duedate').val(moment().format('D-MMM-YYYY'));  
	$('#shipToAdd').select2();
	
	$("#listItem").sortable();
    $("#listItem").disableSelection();	
	
	$("#btnSucOk").click(function(){
		cancel();
	});
	
	$("#btnGenQuote").click(function(){
		angular.element(document.getElementById('ConQuote')).scope().listQuote();
		$("#GenQuote").click();
	});
	
	$("#btnSave").click(function(){
		if(entryCheck == false){
			alertEntryExist();
		}else if(checkMaster() == true && checkDetail()== true && checkLine()==true && entryCheck == true){
			saleOrder();
		}else{
			if(checkMaster() != true || checkDetail() != true){
				alertRequireField();
			}else if(checkLine() == false){
				alertZero();
			}
		}
	});
	
	$("#btnConfirmOk").click(function(){
		$("#RowItem"+rowDelete).remove();
		totalSalOrd();
		showAllLocation();
		clearOneLocation();
		
		totalSTandVAT();
		
		if($("#listItem tr").length<1){
			clearAllLocation();
			clearTotalOrd();
			cleartotalSTandVAT();
		}
	});
	
	// Customer change act
	$("#customer").change(function (){
		var customer = $.trim($("#customer").val());
		var data = [];
		if(customer != ""){
			$("#customer").next().children().children().attr('style','border: 1px solid #d2d6de;');
			for(var i=0;i<LCustomer.length;i++){
				if(customer == $.trim(LCustomer[i].CustID)){
					data.push(LCustomer[i]);
				}
			}
		}else{
			data = [];
			$("#customer").next().children().children().attr('style','border: 1px solid #dd4b39;');
			$("#priceCode").select2('val','');
			addShipToAdd(data);	
		}
		if(data.length>0){
			addShipToAdd(data);	
			$("#priceCode").select2('val',data[0].PriceCode);
			
			if(data[0].PriceCode != ''){
				$("#priceCode").next().children().children().attr('style','border: 1px solid #d2d6de;');
			}
			var orDate = $('#orderDate').val();
			
			TermNetDueIn = toNum(data[0].TermNetDueIn); 
			if(orDate!=""){
				$('#duedate').val(addDays(TermNetDueIn,orDate));
			}else{
				$('#orderDate').val(moment().format('D-MMM-YYYY'));
				$('#duedate').val(addDays(TermNetDueIn,moment().format('D-MMM-YYYY')));		
			}	
			
			duedateOld = $('#duedate').val();
		}		
	});
	// end Customer change act
	
	
	$("#entryNo").change(function (){
		var entryNo = $.trim($("#entryNo").val());
		if(entryNo != ""){
			$.ajax({ 
				url: server+"sale-order/check-entry-no",
				method: "POST",
				async: false,
				data: JSON.stringify({"saleId":entryNo}),
				beforeSend: function(xhr) {
				    xhr.setRequestHeader("Accept", "application/json");
				    xhr.setRequestHeader("Content-Type", "application/json");
			    }, 
			    success: function(result){			    	
					if(result.MESSAGE == "EXIST"){
						entryCheck = false;
						swal("The value of field 'Entry No' is already exist!", "Please try new!", "error");						
						$("#entryNo").attr('style','border: 1px solid #dd4b39;');
					}else{
						entryCheck = true;
						$("#entryNo").attr('style','border: 1px solid #d2d6de;');
					}
				}
			    
			});
		}
	});
	
	
	$("#employee").change(function (){
		var emp = $("#employee").val();
		if(emp == ''){
			$("#employee").next().children().children().attr('style','border: 1px solid #dd4b39;');
		}else{
			$("#employee").next().children().children().attr('style','border: 1px solid #d2d6de;');
		}
	});
	
	$("#priceCode").change(function (){
		var priceCode = $("#priceCode").val();
		if(priceCode == ''){
			$("#priceCode").next().children().children().attr('style','border: 1px solid #dd4b39;');
		}else{
			$("#priceCode").next().children().children().attr('style','border: 1px solid #d2d6de;');
		}
	});
	
	$("#orderDate").change(function(){
		var orDate = $.trim($("#orderDate").val());
		if(orDate == ''){
			$("#orderDate").val(orDateOld);
		}else{
			orDateOld = orDate;
			$('#duedate').val(addDays(TermNetDueIn,orDate));
		}
	});
	
	$("#duedate").change(function(){
		var duedate = $.trim($("#duedate").val());
		if(duedate == ''){
			$("#duedate").val(duedateOld);
		}else{
			duedateOld = duedate;			
		}
	});
	
	// add an item
	$("#addAnItem").click(function(){	
		if(entryCheck == false){
			alertEntryExist();
		}else if(checkMaster() == true){
			if(checkDetail() == true){	
				index++;
				$("#listItem").append(addAnItem());
				select2Init("item"+index);
				select2Init("location"+index);
				styUom= $("#uom"+index).attr('style');
				styQty = $("#qty"+index).attr('style');
				
			}else{				
				alertRequireField();
			}
		}else{			
			alertRequireField();			
			checkDetail();
		}	
		clearOneLocation();
	});
	// end add an item	
	
	$("#invDis").click(function(){
		if(getValueById('txtTSalOrd')>0){
			$("#invDisDia").click();			
		}	
	});
	
	$("#btnInvDisOk").click(function(){
		 disInvoive();
		 netInvoice();	 
	});
});



function alertRequireField(){
	swal({  
		   title: "Require Field!",   
		   text: "",   
		   timer: 2000,   
		   type: "warning",
		   showConfirmButton: false 
	});
}

function alertZero(){
	swal({  
		   title: "The number of record must be more than zero.",   
		   text: "",   
		   timer: 2000,   
		   type: "warning",
		   showConfirmButton: false 
	});
}

function alertEntryExist(){
	swal({  
		   title: "The value of field 'Entry No' is already exist!",   
		   text: "Please try new!",   
		   timer: 2000,   
		   type: "warning",
		   showConfirmButton: false 
	});
}


// START ALL FUNCTION 

function priceFactorChange(obj,l){
	var num = toNum(obj.value);
	var obj1 = $("#"+obj.getAttribute("id"));
	var n = obj1.parent().parent().attr('val');
	
	
	if(num==0){
		num =1;
	}
	
	obj.value = num.toFixed(l).replace(/(\d)(?=(\d{3})+\.)/g, "$1,");
	
	calculateByItem(n);
	
	totalSalOrd();
	showOneLocation(n);
}
function upChange(obj,l){
	var num = toNum(obj.value);
	var obj1 = $("#"+obj.getAttribute("id"));
	var n = obj1.parent().parent().attr('val');
	
	obj.value = num.toFixed(l).replace(/(\d)(?=(\d{3})+\.)/g, "$1,");
	
	calculateByItem(n);
	
	totalSalOrd();
	
	showOneLocation(n);
	
}
function qtyChange(obj,l){
	
	var num = toNum(obj.value);
	var obj1 = $("#"+obj.getAttribute("id"));
	var n = obj1.parent().parent().attr('val');
	
	if(num>0){
		obj1.attr('style',styQty);
	}else{
		obj1.attr('style','border: 1px solid #dd4b39;'+styQty);
	}		
	obj.value = num.toFixed(l).replace(/(\d)(?=(\d{3})+\.)/g, "$1,");
	
	calculateByItem(n);
	
	totalSalOrd();
	showOneLocation(n);
	
}
function disDolChange(obj,l){
	
	var num = toNum(obj.value);
	var obj1 = $("#"+obj.getAttribute("id"));
	var n = obj1.parent().parent().attr('val');
	
	
	obj.value = num.toFixed(l).replace(/(\d)(?=(\d{3})+\.)/g, "$1,");
	
	var up = toNum($.trim($("#up"+n).val()));
	var qty = toNum($.trim($("#qty"+n).val()));
	
	var priceFactor = toNum($("#priceFactor"+n).val());
	if(priceFactor == 0){
		priceFactor = 1;
		$("#priceFactor"+n).val(formatNumByLength(priceFactor,4));
	}
	var disP = 0;
	if(up*qty*priceFactor != 0 || num*100 != 0)
		disP = (num*100/(up*qty*priceFactor));
	
	$("#disP"+n).val(formatNumByLength(disP,5));
	
	calculateByItem(n);
	
	if(obj.value == disDolOnChangeAct ){
		$("#disP"+n).val(formatNumByLength(disOnChangeAct,5));
	}else{
		disOnChangeAct = formatNumByLength(disP,5);
	}
	
	
	disDolOnChangeAct = obj.value;
	
	totalSalOrd();
	showOneLocation(n);
}
function disPerChange(obj,l){
	
	var num = toNum(obj.value);
	var obj1 = $("#"+obj.getAttribute("id"));
	var n = obj1.parent().parent().attr('val');
	
	
			
	obj.value = num.toFixed(l).replace(/(\d)(?=(\d{3})+\.)/g, "$1,");
	disOnChangeAct = obj.value;
	calculateByItem(n);
	
	disDolOnChangeAct = toNum($.trim($("#disDol"+n).val()));
	
	totalSalOrd();
	showOneLocation(n);
}

function disFocus(obj,l){
	var obj1 = $("#"+obj.getAttribute("id"));
	var n = obj1.parent().parent().attr('val');
	disDolOnChangeAct = obj.value;
	disOnChangeAct = toNum($.trim($("#disP"+n).val()));
	
}

function stFocus(obj,l){
	var obj1 = $("#"+obj.getAttribute("id"));
	var n = obj1.parent().parent().attr('val');
	stDolOnChangeAct = obj.value;
	stOnChangeAct = toNum($.trim($("#stP"+n).val()));
	
}
function vatFocus(obj,l){
	var obj1 = $("#"+obj.getAttribute("id"));
	var n = obj1.parent().parent().attr('val');
	vatDolOnChangeAct = obj.value;
	vatOnChangeAct = toNum($.trim($("#vatP"+n).val()));
	
}
function vatDolChange(obj,l){
	var num = toNum(obj.value);
	var obj1 = $("#"+obj.getAttribute("id"));
	var n = obj1.parent().parent().attr('val');
	
	
	obj.value = num.toFixed(l).replace(/(\d)(?=(\d{3})+\.)/g, "$1,");
	
	var up = toNum($.trim($("#up"+n).val()));
	var qty = toNum($.trim($("#qty"+n).val()));
	var disDol = toNum($.trim($("#disDol"+n).val()));
	var stDol = toNum($.trim($("#stDol"+n).val()));
	
	var priceFactor = toNum($("#priceFactor"+n).val());
	if(priceFactor == 0){
		priceFactor = 1;
		$("#priceFactor"+n).val(formatNumByLength(priceFactor,4));
	}
	
	var vatP = 0;
	if(up*qty != 0 || num*100 != 0)
		vatP = (num*100/((up*qty*priceFactor)-disDol));
	
	$("#vatP"+n).val(formatNumByLength(vatP,5));
	
	calculateByItem(n);
	
	if(obj.value == vatDolOnChangeAct ){
		$("#vatP"+n).val(formatNumByLength(vatOnChangeAct,5));
	}else{
		disOnChangeAct = formatNumByLength(vatP,5);
	}
	
	
	
	totalSalOrd();
	showOneLocation(n);
}
function vatPerChange(obj,l){
	var num = toNum(obj.value);
	var obj1 = $("#"+obj.getAttribute("id"));
	var n = obj1.parent().parent().attr('val');
	
			
	obj.value = num.toFixed(l).replace(/(\d)(?=(\d{3})+\.)/g, "$1,");
	vatOnChangeAct = obj.value;
	calculateByItem(n);
	
	vatDolOnChangeAct = toNum($.trim($("#vatDol"+n).val()));
	totalSalOrd();
	showOneLocation(n);
}
function stDolChange(obj,l){
	var num = toNum(obj.value);
	var obj1 = $("#"+obj.getAttribute("id"));
	var n = obj1.parent().parent().attr('val');
	
	
	obj.value = num.toFixed(l).replace(/(\d)(?=(\d{3})+\.)/g, "$1,");
	var disDol = toNum($.trim($("#disDol"+n).val()));
	var up = toNum($.trim($("#up"+n).val()));
	var qty = toNum($.trim($("#qty"+n).val()));
	var priceFactor = toNum($("#priceFactor"+n).val());
	if(priceFactor == 0){
		priceFactor = 1;
		$("#priceFactor"+n).val(formatNumByLength(priceFactor,4));
	}
	var stP = 0;
	if(up*qty != 0 || num*100 != 0)
		stP = (num*100/((up*qty*priceFactor)-disDol));
	
	$("#stP"+n).val(formatNumByLength(stP,5));
	
	calculateByItem(n);
	
	if(obj.value == stDolOnChangeAct ){
		$("#stP"+n).val(formatNumByLength(stOnChangeAct,5));
	}else{
		stOnChangeAct = formatNumByLength(stP,5);
	}
	
	totalSalOrd();
	showOneLocation(n);
}
function stPerChange(obj,l){
	var num = toNum(obj.value);
	var obj1 = $("#"+obj.getAttribute("id"));
	var n = obj1.parent().parent().attr('val');
	
			
	obj.value = num.toFixed(l).replace(/(\d)(?=(\d{3})+\.)/g, "$1,");
	
	stOnChangeAct = obj.value;
	calculateByItem(n);
	
	stDolOnChangeAct = toNum($.trim($("#stDol"+n).val()));
	
	totalSalOrd();
	showOneLocation(n);
}

function calculateByItem(n){
	
	var qty    = toNum($("#qty"+n).val());
	var up     = toNum($("#up"+n).val());
	var disP   = toNum($("#disP"+n).val());
	var disDol = toNum($("#disDol"+n).val());
	var vatP   = toNum($("#vatP"+n).val());
	var vatDol = toNum($("#vatDol"+n).val());
	var stP    = toNum($("#stP"+n).val());
	var stDol  = toNum($("#stDol"+n).val());
	var priceFactor = toNum($("#priceFactor"+n).val());
	
	if(priceFactor == 0){
		priceFactor = 1;
		$("#priceFactor"+n).val(formatNumByLength(priceFactor,4));
	}
	var tAmt = up*qty*priceFactor;

	if(tAmt != 0){
		
		disDol = (tAmt*disP)/100;
		vatDol = ((tAmt-disDol)*vatP)/100;
		stDol = ((tAmt-disDol)*stP)/100;
		
		$("#disDol"+n).val(formatNumByLength(disDol,2));
		$("#vatDol"+n).val(formatNumByLength(vatDol,2));
		$("#stDol"+n).val(formatNumByLength(stDol,2));
		
		
	}else{
		$("#disDol"+n).val(formatNumByLength(0,2));
		$("#vatDol"+n).val(formatNumByLength(0,2));
		$("#stDol"+n).val(formatNumByLength(0,2));
		
		$("#disP"+n).val(formatNumByLength(0,4));
		$("#vatP"+n).val(formatNumByLength(0,4));
		$("#stP"+n).val(formatNumByLength(0,4));	
		
		disP   = 0;
		disDol = 0;
		vatP   = 0;
		vatDol = 0;
		stP    = 0;
		stDol  = 0;
	}
	
	var nTAmt = tAmt-disDol+vatDol+stDol;
	
	$("#tAmt"+n).val(formatNumByLength(tAmt,2));
	$("#nTAmt"+n).val(formatNumByLength(nTAmt,2));
	
	totalSTandVAT();
	
}



function actItemChange(obj){
	var obj = $("#"+obj.getAttribute("id"));
	if(obj.val() !=''){
		obj.next().children().children().attr('style','border: 1px solid #d2d6de;');
		var priceCode = $.trim($("#priceCode").val());
		selectItem = JSON.parse($.ajax({
			url: server+"quote/itemChange",
			method: "POST",
			async: false,
			data: JSON.stringify({
				"itemId" : obj.val(),
				"priceCode" : priceCode
				}),
			beforeSend: function(xhr) {
			    xhr.setRequestHeader("Accept", "application/json");
			    xhr.setRequestHeader("Content-Type", "application/json");
			    }
		}).responseText);
		
		
		
		if(selectItem.MESSAGE == "SUCCESS"){
			selectItem = selectItem.DATA;
			var n = obj.parent().parent().attr('val');
			$("#up"+n).val(formatNumByLength(selectItem.up, 6));
			$("#uom"+n+" option[value='"+selectItem.UOM+"']").attr('selected','selected');				
			$("#reportPrice"+n).val(formatNumByLength(selectItem.rp, 6));
		}else{
			$("#up"+n).val(formatNumByLength(0, 6));
			$("#uom"+n+" option[value='']").attr('selected','selected');				
			$("#reportPrice"+n).val(formatNumByLength(0, 6));
		}
		
		actUomChange(document.getElementById('uom'+n));		
		
		$("#disP"+n).val(formatNumByLength(0, 2));
		$("#disDol"+n).val(formatNumByLength(0, 2));
		
		$("#priceFactor"+n).val(formatNumByLength(1, 4));
		$("#vatP"+n).val(formatNumByLength(0, 2));
		$("#vatDol"+n).val(formatNumByLength(0, 2));
		$("#stP"+n).val(formatNumByLength(0, 2));
		$("#stDol"+n).val(formatNumByLength(0, 2));
		
		calculateByItem(n);
		
		
		if($("#listItem tr").length<2){
			setValueById('txtTSalOrd', formatNumByLength(0, 2));
			setValueById('txtInvDis', formatNumByLength(0, 2));
			setValueById('txtNetInv', formatNumByLength(0, 2));
			setValueById('txtTPTDate', formatNumByLength(0, 2));
			setValueById('txtAmtDue', formatNumByLength(0, 2));
		}
		
		
		setQtyAvailableToRow(n);
		
	}else{
		obj.next().children().children().attr('style','border: 1px solid #dd4b39;');
	}
	showOneLocation(n);
}
function actLocChange(obj){
	var obj = $("#"+obj.getAttribute("id"));
	var n = obj.parent().parent().attr('val');
	if(obj.val() !=''){
		setQtyAvailableToRow(n);
		obj.next().children().children().attr('style','border: 1px solid #d2d6de;');
	}else{
		obj.next().children().children().attr('style','border: 1px solid #dd4b39;');
	}
	showOneLocation(n);
}
function actUomChange(obj){
	var obj = $("#"+obj.getAttribute("id"));
	if(obj.val() !=''){
		obj.attr('style',styUom);
	}else{
		obj.attr('style','border: 1px solid #dd4b39;'+styUom);
	}
}


function select2Init(initId){
	$('#'+initId).select2();
	
}
function removeRowItem(RowID){
	swal({   
			title: "Are you sure you want to delete this line?",   
			text: "",   
			type: "warning",   
			showCancelButton: true,   
			confirmButtonColor: "#DD6B55",   
			confirmButtonText: "Yes",   
			cancelButtonText: "No",   
			closeOnConfirm: false,   
			closeOnCancel: false 
		}, function(isConfirm){   
			if (isConfirm) {			
				$("#RowItem"+RowID).remove();
				totalSalOrd();
				showAllLocation();
				clearOneLocation();
				
				totalSTandVAT();
				
				if($("#listItem tr").length<1){
					clearAllLocation();
					clearTotalOrd();
					cleartotalSTandVAT();
				}
				swal({   title: "Deleted!", type: "success",   text: "",   timer: 2000,   showConfirmButton: false });
			} else {     							
				swal({   title: "Cancelled!", type: "error",   text: "",   timer: 2000,   showConfirmButton: false });
				
			} 
		});	
}


function addShipToAdd(data){
	$('#shipToAdd').empty();
	$('#shipToAdd').append("<option></option>");
	for(i=0;i<data.length;i++){
		if(data[i].AID !='')
			$('#shipToAdd').append("<option value='"+data[i].AID+"'>"+data[i].Address+"</option>");
	}
	$('#shipToAdd').select2();
}


function checkMaster(){
	var cust = $("#customer").val();
	var emp =  $("#employee").val();
	var priceCode = $("#priceCode").val();
	var orDate = $('#orderDate').val();
	var duedate = $('#duedate').val();
	
	if(cust == ''){
		$("#customer").next().children().children().attr('style','border: 1px solid #dd4b39;');
	}
	if(emp == ''){
		$("#employee").next().children().children().attr('style','border: 1px solid #dd4b39;');
	}
	if(priceCode == ''){
		$("#priceCode").next().children().children().attr('style','border: 1px solid #dd4b39;');
	}
	
	if(cust == '' || emp == '' || priceCode == '' || checkDate(orDate)==false || checkDate(duedate)==false){
		return false;
	}
	return true;
	
}

function checkDetail(){
	var tr = $("#listItem tr");
	if(tr.length>0){
		for(i=0;i<tr.length;i++){			
			var n =tr.eq(i).attr('val');
			var itemR = $("#item"+n).val();
			var locR = $("#location"+n).val();
			var uomR = $("#uom"+n).val();
			var qtyR = toNum($("#qty"+n).val());
			
			if(itemR == ''){
				$("#item"+n).next().children().children().attr('style','border: 1px solid #dd4b39;');
			}
			if(locR == ''){
				$("#location"+n).next().children().children().attr('style','border: 1px solid #dd4b39;');
			}			
			if(uomR == ''){
				$("#uom"+n).attr('style','border: 1px solid #dd4b39;'+styUom);
			}			
			if(qtyR <=0){
				$("#qty"+n).attr('style','border: 1px solid #dd4b39;'+styQty);
			}
			if(itemR == '' || locR == '' || uomR == '' || qtyR <=0)
				return false;
		}
	}
	return true;
}
function checkLine(){
	var tr = $("#listItem tr");
	if(tr.length>0){
		return true;
	}
	return false;
}
function totalSalOrd(){
	var tr = $("#listItem tr");
	var totalSalOrd = 0;
	if(tr.length>0){
		for(i=0;i<tr.length;i++){	
			var n =tr.eq(i).attr('val');
			totalSalOrd += toNum($("#nTAmt"+n).val());
		}
		
	}
	
	setValueById('txtTSalOrd', formatNumByLength(totalSalOrd, 2));
	
	disInvoive();
	netInvoice();
	
}
function totalSTandVAT(){
	var tr = $("#listItem tr");
	var st = 0;
	var vat = 0;
	if(tr.length>0){
		for(i=0;i<tr.length;i++){	
			var n =tr.eq(i).attr('val');
			st += toNum($("#stDol"+n).val());
			vat += toNum($("#vatDol"+n).val());
		}
		
	}
	
	setValueById('txtTST', formatNumByLength(st, 2));
	setValueById('txtTVAT', formatNumByLength(vat, 2));	
}
function netInvoice(){
	var totalSalOrd =  toNum($("#txtTSalOrd").val());	
	var disInv =  toNum($("#txtInvDis").val());	
	setValueById('txtNetInv', formatNumAccByLength((totalSalOrd-disInv), 2));
	setValueById('txtAmtDue', formatNumAccByLength((totalSalOrd-disInv), 2));
}

function disInvoive(){
	var disInv = toNum($("#txtDisInv").val());
	if(disInv >= 0){
		var totalSalOrd =  toNum($("#txtTSalOrd").val());		
		$("#txtInvDis").attr('data-persent',disInv);		
		setValueById('txtInvDis', formatNumByLength((disInv*totalSalOrd/100), 2));				
	}
}

function setQtyAvailableToRow(n){
	var locationRow = $("#location"+n).val();
	var itemRow = $("#item"+n).val();
	if(itemRow != '' && locationRow != ''){
		var qtyAvailable = JSON.parse($.ajax({
			url: server+"quote/qty-available",
			method: "POST",
			async: false,
			data: JSON.stringify({
				"itemId" : itemRow,
				"locationId" : locationRow
				}),
			beforeSend: function(xhr) {
			    xhr.setRequestHeader("Accept", "application/json");
			    xhr.setRequestHeader("Content-Type", "application/json");
			    }
		}).responseText);
		if(qtyAvailable.MESSAGE == "SUCCESS"){
			$("#RowItem"+n).attr('data-qty-available',qtyAvailable.DATA.Qty);
		}else{
			$("#RowItem"+n).attr('data-qty-available',0);
		}
		
	}else{
		$("#RowItem"+n).attr('data-qty-available',0);
	}
	
	showOneLocation(n);
	showAllLocation();
}


function showDetailRow(obj){
	var obj = $("#"+obj.getAttribute("id"));
	var n = obj.attr('val');
	
	showOneLocation(n);
	
}
function showOneLocation(n){
	var qtyAv = $("#RowItem"+n).attr('data-qty-available');
	var location = $("#location"+n).val();
	var uom = $("#uom"+n).val();
	
	
	setValueById('txtLocDetail',location);
	setValueById('txtQtyAvailable1',formatNumAccByLength(qtyAv,2));
	setValueById('txtUom1',uom);
	setValueById('txtUomAll',uom);
}

function clearOneLocation(){
	setValueById('txtLocDetail','');
	setValueById('txtQtyAvailable1','');
	setValueById('txtUom1','');
}

function showAllLocation(){
	var tr = $("#listItem tr");
	var totalQtyAv = 0;
	if(tr.length>0){
		for(i=0;i<tr.length;i++){	
			var n =tr.eq(i).attr('val');
			totalQtyAv += toNum(tr.eq(i).attr('data-qty-available'));
		}
	}
	
	setValueById('txtQtyAvailableAll',formatNumAccByLength(totalQtyAv,2));
}

function TNTotal(vat,st,qty,up,dis){
	return (qty*up)-dis+vat+st;
}


function clearAllLocation(){
	setValueById('txtQtyAvailableAll','');
	setValueById('txtUomAll','');
}
function cleartotalSTandVAT(){
	setValueById('txtTVAT','');
	setValueById('txtTST','');
}
function clearTotalOrd(){
	setValueById('txtTSalOrd', '');
	setValueById('txtInvDis', '');
	setValueById('txtNetInv', '');
	setValueById('txtTPTDate', '');
	setValueById('txtAmtDue', '');
}
function saleOrder(){
	
	// master
	
	var entryNo = SalID;	
	var salOrdType = $.trim($("#salOrdType").val());
	var customer = $.trim($("#customer").val());
	var employee = $.trim($("#employee").val());
	var classCodeMaster = $.trim($("#classCodeMaster").val());
	var orderDate = getDateById("orderDate");
	var duedate = getDateById("duedate");
	var reference = $.trim($("#reference").val());
	var priceCode = $.trim($("#priceCode").val());
	var shipToAdd = $.trim($("#shipToAdd").val());
	var remark = $.trim($("#remark").val());
	var disInvDol = toNum($.trim($("#txtInvDis").val()));
	var disInvP = toNum($.trim($("#txtInvDis").attr('data-persent')));
	var TotalAmt = 0;
	var TotalDis = 0;
	var NTAmt = toNum($.trim($("#txtNetInv").val()));
	var totalSTax = toNum($.trim($("#txtTST").val()));
	var totalVTax = toNum($.trim($("#txtTVAT").val()));
	
	
	var tr = $("#listItem tr");
	var detail=[];
	if(tr.length>0){
		for(i=0;i<tr.length;i++){	
			var n =tr.eq(i).attr('val');
			detail.push({
				saleId : entryNo,
				lineNo : i+1,
				itemId: getValueStringById('item'+n),
				locationId: getValueStringById('location'+n),
				classId: getValueStringById('classCode'+n),
				uomId: getValueStringById('uom'+n),
				saleQuantity : getValueById('qty'+n),
				unitPrice : getValueById('up'+n),
				factor: getValueById('priceFactor'+n),
				reportPrice: getValueById('reportPrice'+n),
				disPer: getValueById('disP'+n),
				disDol: getValueById('disDol'+n),
				vtaxPer: getValueById('vatP'+n),
				vtaxDol: getValueById('vatDol'+n),
				staxPer: getValueById('stP'+n),
				staxDol: getValueById('stDol'+n),
				totalAmt: getValueById('tAmt'+n),
				netTotalAmt: getValueById('nTAmt'+n)
			});
			TotalAmt += getValueById('tAmt'+n);
			TotalDis += getValueById('disDol'+n);
		}
		
	}
	
	var master ={
			saleId : entryNo,
			saleType : salOrdType,
			custId : customer,
			empId : employee,
			classId : classCodeMaster,
			saleDate : orderDate,
			dueDate : duedate,
			priceCode : priceCode,
			shipTo : shipToAdd,
			remark : remark,
			saleReference : reference,
			disInvDol : disInvDol,
			disInvPer : disInvP,
			totalAmount : TotalAmt,
			netTotalAmt:NTAmt,
			totalDis : TotalDis,
			totalSTax : totalSTax,
			totalVTax : totalVTax,
			saleOrderDetails: detail
		};
	
	
	$.ajax({ 
		url: server+"sale-order/edit-sale-order",
		method: "POST",
		async: false,
		data: JSON.stringify(master),
		beforeSend: function(xhr) {
		    xhr.setRequestHeader("Accept", "application/json");
		    xhr.setRequestHeader("Content-Type", "application/json");
	    }, 
	    success: function(result){
	    	if(result.MESSAGE == "UPDATED"){
				swal({   
					title: "Successfully!",   
					text: "The sale order with record id: '"+entryNo+"'  was successfully saved!",   
					type: "success",   
					showCancelButton: true,   
					confirmButtonColor: "#8cd4f5",   
					confirmButtonText: "Ok",   
					cancelButtonText: "",   
					closeOnConfirm: false,   
					closeOnCancel: false ,
					showCancelButton: false
				}, function(isConfirm){   
					if (isConfirm) {     
						location.reload();  
					} else {     
						location.reload();
					}
				});
			}else{
				swal("Unsuccessful!", result.MESSAGE, "error");
			}
	    	
		}
	    
	});

}

function cancel(){
	document.location.href = server+"sale-order";
}

