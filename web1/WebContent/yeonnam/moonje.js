var xhr, ele, disp, juso, check;
window.onload = function(){
	check = document.getElementsByName("radio");
	check[0].checked = true;
	check.value = "XML";
}

function goresult(boolean){
	check = boolean;
}

function goFunc(element) {
	ele = element;
	console.log(ele.id);

	xhr = new XMLHttpRequest();
	if (check.value == "XML") {
//		alert("xml")
		juso = "moonjexml.jsp"
	} else {
//		alert("json")
		juso = "moonjejson.jsp"
	}
//	alert(juso);
	xhr.open("post", juso, true);
	xhr.onreadystatechange = function() {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				if (check.value == "XML") {
					processxml();
				} else {
					processjson();
				}

			} else {
				alert("post 요청 실패 : " + xhr.status);
			}
		}
	}
	xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xhr.send("gen=" + ele.id);

}

function processxml() {
	document.getElementById("show2").innerHTML = "이곳은 JSON";
	var data = xhr.responseXML;
	// alert(data);
	var sawonNode = data.getElementsByTagName("sawon");
	var gnameNode = data.getElementsByTagName("gname");
	var gtelNode = data.getElementsByTagName("gtel");
	var snameNode = data.getElementsByTagName("sname");
	var btelNode = data.getElementsByTagName("btel");
	var str = "출력장소 xml<br>";
		str += "<table border ='1'><tr><td>고객명</td><td>고객전화</td><td>관리직원</td><td>부서전화</td></tr>";

	for (var i = 0; i < sawonNode.length; i++) {

		str += "<tr>";
		str += "<td>" + gnameNode[i].firstChild.nodeValue + "</td>";
		str += "<td>" + gtelNode[i].firstChild.nodeValue + "</td>";
		str += "<td>" + snameNode[i].firstChild.nodeValue + "</td>";
		str += "<td>" + btelNode[i].firstChild.nodeValue + "</td>";

		str += "</tr>";
	}
	str += "</table>"
	document.getElementById("show").innerHTML = str;

}

function processjson() {
	document.getElementById("show").innerHTML = "이곳은 XML";
	var data = xhr.responseText;
//	alert(data);
	var parseData = JSON.parse(data);
	var str = "출력장소 json<br>";
		str += "<table border ='1'><tr><td>고객명</td><td>고객전화</td><td>관리직원</td><td>부서전화</td></tr>";
	for (var i = 0; i < parseData.sawons.length; i++) {
		str += "<tr>";
		str += "<td>" + parseData.sawons[i].gname + "</td>";
		str += "<td>" + parseData.sawons[i].gtel + "</td>";
		str += "<td>" + parseData.sawons[i].sname + "</td>";
		str += "<td>" + parseData.sawons[i].btel + "</td>";
		str += "</tr>"

	}
	str += "</table>"
	document.getElementById("show2").innerHTML = str;
}

function clsFunc() {
	document.getElementById("show").innerHTML = "이곳은 XML출력장소";
	document.getElementById("show2").innerHTML = "이곳은 JSON출력장소";
}
