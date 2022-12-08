<!DOCTYPE html>
<!--[if lt IE 9]><html class="no-js lt-ie9" lang="en" dir="ltr"><![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="fr" dir="ltr">
<!--<![endif]-->
<head>
<meta charset="utf-8" />
<!-- Web Experience Toolkit (WET) / Boîte à outils de l'expérience Web (BOEW)
wet-boew.github.io/wet-boew/License-en.html / wet-boew.github.io/wet-boew/Licence-fr.html -->

<title>Sondage</title>
<meta content="width=device-width, initial-scale=1" name="viewport" />
<!-- Meta data -->
<meta name="description" content="Lois codifi&eacute;es R&egrave;glements codifi&eacute;s">
<meta name="dcterms.title" content="Lois codifi&eacute;es R&egrave;glements codifi&eacute;s">
<meta name="dcterms.creator" content="Minist&egrave;re de la Justice">
<meta name="dcterms.issued" title="W3CDTF" content="2015-11-30">
<meta name="dcterms.modified" title="W3CDTF" content="2015-11-30">
<meta name="dcterms.subject" title="scheme" content="Lois codifi&eacute;es R&egrave;glements codifi&eacute;s">
<meta name="dcterms.language" title="ISO639-2" content="fra">
<!-- Meta data-->
<!--[if gte IE 9 | !IE ]><!-->
<link href="/theme-gcwu-fegc/assets/favicon.ico" rel="icon" type="image/x-icon" />
<link rel="stylesheet" href="/theme-gcwu-fegc/css/theme.css" />
<!--<![endif]-->

<!--[if lt IE 9]>
<link href="/theme-gcwu-fegc/assets/favicon.ico" rel="shortcut icon" />
<link rel="stylesheet" href="/theme-gcwu-fegc/css/ie8-theme.css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.js"></script>
<script src="/wet-boew/js/ie8-wet-boew.js"></script>
<![endif]-->

<!-- LAWS custom stuff -->
<script src="/js/jquery-ui.js"></script>
<link rel="stylesheet" href="/js/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="/css/browse.css">
<link rel="stylesheet" type="text/css" href="/css/lawContent.css">
<link rel="stylesheet" type="text/css" href="/css/commonView.css">

<noscript><link rel="stylesheet" href="/wet-boew/css/noscript.css" /></noscript>
</head>
<body vocab="http://schema.org/" typeof="WebPage">	
<ul id="wb-tphp">
<li class="wb-slc">
<a class="wb-sl" href="#wb-cont">Passer au contenu principal</a>
</li>
<li class="wb-slc visible-sm visible-md visible-lg">
<a class="wb-sl" href="#wb-info">Passer à «&#160;À propos de ce site&#160;»</a>
</li>
<li class="wb-slc visible-md visible-lg">
<a class="wb-sl" href="#wb-sec">Passer au menu de la section</a>
</li>
</ul>

<header role="banner">
<!--#include virtual="/includes/banner-f.inc" -->

<!-- START BREADCRUMB -->
<nav role="navigation" id="wb-bc" property="breadcrumb">
<h2>Vous êtes ici :</h2>
<div class="container">
<div class="row">
<ol class="breadcrumb">
<li><a href="http://www.justice.gc.ca/fra">Accueil</a></li>
<li><a href="/fra">Site Web de la législation accueil</a></li>
<li>Sondage sur les boutons d’accessibilité</li>
</ol>
</div>
</div>
</nav>
</header>
<!-- END OF BANNER -->

<!-- START MAIN CONTENT AREA -->
<div class="container">
<div class="row">
<main role="main" property="mainContentOfPage" class="col-md-9 col-md-push-3">
<!-- THIS IS WHERE THE PAGE CONTENT GOES -->

<h1 id="wb-cont">Sondage sur les boutons d’accessibilité</h1>
<div class="wet-boew-texthighlight">
<p lang="fr">Merci pour votre avis.</p>

</div>

<%
	FromPage = Request.ServerVariables("HTTP_REFERER")


	dim  readability, ease, efficiency, comments
	Set readability = request.form("readability")
	Set ease = request.form("ease")
	Set efficiency = request.form("efficiency")
	Set comments = request.form("comments")

dim fs,f
set fs=Server.CreateObject("Scripting.FileSystemObject")
set f=fs.OpenTextFile("d:\survey\testSurvey.txt",8,true)
f.Write("readability-" & readability)
f.Write(",ease-" & ease)
f.Write(",efficiency-" & efficiency)
f.WriteLine(",comments-" & comments)
f.Close
set f=Nothing
set fs=Nothing

	
%>

<dl id="wb-dtmd">
<dt>Date :&#32;</dt>
<dd><time property="dateModified">2018-06-05</time></dd>
</dl>
</main>
<!--#include virtual="/includes/secmenu_WET4-f.inc" -->
</div>
</div>
<!--#include virtual="/includes/footer_WET4-f.inc" -->
<!--[if gte IE 9 | !IE ]><!-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.js"></script>
<script src="/wet-boew/js/wet-boew.js"></script>
<!--<![endif]-->
<!--[if lt IE 9]>
<script src="/wet-boew/js/ie8-wet-boew2.js"></script>
<![endif]-->
<script src="/theme-gcwu-fegc/js/theme.js"></script>
</body>
</html>


