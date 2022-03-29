<%@ Page Language="C#" EnableViewState="false" AutoEventWireup="true" CodeBehind="Avancee.aspx.cs" Inherits="LimsSearch.Avancee" %>
<!DOCTYPE html>
<!--[if lt IE 9]><html class="no-js lt-ie9" lang="fr" dir="ltr"><![endif]--><!--[if gt IE 8]><!-->
<html class="no-js" lang="fr" dir="ltr">
<!--<![endif]-->
<head>
<meta charset="utf-8">
<!-- Web Experience Toolkit (WET) / Boîte à outils de l'expérience Web (BOEW)
wet-boew.github.io/wet-boew/License-en.html / wet-boew.github.io/wet-boew/Licence-fr.html -->
<title>Justice Recherche avanc&eacute;e</title>
<meta content="width=device-width,initial-scale=1" name="viewport">
<!-- Meta data -->
<meta name="description" content="Lois codifi&eacute;es R&egrave;glements codifi&eacute;s">
<meta name="dcterms.title" content="Lois codifi&eacute;es R&egrave;glements codifi&eacute;s">
<meta name="dcterms.creator" content="Minist&egrave;re de la Justice">
<meta name="dcterms.issued" title="W3CDTF" content="2015-11-30">
<meta name="dcterms.modified" title="W3CDTF" content="2015-11-30">
<meta name="dcterms.subject" title="scheme" content="Lois codifi&eacute;es R&egrave;glements codifi&eacute;s">
<meta name="dcterms.language" title="ISO639-2" content="fra">
<meta property="dcterms:accessRights" content="2"/>
<meta property="dcterms:service" content="JUS-Laws_Lois"/>
<!-- Meta data-->
<!--[if gte IE 9 | !IE ]><!-->
<link href="/theme-gcwu-fegc/assets/favicon.ico" rel="icon" type="image/x-icon">
<link rel="stylesheet" href="/theme-gcwu-fegc/css/theme.min.css">
<!--<![endif]-->
<!--[if lt IE 9]>
<link href="/theme-gcwu-fegc/assets/favicon.ico" rel="shortcut icon" />
<link rel="stylesheet" href="/theme-gcwu-fegc/css/ie8-theme.min.css" />
<script src="//assets.adobedtm.com/be5dfd287373/bb72b7edd313/launch-e34f760eaec8.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="/wet-boew/js/ie8-wet-boew.min.js"></script>
<![endif]-->
<noscript><link rel="stylesheet" href="/wet-boew/css/noscript.min.css" /></noscript>
<link rel="stylesheet" type="text/css" href="/css/search.css" /> 
<link rel="stylesheet" type="text/css" href="/css/categorizedSearch.css?version=2" /> 	
<link rel="stylesheet" type="text/css" href="/css/browse.css" />   	
<link rel="stylesheet" type="text/css" href="/css/commonView.css" />   	 
<link rel="stylesheet" type="text/css" href="/css/lawContent.css" />
<link rel="stylesheet" type="text/css" href="/css/privlaw.css" />
<link rel="stylesheet" type="text/css" href="/css/publaw.css" />
<link rel="stylesheet" type="text/css" href="/css/charter.css" />
</head>

<body vocab="http://schema.org/" typeof="WebPage">
<ul id="wb-tphp">
<li class="wb-slc">
<a class="wb-sl" href="#wb-cont">Passer au contenu principal</a>
</li>
<li class="wb-slc visible-sm visible-md visible-lg">
<a class="wb-sl" href="#wb-info">Passer &agrave; «&#160; &agrave; propos de ce site&#160;»</a>
</li>
<li class="wb-slc visible-md visible-lg">
<a class="wb-sl" href="#wb-sec">Passer au menu de la section</a>
</li>
</ul>
<header role="banner">
<!--#include virtual="/includes/banner-f.inc" -->
<!-- START BREADCRUMB -->
<nav role="navigation" id="wb-bc" property="breadcrumb">
<h2>Vous &ecirc;tes ici :</h2>
<div class="container">
<div class="row">
<ol class="breadcrumb">
<li><a href="http://www.justice.gc.ca/fra">Accueil</a></li>
<li><a href="/fra">Site Web de la l&eacute;gislation accueil</a></li>
<li>Recherche avanc&eacute;e</li>
</ol>
</div>
</div>
</nav>
</header>
<!-- START MAIN CONTENT AREA -->
<div class="container">
<div class="row">
<main role="main" property="mainContentOfPage" class="container">
<!--
<section class="alert alert-warning">
		<h2>Avis de fonctionnalit&eacute; de recherche</h2>
		<p>La fonction de recherche sur le Site Web de la l&eacute;gislation (Justice) ne sera pas disponible &agrave; compter de 20 h jusqu'&agrave; minuit (HNE) le jeudi 9 mai 2019 en raison d'un entretien sur le serveur. Nous regrettons tout inconv&eacute;nient que cette interruption pourrait causer.</p>
	</section>	
<section>
-->
<h1 id="wb-cont" class="searchHeader">Recherche avanc&eacute;e</h1>
<div>
<%--<div class="wet-boew-formvalid">--%>
<form id="form1" runat="server" class="form-horizontal">
<details class="searchFormToggle" open="open">
<summary>Formulaire de recherche</summary>


<asp:Panel ID="advancedSearchPanel" runat="server">

<div class="row">
<div class="col-md-6"> <!-- first column of controls -->
<fieldset class="searchGroup"><legend>Mot(s) cl&eacute;(s) :</legend>
<div class="form-group">
<label for="txtS3archA11" class="col-md-6 control-label">tous ces mots :</label> 

<div class="col-md-6">
<asp:TextBox ID="txtS3archA11" runat="server" CssClass="width-90"></asp:TextBox>  
</div></div>

<div class="form-group">
<label for="txtS3arch3xact" class="col-md-6 control-label">cette expression exacte :</label>

<div class="col-md-6">
<asp:TextBox ID="txtS3arch3xact" runat="server" CssClass="width-90"></asp:TextBox>    
</div></div>

<div class="form-group">
<label for="txtS3arch0r" class="col-md-6 control-label">un ou plusieurs de ces mots :</label> 

<div class="col-md-6">
<asp:TextBox ID="txtS3arch0r" runat="server" CssClass="width-90"></asp:TextBox>  
</div></div>


<div class="form-group">
<label for="txtS3archN0t" class="col-md-6 control-label">aucun de ces mots :</label>

<div class="col-md-6">
<asp:TextBox ID="txtS3archN0t" runat="server" CssClass="width-90"></asp:TextBox>  
</div></div>


<div class="form-group">
<label for="ddC0nt3ntTyp3" class="col-md-6 control-label">Rechercher dans :</label>

<div class="col-md-6">
<asp:DropDownList ID="ddC0nt3ntTyp3" runat="server" CssClass="width-80">
<asp:ListItem Text="Lois et r&egrave;glements" Selected="True" Value="ActsRegs"></asp:ListItem>
<asp:ListItem Text="Lois" Value="Statutes"></asp:ListItem>
<asp:ListItem Text="R&egrave;glements" Value="Regulations"></asp:ListItem>
<asp:ListItem Text="Lois annuelles" Value="Annuals"></asp:ListItem>
<asp:ListItem Text="Textes constitutionnels" Value="Constitution"></asp:ListItem>
<asp:ListItem Text="Tableau des lois d'int&eacute;r&ecirc;t public" Value="TOPS"></asp:ListItem>
<asp:ListItem Text="Tableau des lois d'int&eacute;r&ecirc;t priv&eacute;" Value="TOPA"></asp:ListItem>
<asp:ListItem Text="Pages d'aide" Value="Help"></asp:ListItem>
<asp:ListItem Text="Tout le site" Value="All"></asp:ListItem>
</asp:DropDownList>
</div></div>

</div>
<!-- start of second column of controls -->
<div class="col-md-6">
<fieldset  class="searchGroup"><legend>Filtre(s) :</legend>
<div class="form-group">
<label for="txtT1tl3" class="col-md-6 control-label">Titre :</label>

<div class="col-md-6">
<asp:TextBox ID="txtT1tl3" runat="server" CssClass="width-90"></asp:TextBox>        
</div></div>


<div class="form-group">
<label for="txt3nabl3dBy" class="col-md-6 control-label">Loi habilitante :</label>

<div class="col-md-6">
<asp:TextBox ID="txt3nabl3dBy" runat="server" CssClass="width-90"></asp:TextBox>      
</div></div>

<div class="form-group">
<label for="txtAlpha" class="col-md-6 control-label">Chapitre/Num&eacute;ro d'enregistrement :</label>

<div class="col-md-6">
<asp:TextBox ID="txtAlpha" runat="server" CssClass="width-90"></asp:TextBox>
</div> </div>

<div class="form-group">
<label for="inf0rc3Dat3" class="col-md-6 control-label">Date (AAAA-MM-JJ)</label> 						

<div class="col-md-6">
<asp:TextBox id="inf0rc3Dat3" type="date" CssClass="{validate:{dateISO:true}}" runat="server" />
<span class="HelpLink"><a href="/fra/FAQ/#g5">Aide &agrave; la recherche d'une version ant&eacute;rieure</a></span>		
</div></div>

</fieldset>
<div class="form-group">				

<div class="col-md-6">&nbsp;</div>
<div class="col-md-6">
<asp:CheckBox ID="chkTitlesOnly" runat="server" Text="Afficher seulement les titres" CssClass="form-checkbox form-label-inline" />
</div></div>

</div>
</div>
 
<div class="row">
<div class="col-md-6">
<div class="btn-group btn-group-justified">
<div class="btn-group">
<asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="Recherche" class="btn btn-primary" />
</div>
<div class="btn-group">
<asp:Button ID="btnClear" runat="server" onclick="btnClear_Click" Text="Effacer" class="btn btn-default" />
</div>
</div>
</div>
<asp:HiddenField ID="h1dd3nPag3Num" runat="server" Value="1" />
<asp:HiddenField ID="h1dd3nld" runat="server" Value="0" />
<asp:HiddenField ID="h1tNumb3r" runat="server" Value="0" />
<div class="col-md-6 text-right">
<ul class="HorizontalList">
<li><div class="searchButtonLinks">
<a href="/Recherche/Recherche.aspx">Recherche de base</a> | </div></li>
<li> <div class="searchButtonLinks">
<a href="/fra/AideRecherche">Aide &agrave; la recherche</a></div></li>
</ul> 
</div>
</div>

</asp:Panel>

</details> <!-- end of div.toggle-content -->  
    
  <div class="hidden" id="bottomPanel" runat="server">
  
  <a href="javascript:;" class="togglemenu">Afficher / Masquer cat&eacute;gories</a>
    <div id="results" runat="server" class="hidden">
    <asp:Label ID="Label1"  CssClass="totalMatches" runat="server" Text=""></asp:Label>
        <br />
    <asp:Label ID="Label2"  CssClass="totalMatches" runat="server" Text=""></asp:Label>
    <div runat="server" id="divPageNav" class="hidden"></div>
    <asp:Repeater id="searchResults" runat="server">
  <HeaderTemplate>
    <hr />
	<ol class="wet-boew-zebra resultList">
  </HeaderTemplate>
  <ItemTemplate>
	<li class="resultType1">
       <a class="hitTitleLink" href="<%# this.GetHitLink(Container.DataItem) %>"> 
       <%# DataBinder.Eval(Container.DataItem, "Document.Title") %> - 
      <%# DataBinder.Eval(Container.DataItem, "Document.OfficialAlphaNumber")%> <%# DataBinder.Eval(Container.DataItem,"Document.Label") %>
      </a>
       <asp:PlaceHolder ID="MoreDetails" runat="server" Visible='<%# ! (this.textIsEmpty || ! this.chkTitlesOnly.Checked) %>'>
       <div class="gotoPageLinks">
       <a class="hitDetailsLink" href="<%# this.GetHitLink(Container.DataItem) %>">
      Aller &agrave; la page
      </a>
       | 
      <a class="hitDetailsLink" href="<%# this.BuildQueryString(LimsSearch.filterType.ID, Container.ItemIndex, true) %>">
      Donner les r&eacute;sultats en surbrillance
      </a>
      </div>
      </asp:PlaceHolder>
      <asp:PlaceHolder ID="LongTitle" runat="server" Visible='<%# this.txtT1tl3.Text.Trim() != "" %>'>
        <div>
           <%# DataBinder.Eval(Container.DataItem,"Document.LongTitle") %>
        </div>
      </asp:PlaceHolder>
        <asp:PlaceHolder ID="EnablingAuthority" runat="server" Visible='<%# this.txt3nabl3dBy.Text.Trim() != "" %>'>
        <div>
           <p class="EnablingAuthority">Loi(s) habilitante(s) :&nbsp;<%# DataBinder.Eval(Container.DataItem, "Document.EnablingActs")%></p>
        </div>
      </asp:PlaceHolder>           
      <asp:PlaceHolder ID="bar" runat="server" Visible='<%# ! this.chkTitlesOnly.Checked %>'>
      <div id="result-container<%# Container.ItemIndex + 1 %>">
<%--      <ul class="tabs">
        <li><a href="#tab<%# (Container.ItemIndex * 2 ) + 1 %>" id="tab<%# (Container.ItemIndex * 2 ) + 1 %>-link">en contexte</a></li>
        <li><a href="#tab<%# (Container.ItemIndex * 2 ) + 2 %>" id="tab<%# (Container.ItemIndex * 2 ) + 2 %>-link">texte complet</a></li>
      </ul>--%>
      <div class="results-panel">
        <div id="result<%# (Container.ItemIndex * 2 ) + 1 %>">
           <%# DataBinder.Eval(Container.DataItem, "Document.Context") %>
        </div>
<%--        <div id="tab<%# (Container.ItemIndex * 2 ) + 2 %>">
            <p> <%# DataBinder.Eval(Container.DataItem, "Document.Content") %></p>
        </div>--%>
      </div>
      </div>
      <br />
     <%-- <p>Start Date : <%# DataBinder.Eval(Container.DataItem, "Document.InForceStart") %> | End Date : <%# DataBinder.Eval(Container.DataItem, "Document.InForceEnd") %> </p>--%>
	</asp:PlaceHolder></li>
  </ItemTemplate>
  <FooterTemplate>
    </ol>
  </FooterTemplate>
</asp:Repeater>
<hr />
        <div runat="server" id="divPageNav2" class="hidden"></div>
    </div>
    
    <div class="rightMenu" id="rightMenu">
          
         <div id="categories" class="hidden" runat="server">
         
        
            <asp:Repeater runat="server" ID="rptContentTypes">
            <HeaderTemplate>
            <h3 class="relatedTerms">Type :</h3>
            <ul></HeaderTemplate>
            <ItemTemplate>
            <li>
                 <a href="<%# this.BuildQueryString(LimsSearch.filterType.LawType, DataBinder.Eval(Container.DataItem, "TypeName"), false) %>">
              <%# DataBinder.Eval(Container.DataItem, "TypeName")%> 
              (<%# DataBinder.Eval(Container.DataItem, "NumDocs")%>)</a>
                </li>
                </ItemTemplate>
            <FooterTemplate>
            </ul>
            </FooterTemplate>
            </asp:Repeater> 
            
            <asp:Repeater ID="rptRelatedTerms" runat="server">
            <HeaderTemplate>
            <h3 class="relatedTerms">Expressions connexes : </h3>
            <ul></HeaderTemplate>
            <ItemTemplate>
            <li>
              <a href="<%# this.BuildQueryString(LimsSearch.filterType.Related, DataBinder.Eval(Container.DataItem, "Phrase"), false) %>">
              <%# DataBinder.Eval(Container.DataItem, "Phrase")%> </a>
            </li>
            </ItemTemplate>
            <FooterTemplate></ul></FooterTemplate>
            </asp:Repeater>
             <asp:Repeater runat="server" ID="rptAlphas">
            <HeaderTemplate>
            <h3 class="relatedTerms">Titres :</h3>
            <ul>
             <% Response.Write(this.WriteAllTitlesLink()); %>
            </HeaderTemplate>
            <ItemTemplate>
            <li>
              <a href="<%# this.BuildQueryString(LimsSearch.filterType.LawTitle, DataBinder.Eval(Container.DataItem, "TypeName"), false) %>">
              <%# DataBinder.Eval(Container.DataItem, "TypeName")%> 
              (<%# DataBinder.Eval(Container.DataItem, "NumDocs")%>)</a>
                </li></ItemTemplate>
            <FooterTemplate>
            </ul>
            </FooterTemplate>
            </asp:Repeater>
        </div>
        </div> <!-- end of div.rightMenu -->
        </div> <!-- end of bottomPanel -->
    </form>
    </div>
<!--#include virtual="/includes/gcwu-date-mod-f.inc" -->
</main>

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
<script src="/js/lims-toggleMenu.js" type="text/javascript"></script>
</body>
</html>