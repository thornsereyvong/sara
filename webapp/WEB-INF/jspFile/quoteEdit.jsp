<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>

<div class="content-wrapper">
	<section class="content-header">
		<h1>
			Edit Quotation <small></small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="<?php echo $server;?>"><i class="fa fa-home"></i> Home</a></li>
			<li class="active">Edit Quotation</li>
		</ol>
	</section>
	
	<section class="content">
		<div class="box box-info">
			<div class="box-header with-border">
				<button type="submit" name="btnSave" id="btnSave"
					class="btn btn-primary">
					<i class="fa  fa-save"></i> &nbsp;Save
				</button>
				<button type="button" onclick="cancel()" name="btnDiscard" id="btnDiscard"
					class="btn btn-danger">
					<i class="fa fa-remove"></i> &nbsp;Discard
				</button>
				
				<div class="box-tools pull-right">
					<button class="btn btn-box-tool" data-widget="collapse">
						<i class="fa fa-minus"></i>
					</button>
				</div>
			</div>
			<div class="box-body">
				<div class="row">
					<div class="col-md-12">	
							
						<div class="col-md-6">
							<div class="col-md-6">
								<div class="form-group">
									<label>Entry No<span class="text-red"> *</span></label> 
									<input class="form-control" disabled value="" name="entryNo" id="entryNo" type="text" value="" placeholder="***New***">
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Post Status</label> 
									<input class="form-control" disabled="" id="postStatus" name="postStatus" type="text" placeholder="Post Status">
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Customer<span class="text-red"> *</span></label> 
									<select id="customer" name="customer" class="form-control select2 input-lg" style="width: 100%;">
										<option selected="selected" value="">Select A Customer</option>
										
									</select>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Sale Rep. ID <span class="text-red"> *</span></label> 
									<select name="employee" id="employee" class="form-control select2 input-lg" style="width: 100%;">
										<option value="" selected="selected">Select A Employee</option>
										 
									</select>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Price Code <span class="text-red">  *</span></label> 
									<select name="priceCode" id="priceCode" class="form-control select2 input-lg" style="width: 100%;">
										<option value="">Select A Price Code</option>
										 
									</select>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Class</label> 
									<select id="classCodeMaster" name="classCodeMaster" class="form-control select2 input-lg" style="width: 100%;">
										<option selected="selected" value="">Select A Class</option>
										
									</select>
								</div>
							</div>
							
							
							
						</div>
						<div class="col-md-6">
							<div class="col-md-6">
								<div class="form-group">
									<label>Quotation Date<span class="text-red">  *</span></label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input   data-date-format="dd-M-yyyy"
											data-default-date=""
											value=""
											name="quoteDate" id="quoteDate" type="text"
											class="form-control pull-right active">
									</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Start Date<span class="text-red">  *</span></label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input   data-date-format="dd-M-yyyy"
											data-default-date=""
											value=""
											name="startDate" id="startDate" type="text"
											class="form-control pull-right active">
									</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Expire Date<span class="text-red">  *</span></label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input   data-date-format="dd-M-yyyy"
											data-default-date=""
											value=""
											name="expireDate" id="expireDate" type="text"
											class="form-control pull-right active">
									</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Reference</label> 
									<input class="form-control" id="reference" name="reference" type="text" placeholder="Reference...">
								</div>
							</div>
							<div class="col-md-12">
								<div class="form-group">
									<label>Ship to Address <span class="text-red"></span></label> 
									<select name="shipToAdd" id="shipToAdd" class="form-control select2 input-lg" style="width: 100%;">
										 
									</select>
								</div>
							</div>
						</div>
						<div class="col-md-12">
					
							<div class="col-md-12">
								<div class="form-group">
									<label>Remark</label> 
									<input class="form-control" id="remark" name="remark" type="text" placeholder="Remark">
								</div>
							</div>
						</div>
						<form id="frmSaleOrder" action="" method="post">
						<div class="col-md-12" style="padding-top: 25px;">
								<div class="col-md-12  table-responsive no-padding">
									<table id="table-content" class="table table-hover">
										<thead>								
											<tr>
												<th>Item<span class="text-red"> *</span></th>
												<th>Location ID<span class="text-red"> *</span></th>
												<th>Class ID</th>
												<th>UOM ID <span class="text-red"> *</span></th>
												<th>Quantity <span class="text-red"> *</span></th>
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
												<th colspan="2">Net Total Amount</th>
											</tr>	
										</thead>
										<tbody class="cursor_move" id="listItem">
										
											
										</tbody>
										<tfoot>
											<tr>
												<th colspan="11">
													<button type="button" name="addAnItem" id="addAnItem"
														class="btn btn-success">
														<i class="fa  fa-plus-circle"></i> &nbsp;Add An Item
													</button>
												</th>
											</tr>
										</tfoot>
									</table>
								
								</div>
							</div>
						</form>
				
					</div>
						
					</div>
					<!-- <div class="clearfix"></div> -->
					
					
				</div>
				
			<br><br>
			<div class="box-footer" style="border-top: 1px solid #d8d8d8;">
			
			
				<div class="row">
					<div class="col-md-12">
						
						<div class="col-md-6">
							<div class="col-md-6">
								<div class="form-group">
									<label>Total Specific Tax</label> 
									<input disabled class="form-control" id="txtTST" type="text" placeholder="">
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Total VAT</label> 
									<input disabled id="txtTVAT" class="form-control" type="text" placeholder="">
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label>Location</label> 
									<input disabled class="form-control" id="txtLocDetail" type="text" placeholder="">
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label>Quantity Available</label> 
									<input disabled id="txtQtyAvailable1" class="form-control" type="text" placeholder="">
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label>UOM</label> 
									<input disabled  id="txtUom1" class="form-control" type="text" placeholder="">
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label>All Location</label> 
									<input disabled class="form-control" value="All" type="text" placeholder="">
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label>Quantity Available</label> 
									<input disabled class="form-control" id="txtQtyAvailableAll" type="text" placeholder="">
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label>UOM</label> 
									<input disabled id="txtUomAll" class="form-control" type="text" placeholder="">
								</div>
							</div>
						</div>
						<div class="col-md-3">
						</div>
						<div class="col-md-3">
							<div class="col-md-12">
								<div class="form-group">
									<label>Total Sale Order</label> 
									<input disabled id="txtTSalOrd" class="form-control text-align-right" type="text" placeholder="">
								</div>
							</div>
							<div class="col-md-12">
								<label>Invoice Discount<span></span></label> 
								<div class="input-group">
				                    <span class="input-group-addon btn" id="invDis" style="cursor:pointer"><i class="fa  fa-play"></i></span>
				                    <input disabled type="text" id="txtInvDis" data-persent="0" class="form-control text-align-right" placeholder="">
				                  </div>
				                  <br>
							</div>
							<div class="col-md-12">
								<div class="form-group">
									<label> Net Invoice <span></span></label> 
									<input disabled id="txtNetInv" class="form-control text-align-right" type="text" placeholder="">
								</div>
							</div>
							
							<div class="col-md-12">
									<label>Total Payment To Date</label> 
									
								<div class="input-group">
				                    <span class="input-group-addon" style="cursor:pointer"><i class="fa  fa-play"></i></span>
				                    <input disabled type="text" id="txtTPTDate" class="form-control text-align-right" placeholder="">
				                  </div>
				                  <br>
							</div>
							<div class="col-md-12">
								<div class="form-group">
									<label>Amount Due</label> 
									<input disabled id="txtAmtDue" class="form-control text-align-right" type="text" placeholder="">
								</div>
							</div>
						</div>
					</div>
					
				</div>
				
				
			</div>
			<div id="errors"></div>
		</div>
				
			<input type="hidden" id="alertMes" data-toggle="modal" data-target="#myModal" />
			<div class="modal fade modal-danger" id="myModal" role="dialog">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Require Field!</h4>
						</div>
						<div class="modal-body">
							<p id="alertMsgText">Please input *field require.</p>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-outline pull-right"
								data-dismiss="modal">Close</button>

						</div>
					</div>

				</div>
			</div>
			<input type="hidden" id="alertMesError" data-toggle="modal" data-target="#myError" />
			<div class="modal fade modal-danger" id="myError" role="dialog">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Error!</h4>
						</div>
						<div class="modal-body">
							<p id="txtMyError">Please try again...</p>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-outline pull-right" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
			<input type="hidden" id="alertMesSucess" data-toggle="modal" data-target="#mySuccess" />
			<div class="modal fade modal-success" id="mySuccess" role="dialog">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
							<h4 class="modal-title">Successful!</h4>
						</div>
						<div class="modal-body">
							<p id="txtResultSuccess"></p>
						</div>
						<div class="modal-footer">
							<!-- <button type="button" id="btnSucCancel" class="btn btn-outline" data-dismiss="modal">Cancel</button>&nbsp;&nbsp; -->
							<button type="button" id="btnSucOk" class="btn btn-outline pull-right" data-dismiss="modal">Ok</button>
							
						</div>
					</div>
				</div>
			</div>
			<input type="hidden" id="alertMesConfirm" data-toggle="modal" data-target="#myConfirm" />
			<div class="modal fade modal-info" id="myConfirm" role="dialog">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Confirmation!</h4>
						</div>
						<div class="modal-body">
							<p>Are you sure you want to delete this line?</p>
						</div>
						<div class="modal-footer">
							<button type="button" id="btnConfirmCancel" class="btn btn-outline" data-dismiss="modal">Cancel</button>&nbsp;&nbsp;
							<button type="button" id="btnConfirmOk" class="btn btn-outline pull-right" data-dismiss="modal">Ok</button>
							
						</div>
					</div>
				</div>
			</div>
			<input type="hidden" id="invDisDia" data-toggle="modal" data-target="#frmInvDisDia" />
			<div class="modal fade modal-default" id="frmInvDisDia" role="dialog">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Discount Invoice</h4>
						</div>
						<div class="modal-body">
							<div class="form-group">
								<label>Discount Invoice % :</label> 
								<input id="txtDisInv" onkeypress='return isPersent(this,event)' class="form-control" type="text" placeholder="">
							</div>
							
						</div>
						<div class="modal-footer">
							<button type="button" id="btnInvDisCancel" class="btn btn-danger" data-dismiss="modal">Cancel</button>&nbsp;&nbsp;
							<button type="button" id="btnInvDisOk" class="btn btn-primary pull-right" data-dismiss="modal">Ok</button>
							
						</div>
					</div>
				</div>
			</div>
	</section>
	
</div>

<jsp:include page="${request.contextPath}/footer"></jsp:include>

<script src="${pageContext.request.contextPath}/resources/js.mine/quote/quote-edit.js"></script>
<script src="${pageContext.request.contextPath}/resources/js.mine/function.mine.js"></script>
<script>

var server = "${pageContext.request.contextPath}/";
var index=0;
var SalID = "<%=request.getAttribute("saleId") %>";
var content = JSON.parse($.ajax({ 
	url: server+"quote/list-content-by-id/"+SalID,
	method: "GET",
	async: false,
}).responseText);

var tagItem = "";
var LItem = content.QUOTE_STARTUP[0].item;
var tagLocation ="";
var LLocation = content.QUOTE_STARTUP[0].location;
var tagClass ="";
var LClass = content.QUOTE_STARTUP[0].classCode;
var tagUom ="";
var LUom = content.QUOTE_STARTUP[0].uom;

var LCustomer = content.QUOTE_STARTUP[0].customer;
var LPriceCode = content.QUOTE_STARTUP[0].priceCode;
var LEmp = content.QUOTE_STARTUP[0].employee;
if(content.MESSAGE == "SUCCESS"){
	if(LItem.length > 0){
		for(var i=0;i<LItem.length;i++){
			tagItem += "<option value="+LItem[i].ItemID+">["+LItem[i].ItemID+"] "+LItem[i].ItemName+"</option>";
		}
	}
	if(LLocation.length > 0){
		for(var i=0;i<LLocation.length;i++){
			tagLocation += "<option value="+LLocation[i].LocationID+">["+LLocation[i].LocationID+"] "+LLocation[i].LocationName+"</option>";
		}
	}
	if(LClass.length > 0){
		for(var i=0;i<LClass.length;i++){
			tagClass += "<option value="+LClass[i].ClassID+">["+LClass[i].ClassID+"] "+LClass[i].ClassName+"</option>";
		}
		$("#classCodeMaster").append(tagClass);
	}
	if(LUom.length > 0){
		for(var i=0;i<LUom.length;i++){
			tagUom += "<option value="+LUom[i].UomID+">["+LUom[i].UomID+"] "+LUom[i].UomName+"</option>";
		}
	}
	if(LCustomer.length > 0){
		for(var i=0;i<LCustomer.length;i++){
			 $("#customer").append("<option value="+LCustomer[i].CustID+">["+LCustomer[i].CustID+"] "+LCustomer[i].CustName+"</option>");
		}
	}
	if(LPriceCode.length > 0){
		for(var i=0;i<LPriceCode.length;i++){
			$("#priceCode").append("<option value='"+LPriceCode[i].PriceCode+"' > ["+LPriceCode[i].PriceCode+"] "+LPriceCode[i].Description+"</option>");
		}
	}
	if(LEmp.length > 0){
		for(var i=0;i<LEmp.length;i++){
			 $("#employee").append("<option value="+LEmp[i].EmpID+">["+LEmp[i].EmpID+"] "+LEmp[i].EmpName+"</option>");
		}
	}
	
	
	
}


function addAnItem(){
	var addAnItem ="";
	addAnItem += "<tr onclick='showDetailRow(this)' data-qty-available='0' id='RowItem"+index+"' val='"+index+"'>";	
	
	addAnItem += "<td><select title='Item is required.' onChange='actItemChange(this)' style='width:300px' id='item"+index+"' name='item' class='form-control select2'> <option selected='selected' value=''></option>"+tagItem+"</select></td>";	
    addAnItem += "<td>"+
		         "<select title='Location is required.' onChange='actLocChange(this)' name='location' id='location"+index+"' class='form-control select2 input-lg' style='width: 200px;'>"+
			     "<option value='' selected='selected'></option>"+tagLocation+"</select></td>";
	addAnItem += "<td>"+
		         "<select name='classCode' id='classCode"+index+"' class='form-control' style='width: 100px;'>"+
			     "<option value='' selected='selected'></option>"+tagClass+"</select></td>";
	addAnItem += "<td>"+
		         "<select onfocusout='actUomChange(this)' onChange='actUomChange(this)' name='uom' title='UOM is required.' id='uom"+index+"' class='form-control width-100' >"+
			     "<option value=''></option>"+tagUom+ "</select></td>";
	addAnItem += "<td> <input onfocusout='qtyChange(this,4)' onkeypress='return isNumeric(this,event)' title='Quantity is bigger than 0.'  name='qty' id='qty"+index+"' class='form-control' style='width: 80px;' type='text' placeholder=''></td>"+
				 "<td> <input onfocusout='upChange(this,6)' onkeypress='return isNumeric(this,event)'  name='up' id='up"+index+"' class='form-control' style='width: 80px;' type='text' placeholder=''></td>"+								
				 "<td> <input onfocusout='priceFactorChange(this,4)' onkeypress='return isNumeric(this,event)' title='Price factor can not equal 0.'  name='priceFactor' id='priceFactor"+index+"' class='form-control' style='width: 80px;' type='text' placeholder=''></td>"+
				 "<td> <input disabled onfocusout='reportPriceChange(this,6)' onkeypress='return isNumeric(this,event)'  name='reportPrice' id='reportPrice"+index+"' class='form-control' style='width: 80px;' type='text' placeholder=''></td>"+
				 "<td> <input disabled onfocusout='fmNum(this,2,0)' onkeypress='return isNumeric(this,event)'  name='tAmt' id='tAmt"+index+"' class='form-control' style='width: 90px;' type='text' placeholder=''></td>"+
				 "<td> <input onfocusout='disPerChange(this,5)' onkeypress='return isPersent(this,event)'  name='disP' id='disP"+index+"' class='form-control' style='width: 80px;' type='text' placeholder=''></td>"+
				 "<td> <input onfocus='disFocus(this,2)' onfocusout='disDolChange(this,2)' onkeypress='return isNumeric(this,event)'  name='disDol' id='disDol"+index+"' class='form-control' style='width: 80px;' type='text' placeholder=''></td>"+				
				 "<td> <input onfocusout='vatPerChange(this,5)' onkeypress='return isPersent(this,event)'  name='vatP' id='vatP"+index+"' class='form-control' style='width: 80px;' type='text' placeholder=''></td>"+
				 "<td> <input onfocus='vatFocus(this,2)' onfocusout='vatDolChange(this,2)' onkeypress='return isNumeric(this,event)'  name='vatDol' id='vatDol"+index+"' class='form-control' style='width: 80px;' type='text' placeholder=''></td>"+				
				 "<td> <input onfocusout='stPerChange(this,5)' onkeypress='return isPersent(this,event)'  name='stP' id='stP"+index+"' class='form-control' style='width: 80px;' type='text' placeholder=''></td>"+
				 "<td> <input onfocus='stFocus(this,2)' onfocusout='stDolChange(this,2)' onkeypress='return isNumeric(this,event)'  name='stDol' id='stDol"+index+"' class='form-control' style='width: 80px;' type='text' placeholder=''></td>"+
				 "<td> <input disabled onfocusout='fmNum(this,2,0)' onkeypress='return isNumeric(this,event)'  name='nTAmt' id='nTAmt"+index+"' class='form-control' style='width: 100px;' type='text' placeholder=''></td>";
	addAnItem += "<td><button onClick='removeRowItem("+index+")' class='btn btn-danger' type='button'><i class='fa  fa-trash'></i></button></td>";
	addAnItem += "</tr>";

	return addAnItem;
}


function listDataSalOrdByID(data){
	if(data != ""){
		
		//alert(data.custId)
		
		setValueById('entryNo', data.saleId);
		$("#customer").select2('val',data.custId);
		$("#employee").select2('val',data.empId);
		$("#priceCode").select2('val',data.priceCode);
		$("#classCodeMaster").select2('val',data.classId);
		
		setValueById('quoteDate', convertFromSQLToDate(data.saleDate));
		setValueById('startDate', convertFromSQLToDate(data.startDate));
		setValueById('expireDate', convertFromSQLToDate(data.expireDate));
		
		setValueById('reference', data.saleReference);
		setValueById('remark', data.remark);
							
		$("#shipToAdd").select2('val',data.shipTo);
		
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
		
		
		
		setValueById('postStatus', data.postStatus);
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

$(function(){
	listDataSalOrdByID(content.DATA);
})


</script>


<!-- /.content-wrapper -->

