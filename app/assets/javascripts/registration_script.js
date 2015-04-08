$(document).ready(function(){

	function checkValidation(element) {
		re = new RegExp($(element).data("regex"));
		sibling = null;
		if($(element).siblings().length>0){
			sibling = $(element).siblings();
		}
		if((element.getAttribute("id").split("_")[2] === "confirmation" && $(element).val() != $("input[id$='password']").val())||(!re.test($(element).val()))) {
			console.log("nahi yaar");
			$(element).addClass("input_error");
			if(sibling!=null){
				sibling.addClass("i_error");
			}
			if($(element).parent().find("div.alert").length==0){
				alert = '<div class="alert"><strong>Oh snap!</strong> ' + $(element).data('tooltip') + '</div>';
				$(element).parent().append(alert);
			}
		}
		else {
			$(element).removeClass("input_error");
			if(sibling!=null){
				sibling.removeClass("i_error");
			}
			if($(element).parent().find("div.alert").length>0){
				$(element).parent().find("div.alert").remove();
			}
		}
	}
	$("input,textarea").focusout(function(){
		checkValidation(this);
	});
	$("input,textarea").change(function(){
		checkValidation(this);
	});

	$("button").click(function(e){
		e.preventDefault();
		r = $("form").serialize();
		console.log(r);
	});

});