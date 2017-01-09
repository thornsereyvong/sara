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

var probab = [0,10,20,40,70,90,100,0];


function getPermissionByModule(moduleId,action){
	for(i=0;i<permission.roleDetails.length;i++){		
		if(moduleId == permission.roleDetails[i].module.moduleId){
			switch(action) {
			    case "create":
			        return permission.roleDetails[i].roleAccess;
			    case "delete":
			    	 return permission.roleDetails[i].roleDelete;
			    case "edit":
			    	 return permission.roleDetails[i].roleEdit;	   
			    default:
			    	return "NO";
			}
		}		
	}
}

function checkAssignTo(){
	if(curAssign == username){
		return true;
	}
	return false;
}
function checkOwner(){
	if(ownerItem == username){
		return true;
	}
	return false;
}

function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires="+d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

function checkCookie() {
    var user = getCookie("username");
    if (user != "") {
        alert("Welcome again " + user);
    } else {
        user = prompt("Please enter your name:", "");
        if (user != "" && user != null) {
            setCookie("username", user, 365);
        }
    }
}

function alertMsgErrorSweetWithTxt(msg){
	swal({
		title:"UNSUCCESSFUL",
		text: msg,
		type:"error",  
		timer: 2000,
		html:true,
		showConfirmButton: true
	});
}
function alertMsgSuccessSweetWithTxt(msg){
	swal({
		title:"SUCCESSFUL",
		text: msg,
		type:"success",  
		timer: 2000,
		html:true,
		showConfirmButton: true
	});
}
function alertMsgErrorSweet(){
	swal({
		title:"UNSUCCESSFUL",
		text:"Please try agian!",
		type:"error",  
		timer: 2000,   
		showConfirmButton: true
	});
}

function alertMsgRequire(){
	swal({
        title:"<span color='#dd4b39'>REQUIRED FIELD</span>",
        html: true,
        text:"Please check field required!",
        showImage: false
	});	
}

function alertMsgNoPermision(){
	swal({
        title:"<span color='#dd4b39'>PERMISSION DENY</span>",
        html: true,
        text:"You have no permission to do this transaction. Please contact your administrator.",
        showImage: false
	});	
}

function reloadForm(time){
	setTimeout(function(){ location.reload(); },time);
}



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

function getDateByFormat(ID){
	var date  = $.trim($("#"+ID).val());
	if(date==""  || date == null || date == 'undefined') return null;
	date = date.split('/');
	return date[2]+"-"+date[1]+"-"+date[0];
}
function conDateSqlToNormal(date, strCon){
	if(date == "" || date == null || date == 'undefined') return "";
	date = date.split('-');
	return date[2]+""+strCon+""+date[1]+""+strCon+""+date[0];
}
function getDateTimeByFormat(ID){
	
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

function getJsonById(key, ID,type){
	var obj = $.trim($("#"+ID).val());
	if(obj == "")
		return null;
	if(type=="str")
		return JSON.parse('{"'+key+'" : "'+obj+'"}');
	return JSON.parse('{"'+key+'" : '+obj+'}');
}

function getJsonByValue(key, obj,type){
	if(obj == "")
		return null;
	if(type=="str")
		return JSON.parse('{"'+key+'" : "'+obj+'"}');
	return JSON.parse('{"'+key+'" : '+obj+'}');
}

function getIntToNull(ID){
	var obj = Number($.trim($("#"+ID).val()));
	if(obj == 0)
		return null;
	return obj;
}

function getStringToNull(ID){
	var obj = $.trim($("#"+ID).val());
	if(obj == "")
		return null;
	return obj;
}
function getValueById(ID){
	return toNum($("#"+ID).val());
}
function getValueStringById(ID){
	return ($.trim($("#"+ID).val())).toString();
}

function toNum(num){	
	if (num === undefined || num === null || num == 0 || num=='.') {
		return 0;		
	}
	num = num.toString();
	num  = num.split(",");
	num  = num.join("");
	return Number(num);
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


function getTags(ID,key){
	var obj = [];
	var tags = $.trim($("#"+ID).val());	
	if(tags == "")
		return null;
	tags = tags.toString();
	if(tags !=null){
		tags = tags.split(',');
		for(var i=0;i<tags.length;i++){
			obj.push(JSON.parse('{"'+key+'" : "'+tags[i]+'"}'));
		}
		return obj;
	}	
	return null;
}
function getDateToSQL(ID){
	var date =  $.trim($("#"+ID).val());
	if(date != ""){
		
	}
}

function getDateById(ID){
	var date =  $.trim($("#"+ID).val());
	if(date != ""){
		date =  date.split('-');
		date = date[2]+'-'+month_num[date[1]]+'-'+date[0];
	}	
	return date;
}
function fSQLTo(f,date){
	date =  date.split('-');
	return date[2]+f+date[1]+f+date[0];
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

function fmNull(str){
	if(str == null)
		return "";
	return str;
}

$(function(){
	$("#op_stage").change(function(){ $("#op_probability").val(probab[getInt("op_stage")]); });
	$("#oppStage").change(function(){ $("#oppProbability").val(probab[getInt("oppStage")]); });	
});

