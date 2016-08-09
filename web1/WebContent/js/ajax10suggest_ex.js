var xhr;
var checkFirst = loopSend = false;
var lastKeyword = "";

function sijak() {	
	if (checkFirst == false) {
		setTimeout("sendKeyword()", 2000);
		loopSend = true;
	}
}

function sendKeyword() {	
	if (loopSend == false)
		return;

	var keyWord = document.frm.keyword.value;
	console.log(keyWord);

	if (keyWord == "") {
		lastKeyword = "";
		hide("suggest");
	} else if (keyWord != lastKeyword) {
		lastKeyword = keyWord;
		if (keyWord != "") {
			var para = "ibsail=" + keyWord;
			xhr = new XMLHttpRequest();
			xhr.open("post", "ajax10_ex.jsp", true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4) {
					if (xhr.status == 200) {
						process();
					}
				}
			}
			xhr.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");
			xhr.send(para);
		} else {
			hide("suggest");
		}
	}
	setTimeout("sendKeyword()", 1200);
}

function process() {
	var reData = xhr.responseXML;	
	var sawonNode = reData.getElementsByTagName("sawon");
	var sawon_ibsailNode = reData.getElementsByTagName("sawon_ibsail");
	var str = "";
	
	for (var i = 0; i < sawonNode.length; i++) {
		str += "<a href=\"javascript:func('";
		str += sawon_ibsailNode[i].childNodes[0].nodeValue + "')\">";
		str += sawon_ibsailNode[i].childNodes[0].nodeValue + "<a><br/>";
	}	
	var listView = document.getElementById("suggestlist");
	listView.innerHTML = str;
	show("suggest");
}

function func(data) {
	frm.keyword.value = data;
	loopSend = checkFirst = false;
	lastKeyword = "";
	// frm.keyword.value="";
	hide("suggest");
	var year = data;
	request(year)
}

function request(year) {
	
	//alert(year);
	var para1 = "year=" + year;
	xhr = new XMLHttpRequest();
	xhr.open("post", "ajax10_ex1.jsp", true);
	xhr.onreadystatechange = function() {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				process1();
			}
		}
	}
	xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xhr.send(para1);
}

function process1() {
	var reData1 = xhr.responseXML;
	alert("reData1" + reData1);
	var sawon_showNode = reData1.getElementsByTagName("sawon_show");
	var sawon_nameNode = reData1.getElementsByTagName("sawon_name");
	var str = "";
	// alert(sawon_showNode.length);
	str += "<option>사원이름을 선택해 주세요</option>"
	for (var i = 0; i < sawon_showNode.length; i++) {
		str += "<option value=\"";
		str += sawon_nameNode[i].childNodes[0].nodeValue + "\">";
		str += sawon_nameNode[i].childNodes[0].nodeValue + "</option>";
	}
	alert(str);
	document.getElementById("dropMeun").innerHTML = str;
	
}

function setValues(){
	 var sName = (frm.dropMeun.value);
	 request1(sName);
}


function request1(sName) {
	var para2 = "sName=" + sName;
	xhr = new XMLHttpRequest();
	xhr.open("post", "ajax10_ex2.jsp", true);
	xhr.onreadystatechange = function() {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				process3();
			}
		}
	}
	xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xhr.send(para2);
}
	
	
	
	function process3(){
	
	 var reData2 = xhr.responseXML;
		//alert(reData2);
		var gogek_showNode = reData2.getElementsByTagName("gogek_show");
		var gogek_noNode = reData2.getElementsByTagName("gogek_no");
		var gogek_nameNode = reData2.getElementsByTagName("gogek_name");
		var gogek_juminNode = reData2.getElementsByTagName("gogek_jumin");
		var gogek_telNode = reData2.getElementsByTagName("gogek_tel");
		var str = "";
		// alert(gogek_showNode.length);
		str += "<table border = '1'><tr><th>고객번호</th><th>고객성함</th><th>주민번호</th><th>고객전화</th></tr>";
		for (var i = 0; i < gogek_showNode.length; i++) {
			str += "<tr><td>" + gogek_noNode[i].childNodes[0].nodeValue + "</td>";
			str += "<td>" + gogek_nameNode[i].childNodes[0].nodeValue + "</td>";
			str += "<td>" + gogek_juminNode[i].childNodes[0].nodeValue + "</td>";
			str += "<td>" + gogek_telNode[i].childNodes[0].nodeValue + "</td>";
		}
		str += "</tr></table>";
		// alert(str);		
		document.getElementById("tableDisp").innerHTML = str;
}

function hide(ele) {
	var e = document.getElementById(ele);
	if (e)
		e.style.display = "none";
}

function show(ele) {
	var e = document.getElementById(ele);
	if (e)
		e.style.display = "";
}
