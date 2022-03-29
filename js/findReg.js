 $(function() {
 
  	var $newInput;
	var $lookup;
	var $path;
	var $message;
	if($('html').attr('lang') == "fr")
	{
	$newInput = $('<h2>Trouver un titre</h2><p><input size="60" type="text" id="txtTitles"></input></p>');
	$lookup = "/js/lookup_f.xml";
	$path = "fra/reglements/";
	$message = "Aller au règlement";
	}
	else
	{
	$newInput = $('<h2>Find a title</h2><p><input size="60" type="text" id="txtTitles"></input></p>');
	$lookup = "/js/lookup_e.xml";
	$path = "eng/regulations/";
	$message = "Go to regulation";
	}
	
	
	$("#byTitle").before($newInput);
	var $titles = $("#txtTitles");
	
	$titles.keyup(function (e)
	{	
		if (e.which == 8)
		{
		$("#actButton").remove();
		}
	});
 
    $.ajax({
      url: $lookup,
      dataType: "xml",
      success: function( xmlResponse ) {
        var data = $( "D", xmlResponse ).map(function() {
		
		if ($(this).attr("t") == "r")
		{
		
		$alpha = " (" + $( "C", this ).text() + ")";
		
		return {
		 
			value: $( "T", this ).text() + $alpha,
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
			$titles.after("<a role='button' id='actButton' class='btn btn-primary' href='/" + $path + ui.item.id.replace(/ /g, "_").replace(/\//g, "-") + "'>" + $message + "</a>");
		  }
        });
      }
    });
  });