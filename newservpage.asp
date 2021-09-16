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
<html lang="en">
<head>
	<meta charset="utf-8" />
	<link rel="schema.dcterms" href="http://purl.org/dc/terms/" />
	<!-- Web Experience Toolkit (WET) / Boîte à outils de l'expérience Web (BOEW)
	Terms and conditions of use: http://tbs-sct.ircan.gc.ca/projects/gcwwwtemplates/wiki/Terms
	Conditions régissant l'utilisation : http://tbs-sct.ircan.gc.ca/projects/gcwwwtemplates/wiki/Conditions
	-->
	<!-- Title begins / Début du titre -->
	<title>Page not Found - Page non trouv&eacute;</title>
	<!-- Title ends / Fin du titre -->
	<!-- Favicon (optional) begins / Début du favicon (optionnel) -->
<link rel="shortcut icon" href="/images/favicon.ico" />
	<!-- Favicon (optional) ends / Find du favicon (optionnel) -->
	<!-- Meta-data begins / Début des métadonnées -->
	<meta name="robots" content="none" />
	<meta name="dcterms.title" content="HTTP Error 404 - Not Found" />
	<meta name="dcterms.title" lang="fr" content="Erreur HTTP 404 - Non trouvé" />
	<meta name="dcterms.language" title="ISO639-2" content="eng" />
	<meta name="dcterms.language" lang="fr" title="ISO639-2" content="fra" />
	<!-- Meta-data ends / Fin des métadonnées -->
	<!-- WET scripts/CSS begin / Début des scripts/CSS de la BOEW --><!--[if IE 6]><![endif]-->
	<link href="/css/base.css" rel="stylesheet" type="text/css" />
	<!--[if IE 8]><link href="/css/base-ie8.css" rel="stylesheet" type="text/css" /><![endif]-->
	<!--[if IE 7]><link href="/css/base-ie7.css" rel="stylesheet" type="text/css" /><![endif]-->
	<!--[if lte IE 6]><link href="/css/base-ie6.css" rel="stylesheet" type="text/css" /><![endif]-->
	<link href="/css/util.css" rel="stylesheet" type="text/css" />
<!-- clf2-nsi2 theme begins / Début du thème clf2-nsi2 -->
<link href="/css/servpage-theme-clf2-nsi2.css" rel="stylesheet" type="text/css" />
	<!--[if lte IE 6]><link href="/css/servpage-theme-clf2-nsi2-ie6.css" rel="stylesheet" type="text/css" /><![endif]-->
<!-- clf2-nsi2 theme ends / Fin du thème clf2-nsi2 -->
	<!-- WET scripts/CSS end / Fin des scripts/CSS de la BOEW -->

	<!-- Progressive enhancement begins / Début de l'amélioration progressive -->
	<script src="/js/lib/jquery.min.js" type="text/javascript"></script>
	<script src="/js/pe-ap.js" type="text/javascript" id="progressive"></script>
	<script type="text/javascript">
	/* <![CDATA[ */
		var params = {
		};
		PE.progress(params);
	/* ]]> */
	</script>
	<!-- Progressive enhancement ends / Fin de l'amélioration progressive -->

	<!-- Custom scripts/CSS begin / Début des scripts/CSS personnalisés -->
	<!-- Custom scripts/CSS end / Fin des scripts/CSS personnalisés -->

	<!-- WET print CSS begins / Début du CSS de la BOEW pour l'impression -->
	<link href="/css/pf-if.css" rel="stylesheet" media="print" type="text/css" />
<!-- clf2-nsi2 theme begins / Début du thème clf2-nsi2 -->
	<link href="/css/pf-if-theme-clf2-nsi2.css" rel="stylesheet" media="print" type="text/css" />
<!-- clf2-nsi2 theme ends / Fin du thème clf2-nsi2 -->
	<!-- WET print CSS ends / Fin du CSS de la BOEW pour l'impression -->

<!-- Do not remove - this WebTrends SDC tag - STARTS --> 	
	<!--#include virtual="/wt_scripts/webtrends.inc" -->
	<META name="DCS.dcssta" content="404"></META>;
<!-- Do not remove - this WebTrends SDC tag - STARTS --> 	
 


</head>
<body>
<!-- One column layout begins / Début de la mise en page d'une colonne -->
<div id="cn-body-inner-1col">
	<!-- Skip header begins / Début du saut de l'en-tête -->
	<div id="cn-skip-head">
	<nav>
		<ul id="cn-tphp">
			<li id="cn-sh-link-1"><a href="#cn-cont">Skip to main content / <span lang="fr">Passer au contenu principal</span></a></li>
			<li id="cn-sh-link-2"><a href="#cn-nav">Skip to footer / <span lang="fr">Passer au pied de page</span></a></li>
		</ul>	</nav>
	</div>
	<!-- Skip header ends / Fin du saut de l'en-tête -->

	<!-- Header begins / Début de l'en-tête -->	<div id="cn-head"><div id="cn-head-inner">
	<header>
<!-- clf2-nsi2 theme begins / Début du thème clf2-nsi2 -->
		<div id="cn-sig"><img src="/images/sig-eng.gif" alt="Government of Canada / Gouvernement du Canada" title="Government of Canada / Gouvernement du Canada" /></div>
		<div id="cn-wmms"><img src="/images/wmms.gif" alt="Symbol of the Government of Canada / Symbole du gouvernement du Canada" title="Symbol of the Government of Canada / Symbole du gouvernement du Canada" /></div>
<!-- clf2-nsi2 theme ends / Fin du thème clf2-nsi2 -->
	</header>
	</div></div>
	<!-- Header ends / Fin de l'en-tête -->

	<div id="cn-cols">
	<!-- Main content begins / Début du contenu principal -->
	<div id="cn-centre-col" role="main"><div id="cn-centre-col-inner">
	<section>
		<!-- Content title begins / Début du titre du contenu -->
		<header>
			<h1 id="cn-cont">HTTP Error 404 - Not Found - <span lang="fr">Erreur HTTP 404 - Non trouv&eacute;</span></h1>
		</header>
		<!-- Content Title ends / Fin du titre du contenu -->

<!-- clf2-nsi2 theme begins / Début du thème clf2-nsi2 -->
		<!-- English message begins / Début du message en anglais -->
		<div id="cn-left-msg">
		<section>
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

<p><br />In order to assist you, we recommend that you visit our:</p>
<ul>
<li><a href="/eng">Laws Site Home page</a></li>
<li><a href="/Search">Laws Site Search engine</a></li>
</ul>
<p>Please update your bookmarks and/or links accordingly.</p>

<p><br />Again, we are sorry for any inconvenience this may have caused.</p>

<p>Thank you.</p>
		
		</section>
		</div>
		<!-- English message ends / Fin du message en anglais -->

		<!-- French message begins / Début du message en français -->
		<div id="cn-right-msg" lang="fr">
		<section>
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
%>

<p>Pour vous aider, nous vous recommandons de consulter les liens suivants : </p>
<ul>
<li><a href="/fra">Page d'accueil - Lois du Canada</a></li>
<li><a href="/Recherche">Moteur de recherche - Lois du Canada</a></li>
</ul>

<p>Veuillez mettre &agrave; jour vos signets ou liens en cons&eacute;quence.</p>

<p>De nouveau, nous tenons &agrave; nous excuser de tout inconv&eacute;nient que cette situation a pu vous causer.</p>

<p>Merci.</p>
		
		</section>
		</div>
		<!-- French message ends / Fin du message en français -->
<!-- clf2-nsi2 theme ends / Fin du thème clf2-nsi2 -->
	</section>
	</div></div>
	<!-- Main content ends / Fin du contenu principal -->
	</div>

	<!-- Footer begins / Début du pied de page -->
	<div id="cn-foot"><div id="cn-foot-inner">
	<footer>
		<h2 id="cn-nav">Footer</h2>
<!-- clf2-nsi2 theme begins / Début du thème clf2-nsi2 -->
		<div id="cn-in-pd">
			<ul>
				<li id="cn-inotices-link-left"><a href="#" rel="license">Important Notices</a></li>
				<li id="cn-inotices-link-right" lang="fr"><a href="#" rel="license">Avis importants</a></li>
			</ul>
		</div>
<!-- clf2-nsi2 theme ends / Fin du thème clf2-nsi2 -->
	</footer>
	</div></div>
	<!-- Footer ends / Fin du pied de page -->
</div>
<!-- One column layout ends / Fin de la mis en page d'une colonne -->
</body>
</html>

