$(document). ready(function(){
	$("tbody > tr").hover(
			function(){
				$(this).find("td").addClass("hov");
			},
			function(){
				$(this).find("td").removeClass("hov");
			}
		);
	
	$("#btnSearch").click(function(){			//XML	
		search = ($("#textSearch").val());
		//alert(search);
		$.ajax({
			type:"post",
			url:"jq13ex1.jsp",
			data:{"buser": search},
			dataType:"json",
			success:function(data){	
				//alert(data);
				var str = "<table border = '1'><tbody><tr><td>사번</td><td>직원명</td><td>직급</td><td>관리고객</td></tr><tr>";
				$.each(data, function(index, entry){
					str += "<td>" + entry.sawon_no + "</td>";
					if(entry.gogek_count > 0){
						str += "<td><a href= # onclick='go(this)'>" + entry.sawon_name + "</td>";
					}else{
						str += "<td>" + entry.sawon_name + "</td>";	
					} 
					str += "<td>" + entry.sawon_jik + "</td>";
					str += "<td>" + entry.gogek_count + "</td></tr>";
				});				
				str += "</tbody></table>"
				$("#disp1").empty();
				$("#disp1").append(str);
			},
			error:function(){
				$("#disp1").text("에러 발생");
			},
		});		
	});
});
	
	

function go(data) {
	var sName = data.text;
	$.ajax({
		type:"post",
		url:"jq13ex1-1.jsp",
		data:{"sName": sName},
		dataType:"json",
		success:function(data){			
			var str = "<table border = '1'><tr><td>고객명</td><td>고객전화</td><td>고객성별</td><td>고객나이</td></tr><tr>";
			$.each(data, function(index, entry){
				str += "<td>" + entry.gogek_name + "</td>";
				str += "<td>" + entry.gogek_tel + "</td>"; 
				str += "<td>" + entry.gogek_gen + "</td>";
				str += "<td>" + entry.gogek_age + "</td></tr>";
			});				
			str += "</table>"
			$("#disp2").empty();
			$("#disp2").append(str);
		},
		error:function(){
			$("#disp2").text("에러 발생");
		},
	});		
}