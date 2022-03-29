 $(function() {
 
 	var $newInput;
	var $lookup;
	var $path;
	var $message;
	
	if($('html').attr('lang') == "fr")
	{
	$newInput = $('<h2>Trouver un titre</h2><p><input size="60" type="text" id="txtTitles"></input></p>');
	$lookup = "/js/lookup_acts_f.xml";
	$path = "fra/lois/";
	$message = "Aller à la loi";
	}
	else
	{
	$newInput = $('<h2>Find a title</h2><p><input size="60" type="text" id="txtTitles"></input></p>');
	$lookup = "/js/lookup_acts_e.xml";
	$path = "eng/acts/";
	$message = "Go to Act";
	}
	
	$("#byTitle").before($newInput);
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
		
		if ($(this).attr("t") == "a")
        {
            $OffNum = " (" + $("OC", this).text() + ")";
		return {
		 
            value: $("T", this).text() + $OffNum,
            id: $( "C", this ).text()
          };
		}
        }).get();
        $titles.autocomplete({
          source: data,
          minLength: 3,
		  select: function(event, ui) 
		  {
		    $("#actButton").remove();
			$titles.after("<a role='button' id='actButton' class='btn btn-primary' href='/" + $path + ui.item.id + "'>" + $message + "</a>");
		  }
        });
      }
    });
  });