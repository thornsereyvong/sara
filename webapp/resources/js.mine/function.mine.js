var month_num = new Array();
month_num['Jan'] = 1;
month_num['Feb'] = 2;
month_num['Mar'] = 3;
month_num['Apr'] = 4;
month_num['May'] = 5;
month_num['Jun'] = 6;
month_num['Jul'] = 7;
month_num['Aug'] = 8;
month_num['Sep'] = 9;
month_num['Oct'] = 10;
month_num['Nov'] = 11;
month_num['Dec'] = 12;

function checkDate(date) {
	if (date != '') {
		var dtRegex = new RegExp(/\b\d{1,2}[\/-]\w{1,3}[\/-]\d{4}\b/);
		return dtRegex.test(date);
	}
	return false;
}
function checkMonthAndYear(date) {
	if (date != '') {
		var dtRegex = new RegExp(/\b\w{1,3}[\/-]\d{4}\b/);
		return dtRegex.test(date);
	}
	return false;
}
function getLastDayOfMonth() {
	var t = new Date();
	return new Date(t.getFullYear(), t.getMonth() + 1, 0, 23, 59, 59).getDate();
}
function formatNum(n) {
	return Number(n).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1,");
}
function formatNumByLength(n, i) {
	return Number(n).toFixed(i).replace(/(\d)(?=(\d{3})+\.)/g, "$1,");
}
function formatNumAcc(n) {
	if (Number(n) < 0)
		return '('
				+ (Number(n) * (-1)).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g,
						"$1,") + ')';
	return Number(n).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1,");
}
function formatNumAccByLength(n,i) {
	if (Number(n) < 0)
		return '('
				+ (Number(n) * (-1)).toFixed(i).replace(/(\d)(?=(\d{3})+\.)/g,
						"$1,") + ')';
	return Number(n).toFixed(i).replace(/(\d)(?=(\d{3})+\.)/g, "$1,");
}
function formatNumAccRe(n, R) {
	if ((Number(n) * R) < 0)
		return '('
				+ (Number(n) * (-1) * R).toFixed(2).replace(
						/(\d)(?=(\d{3})+\.)/g, "$1,") + ')';
	return (Number(n) * R).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1,");
}
function loadingImg(id, Class) {
	$("#" + id).find("i").removeClass(Class);
	$("#" + id).find("i").append("<img src='img/loading.gif' width='25'/>");
	$("#" + id).prop('disabled', true);
}
function unloadingImg(id, Class) {
	$("#" + id).find("i").addClass(Class);
	$("#" + id).find("i").find("img").remove();
	$("#" + id).prop('disabled', false);
}
function loading(id) {
	$("#" + id).append('<img style="margin: 0 auto;" width="75px" alt="" src="'+server+'img/Fading lines.gif">');
	return true;
}
function unloading(id) {
	$("#" + id).empty();
}
function checkError(fields) {
	for (i = 0; i < fields.length; i++) {
		var check = $("#" + fields[i]).parent().attr("class").split(' ');
		if (check[check.length - 1] == "has-error") {
			return false;
		}
	}
	return true;
}
function dis(data) {
	$("#errors").append(JSON.stringify(data));
}
function dis1(data) {
	$("#errors").append(data);
}
function getChar(event) {
	return String.fromCharCode(event.keyCode || event.charCode)
}
function isNumeric(obj,evt) {
	evt = (evt) ? evt : window.event;
	var charCode = (evt.which) ? evt.which : evt.keyCode;
	if(charCode == 46){
		var dot= obj.value;
		dot = dot.indexOf('.');
		if(obj.value == ''){
			obj.value = '0.';
			return false;
		}else if(dot == -1)
			return true;
		else
			return false;
	}	
	if (charCode > 31 && (charCode < 48 || charCode > 57)) {
		return false;
	}
	return true;
}
function isPersent(obj,evt) {
	evt = (evt) ? evt : window.event;
	var charCode = (evt.which) ? evt.which : evt.keyCode;

	if(Number(obj.value+''+getChar(evt))>100){
		return false;
	}
	
	if(charCode == 46){
		var dot= obj.value;
		dot = dot.indexOf('.');
		if(obj.value == ''){
			obj.value = '0.';
			return false;
		}else if(dot == -1)
			return true;
		else
			return false;
	}	
	if (charCode > 31 && (charCode < 48 || charCode > 57)) {
		return false;
	}
	return true;
}

function isInt(evt){
	evt = (evt) ? evt : window.event;
	var charCode = (evt.which) ? evt.which : evt.keyCode;
	if (charCode > 31 && (charCode < 48 || charCode > 57)) {
		return false;
	}
	return true;
}
function fmNum(obj,i,type){
	var n = Number(obj.value);	
	if(type == 12345678){
		var obj1 = $("#"+obj.getAttribute("id"));
		if(n>0){
			obj1.attr('style',styQty);
		}else{
			obj1.attr('style','border: 1px solid #dd4b39;'+styQty);
		}	
	}
	obj.value = n.toFixed(i).replace(/(\d)(?=(\d{3})+\.)/g, "$1,");	
}
function addDays(day,date){
	var monthNames = ["Jan", "Feb", "Mar","Apr", "May", "Jun", "Jul","Aug", "Sep", "Oct","Nov", "Dec"];	
	var pattern = /(\d{2})\-(\d{2})\-(\d{4})/;
	var dt = new Date(date.replace(pattern,'$3-$2-$1'));
	
	dt.setDate(dt.getDate() + day); 
	
	var dd = dt.getDate();
	var mm = monthNames[dt.getMonth()];
	var y = dt.getFullYear();

	return (dd + '-'+ mm + '-'+ y);		
}

function convertFromSQLToDate(value){
	if(value != "0001-01-01" && value != null)
		return addDays(0,value);
	else{
		return "";
	}
}


function setValueDateById(ID, value){
	if(value != "0001-01-01")
		$("#"+ID).val(addDays(0,value));
	else{
		$("#"+ID).val("");
	}
}
function setValueById(ID,value){
	$("#"+ID).val(value);
}
function getInt(ID){
	return Number($.trim($("#"+ID).val()));
}


function getValueById(ID){
	return toNum($("#"+ID).val());
}
function getValueStringById(ID){
	return ($.trim($("#"+ID).val())).toString();
}
function toNum(num){	
	if (num === undefined || num === null || num == 0) {
		return 0;		
	}
	num = num.toString();
	num = num.replace(',','');
	return Number($.trim(num));
}


function readURL(input, dis_img) {	
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $('#'+dis_img).attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
}
function checkRegExp(string,patt) {
	var re = new RegExp(patt);
	if (re.test(string)) {
	   return true;
	}
	return false
}

function getDateById(ID){
	var date =  $.trim($("#"+ID).val());
	if(date != ""){
		date =  date.split('-');
		date = date[2]+'-'+month_num[date[1]]+'-'+date[0];
	}	
	return date;
}

function getFomatDateToSQL(date){
	if(date != ""){
		date =  date.split('-');
		date = date[2]+'-'+month_num[date[1]]+'-'+date[0];
	}	
	return date;
}

function addSuccessToSelect2(ID){
	$("#"+ID).next().children().children().attr('style','border: 1px solid #00a65a;');
	$("#"+ID).prev().css({"color": "#00a65a"});
}
function addErrorToSelect2(ID){
	$("#"+ID).next().children().children().attr('style','border: 1px solid #dd4b39;');
	$("#"+ID).prev().css({"color": "#dd4b39"});
}
function clearToSelect2(ID){
	$("#"+ID).next().children().children().attr('style','border: 1px solid #d2d6de;');
	$("#"+ID).prev().css({"color": "#333"});
}
function addSuccessToDate(id){
	$("#"+id).addClass('date-control col-md-3 has-success');
	$("#"+id).children().eq(0).attr('style','color: #00a65a;');
	$("#"+id).children().eq(1).attr('style','border: 1px solid #00a65a;');
	$("#"+id).children().eq(1).children().eq(1).attr('style','border: 0px; border-left: 1px solid #00a65a;');	
}
function addErrorToDate(id){
	$("#"+id).addClass('date-control col-md-3 has-success');
	$("#"+id).children().eq(0).attr('style','color: #dd4b39;');
	$("#"+id).children().eq(1).attr('style','border: 1px solid #dd4b39;');
	$("#"+id).children().eq(1).children().eq(1).attr('style','border: 0px; border-left: 1px solid #dd4b39;');
}



