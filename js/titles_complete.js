 $(function() {
 
	var $path;
	if (window.pe.language == "fr")
	{
		$path = "/js/lookup_fr.xml";
	}
	else
	{
		$path = "/js/lookup_en.xml";
	}
    $.ajax({
      url: $path,
      dataType: "xml",
      success: function( xmlResponse ) {
        var data = $( "LAW", xmlResponse ).map(function() {
			return {value: $( "ST", this ).text(), id: $( "CN", this ).text() };
			}).get();
        $( "#txtT1tl3" ).autocomplete({
          source: data,
          minLength: 3
        });
      }
    });
  });