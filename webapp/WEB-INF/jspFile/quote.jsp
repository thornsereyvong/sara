<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>

<div class="content-wrapper">
	<section class="content-header">
		<h1>
			Add Quotation<small></small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li class="active">Add Quotation</li>
		</ol>
	</section>
	
	<section class="content">
		<div class="box box-danger">
			<div class="box-header with-border">								
				<button type="button" class="btn btn-info btn-app" name="btnSave" id="btnSave" > <i class="fa fa-save"></i> Save</button> 
				<a class="btn btn-info btn-app" id="btn_clear" onclick="cancel()"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
				<a class="btn btn-info btn-app"  href="${pageContext.request.contextPath}/quote/list"> <i class="fa fa-reply"></i> Back </a>

				<div class="clearfix"></div>								
			</div>
			<div class="box-body">
				<div class="row">
					<div class="col-md-12">	
							
						<div class="col-md-6">
							<div class="col-md-6">
								<div class="form-group">
									<label>Entry No<span class="requrie"> (Required)</span></label> 
									<input class="form-control" name="entryNo" id="entryNo" type="text" value="" placeholder="***New***">
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Post Status</label> 
									<input class="form-control" disabled="" id="postStatus" name="postStatus" type="text" placeholder="Open">
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Customer<span class="requrie"> (Required)</span></label> 
									<select id="customer" name="customer" class="form-control select2-small input-lg" style="width: 100%;">
										<option selected="selected" value="">Select A Customer</option>
										
									</select>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Price Code<span class="requrie"> (Required)</span></label> 
									<select name="priceCode" id="priceCode" class="form-control select2 input-lg" style="width: 100%;">
										<option value="">Select A Price Code</option>
										 
									</select>
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Sale Rep. ID<span class="requrie"> (Required)</span></label> 
									<select name="employee" id="employee" class="form-control select2 input-lg" style="width: 100%;">
										<option value="" selected="selected">Select A Employee</option>
										 
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
							<div class="clearfix"></div>
						</div>
						<div class="col-md-6">
							<div class="col-md-6">
								<div class="form-group">
									<label>Quotation Date<span class="requrie"> (Required)</span></label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input readonly="readonly"  data-date-format="dd-M-yyyy"
											data-default-date=""
											value=""
											name="quoteDate" id="quoteDate" type="text"
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
							<div class="clearfix"></div>
							<div class="col-md-6">
							
								<div class="date-control">
									<label for="startDate">Start Date<span class="requrie"> (Required)</span></label>
									<div class="input-group datefield">
										<span class="add-on input-group-addon"><i class="fa fa-calendar"></i></span>
										<input readonly="readonly" id="startDate" name="startDate" class="form-control date" size="16" type="text" value="" validation="none">  			
									</div>
									
								</div>
							
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Expire Date<span class="requrie"> (Required)</span></label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input readonly="readonly"  data-date-format="dd-M-yyyy"
											data-default-date=""
											value=""
											name="expireDate" id="expireDate" type="text"
											class="form-control pull-right active">
									</div>
								</div>
							</div>
							<div class="clearfix"></div>
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
												<th colspan="2">Item<span class="requrie"> (Required)</span></th>
												<th>Location<span class="requrie"> (Required)</span></th>
												<th>UOM<span class="requrie"> (Required)</span></th>
												<th>Quantity<span class="requrie"> (Required)</span></th>
												<th>Unit Price</th>
												<th>Net Total Amount</th>
												<th></th>
											</tr>	
										</thead>
										<tbody class="cursor_move" id="listItem">
										
											
										</tbody>
										<tfoot>
											<tr>
												<th colspan="7">
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
				</div>
				
			<br><br>
			<div class="box-footer" style="border-top: 1px solid #d8d8d8;">
				<div class="row">
					<div class="col-md-12">
						<div class="col-md-6">
							<div class="col-md-4">
								<div class="form-group">
									<label>Credit Limit</label> 
									<input disabled class="form-control" id="txtCLimit" type="text" placeholder="">
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label>Total Specific Tax</label> 
									<input disabled class="form-control" id="txtTST" type="text" placeholder="">
								</div>
							</div>
							<div class="col-md-4">
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
						
						<div class="col-md-3"></div>
						
						<div class="col-md-3">
							<div class="col-md-12">
								<div class="form-group">
									<label>Total Quote</label> 
									<input disabled id="txtTSalOrd" class="form-control text-align-right" type="text" placeholder="">
								</div>
							</div>
							<div class="col-md-12">
								<label>Discount<span></span></label> 
								<div class="input-group">
				                    <span class="input-group-addon btn" id="invDis" style="cursor:pointer"><i class="fa  fa-play"></i></span>
				                    <input disabled type="text" id="txtInvDis" data-persent="0" class="form-control text-align-right" placeholder="">
				                  </div>
				                  <br>
							</div>
							<div class="col-md-12">
								<div class="form-group">
									<label> Net Total Amount <span></span></label> 
									<input disabled id="txtNetInv" class="form-control text-align-right" type="text" placeholder="">
								</div>
							</div>
							
							<div class="col-md-12" style="display:none;">
									<label>Total Payment To Date</label> 
									
								<div class="input-group">
				                    <span class="input-group-addon" style="cursor:pointer"><i class="fa  fa-play"></i></span>
				                    <input disabled type="text" id="txtTPTDate" class="form-control text-align-right" placeholder="">
				                  </div>
				                  <br>
							</div>
							<div class="col-md-12" style="display:none;">
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
			
			
			<input type="hidden" id="btn_show_product" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#frmProduct" />
			<div class="modal fade modal-default" id="frmProduct" role="dialog">
				<div class="modal-dialog  modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" onclick="cancelProductClick()" class="close"
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
												<select onChange="act1ItemChange(this)" class="form-control select2" name="oppItem" id="oppItem" style="width: 100%;">
													<option value="" selected>-- SELECT AN ITEM --</option>
													
												</select>
											</div>
										</div>
										<div class="col-md-6">
											<div class="bootstrap-timepicker">
												<div class="form-group">
													<label>UOM ID <span class="requrie">(Required)</span></label>
													<select class="form-control select2" name="oppUom" id="oppUom" style="width: 100%;">
														<option value="">-- SELECT AN UOM --</option>
														
													</select>
												</div>
											</div>
										</div>
										
										<div class="clearfix"></div>
										<div class="col-md-6">
											<div class="bootstrap-timepicker">
												<div class="form-group">
													<label>Location ID <span class="requrie">(Required)</span></label>
													<select class="form-control select2" name="oppLocation" id="oppLocation" style="width: 100%;">
														<option value="">-- SELECT A LOCATION --</option>
														
													</select>
												</div>
											</div>
										</div>
										<div class="col-md-6">
											<div class="bootstrap-timepicker">
												<div class="form-group">
													<label>Class ID </label>
													<select class="form-control select2" name="oppClassDetail" id="oppClassDetail" style="width: 100%;">
														<option value="">-- SELECT A CLASS --</option>
														
													</select>
												</div>
											</div>
										</div>
										
										<div class="clearfix"></div>
										<div class="col-md-6">
											<div class="form-group">
												<label>Quantity <span class="requrie">(Required)</span></label>
												<input id="oppQty"  onchange="oppQtyChange(this)"  onkeypress='return isNumeric(this,event)' name="oppQty" class="form-control" type="text"
												placeholder="">
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<label>Unit Price <span class="requrie">(Required)</span></label>
												<input onblur="fToNumber(this, 6)" onkeypress='return isNumeric(this,event)' onchange="oppUnitPriceChange(this)" id="oppUnitPrice" name="oppUnitPrice" class="form-control" type="text"
												placeholder="">
											</div>
										</div>
										
										<div class="clearfix"></div>
										<div class="col-md-6">
											<div class="form-group">
												<label>Price Factor<span class="requrie">(Required)</span></label>
												<input id="oppPriceFactor" onblur="fToNumber(this, 4)" onchange="oppPriceFactorChange(this)" onkeypress='return isNumeric(this,event)'  name="oppPriceFactor" class="form-control" type="text"
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
												<label>Discount %</label>
												<input ng-model="oppDisPer" onblur="fToNumber(this, 5)" onchange="oppDisPerChange()" onkeypress='return isPersent(this,event)' id="oppDisPer" name="oppDisPer" class="form-control" type="text"
												placeholder="">
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<label>Discount $</label>
												<input ng-model="oppDisDol" onblur="fToNumber(this, 2)" onchange="oppDisDolChange()" id="oppDisDol" onkeypress='return isNumeric(this,event)' name="oppDisDol" class="form-control" type="text"
												placeholder="">
											</div>
										</div>
										<div class="clearfix"></div>
										<div class="col-md-6">
											<div class="form-group">
												<label>VAT %</label>
												<input ng-model="oppVatPer" onblur="fToNumber(this, 5)" onchange="oppVatPerChange()" onkeypress='return isPersent(this,event)' id="oppVatPer" name="oppVatPer" class="form-control" type="text"
												placeholder="">
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<label>VAT $</label>
												<input ng-model="oppVatDol" onblur="fToNumber(this, 2)" onchange="oppVatDolChange()" id="oppVatDol" onkeypress='return isNumeric(this,event)' name="oppVatDol" class="form-control" type="text"
												placeholder="">
											</div>
										</div>
										<div class="clearfix"></div>
										<div class="col-md-6">
											<div class="form-group">
												<label>ST %</label>
												<input ng-model="oppSTPer" onblur="fToNumber(this, 5)" onchange="oppSTPerChange()" onkeypress='return isPersent(this,event)' id="oppSTPer" name="oppSTPer" class="form-control" type="text"
												placeholder="">
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<label>ST $</label>
												<input ng-model="oppSTDol" onblur="fToNumber(this, 2)" onchange="oppSTDolChange()" id="oppSTDol" onkeypress='return isNumeric(this,event)' name="oppSTDol" class="form-control" type="text"
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
								onclick="cancelProductClick()" name="btnProductCancel"
								class="btn btn-danger" data-dismiss="modal">Cancel</button>
							&nbsp;&nbsp;
							<button type="button" onclick="btnProductSave()" class="btn btn-primary pull-right"
								id="btnProductSave" name="btnProductSave">Save</button>
		
						</div>
					</div>
				</div>
			</div>
			
			
	</section>
	
</div>

<jsp:include page="${request.contextPath}/footer"></jsp:include>

<script src="${pageContext.request.contextPath}/resources/js.mine/quote/quote.js"></script>
<script src="${pageContext.request.contextPath}/resources/js.mine/function.mine.js"></script>
<script>

	var server = "${pageContext.request.contextPath}/";
	var index=0;
	
	var content = JSON.parse($.ajax({ 
		url: server+"quote/list-content",
		method: "GET",
		async: false,
	}).responseText);
	
	
	var empLinkUser = content.DATA[0].empLinkUser;
	var tagItem = "";
	var LItem = content.DATA[0].item;
	var tagLocation ="";
	var LLocation = content.DATA[0].location;
	var tagClass ="";
	var LClass = content.DATA[0].classCode;
	var tagUom ="";
	var LUom = content.DATA[0].uom;
	var LShipToAddress = content.DATA[0].shipToAddress;
	var LCustomer = content.DATA[0].customer;
	var LPriceCode = content.DATA[0].priceCode;
	var LEmp = content.DATA[0].employee;
	
	
	if(content.MESSAGE == "SUCCESS"){
		if(LItem.length > 0){
			for(var i=0;i<LItem.length;i++){
				tagItem += "<option value="+LItem[i].ItemID+">["+LItem[i].ItemID+"] "+fmNull(LItem[i].ItemName)+"</option>";
			}
		}
		if(LLocation.length > 0){
			for(var i=0;i<LLocation.length;i++){
				tagLocation += "<option value="+LLocation[i].LocationID+">["+LLocation[i].LocationID+"] "+fmNull(LLocation[i].LocationName)+"</option>";
			}
		}
		if(LClass.length > 0){
			for(var i=0;i<LClass.length;i++){
				tagClass += "<option value="+LClass[i].ClassID+">["+LClass[i].ClassID+"] "+fmNull(LClass[i].ClassName)+"</option>";
			}
			$("#classCodeMaster").append(tagClass);
		}
		if(LUom.length > 0){
			for(var i=0;i<LUom.length;i++){
				tagUom += "<option value="+LUom[i].UomID+">["+LUom[i].UomID+"] "+fmNull(LUom[i].UomName)+"</option>";
			}
		}
		if(LCustomer.length > 0){
			for(var i=0;i<LCustomer.length;i++){
				 $("#customer").append("<option value="+i+">["+LCustomer[i].custID+"] "+fmNull(LCustomer[i].custName)+"</option>");
			}
		}
		if(LPriceCode.length > 0){
			for(var i=0;i<LPriceCode.length;i++){
				$("#priceCode").append("<option value='"+LPriceCode[i].PriceCode+"' > ["+LPriceCode[i].PriceCode+"] "+fmNull(LPriceCode[i].Description)+"</option>");
			}
		}
		if(LEmp.length > 0){
			for(var i=0;i<LEmp.length;i++){
				 $("#employee").append("<option value="+LEmp[i].EmpID+">["+LEmp[i].EmpID+"] "+fmNull(LEmp[i].EmpName)+"</option>");
			}
		}
	}

	function addAnItem(){
		var addAnItem ="";
		
		addAnItem += "<tr onclick='showDetailRow(this)' data-qty-available='0' id='RowItem"+index+"' val='"+index+"'>";					
		
		addAnItem +="<td><div style='width: 15px;margin-top:5px; text-align: center;'><span class=\"handle ui-sortable-handle\">"+
					'<i style="font-size:20px;" class="fa fa-ellipsis-v"></i>&nbsp;'+
					'<i style="font-size:20px;" class="fa fa-ellipsis-v"></i>'+
					'</span>'+
					"</div></td>";
		
		addAnItem +="<td><div class='form-group' style='min-width:275px; margin-bottom: 0px;'><select onChange='actItemChange(this)' id='item"+index+"' name='item' class=\"form-control select2\" style=\"width:100% !important; display:none !important;\"><option selected='selected' value=''>-- SELECT AN ITEM --</option>"+tagItem+"</select></div></td>";
		
		addAnItem +="<td><div class='form-group' style='min-width:175px; margin-bottom: 0px;'><select onChange='actLocChange(this)' id='location"+index+"' name='location' class=\"form-control select2\" style=\"width:100% !important;display:none !important;\"><option selected='selected' value=''>-- SELECT A LOCATION --</option>"+tagLocation+"</select></div></td>";
		
		addAnItem +="<td><div class='form-group' style='min-width:155px; margin-bottom: 0px;'><select onfocusout='actUomChange(this)' onChange='actUomChange(this)' name='uom' title='UOM is required.' id='uom"+index+"' class=\"form-control select2\" style=\"width:100% !important;display:none !important;\"><option selected='selected' value=''>-- SELECT AN UOM --</option>"+tagUom+"</select></div></td>";			
		
		addAnItem +="<td><div class='form-group' style='min-width:155px; margin-bottom: 0px;'><input onfocusout='qtyChange(this,4)' onkeypress='return isNumeric(this,event)' title='Quantity is bigger than 0.'  name='qty' id='qty"+index+"' class='form-control' type='text' placeholder='' /></div></td>";
		
		addAnItem +="<td><div class='form-group' style='min-width:155px; margin-bottom: 0px;'><input onfocusout='upChange(this,6)' onkeypress='return isNumeric(this,event)'  name='up' id='up"+index+"' class='form-control' type='text' placeholder='' /> </div></td>";
		
		addAnItem +="<td><div class='form-group' style='min-width:155px; margin-bottom: 0px;'><input disabled onfocusout='fmNum(this,2,0)' onkeypress='return isNumeric(this,event)'  name='nTAmt' id='nTAmt"+index+"' class='form-control' type='text' placeholder=''> </div></td>";
		
		// hidden field
		
		addAnItem += "<input type='hidden' name='classCode' id='classCode"+index+"' />";
	 	addAnItem += "<input type='hidden' name='priceFactor' id='priceFactor"+index+"' >";
	 	addAnItem += "<input type='hidden' name='reportPrice' id='reportPrice"+index+"' >";
	 	addAnItem += "<input type='hidden' name='disP' id='disP"+index+"' >";
	 	addAnItem += "<input type='hidden' name='disDol' id='disDol"+index+"' >";
	 	addAnItem += "<input type='hidden' name='vatP' id='vatP"+index+"' >";
	 	addAnItem += "<input type='hidden' name='vatDol' id='vatDol"+index+"' >";
	 	addAnItem += "<input type='hidden' name='stP' id='stP"+index+"' >";
	 	addAnItem += "<input type='hidden' name='stDol' id='stDol"+index+"' >";
	 	addAnItem += "<input type='hidden' name='tAmt' id='tAmt"+index+"' >";
	 	
	 	
		addAnItem += "<td><div style='width:100px;'><button onClick='removeRowItem("+index+")' class='btn btn-danger' type='button'><i class='fa  fa-trash'></i></button><button style='margin-left:5px;' onClick='detailRowItem("+index+")' class='btn btn-info' type='button'><i class='fa  fa-info'></i></button></div></td>";
		addAnItem += "</tr>";
	
		return addAnItem;
	}
	
	$(function(){
		$("#oppItem").append(tagItem);
		$("#oppUom").append(tagUom);
		$("#oppLocation").append(tagLocation);
		$("#oppClassDetail").append(tagClass);
	});
	
</script>