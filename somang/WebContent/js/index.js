//배너 이미지 추가
		var addImages = [			
			"images/s3.jpg",	
			"images/s4.jpg",
			"images/s5.jpg"
		];
		
		// 배경 이미지, 텍스트 준비와 카운트 초기화
		var bg = ["url(images/bg1.jpg)" , "url(images/windy.jpg)" , "url(images/snowy.jpg)" , "url(images/bg4.jpg)", "url(images/bg3.jpg)"];
		var txt = ["Rainy" , "Windy" , "Snowy" , "Gloomy", "Sunny"];
		var i = 0;	
		var total = bg.length;
		var curNum = i+1;
		var count=0;
		var imgCount = addImages.length;
		
		//브라우저 로딩시 
		window.onload = function(){
			
			//갤러리화면 초기화
			init();
			//배너 함수 실행
			rotate();
			
			//로그인 버튼 클릭 시 log_in 함수 실행
			document.getElementById("confirm").onclick = log_in;
			//로그아웃 버튼 클릭 시 log_out 함수 실행
			document.getElementById("cancel").onclick = log_out;		
		
			//갤러리화면의 이전버튼 클릭 시  prev 함수 실행		
			document.getElementById("prev").onclick = prev;
			//갤러리화면의 다음버튼 클릭 시 next 함수 실행
			document.getElementById("next").onclick = next;	
			//갤러리 보기 버튼 클릭시 showGaleery 함수 실행
			document.getElementById("call").onclick = showGallery;
			//홈버튼 클릭 시 showMain 함수 실행
			document.getElementById("home").onclick = showMain;
		}
		
		
		//갤러리 화면 초기화 함수
		function init(){
			document.getElementById("wrap").style.backgroundImage = bg[0];
			document.getElementById("txt").innerText = txt[0];
			document.getElementById("prev").style.display ="none";	
			document.getElementById("curNum").innerText = curNum;
			document.getElementById("total").innerText = total;
		}		
		
		// 배너가 자동으로 움직이는 함수
		function rotate(){			
			if(document.images){
				count++;
				if(count==imgCount){
					count = 0;
				}
				document.getElementById("banner").src = addImages[count];
				setTimeout("rotate()",2000);
			}
		}
		
		//로그인 처리 함수
		function log_in(){			
			var s1 = login.id.value;
			var s2 = parseInt(login.pw.value);		
			
			if( s1 =="korea" && s2 == 123 ){
				addClass();
			}else{
				alert("아이디와 비밀번호의 정보가 올바르지 않습니다.");		
				login.id.value ="";
				login.pw.value = "";
				login.id.focus();
			}			
		}		
		
		//로그아웃 함수
		function log_out(){			
			login.id.value ="";
			login.pw.value = "";
			removeClass();
		}
		
		
		// 클래스 추가하는 함수
		function addClass(){
			document.getElementById("frame").className = "on";
		}
		// 클래스 제거하는 함수
		function removeClass(){
			document.getElementById("frame").className = "";
		}	
		
		
		// 이전이미지 보이기 ( 제일 처음 이미지일때 이전버튼 숨기기)
		function prev(){				
			if( i > 0){
				i--;					
				change();
			}	
			if( i == 0){ document.getElementById("prev").style.display ="none"; }
		}
		
		// 다음이미지 보이기 ( 제일 마지막 이미지일때 다음버튼 숨기기)
		function next(){
			if( i < bg.length-1 ){
				i++;				
				change();
			}
			if( i == bg.length-1 ){ document.getElementById("next").style.display ="none"; }			
		}
		
		//갤러리 화면 이미지 전환 및 좌우 버튼 초기화
		function change(){
			curNum = i+1;
			document.getElementById("curNum").innerText = curNum;
			document.getElementById("wrap").style.backgroundImage = bg[i];
			document.getElementById("txt").innerText = txt[i];
			document.getElementById("prev").style.display ="";
			document.getElementById("next").style.display ="";
		}	
		
		//갤러리 화면 보이는 함수
		function showGallery(){			
			document.getElementById("wrap").style.display = "block";
		}
		
		//메인 로그인 화면 보이는 함수
		function showMain(){
			document.getElementById("wrap").style.display = "none";
		}
				