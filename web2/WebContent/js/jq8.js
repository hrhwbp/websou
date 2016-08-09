$(document).ready(function(){
	$("#id_error").hide();
	$("#age_error1").hide();
	$("#age_error2").hide();
	$("#p_error1").hide();
	$("#p_error2").hide();	
	
	$("input#btnSend").click(function(){
		//id검사
		var id = $('#userid').val();
		//alert(id);
		if(id.length < 1){
			$("#id_error").show();
			return false;
		}else{
			$("#id_error").hide();
		}
	});
});