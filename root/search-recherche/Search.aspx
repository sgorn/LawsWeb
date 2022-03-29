<%@ Page Language="C#" EnableViewState="false" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="LimsSearch.Search" %>
<!DOCTYPE html>
<!--[if lt IE 9]><html class="no-js lt-ie9" lang="en" dir="ltr"><![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="en" dir="ltr">
<!--<![endif]-->
<head>
<meta charset="utf-8" />
<!-- Web Experience Toolkit (WET) / Boîte à outils de l'expérience Web (BOEW)
wet-boew.github.io/wet-boew/License-en.html / wet-boew.github.io/wet-boew/Licence-fr.html -->

<title>Justice Laws Search</title>
<meta content="width=device-width, initial-scale=1" name="viewport" />
<!-- Meta data -->
<meta name="description" content="Federal laws of canada" />
<meta name="dcterms.title" content="Consolidated federal laws of canada, Access to Information Act" />
<meta name="dcterms.creator" title="Department of Justice" content="Legislative Services Branch" />
<meta name="dcterms.issued" title="W3CDTF" content="2015-07-30" />
<meta name="dcterms.modified" title="W3CDTF" content="2015-07-30" />
<meta name="dcterms.subject" title="scheme" content="Consolidated federal laws of canada" />
<meta name="dcterms.language" title="ISO639-2" content="eng" />
<meta property="dcterms:accessRights" content="2"/>
<meta property="dcterms:service" content="JUS-Laws_Lois"/>
<!-- Meta data-->
<!--[if gte IE 9 | !IE ]><!-->
<link href="/theme-gcwu-fegc/assets/favicon.ico" rel="icon" type="image/x-icon" />
<link rel="stylesheet" href="/theme-gcwu-fegc/css/theme.css" />
<!--<![endif]-->

<!--[if lt IE 9]>
<link href="/theme-gcwu-fegc/assets/favicon.ico" rel="shortcut icon" />
<link rel="stylesheet" href="/theme-gcwu-fegc/css/ie8-theme.css" />
<script src="//assets.adobedtm.com/be5dfd287373/bb72b7edd313/launch-e34f760eaec8.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.js"></script>
<script src="/wet-boew/js/ie8-wet-boew.js"></script>
<![endif]-->

<!-- CustomScriptsCSSStart -->
<link rel="stylesheet" type="text/css" href="/css/search.css" /> 
<link rel="stylesheet" type="text/css" href="/css/categorizedSearch.css" /> 	
<link rel="stylesheet" type="text/css" href="/css/browse.css" />   	
<link rel="stylesheet" type="text/css" href="/css/commonView.css" />   	 
<link rel="stylesheet" type="text/css" href="/css/lawContent.css" />
<link rel="stylesheet" type="text/css" href="/css/privlaw.css" />
<link rel="stylesheet" type="text/css" href="/css/publaw.css" />
<link rel="stylesheet" type="text/css" href="/css/charter.css" />
<!-- CustomScriptsCSSEnd -->
<noscript><link rel="stylesheet" href="/wet-boew/css/noscript.css" /></noscript>
</head>
<body vocab="https://schema.org/" typeof="WebPage">	
<ul id="wb-tphp">
<li class="wb-slc">
<a class="wb-sl" href="#wb-cont">Skip to main content</a>
</li>
<li class="wb-slc visible-sm visible-md visible-lg">
<a class="wb-sl" href="#wb-info">Skip to "About this site"</a>
</li>
<li class="wb-slc visible-md visible-lg">
<a class="wb-sl" href="#wb-sec">Skip to section menu</a>
</li>
</ul>


<header role="banner">
<!--#include virtual="/includes/banner-e.inc" -->
<!-- START BREADCRUMB -->
<nav role="navigation" id="wb-bc" property="breadcrumb">
<h2>You are here:</h2>
<div class="container">
<div class="row">
<ol class="breadcrumb">
<li><a href="https://www.justice.gc.ca/eng">Home</a></li>
<li><a href="/eng">Laws Website Home</a></li>
<li>Basic Search</li>
</ol>
</div>
</div>
</nav>
</header>

<!-- START MAIN CONTENT AREA -->
<div class="container">
<div class="row">

<main role="main" property="mainContentOfPage" class="col-md-9 col-md-push-3">
<!--
<section class="alert alert-warning">
		  <h2>Search feature notice</h2>
			<p>The search feature on the Justice Laws Website will be temporarily unavailable from 8:00 pm until midnight (EST) on Thursday, May 9, 2019 due to server maintenance. We apologize for any inconvenience this may cause.</p></section>	
<section>
-->
<h1 id="wb-cont" class="searchHeader">Basic Search</h1>
<div>
<form id="form1" runat="server" class="form-horizontal">        
<asp:Panel ID="advancedSearchPanel" runat="server">

<div class="form-group">
<label for="txtS3archA11" class="col-md-4 control-label">Keyword(s):</label>
<div class="col-md-6">
<asp:TextBox ID="txtS3archA11" runat="server" CssClass="width-70"></asp:TextBox>

</div>
</div>
<div class="form-group">
<label for="txtT1tl3" class="col-md-4 control-label">Title:</label>

<div class="col-md-6"><asp:TextBox ID="txtT1tl3" runat="server" CssClass="width-70"></asp:TextBox>
</div>
</div>

<div class="form-group">
<label for="ddC0nt3ntTyp3" class="col-md-4 control-label">Search in:</label>

<div class="col-md-6">
<asp:DropDownList ID="ddC0nt3ntTyp3" runat="server" CssClass="width-70">
<asp:ListItem Text="Acts and Regulations" Selected="True" Value="ActsRegs"></asp:ListItem>
<asp:ListItem Text="Acts" Value="Statutes"></asp:ListItem>
<asp:ListItem Text="Regulations" Value="Regulations"></asp:ListItem>
<asp:ListItem Text="Annual Statutes" Value="Annuals"></asp:ListItem>
<asp:ListItem Text="Constitution" Value="Constitution"></asp:ListItem>
<asp:ListItem Text="Table of Public Statutes" Value="TOPS"></asp:ListItem>
<asp:ListItem Text="Table of Private Acts" Value="TOPA"></asp:ListItem>
<asp:ListItem Text="Help Pages" Value="Help"></asp:ListItem>
<asp:ListItem Text="Entire site" Value="All"></asp:ListItem>
</asp:DropDownList>
</div>
</div>

<div class="form-group">
<div class="col-md-4">&nbsp;</div>
<div class="col-md-6">
<asp:CheckBox ID="chkTitlesOnly" runat="server" CssClass="form-checkbox form-label-inline" Text="Show Titles only" />
</div>
</div>

</asp:Panel> 

<div class="row mrgn-tp-md">
<div class="col-md-3">&nbsp;</div>
<div class="col-md-6">
<div class="btn-group btn-group-justified">
<div class="btn-group">
<asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="Search" class="btn btn-primary" />
</div>
<div class="btn-group">
<asp:Button ID="btnClear" runat="server" onclick="btnClear_Click" Text="Clear" class="btn btn-default" />
</div>
</div>
<asp:HiddenField ID="h1dd3nPag3Num" runat="server" Value="1" />
<asp:HiddenField ID="h1dd3nld" runat="server" Value="0" />
<asp:HiddenField ID="h1tNumb3r" runat="server" Value="0" />
</div>
<div class="col-md-3 text-right">
<ul class="HorizontalList">
<li><div class="searchButtonLinks">
<a title="Advanced Search" href="/Search/Advanced.aspx">Advanced Search</a> | </div></li>
<li> <div class="searchButtonLinks">
<a title="Search Help" href="/eng/SearchHelp">Search Help</a></div>
</li>
</ul>
</div>
</div>


<div class="hidden" id="bottomPanel" runat="server">
<a href="javascript:;" class="togglemenu">Display / Hide Categories</a>
<div id="results" runat="server" class="hidden">
<asp:Label ID="Label1"  CssClass="totalMatches" runat="server" Text=""></asp:Label>
    <br />
<asp:Label ID="Label2"  CssClass="totalMatches" runat="server" Text=""></asp:Label>
<div runat="server" id="divPhraseMessage" class="hidden"></div>
<div runat="server" id="divPageNav" class="hidden"></div>

<asp:Repeater id="searchResults" runat="server">
<HeaderTemplate>
<hr />
<ol class="wet-boew-zebra resultList">
</HeaderTemplate>
  <ItemTemplate>
	<li class="resultType1">
       <a class="hitTitleLink" href="<%# this.GetHitLink(Container.DataItem) %>">  
       <%# DataBinder.Eval(Container.DataItem, "Document.Title")%> - 
      <%# DataBinder.Eval(Container.DataItem, "Document.OfficialAlphaNumber")%> <%# DataBinder.Eval(Container.DataItem, "Document.Label")%>
      </a>
      <asp:PlaceHolder ID="MoreDetails" runat="server" Visible='<%# ! (this.textIsEmpty || ! this.chkTitlesOnly.Checked) %>'>
      <div class="gotoPageLinks">
       <a class="hitDetailsLink" href="<%# this.GetHitLink(Container.DataItem) %>">
      Go to Page
      </a>
       | 
      <a class="hitDetailsLink" href="<%# this.BuildQueryString(LimsSearch.filterType.ID, Container.ItemIndex, true) %>">
      Show highlighted hits
      </a>
      </div>
      </asp:PlaceHolder>
      
      <asp:PlaceHolder ID="LongTitle" runat="server" Visible='<%# this.txtS3archA11.Text.Trim() == "" %>'>
        <div>
           <%# DataBinder.Eval(Container.DataItem, "Document.LongTitle")%>
        </div>             
      </asp:PlaceHolder>
      <asp:PlaceHolder ID="bar" runat="server" Visible='<%# this.txtS3archA11.Text.Trim() != "" && ! this.chkTitlesOnly.Checked == true %>'>
      <div id="result-container<%# Container.ItemIndex + 1 %>">
<%--      <ul class="tabs">
        <li><a href="#tab<%# (Container.ItemIndex * 2 ) + 1 %>" id="tab<%# (Container.ItemIndex * 2 ) + 1 %>-link">Hits in context</a></li>
        <li><a href="#tab<%# (Container.ItemIndex * 2 ) + 2 %>" id="tab<%# (Container.ItemIndex * 2 ) + 2 %>-link">Full section content</a></li>
      </ul>--%>
      <div class="results-panel">
        <div id="result<%# (Container.ItemIndex * 2 ) + 1 %>">
            <%# DataBinder.Eval(Container.DataItem, "Document.Context")%>
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
            <h3 class="relatedTerms">Type:</h3>
            <ul></HeaderTemplate>
            <ItemTemplate>
            <li>
                 <a href="<%# this.BuildQueryString(LimsSearch.filterType.LawType, DataBinder.Eval(Container.DataItem, "TypeName"), ! this.chkTitlesOnly.Checked) %>">
              <%# DataBinder.Eval(Container.DataItem, "TypeName")%> 
              (<%# DataBinder.Eval(Container.DataItem, "NumDocs")%>)</a>
                </li>
                </ItemTemplate>
            <FooterTemplate>
            </ul>
            </FooterTemplate>
            </asp:Repeater> 
           <%-- <asp:Repeater ID="rptRelatedTerms" runat="server">
            <HeaderTemplate>
            <p class="relatedTerms">Related phrases: </p>
            <ul></HeaderTemplate>
            <ItemTemplate>
            <li>
              <a href="<%# this.BuildQueryString(LimsSearch.filterType.Related, DataBinder.Eval(Container.DataItem, "Phrase"), this.rdoContext.Checked) %>">
              <%# DataBinder.Eval(Container.DataItem, "Phrase")%> </a>
            </li>
            </ItemTemplate>
            <FooterTemplate></ul></FooterTemplate>
            </asp:Repeater>--%>
             <asp:Repeater runat="server" ID="rptAlphas">
            <HeaderTemplate>
            <h3 class="relatedTerms">Titles:</h3>
            <ul>
            <% Response.Write(this.WriteAllTitlesLink()); %>
            </HeaderTemplate>
            <ItemTemplate>
            <li>
              <a href="<%# this.BuildQueryString(LimsSearch.filterType.LawTitle, DataBinder.Eval(Container.DataItem, "TypeName"), ! this.chkTitlesOnly.Checked) %>">
              <%# DataBinder.Eval(Container.DataItem, "TypeName")%> 
              (<%# DataBinder.Eval(Container.DataItem, "NumDocs")%>)</a>
                </li></ItemTemplate>
            <FooterTemplate>
            </ul>
            </FooterTemplate>
            </asp:Repeater>
        </div>
        </div>
    
    </div> <!-- end of bottomPanel -->
    </form>
    </div>

<!--#include virtual="/includes/gcwu-date-mod-e.inc" -->
</main>
<!--#include virtual="/includes/secmenu_WET4-e.inc" -->
</div>
</div>
<!--#include virtual="/includes/footer_WET4-e.inc" -->
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