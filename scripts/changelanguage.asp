<%
	FromPage = Request.ServerVariables("HTTP_REFERER")
	
	If InStr(LCase(FromPage), "eng")Then
		
		'commas get transfromed to %2C when going from english to french and vise versa
		'This will handle the character before being normalized
	
		If InStr(FromPage, "%2C") Then
			FromPage = Replace(FromPage, "%2C", ",")
		End If
		
		FromPage = LCase(FromPage)
		FromPage = Replace(FromPage, "eng/", "fra/")
		
		If InStr(FromPage, "regulations") Then
			FromPage = Replace(FromPage, "regulations", "reglements")
			FromPage = Replace(FromPage, "sor-", "DORS-")
			FromPage = Replace(FromPage, "si-", "TR-")
			FromPage = Replace(FromPage, "c.r.c.,_c.", "C.R.C.,_ch.")
		End If
		
		FromPage = Replace(FromPage, "search.html", "recherche.html")
		FromPage = Replace(FromPage, "fulltext", "TexteComplet")
		FromPage = Replace(FromPage, "archivenote", "NoteArchivee")
		FromPage = Replace(FromPage, "reports", "Rapports")
		FromPage = Replace(FromPage, "tablepublicstatutes", "TableauLoisPublic")
		FromPage = Replace(FromPage, "repealedstatutes", "LoisAbrogees")
		FromPage = Replace(FromPage, "annualstatutes", "LoisAnnuelles")
		FromPage = Replace(FromPage, "importantnote", "NoteImportante")
		FromPage = Replace(FromPage, "glossary", "Glossaire")
		FromPage = Replace(FromPage, "accessibility", "Accessibilite")
		FromPage = Replace(FromPage, "printing", "Impression")
		FromPage = Replace(FromPage, "searchhelp", "AideRecherche")
		FromPage = Replace(FromPage, "generalhelp", "AideGenerale")
		FromPage = Replace(FromPage, "pdfhelp", "AidePDF")
		FromPage = Replace(FromPage, "relatedresources", "RessourcesConnexes")
		FromPage = Replace(FromPage, "indexationfees", "IndexationFrais")
		FromPage = Replace(FromPage, "indexstatutoryinstruments", "IndexTextesReglementaires")
		FromPage = Replace(FromPage, "linkingguide", "GuideLiens")
		FromPage = Replace(FromPage, "acts.html", "Lois.html")
		FromPage = Replace(FromPage, "charter", "Charte")
		FromPage = Replace(FromPage, "/acts/", "/lois/")

		If InStr(FromPage, "tableprivateacts") Then
			FromPage = Replace(FromPage, "tableprivateacts", "TableauLoisPrive")
			FromPage = Replace(FromPage, "banks", "banques")
			FromPage = Replace(FromPage, "organizations", "associations")
			FromPage = Replace(FromPage, "insurance", "assurances")
			FromPage = Replace(FromPage, "patents", "brevets")
			FromPage = Replace(FromPage, "boards", "chambres")
			FromPage = Replace(FromPage, "railways", "cheminsdefer")
			FromPage = Replace(FromPage, "trust", "fiducie")
			FromPage = Replace(FromPage, "bridges", "ponts")
			FromPage = Replace(FromPage, "harbours", "ports")
			FromPage = Replace(FromPage, "miscellaneous", "divers")
		End If
			
	ElseIf InStr(LCase(FromPage), "fra") Then'French to English
	
		If InStr(FromPage, "%2C") Then
			FromPage = Replace(FromPage, "%2C", ",")
		End If
	
		FromPage = LCase(FromPage)
		FromPage = Replace(FromPage, "fra/", "eng/")
		
		If InStr(FromPage, "reglements") Then
			FromPage = Replace(FromPage, "reglements", "regulations")
			FromPage = Replace(FromPage, "dors-", "SOR-")
			FromPage = Replace(FromPage, "tr-", "SI-")
			FromPage = Replace(FromPage, "c.r.c.,_ch.", "C.R.C.,_c.")
		End If	
		
		FromPage = Replace(FromPage, "recherche.html", "search.html")
		FromPage = Replace(FromPage, "textecomplet", "FullText")
		FromPage = Replace(FromPage, "notearchivee", "ArchiveNote")
		FromPage = Replace(FromPage, "rapports", "Reports")
		FromPage = Replace(FromPage, "tableauloispublic", "TablePublicStatutes")
		FromPage = Replace(FromPage, "loisabrogees", "RepealedStatutes")
	    FromPage = Replace(FromPage, "loisannuelles" , "AnnualStatutes")
	    FromPage = Replace(FromPage, "noteimportante", "ImportantNote")
	    FromPage = Replace(FromPage, "glossaire", "Glossary")
	    FromPage = Replace(FromPage, "impression", "Printing")
		FromPage = Replace(FromPage, "accessibilite", "Accessibility")
	    FromPage = Replace(FromPage, "aiderecherche", "SearchHelp")
	    FromPage = Replace(FromPage, "aidegenerale", "GeneralHelp")
	    FromPage = Replace(FromPage, "aidepdf", "PDFHelp")
	    FromPage = Replace(FromPage, "ressourcesconnexes", "RelatedResources")
		FromPage = Replace(FromPage, "indexationfrais", "IndexationFees")
	    FromPage = Replace(FromPage, "indextextesreglementaires", "IndexStatutoryInstruments")
	    FromPage = Replace(FromPage, "rechercheloisannuelles", "AnnualStatutesSearch")
	    FromPage = Replace(FromPage, "guideliens", "LinkingGuide")
	    FromPage = Replace(FromPage, "lois.html", "Acts.html")
		FromPage = Replace(FromPage, "charte", "Charter")
	    FromPage = Replace(FromPage, "/lois/", "/acts/")
 	    
		
		If InStr(FromPage, "tableauloisprive") Then
			FromPage = Replace(FromPage, "tableauloisprive", "TablePrivateActs")
			FromPage = Replace(FromPage, "associations", "organizations")
			FromPage = Replace(FromPage, "assurances", "insurance")
			FromPage = Replace(FromPage, "banques", "banks")
			FromPage = Replace(FromPage, "brevets", "patents")
			FromPage = Replace(FromPage, "chambres", "boards")
			FromPage = Replace(FromPage, "cheminsdefer", "railways")
			FromPage = Replace(FromPage, "fiducie", "trust")
			FromPage = Replace(FromPage, "ponts", "bridges")
			FromPage = Replace(FromPage, "ports", "harbours")
			FromPage = Replace(FromPage, "divers", "miscellaneous")
		End If
			
	End If
	
	
	If InStr(LCase(FromPage), "recherche") Then
		FromPage = LCase(FromPage)
		FromPage = Replace(FromPage, "recherche", "Search")
		FromPage = Replace(FromPage, "avancee", "Advanced")
	ElseIf InStr(LCase(FromPage), "search") Then
		FromPage = LCase(FromPage)
		FromPage = Replace(FromPage, "search", "Recherche")
		FromPage = Replace(FromPage, "advanced", "Avancee")
	End If
	
	If InStr(LCase(FromPage), "aidesearch") Then
		FromPage = LCase(FromPage)
		FromPage = Replace(FromPage, "aidesearch", "AideRecherche")
	End If
	
	If InStr(LCase(FromPage), "recherchehelp") Then
		FromPage = LCase(FromPage)
		FromPage = Replace(FromPage, "recherchehelp", "SearchHelp")
	End If

	If InStr(FromPage, "section-sched") Then
		FromPage = Left(FromPage, InStr(FromPage, "/section-sched"))
	End If
	    

 Response.Redirect FromPage 
	
%>



