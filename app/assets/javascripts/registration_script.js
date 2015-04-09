function previewFile() {
  var preview = $(".contact-card-profile-img")[0];
  var file    = document.querySelector('input[type=file]').files[0];
  var reader  = new FileReader();

  reader.onloadend = function () {
    preview.src = reader.result;
  }

  if (file) {
    reader.readAsDataURL(file);
  } else {
    preview.src = "";
  }
}

$(document).ready(function(){

	function checkValidation(element) {
		if(element.getAttribute("id") === null) {
			return true;
		}
		re = new RegExp($(element).data("regex"));
		sibling = null;
		if($(element).siblings().length>0){
			sibling = $(element).siblings();
		}
		if((element.getAttribute("id").split("_")[2] === "confirmation" && $(element).val() != $("input[id$='password']").val())||(!re.test($(element).val()))) {
			$(element).addClass("input_error");
			if(sibling!=null){
				sibling.addClass("i_error");
			}
			if($(element).parent().find("div.alert.validation").length==0){
				alert = '<div class="alert validation"><strong>Oh snap!</strong> ' + $(element).data('tooltip') + '</div>';
				$(element).parent().append(alert).hide().show('200');
			}
			return false;
		}
		else {
			$(element).removeClass("input_error");
			if(sibling!=null){
				sibling.removeClass("i_error");
			}
			if($(element).parent().find("div.alert.validation").length>0){
				$(element).parent().find("div.alert.validation").remove();
			}
			return true;
		}
	}
	$("input,textarea").focusout(function(){
		checkValidation(this);
	});
	$("input,textarea").change(function(){
		checkValidation(this);
	});

    function isInt(n) { return parseInt(n) == n && parseInt(n)>0; }

	function changeRollNo() {
		originalValue = $("input[id$='roll_no']").val();
		rollNumber = null;
		if(originalValue.split("-").length == 3){
			tempRollNumber = originalValue.split("-")[2];
			if(isInt(tempRollNumber)){
				rollNumber = tempRollNumber;
			}
		}
		$("input[id$='roll_no']").val(parseInt($("select[id$='joining']").val())%1000 + "-" + $("select[id$='branch']").val() + "-");
		if(rollNumber != null){
			$("input[id$='roll_no']").val($("input[id$='roll_no']").val() + rollNumber);
		};
	}

	changeRollNo();

	$("select[id$='joining'],select[id$='branch']").change(function(){
		changeRollNo();
		$("input[id$='roll_no']").trigger("change");
	});

	$("input[id$='roll_no']").keyup(function(){
		if(!checkValidation(this)){
			changeRollNo();
		}
	});

	function checkFormValidated() {
		if($("div.alert.validation").length>0) {
			return false;
		}
		return true;
	}

	$("#btn-confirm-dialog").click(function(e){
		e.preventDefault();
		$("input,textarea").trigger("change");
		if(checkFormValidated()) {
			$("#confirmation-dialog").openModal();
			$("body").animate({scrollTop:0}, '1000');
		}
	});
	$("#btn-sign-up").click(function(e){
		$("form").submit();
	});
});