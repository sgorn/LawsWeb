$(document).ready(function() {
    // set initial state
    $(".mainContent").width("65%");
    $(".rightMenu").show();
	$(".rightMenu").attr("aria-hidden", "false");
	$("a.togglemenu").attr("role", "button");
	$("a.togglemenu").addClass("toggle-link-collapse");
	$(".togglemenu").attr("aria-expanded", "true");
	$(".togglemenu").attr("aria-controls", "rightMenu");
	$(".togglemenu").attr("aria-pressed", "true");

    $(".togglemenu").click(function(){
        // if the menu is visible hide it and adjust the mainContent

        if ($(".rightMenu").is(":visible")) {
			$(".rightMenu").hide("slow", function() { //wait for hide to finish before adjusting width
				$(".mainContent").width("99%");
				});
			$(".rightMenu").attr("aria-hidden", "true");
            $(this).attr("aria-expanded", "false");
			$(this).attr("aria-pressed", "false");
			$(this).removeClass("toggle-link-collapse").addClass("toggle-link-expand");
        } else {
        // if not visible - adjust mainContent and show() rightmenu
            $(".mainContent").width("65%");
			$(".rightMenu").show("slow");
			$(".rightMenu").attr("aria-hidden", "false");
            $(this).attr("aria-expanded", "true");
			$(this).attr("aria-pressed", "true");
			$(this).removeClass("toggle-link-expand").addClass("toggle-link-collapse");
			
        }
    });

}) // jquery ends
    