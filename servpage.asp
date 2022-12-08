<% 
Function IsHttpStatus(url)
on error resume next
dim fs
set fs=Server.CreateObject("Scripting.FileSystemObject")
If fs.FolderExists(url) Then
	IsHttpStatus = true
ElseIf fs.FileExists(url) Then
	IsHttpStatus = true
Else
	IsHttpStatus = false
End If
If Err.Number <> 0 Then
	IsHttpStatus = false
End If
set fs=nothing

End Function

'handle404.asp – ASP file for handling Customer Error
'Messages mapped to a URL
Dim capturedQryStrg
Dim requestedURL
'As I explained above, the entire query string starts with
'the error number, followed by the requested URL
capturedQryStrg = Request.ServerVariables("Query_String")
'Once we have captured the entire query string, in this
'case "404;http://www.reskit.com/missing.htm", let us
'clean it by removing the "404;", leaving us with just the
'requested URL
requestedURL = Replace(capturedQryStrg, "404;", "")
Dim i
Dim j
Dim firstTry
firstTry = true
requestedURL = Replace(requestedURL,":80/","/")
requestedURL = Replace(requestedURL,"/en/","/eng/")
requestedURL = Replace(requestedURL,"/fr/","/fra/")
requestedURL = Replace(requestedURL,"/EN/","/eng/")
requestedURL = Replace(requestedURL,"/FR/","/fra/")
requestedURL = Replace(requestedURL,"/ENG/","/eng/")
requestedURL = Replace(requestedURL,"/FRA/","/fra/")
requestedURL = Replace(requestedURL,"/laws.justice.gc.ca/","/laws-lois.justice.gc.ca/")
requestedURL = Replace(requestedURL,"/lois.justice.gc.ca/","/lois-laws.justice.gc.ca/")
requestedURL = Replace(requestedURL,"/showtdm/","/")
requestedURL = Replace(requestedURL,"/ShowTdm/","/")
requestedURL = Replace(requestedURL,"/ShowDoc/","/")
requestedURL = Replace(requestedURL,"/showdoc/","/")
requestedURL = Replace(requestedURL,"/StatutoryRes/","/RelatedResources/")
requestedURL = Replace(requestedURL,"/statutoryres/","/RelatedResources/")
requestedURL = Replace(requestedURL,"/cr/","/")
requestedURL = Replace(requestedURL,"/cs/","/")
requestedURL = Replace(requestedURL,"/Search.html","/Recherche.html")
requestedURL = Replace(requestedURL,"/Recherche.html","/Search.html")
requestedURL = Replace(requestedURL,"/search.html","/recherche.html")
requestedURL = Replace(requestedURL,"/recherche.html","/search.html")

Dim quickurl
quickurl = Replace(requestedURL ,"http://ot1s0178.justice.gc.ca/","D:\Inetpub\wwwroot_WET\")
quickurl = Replace(quickurl ,"http://laws-lois.justice.gc.ca/","E:\wwwroot\")
quickurl = Replace(quickurl ,"http://lois-laws.justice.gc.ca/","E:\wwwroot\")
' if the file only needs to have en switched to eng or fr to fra; go there right away:
If IsHttpStatus(quickurl) Then
	Response.Status="301 Moved Permanently"
	Response.AddHeader "Location",requestedURL
Else
	Response.Status="404 Not Found"
End If

i = InStr(requestedURL, "eng")
j = InStr(requestedURL, "fra")
Dim re
Set re = new regexp 
re.Pattern = "/[A-Z]-[0-9][0-9\.]*/"
If InStr(requestedURL, ".pdf") Or InStr(requestedURL, ".PDF") Then
	Dim filenamePos
	filenamePos = InStrRev(requestedURL, "/")
	requestedURL = "http://laws-lois.justice.gc.ca/PDF/" + Right(requestedURL, Len(requestedURL) - filenamePos)
	requestedURL = Replace(requestedURL, "TR", "SI")
	requestedURL = Replace(requestedURL, "DORS", "SOR")
	requestedURL = Replace(requestedURL, "ch.", "c.")
	requestedURL = Replace(requestedURL, "CH.", "c.")
	
ElseIf i > 0 Then
	If InStr(requestedURL, "acts") Or InStr(requestedURL, "regulations") Then
		firstTry = false
		
	ElseIf InStr(UCase(requestedURL), "SOR") Or InStr(UCase(requestedURL), "SI") Then
		requestedURL = Replace(requestedURL, "eng", "eng/regulations")
		If re.Test(requestedURL) Then
			requestedURL = re.Replace(requestedURL,"/")
		End If
	ElseIf Instr(requestedURL, "C.R.C.-c.") Or Instr(requestedURL, "C.R.C.-C.") Then
		requestedURL = Replace(requestedURL, "eng", "eng/regulations")
		requestedURL = Replace(requestedURL, "C.R.C.-c.", "C.R.C.,_c._")
		requestedURL = Replace(requestedURL, "C.R.C.-C.", "C.R.C.,_c._")
		If re.Test(requestedURL) Then
			requestedURL = re.Replace(requestedURL,"/")
		End If
	ElseIf Instr(UCase(requestedURL), "CHARTER") Then
		requestedURL = "http://laws-lois.justice.gc.ca/eng/Const/index.html"
	Else 
		requestedURL = Replace(requestedURL, "eng", "eng/acts")
	End If
	
ElseIf j > 0 Then
	If InStr(requestedURL, "lois/") Or InStr(requestedURL, "reglements") Then
		firstTry = false
	ElseIf Instr(requestedURL, "C.R.C.-ch.") Or Instr(requestedURL, "C.R.C.-CH.") Then
		requestedURL = Replace(requestedURL, "fra", "fra/reglements")
		requestedURL = Replace(requestedURL, "C.R.C.-ch.", "C.R.C.,_ch._")
		requestedURL = Replace(requestedURL, "C.R.C.-CH.", "C.R.C.,_ch._")
		If re.Test(requestedURL) Then
			requestedURL = re.Replace(requestedURL,"/")
		End If
	ElseIf InStr(UCase(requestedURL), "DORS") Or InStr(UCase(requestedURL), "TR") Then
		requestedURL = Replace(requestedURL, "fra", "fra/reglements")
		If re.Test(requestedURL) Then
			requestedURL = re.Replace(requestedURL,"/")
		End If
	ElseIf Instr(UCase(requestedURL), "CHARTE") Then
		requestedURL = "http://laws-lois.justice.gc.ca/fra/Const/index.html"
	Else 
		requestedURL = Replace(requestedURL, "fra", "fra/lois")
	End If

End If
url = Replace(requestedURL,"http://ot1s0178.justice.gc.ca/","D:\Inetpub\wwwroot_WET\")
url = Replace(url,"http://laws-lois.justice.gc.ca/","E:\wwwroot\")
url = Replace(url,"http://lois-laws.justice.gc.ca/","E:\wwwroot\")

url = Replace(url,"/","\")
If IsHttpStatus(url) Then 
	'url = "Yes: " & url
	Response.Status="301 Moved Permanently"
	Response.AddHeader "Location",requestedURL
	'Response.Redirect(requestedURL)
'Else 
	'url = "No: " & url
End If
%>
<!DOCTYPE html>
<!--[if IE 7]><html lang="en" class="no-js ie7"><![endif]-->
<!--[if IE 8]><html lang="en" class="no-js ie8"><![endif]-->
<!--[if gt IE 8]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
<meta charset="utf-8" />
<!-- Web Experience Toolkit (WET) / Boîte à outils de l'expérience Web (BOEW)
wet-boew.github.com/wet-boew/License-eng.txt / wet-boew.github.com/wet-boew/Licence-fra.txt -->
	<title>Page not Found - Page non trouv&eacute;</title>
<link rel="shortcut icon" href="/build/theme-gcwu-fegc/images/favicon.ico" />
<meta name="description" content="Consolidated Federal laws and regulations" />
<meta name="description" lang="fr" content="Lois codifiés Règlements codifiés" />
<meta name="dcterms.creator" content="Justice Department" />
<meta name="dcterms.creator" lang="fr" content="Ministère de la Justice" />
<meta name="dcterms.title" content="ustice Laws Website" />
<meta name="dcterms.title" lang="fr" content="Site Web de la législation (Justice)" />
<meta name="dcterms.issued" title="W3CDTF" content="2012-11-01" />
<meta name="dcterms.modified" title="W3CDTF" content="2012-11-01" />
<meta name="dcterms.subject" title="scheme" content="Consolidated Federal laws and regulations" />
<meta name="dcterms.subject" lang="fr" title="scheme" content="Lois codifiés Règlements codifiés" />
<meta name="dcterms.language" title="ISO639-2" content="eng" />
<meta name="dcterms.language" lang="fr" title="ISO639-2" content="fra" />
<meta name="viewport" content="width=device-width, initial-scale=1" />

<script src="/build/js/jquery.min.js"></script>
<!--[if lte IE 8]>
<script src="/build/js/polyfills/html5shiv-min.js"></script>
<link rel="stylesheet" href="/build/grids/css/util-ie-min.css" />
<link rel="stylesheet" href="/build/js/css/pe-ap-ie-min.css" />
<link rel="stylesheet" href="/build/theme-gcwu-fegc/css/theme-serv-ie-min.css" />
<![endif]-->
<!--[if gt IE 8]><!-->
<link rel="stylesheet" href="/build/grids/css/util-min.css" />
<link rel="stylesheet" href="/build/js/css/pe-ap-min.css" />
<link rel="stylesheet" href="/build/theme-gcwu-fegc/css/theme-serv-min.css" />

<!--<![endif]-->
<noscript><link rel="stylesheet" href="/build/theme-gcwu-fegc/css/theme-ns-min.css" /></noscript>

<!-- CustomScriptsCSSStart -->
<!-- CustomScriptsCSSEnd -->
</head>
<body><div id="wb-body">
<div id="wb-skip">
<ul id="wb-tphp">
<li id="wb-skip1"><a href="#wb-cont">Skip to main content / <span lang="fr">Passer au contenu principal</span></a></li>
<li id="wb-skip2"><a href="#wb-nav">Skip to footer / <span lang="fr">Passer au pied de page</span></a></li>
</ul>
</div>

<div id="wb-head"><div id="wb-head-in"><header>
<!-- HeaderStart -->
<div id="gcwu-title" class="span-8">
<div id="gcwu-sig" class="span-4 row-start"><div id="gcwu-sig-in"><div id="gcwu-sig-eng" title="Government of Canada / Gouvernement du Canada"><img src="/build/theme-gcwu-fegc/images/sig-eng.gif" class="image-actual" width="214" height="20" alt="Government of Canada / Gouvernement du Canada" /></div></div></div>
<div id="gcwu-wmms" class="span-4 row-end"><div id="gcwu-wmms-in"><div id="gcwu-wmms-fip" title="Symbol of the Government of Canada / Symbole du gouvernement du Canada"><img src="/build/theme-gcwu-fegc/images/wmms.gif" class="image-actual" width="126" height="30"  alt="Symbol of the Government of Canada / Symbole du gouvernement du Canada" /></div></div></div>
<div class="clear"></div>

<div id="gcwu-title-left" class="span-4 row-start"><a href="/eng">Justice Laws Website</a></div>
<div id="gcwu-title-right" class="span-4 row-end" lang="fr"><a href="/fra">Site Web de la l&eacute;gislation (Justice)</a></div>
<div class="clear"></div>
</div>
<!-- HeaderEnd -->
</header></div></div>


<div id="wb-core"><div id="wb-core-in" class="equalize">
<div id="wb-main" role="main"><div id="wb-main-in">
<!-- MainContentStart -->


<div class="span-4"><section>
<h2>Page not found</h2>
<p>We apologize...</p>
<p>We cannot locate the web page you are attempting to access. Please check the URL as the page may have been moved or archived.</p>

<%
If firstTry Then
	Response.Write("<p>The structure of the laws site has been updated.  Please try : <br /><a href='")
	Response.Write(requestedURL)
	Response.Write("'>")
	Response.Write(requestedURL)
	Response.Write("</a>")
	Response.Write("</p>")
End If
	'Response.Write("<p>" & url & "</p>")
	'Response.Write("<p>quick " & quickurl & "</p>")
%>

<p>In order to assist you, we recommend that you visit our:</p>
<ul>
<li><a href="/eng">Laws Site Home page</a></li>
<li><a href="/Search">Laws Site Search engine</a></li>
</ul>
<p>Please update your bookmarks and/or links accordingly.</p>

<p><br />Again, we are sorry for any inconvenience this may have caused.</p>

<p>Thank you.</p>
</section></div>


<div class="span-4" lang="fr"><section>
<h2>Page non trouv&eacute;</h2>
<p>Nous regrettons cet inconv&eacute;nient...</p>

<p>Le serveur Web ne parvient pas &agrave; trouver la page que vous tentez de consulter. Veuillez v&eacute;rifier l'adresse URL, car il est possible que cette page ait &eacute;t&eacute; archiv&eacute;e ou d&eacute;plac&eacute;e.</p>

<%
If firstTry Then
	Response.Write("<p>La structure du site Web a &eacute;t&eacute; modifi&eacute;e.  Veuillez  essayer: <br /><a href='")
	Response.Write(requestedURL)
	Response.Write("'>")
	Response.Write(requestedURL)
	Response.Write("</a>")
	Response.Write("</p>")
End If
%><p>Pour vous aider, nous vous recommandons de consulter les liens suivants : </p>
<ul>
<li><a href="/fra">Page d'accueil - Lois du Canada</a></li>
<li><a href="/Recherche">Moteur de recherche - Lois du Canada</a></li>
</ul>

<p>Veuillez mettre &agrave; jour vos signets ou liens en cons&eacute;quence.</p>

<p>De nouveau, nous tenons &agrave; nous excuser de tout inconv&eacute;nient que cette situation a pu vous causer.</p>

<p>Merci.</p>
		
</section></div>
<div  id="gcwu-bar" class="span-8"></div>
<div class="clear"></div>

<!-- MainContentEnd -->
</div></div>
</div></div>

<div id="wb-foot"><div id="wb-foot-in"><footer><h2 id="wb-nav">Footer / <span lang="fr">Pied de page</span></h2>
<!-- FooterStart -->
<div id="gcwu-tc" class="span-8">
<ul>
<li class="gcwu-tc-left"><div class="span-4 row-start"><a href="#" rel="license">Terms and conditions</a></div></li>
<li class="gcwu-tc-right" lang="fr"><div class="span-4 row-end"><a href="#" rel="license">Avis</a></div></li>
</ul>
<div class="clear"></div>
</div>
<!-- FooterEnd -->
</footer>
</div></div>

</div>

<!-- ScriptsStart -->
<script src="/build/theme-gcwu-fegc/js/theme-min.js"></script>
<script src="/build/js/settings.js"></script>
<script src="/build/js/pe-ap-min.js"></script>
<!-- ScriptsEnd -->
</body>
</html>
