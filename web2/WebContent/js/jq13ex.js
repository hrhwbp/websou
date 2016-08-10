$(document). ready(function(){	
	var search = "";
	//검색버튼 누를시=====================================
	$("#btnSearch").click(function(){			//XML	
		search = ($("#textSearch").val());
		alert(search);
		$.ajax({
			type:"get",
			url:"jq13ex.jsp",
			data: "sang=" + search,			
			dataType:"xml",
			success:function(data){	
				var str = "<table border = '1'><tr><td>코드</td><td>상품명</td><td>수량</td><td>단가</td><td>금액</td></tr><tr>";
				$(data).find("sangpums").each(function(){
					str += "<td>" + $(this).find("code").text() + "</td>";
					str += "<td>" + $(this).find("sangpum").text() + "</td>";
					str += "<td>" + $(this).find("su").text() + "</td>";
					str += "<td>" + $(this).find("dan").text() + "</td></tr>";
				});
				str += "</table>";
				$("#disp").empty();
				$("#disp").append(str);
			},
			error:function(){
				$("#disp").text("에러 발생");
			},
		});
	});
	//전체버튼 누를시=====================================
	$("#btnAll").click(function(){			//XML	
		$.ajax({
			type:"get",
			url:"jq13ex.jsp",
			data: "sang=" + "",
			dataType:"xml",
			success:function(data){				
				var str = "<table border = '1'><tr><td>코드</td><td>상품명</td><td>수량</td><td>단가</td><td>금액</td></tr><tr>";
				$(data).find("sangpums").each(function(){
					str += "<td>" + $(this).find("code").text() + "</td>";
					str += "<td>" + $(this).find("sangpum").text() + "</td>";
					str += "<td>" + $(this).find("su").text() + "</td>";
					str += "<td>" + $(this).find("dan").text() + "</td>";
					str += "<td>" + (parseInt($(this).find("dan").text()))* (parseInt($(this).find("su").text())) + "</td></tr>";
				});
				str += "</table>";
				$("#disp").empty();
				$("#disp").append(str);
			},
			error:function(){
				$("#disp").text("에러 발생");
			},
		});
	});
});