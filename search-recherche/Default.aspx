<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="LimsSearch._Default" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<link rel="schema.dc" href="http://purl.org/dc/elements/1.1/" />
	<link rel="schema.dcterms" href="http://purl.org/dc/terms/" />

	<!-- Web Experience Toolkit (WET) / Boîte à outils de l'expérience Web (BOEW)
	Terms and conditions of use: http://tbs-sct.ircan.gc.ca/projects/gcwwwtemplates/wiki/Terms
	Conditions régissant l'utilisation : http://tbs-sct.ircan.gc.ca/projects/gcwwwtemplates/wiki/Conditions
	-->

	<!-- Title begins / Début du titre -->
	<title>Justice Laws Advanced Search</title>
	<!-- Title ends / Fin du titre -->
	
	<!-- Favicon (optional) begins / Début du favicon (optionnel) -->
	<!-- <link rel="shortcut icon" href="images/favicon.ico" /> -->
	<!-- Favicon (optional) ends / Find du favicon (optionnel) -->
	
	<!-- Meta-data begins / Début des métadonnées -->
	<meta name="dcterms.description" content="Justice Laws Advanced Search" />
	<meta name="description" content="Justice Laws Advanced Search" />
	<meta name="keywords" content="Justice Laws Advanced Search" />
	<meta name="dcterms.creator" title="Titles of Federal Organizations" content="Department of Justice Canada" />
	<meta name="dcterms.title" content="Justice Laws Advanced Search" />
	<meta name="dcterms.issued" title="W3CDTF" content="Date published (YYYY-MM-DD) / Date de publication (AAAA-MM-JJ)" />
	<meta name="dcterms.modified" title="W3CDTF" content="Date modified (YYYY-MM-DD) / Date de modification (AAAA-MM-JJ)" />
	<meta name="dcterms.subject" title="scheme" content="Justice Laws Advanced Search" />
	<meta name="dcterms.language" title="ISO639-2" content="eng" />
	<meta name="dc.language" title="ISO639-2" content="eng" />
	<!-- Meta-data ends / Fin des métadonnées -->

	<!-- WET scripts/CSS begin / Début des scripts/CSS de la BOEW --><!--[if IE 6]><![endif]-->
	<link href="/css/base.css" rel="stylesheet" type="text/css" />
	<!--[if IE 8]><link href="/css/base-ie8.css" rel="stylesheet" type="text/css" /><![endif]-->
	<!--[if IE 7]><link href="/css/base-ie7.css" rel="stylesheet" type="text/css" /><![endif]-->
	<!--[if lte IE 6]><link href="/css/base-ie6.css" rel="stylesheet" type="text/css" /><![endif]-->
	<link href="/css/util.css" rel="stylesheet" type="text/css" />
<!-- clf2-nsi2 theme begins / Début du thème clf2-nsi2 -->
	<link href="/css/theme-clf2-nsi2.css" rel="stylesheet" type="text/css" />
	<!--[if IE 7]><link href="/css/theme-clf2-nsi2-ie7.css" rel="stylesheet" type="text/css" /><![endif]-->
	<!--[if lte IE 6]><link href="/css/theme-clf2-nsi2-ie6.css" rel="stylesheet" type="text/css" /><![endif]-->
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
	<link rel="stylesheet" type="text/css" href="/css/search.css" /> 
	<link rel="stylesheet" type="text/css" href="/css/institution.css" />    	
	<link rel="stylesheet" type="text/css" href="/css/browse.css" />   	
	<link rel="stylesheet" type="text/css" href="/css/commonView.css" />   	 
	<link rel="stylesheet" type="text/css" href="/css/lawContent.css" />
	<!-- Custom scripts/CSS end / Fin des scripts/CSS personnalisés -->

	<!-- WET print CSS begins / Début du CSS de la BOEW pour l'impression -->
	<link href="/css/pf-if.css" rel="stylesheet" media="print" type="text/css" />
<!-- clf2-nsi2 theme begins / Début du thème clf2-nsi2 -->
	<link href="/css/pf-if-theme-clf2-nsi2.css" rel="stylesheet" media="print" type="text/css" />
<!-- clf2-nsi2 theme ends / Fin du thème clf2-nsi2 -->
	<!-- WET print CSS ends / Fin du CSS de la BOEW pour l'impression -->
</head>
<body>
    <div id="cn-body-inner-2col">

	<!--#include virtual="/includes/cn-banner-e.inc" -->
	
<!-- Breadcrumb begins / D�but du fil d'Ariane -->
			<div id="cn-bcrumb">
				<h2>Breadcrumb</h2>
				<ol><li><a class="breadcrumbs" href="/eng">Home</a>&#x00A0;&gt;&#x00A0;</li>
				<li>Search</li>
				</ol>
			</div>
			<!-- Breadcrumb ends / Fin du fil d'Ariane -->	
		</nav>
		</div>
<!-- clf2-nsi2 theme ends / Fin du th�me clf2-nsi2 -->
	</header>
	</div>
	</div>
	<!-- Header ends / Fin de l'en-t�te -->	
<div id="cn-cols"><!-- Main content begins / Début du contenu principal -->
<div id="cn-centre-col-gap"></div>
	<div id="cn-centre-col" role="main">
		<div id="cn-centre-col-inner">
			<section>
			
            <form id="form1" runat="server">
            <div class="advancedSearch">
            <div class="searchBoxEntry">
            <label class="searchLabel" for="txtS3archT3rms">Keyword(s) :</label>
            <asp:TextBox ID="txtS3archT3rms" runat="server"></asp:TextBox>
             &nbsp;<asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
                Text="Search" /><a href="Advanced.aspx" id="advancedLink" name="advancedLink" title="Advanced Search">Advanced</a>
                
                <span class="errorMessage">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="txtS3archT3rms" ErrorMessage="Enter a term" 
                ForeColor="Maroon"></asp:RequiredFieldValidator>
                <br />
                </span>
        <span class="searchBoxData">
            <label for="ddC0nt3ntTyp3" class="searchLabel">Search in :</label>
            <asp:DropDownList ID="ddC0nt3ntTyp3" name="ddC0nt3ntTyp3" runat="server" Height="20px">
            <asp:ListItem Text="Entire site" Selected="True" Value="All"></asp:ListItem>
            <asp:ListItem Text="Statutes and Regulations" Value="ActsRegs"></asp:ListItem>
            <asp:ListItem Text="Statutes" Value="Statutes"></asp:ListItem>
            <asp:ListItem Text="Regulations" Value="Regulations"></asp:ListItem>
            <asp:ListItem Text="Assented-to Acts" Value="Annuals"></asp:ListItem>
            <asp:ListItem Text="Constitution" Value="Constitution"></asp:ListItem>
            <asp:ListItem Text="Table of Public Statutes" Value="TOPS"></asp:ListItem>
            <asp:ListItem Text="Table of Private Acts" Value="TOPA"></asp:ListItem>
            <asp:ListItem Text="Help Pages" Value="Help"></asp:ListItem>
            </asp:DropDownList></span>
        <br /> 
     </div>
     </div>
        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
            <br />     
             <div runat="server" id="divPageNav" class="hidden"></div>
            <asp:HiddenField ID="h1dd3nPag3Num" runat="server" Value="1" />
        <asp:Repeater id="searchResults" runat="server">
  <HeaderTemplate>
    <hr />
	<ol class="resultList">
  </HeaderTemplate>
  <ItemTemplate>
	<li class="resultType1">
      <a class="hitTitleLink" href="<%# this.AddTermsToLink(DataBinder.Eval(Container.DataItem, "Reference")) %>">
      <%# DataBinder.Eval(Container.DataItem, "Document.Title") %> - 
      <%# DataBinder.Eval(Container.DataItem, "Document.Alphanum") %></a>
      
      <p> <%# DataBinder.Eval(Container.DataItem, "Document.Context") %></p>
      <%--<p>Start Date : <%# DataBinder.Eval(Container.DataItem, "Document.InForceStart") %> | End Date : <%# DataBinder.Eval(Container.DataItem, "Document.InForceEnd") %> </p>--%>
	</li>
  </ItemTemplate>
  <AlternatingItemTemplate>
	<li class="resultType2">
      <a class="hitTitleLink" href="<%# this.AddTermsToLink(DataBinder.Eval(Container.DataItem, "Reference")) %>">
      <%# DataBinder.Eval(Container.DataItem, "Document.Title") %> - 
      <%# DataBinder.Eval(Container.DataItem, "Document.Alphanum") %></a>
      <p> <%# DataBinder.Eval(Container.DataItem, "Document.Context") %></p>
      <%-- <p>Start Date : <%# DataBinder.Eval(Container.DataItem, "Document.InForceStart") %> | End Date : <%# DataBinder.Eval(Container.DataItem, "Document.InForceEnd") %></p>--%>
	</li>
  </AlternatingItemTemplate>
  <FooterTemplate>
    </ol>
  </FooterTemplate>
  <SeparatorTemplate>
    <hr />
  </SeparatorTemplate>
</asp:Repeater>
    </form>
    </section>
<!-- clf2-nsi2 theme ends / Fin du thème clf2-nsi2 -->
		</div>
	</div>

<!-- Main content ends / Fin du contenu principal --> 
<!--#include virtual="/includes/cn-left-e.inc" -->
</div>
<!--#include virtual="/includes/cn-footer-e.inc" -->
</div><!-- Two column layout ends / Fin de la mis en page de deux colonnes -->
</body></html>