//When user clicks on the related regs icon on the by titles page, this will populate/display the list.
function getRegs(id) {

	//Get the popup to be populated/displayed
	popupSpan = $("#"+id);
	
	//Get the waiting gif div to be enabled
	waitingGIF = $("."+id);

	if ($("#"+id).css('display') == 'none') {
		
		//Enable waiting GIF
		waitingGIF.addClass("loading");
		
		//Ajax makes call to api to get related regs
		//If success, create a list and toggle the list on the site
		$.ajax({
			type: 'GET',
			url: 'https://laws-lois-api.justice.gc.ca/acts/' + id + '/regulations',
			dataType: 'JSON',
			success: function(data){
								
				//Clear the content in the span
				popupSpan.empty();
				
				//Build list of related regs
				var list = "<ul>";
				$(data.value).each(function(i, v){
					var sTitle = v.title;
					var sAlpha = v.alpha;
					var regLink = v.web_page_index;
					var regAnchor = "<a href='" + regLink + "'>" + sTitle + " (" +  sAlpha + ")</a>";
					
					if (sTitle == ""){alert("missing longtitle " + sAlpha)}
				
					list += ("<li>" + regAnchor + "</li>");
				});
				list += "<ul>";
				
				//Disable waiting GIF
				waitingGIF.removeClass("loading");
				
				//Add the list to html page
				popupSpan.append(list);
				
				//Show the related regs list
				popupSpan.slideDown("slow");
			},
			error: function (xhr, textStatus, errorThrown) { 
				alert(xhr.reponseText + " " + xhr.status);
				
				//Disable waiting GIF
				waitingGIF.removeClass("loading");
			}
		});
	}else{
		//Hide the related regs list
		popupSpan.slideUp("slow");
	}
}

//If javascript is enabled, this will change the href to a onclick method.
$(document).ready(function () {
	
	//Iterates through html to get the popuptext span element
	$("li .popuptext").each(function() {
		
		//Get the id from the popuptext for referencing
		var id = $(this).attr("id");
		
		//Remote the href attribute, and add the onglick attribute with id
		$(this).siblings().find(".rButtonShowRegList").removeAttr("href");
		$(this).siblings().find(".rButtonShowRegList").attr("onclick", "getRegs('" + id + "')");		
	});
});