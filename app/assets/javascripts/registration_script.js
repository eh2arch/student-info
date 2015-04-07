$(document).ready(function(){

	function checkValidation(element) {
		re = new RegExp($(element).data("regex"));
		sibling = null;
		if($(element).siblings().length>0){
			sibling = $(element).siblings();
		}
		if((element.getAttribute("id").split("_")[2] === "confirmation" && $(element).val() != $("input[id$='password']").val())||(!re.test($(element).val()))) {
			$(element).addClass("input_error");
			// $(element).trigger("mouseenter");
			ele = element;
			// setTimeout(function(){
			// 	$(ele).trigger("mouseleave");
			// },1500);
			if(sibling!=null){
				sibling.addClass("i_error");
			}
		}
		else {
			$(element).removeClass("input_error");
			if(sibling!=null){
				sibling.removeClass("i_error");
			}
		}
	}
	$("input,textarea").focusout(function(){
		checkValidation(this);
	});
	$("input,textarea").change(function(){
		checkValidation(this);
	});

});