 $(function() {
 	var $newInput;
	var $lookup;
	var $path;
	var $regPath;
	var $message;
	var $regMessage;
	
	if($('html').attr('lang') == "fr")
	{
	$newInput = $('<h2 id="hfind">Trouver un titre</h2><p><input aria-labelledby="hfind" size="60" type="text" id="txtTitles"></input></p>');
	$lookup = "/js/lookup_f.xml";
	$path = "fra/lois/";
	$regPath = "fra/reglements/";
	$message = "Aller à la table des matières";
	}
	else
	{
	$newInput = $('<h2 id="hfind">Find a title</h2><p><input aria-labelledby="hfind" size="60" type="text" id="txtTitles"></input></p>');
	$lookup = "/js/lookup_e.xml";
	$path = "eng/acts/";
	$regPath = "eng/regulations/";
	$message = "Go to table of contents";
	}
	
	$("#welcome").after($newInput);
	var $titles = $("#txtTitles");
	$titles.keyup(function (e)
	{
		if (e.which == 8)	//remove link on backspace
		{
		  $("#actButton").remove();
		}
	});
 
    $.ajax({
      url: $lookup,
      dataType: "xml",
      success: function( xmlResponse ) {
        var data = $( "D", xmlResponse ).map(function() {
		
		var $link;
		var $alpha = "";
		
		if ($(this).attr("t") == "a") //ACTS
        {
            $alpha = " (" + $("OC", this).text() + ")";
		    $link = $path + $( "C", this ).text();
		}
		else //REGS
		{
		    $alpha = $( "C", this ).text();
		    $link = $regPath + $alpha.replace(/ /g, "_").replace(/\//g, "-")
		    $alpha = " (" + $alpha + ")";
		}
		
		return {
		 
			value: $( "T", this ).text() + $alpha,
            id: $link
          };
        }).get();
		
        $titles.autocomplete({
          source: data,
          minLength: 3,
		  select: function(event, ui) 
		  {
		    $("#actButton").remove();
			$titles.after("<a title='" + ui.item.value + "' role='button' id='actButton' class='btn btn-primary' href='/" + ui.item.id + "'>" + $message + "</a>");
		  }
        });
      }
    });
  });