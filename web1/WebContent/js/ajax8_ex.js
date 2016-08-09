var xhr, ele, popup, disp;

var ele; 
var obj = document.getElementsByName("rbtn");
var checked_value = "XML";
var tableWidth;

function checkIt(selected){
	checked_value = selected.value;
	//alert(checked_value);	
}

function goFunc(prop){
	gen = prop.id;	
	if(checked_value == "XML"){
		goFuncXML(gen);
	}else if(checked_value == "JSON"){
		goFuncJSON(gen);
	}
}

function goFuncXML(gen){	
	xhr = new XMLHttpRequest();
	xhr.open("post","ajax8_exxml.jsp",true);
	xhr.onreadystatechange = function(){
		if(xhr.readyState==4){
			if(xhr.status == 200){
				var datas = xhr.responseXML;
				xml_process();            
			}else{
				alert("goFuncXML 오류: "+xhr.status);
			}
		}
	}
	xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xhr.send("gogek_gen="+gen);
	}

function goFuncJSON(gen){   
	xhr = new XMLHttpRequest();  
	   xhr.open("post", "ajax8_exjson.jsp", true);
	   xhr.onreadystatechange = function(){
	      if (xhr.readyState == 4) {
	         if (xhr.status == 200) {
	            json_process();
	         }else{
	            alert("goFuncJSON 오류 : " + xhr.status);   
	         }         
	      }
	   }
	   xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	   xhr.send("gogek_gen="+gen);	
	}

function xml_process(){
	
	var Data1 = xhr.responseXML;
	var gogekTableNode = Data1.getElementsByTagName("gogekTable");
	var gogekNode = Data1.getElementsByTagName("gogek");
	var gogek_nameNode = Data1.getElementsByTagName("gogek_name");
	var gogek_telNode = Data1.getElementsByTagName("gogek_tel");
	var sawon_nameNode = Data1.getElementsByTagName("sawon_name");
	var buser_telNode = Data1.getElementsByTagName("buser_tel");
	var str = "";
	
	str += "<table border = '1'><tr><th>고객성함</th><th>고객전화</th><th>담당사원</th><th>부서전화</th></tr>"
	for (var i = 0; i < gogekNode.length; i++) {		
		str += "<tr><td>" + gogek_nameNode[i].childNodes[0].nodeValue + "</td>";
		str += "<td>" + gogek_telNode[i].childNodes[0].nodeValue + "</td>";
		str += "<td>" + sawon_nameNode[i].childNodes[0].nodeValue + "</td>";
		str += "<td>" + buser_telNode[i].childNodes[0].nodeValue + "</td></tr>";
	}
	str += "</table>";	
	document.getElementById("XMLdisp").innerHTML = str;
} 

function json_process(){

	   var data = xhr.responseText;
	   var parseData = JSON.parse(data);
	   
	   //var parseData = eval("(" + data + ")"); //JSON.parse 버그
	   var str ="<table border = '1'>";
	   
	   for (var i = 0; i < parseData.gogekinfo.row.length; i++) {
	      str += "<tr><td>" + parseData.gogekinfo.row[i].gogek_name + "</td>";
	      str += "<td>" + parseData.gogekinfo.row[i].gogek_tel + "</td>";
	      str += "<td>" + parseData.gogekinfo.row[i].sawon_name + "</td>";
	      str += "<td>" + parseData.gogekinfo.row[i].buser_tel + "</td></tr>";
	   }
	   document.getElementById("JSONdisp").innerHTML = data;
	}

function clsFunc(){
	document.getElementById("JSONdisp").innerHTML = "";
	document.getElementById("XMLdisp").innerHTML = "";
}


