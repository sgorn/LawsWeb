//TOC for Harmonized Bill.
$(document).ready(function() {
	//Adds the clickability to the TOC button
	$(".tocButtonBar .btn").click(function() {
		//IF TOC is visible on page, hide TOC, otherwise show the TOC.
		if ($(".navigationTOC").is(":visible")){
			$(".navigationTOC").hide(1300);//Integer used to determine the speed that the TOC closes.
		} else {
			$(".navigationTOC").show(1300);//Integer used to determine the speed that the TOC opens.
		}//End if
	});//End click
});//End ready