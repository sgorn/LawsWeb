<?xml version='1.0' encoding='ISO-8859-1'?>

<!-- =============================================================== -->
<!--                                                                 -->
<!-- Convert LIMS XML to X HTML                    						-->
<!--                                                                 -->
<!-- =============================================================== -->

<xsl:stylesheet version="1.0"
            xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
            xmlns:lims="http://justice.gc.ca/lims"
				xmlns:m="http://www.w3.org/1998/Math/MathML"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"				
	extension-element-prefixes="msxsl"
	xmlns:CGext="urn:custom-extensions"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
      exclude-result-prefixes="xsl m lims msxsl CGext fo">
		<!-- xmlns="http://www.w3.org/Profiles/xhtml1-transitional" -->

<xsl:output
	method="xml"
	encoding="utf-8"
	omit-xml-declaration="yes"
	indent="no"/>

<!-- xsl:param name="nesting-level" select="'1'"/>
<xsl:param name="class" select="'unknown'"/>
<xsl:param name="label" select="'__'"/ -->
<xsl:param name="language" select="'fr'" />
<xsl:param name="folder" select="'C-46'"/>
<!-- xsl:param name="hidden-regulations" select="'no'" / -->
<xsl:param name="InForce" select="'perhaps'" />
		  
<xsl:template match="/">
		  <xsl:apply-templates />
</xsl:template>

<xsl:template match="Label" mode="pulled">
  <xsl:choose>
	  <xsl:when test="parent::Section">
					 <strong><xsl:apply-templates /></strong>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates />
		 </xsl:otherwise>
	</xsl:choose>
	<xsl:text>&#x00A0;</xsl:text>
</xsl:template>

<xsl:template match="Label[parent::Section]">
		  <xsl:if test="not(ancestor::Schedule)"><xsl:message>~<xsl:choose><xsl:when test="$language='fr'"><xsl:text>Article </xsl:text></xsl:when>
					  <xsl:otherwise><xsl:text>Section </xsl:text></xsl:otherwise></xsl:choose><xsl:apply-templates /></xsl:message></xsl:if>
</xsl:template>

<xsl:template match="Title"><xsl:apply-templates /></xsl:template>

<xsl:template name="GetClassFromFormatRef">
		  <xsl:param name="formatref" />
		  <xsl:choose>
					 <xsl:when test="$formatref='indent-1-0'">
							<xsl:text>Section</xsl:text>
				 </xsl:when>
					 <xsl:when test="$formatref='indent-1-1'">
							<xsl:text>Paragraph</xsl:text>
					 </xsl:when>
					 <xsl:when test="$formatref='indent-2-2'">
							<xsl:text>Subparagraph</xsl:text>
					 </xsl:when>
					 <xsl:when test="$formatref='indent-3-3'">
							<xsl:text>Clause</xsl:text>
					 </xsl:when>
					 <xsl:when test="$formatref='indent-4-4'">
							<xsl:text>Subclause</xsl:text>
					 </xsl:when>
					 <xsl:when test="$formatref='indent-5-5'">
							<xsl:text>Subsubclause</xsl:text>
					 </xsl:when>
					 <xsl:when test="$formatref='centered'">
							<xsl:text>Centered</xsl:text>
					 </xsl:when>
					 <xsl:when test="$formatref='group1-part'">
							<xsl:text>Topic</xsl:text>
					 </xsl:when>
					 <xsl:when test="$formatref='group2-division'">
							<xsl:text>Subheading</xsl:text>
					 </xsl:when>
					 <xsl:when test="$formatref='group3-subdivision'">
							<xsl:text>Subheading</xsl:text>
					 </xsl:when>
					 <xsl:when test="$formatref='group4'">
							<xsl:text>Subheading</xsl:text>
					 </xsl:when>
					 <xsl:when test="$formatref='group5'">
							<xsl:text>Subheading</xsl:text>
					 </xsl:when>
					 <xsl:otherwise>
								<xsl:value-of select="$formatref" />
					 </xsl:otherwise>
		  </xsl:choose>
</xsl:template>


<xsl:template name="GetClassFromProvision">
		  <xsl:param name="provision" />
		  <xsl:choose>
					 <xsl:when test="msxsl:node-set($provision)[@format-ref]">
								<xsl:call-template name="GetClassFromFormatRef">
										  <xsl:with-param name="formatref"><xsl:value-of select="msxsl:node-set($provision)[@format-ref]" /></xsl:with-param>
								</xsl:call-template>
					 </xsl:when>
					 <xsl:otherwise>
								<xsl:text>CustomProvision</xsl:text>
					 </xsl:otherwise>
		  </xsl:choose>
</xsl:template>

<xsl:template match="Item/Text">
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="Text">
		  <xsl:variable name="class">
					 <xsl:choose>
								<xsl:when test="parent::Provision">
										  <xsl:call-template name="GetClassFromProvision"><xsl:with-param name="provision"><xsl:value-of select="parent::Provision" /></xsl:with-param></xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
										  <xsl:value-of select="name(parent::*)" />
								</xsl:otherwise>
					 </xsl:choose>
		  </xsl:variable>
		  <xsl:variable name="hide">
			 <xsl:choose>
			 <xsl:when test="contains(parent::*,'span class=')"><xsl:text>no</xsl:text></xsl:when>
			 <xsl:otherwise><xsl:text>yes</xsl:text></xsl:otherwise>
				</xsl:choose>
	 </xsl:variable>
			<p><xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute>
					  <xsl:if test="$hide='yes'"><xsl:attribute name="hide"><xsl:text>yes</xsl:text></xsl:attribute></xsl:if>
 <xsl:if test="parent::Subsection[not(preceding-sibling::Subsection) and parent::Section]">
	<xsl:apply-templates select="parent::Subsection/parent::Section/Label" mode="pulled" />
 </xsl:if>
	<xsl:if test="preceding-sibling::*[1][self::Label]">
		<xsl:apply-templates select="preceding-sibling::Label[1]" mode="pulled" />
	</xsl:if>
	<xsl:if test="preceding-sibling::*[1][self::FormulaTerm]">
		<xsl:apply-templates select="preceding-sibling::FormulaTerm[1]" />
	</xsl:if>
	<xsl:apply-templates />
  </p>
</xsl:template>

<xsl:template match="Note">
 <p><xsl:apply-templates /></p>
</xsl:template>


<xsl:template match="HistoricalNote">
  <p class="HistoricalNote"  style="text-indent:0em;" >
	 <xsl:apply-templates />
  </p>
</xsl:template>

<xsl:template match="OriginatingRef">
  <p class="OriginatingRef">
	<xsl:apply-templates />
  </p>
</xsl:template>

<xsl:template match="ProvisionHeading">
		  <xsl:choose>
					 <xsl:when test="starts-with(@format-ref,'group')">
								<xsl:choose>
										<xsl:when test="@format-ref='group1-part'">
											<h1 class="Topic">
												<xsl:apply-templates />
											</h1>
										</xsl:when>
										<xsl:when test="@format-ref='group2-division'">
												<h2 class="Subheading">
												<xsl:apply-templates />
												</h2>
									 	</xsl:when>
										<xsl:when test="@format-ref='group3-subdivision'">
											<h3 class="Subheading">
												<xsl:apply-templates />
											</h3>
										</xsl:when>
										<xsl:when test="@format-ref='group4'">
											<h4>
												<xsl:apply-templates />
											</h4>
									 </xsl:when>
									 <xsl:otherwise>
											<h5>
												<xsl:apply-templates />
											</h5>
									 </xsl:otherwise>
							  </xsl:choose>
					</xsl:when>
					<xsl:when test="@format-ref">
					  <p><xsl:attribute name="class"><xsl:call-template name="GetClassFromProvision"><xsl:with-param name="provision"><xsl:value-of select="." /></xsl:with-param></xsl:call-template></xsl:attribute><xsl:apply-templates />
					  </p>
			</xsl:when>
			<xsl:otherwise>
				<h5>
					<xsl:apply-templates />
				</h5>
			</xsl:otherwise>
	 </xsl:choose>
</xsl:template>

<xsl:template match="Fraction">
  <xsl:choose>
		<xsl:when test="Numerator">
			<xsl:variable name="math-ml">
		  	<!-- fo:instream-foreign-object font-family="Arial Unicode MS" -->
				<math xmlns="http://www.w3.org/1998/Math/MathML"><mfrac><xsl:apply-templates/></mfrac></math>
				<!-- /fo:instream-foreign-object -->
			</xsl:variable>
			<xsl:copy-of select="CGext:CreatePNGFromMathML($math-ml,$folder)" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- This file is responsible for formatting the inline element Numerator -->
<xsl:template match="Numerator">
<!-- mrow xmlns="http://www.w3.org/1998/Math/MathML"><xsl:apply-templates /></mrow -->
<mrow xmlns="http://www.w3.org/1998/Math/MathML"><xsl:apply-templates mode="mathML" /></mrow>
</xsl:template>

<xsl:template match="text()" mode="mathML">
	
	<!-- In AntennaHouse (AH), when the denominator as only a single character, it gets italized.  
	To overcome this issue, we append this single character with a non-break space-->
	<!-- xsl:variable name="append-non-break-space">
		<xsl:value-of select="string-length(./text()) = 1 and parent::Denominator" />
	</xsl:variable>
	
	<mi xmlns="http://www.w3.org/1998/Math/MathML">
	    <xsl:if test="$append-non-break-space">
			<xsl:text>&#xa0;</xsl:text>
		</xsl:if>
		<xsl:value-of select="." />
		<xsl:if test="$append-non-break-space">
			<xsl:text>&#xa0;</xsl:text>
		</xsl:if>
	</mi -->
<mi xmlns="http://www.w3.org/1998/Math/MathML"><xsl:value-of select="." /></mi>
</xsl:template>

<!-- This file is responsible for formatting the inline element Denominator-->
<xsl:template match="Denominator">
<mrow xmlns="http://www.w3.org/1998/Math/MathML"><xsl:apply-templates mode="mathML" /></mrow>
</xsl:template>


<xsl:template match="msup | MSup" mode="mathML">
 <msup xmlns="http://www.w3.org/1998/Math/MathML">
	<xsl:choose>
	  	<xsl:when test="Base or base">
			<mi>
				<xsl:value-of select="Base | base" />
			</mi>
			<mi>
				<xsl:value-of select="Superscript | superscript" />
			</mi>
		</xsl:when>
		<xsl:otherwise>
			<xsl:copy-of select="node()"/>
		</xsl:otherwise>
	</xsl:choose>
  </msup>						
</xsl:template>

<xsl:template match="msub | MSub" mode="mathML">
  <msub xmlns="http://www.w3.org/1998/Math/MathML">		
	<xsl:choose>
	  	<xsl:when test="Base or base">
			<mi>
				<xsl:value-of select="Base | base" />
			</mi>
			<mi>
				<xsl:value-of select="Subscript | subscript" />
			</mi>
		</xsl:when>
		<xsl:otherwise>
			<xsl:copy-of select="node()"/>
		</xsl:otherwise>
	</xsl:choose>
  </msub>				
</xsl:template>

<xsl:template match="Base | base">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="Superscript | superscript">
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="Subscript | subscript">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="MathML">
	<!-- xsl:variable name="math-ml">
			<fo:instream-foreign-object font-family="Arial Unicode MS">
			<xsl:apply-templates />
			</fo:instream-foreign-object>
	 </xsl:variable>
	 <xsl:copy-of select="CGext:CreatePNGFromMathML($math-ml,$folder)" / -->
	<xsl:copy-of select="CGext:CreatePNGFromMathML(.,$folder)" />
</xsl:template>

<xsl:template match="math">
		
	<math xmlns="http://www.w3.org/1998/Math/MathML">
		<!-- xsl:copy-of select="*" / -->
		<!-- Work around since copy-of will assign empty namespaces to elements and this will cause problems with AntennaHouse rendering of MathML -->
		<!-- When xslt engine will support XSLT 2.0 - we will add an attribute named "copy-namespaces" with a value of "no"  -->
		<!-- Example: <xsl:copy-of select="node() | @*" copy-namespaces="no"/> -->
		<xsl:apply-templates mode="mathMLandChangeNS"/>
	</math>
</xsl:template>

<xsl:template match="*" mode="mathMLandChangeNS"> 
	<!-- create a new element with the same local name --> 
	<xsl:element name="{local-name()}" namespace="http://www.w3.org/1998/Math/MathML"> 
		  <!-- copy all the attributes from the matched element --> 
		  <xsl:copy-of select="@*"/>
		  <!-- apply templates on the same mode to get its content copied and  change the namespace  --> 
		  <xsl:apply-templates select="node()" mode="mathMLandChangeNS"/> 
	</xsl:element> 
</xsl:template>

<xsl:template match="ImageGroup">
		  <xsl:if test="Caption[@position='over']">
					 <xsl:apply-templates select="Caption" />
		  </xsl:if>
		  <xsl:apply-templates select="*[not(self::Caption)]" />
		  <xsl:if test="Caption[not(@position='over')]">
				<xsl:apply-templates select="Caption" />
		  </xsl:if>
</xsl:template>

<xsl:template match="Image">
		  <img><xsl:attribute name="source"><xsl:value-of select="@source" /></xsl:attribute>
					 <xsl:if test="preceding-sibling::AlternateText"><xsl:attribute name="alt"><xsl:value-of select="preceding-sibling::AlternateText" /></xsl:attribute></xsl:if>
		  </img>
</xsl:template>

<xsl:template match="FormBlank">
		  <xsl:text>&#x00A0;{&#x00A0;</xsl:text><em><xsl:apply-templates /></em><xsl:text>&#x00A0;}&#x00A0;</xsl:text>
</xsl:template>

<xsl:template match="LineBreak">
		  <br />
</xsl:template>

<xsl:template match="RunningHead | PageBreak">
</xsl:template>

	<xsl:template match="Schedule">
			<xsl:apply-templates />			  
  </xsl:template>
<xsl:template match="RegulationPiece | BillPiece | Preamble | Order | Recommendation">
		  <xsl:apply-templates />
</xsl:template>

<xsl:template match="List">
		  <xsl:choose>
					 <xsl:when test="@style='roman-lc'">
								<ol class="roman-lc"><xsl:apply-templates /></ol>
					  </xsl:when>
					 <xsl:when test="@style='roman-uc'">
								<ol class="roman-uc"><xsl:apply-templates /></ol>
					 </xsl:when>
					 <xsl:when test="@style='alphabet-lc'">
								<ol class="alphabet-lc"><xsl:apply-templates /></ol>
					 </xsl:when>
 					 <xsl:when test="@style='alphabet-uc'">
								<ol class="alphabet-uc"><xsl:apply-templates /></ol>
					 </xsl:when>
 					 <xsl:when test="@style='bullet'">
								<ul class="bullet"><xsl:apply-templates /></ul>
					 </xsl:when>					 
 					 <xsl:when test="@style='en-dash'">
								<ul class="en-dash"><xsl:apply-templates /></ul>
					  </xsl:when>					 
 					 <xsl:when test="@style='em-dash'">
								<ul class="em-dash"><xsl:apply-templates /></ul>
					  </xsl:when>					 
					  <xsl:otherwise>
								 <ol><xsl:apply-templates /></ol>
					  </xsl:otherwise>
			</xsl:choose>
 </xsl:template>

 <xsl:template match="Item">
			<li><xsl:if test="Label"><xsl:apply-templates select="Label"/><xsl:text>&#x00A0;</xsl:text></xsl:if><xsl:apply-templates select="*[not(Label)]" /></li>
 </xsl:template>

<xsl:template match="AmendedText | AmendedContent">
		  <xsl:apply-templates />
</xsl:template>

<xsl:template match="ReadAsText | QuotedText">
		  <xsl:apply-templates />
</xsl:template>

<xsl:template match="DocumentInternal | Group | SectionPiece">
		  <xsl:apply-templates />
</xsl:template>

<xsl:template match="Section">
		  <!-- xsl:apply-templates select="*[not(self::Label)]"/ -->
		  <xsl:apply-templates />
</xsl:template>

<xsl:template match="Subsection | Paragraph | Subparagraph | Clause | Subclause | Subsubclause | Provision">
	<xsl:apply-templates select="*[not(self::Label)]" />
</xsl:template>

<xsl:template match="ContinuedSectionSubsection | ContinuedParagraph | ContinuedSubparagraph | ContinuedClause | ContinuedSubclause | ContinuedDefinition | ContinuedFormulaParagraph ">
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="Definition">
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="Preamble/Provision/MarginalNote">
		  <p class="MarginalNote">
		  <xsl:variable name="hide">
			 <xsl:choose>
					 <xsl:when test="contains(parent::*,'span class=')"><xsl:text>no</xsl:text></xsl:when>								
					 <xsl:otherwise><xsl:text>yes</xsl:text></xsl:otherwise>
			 </xsl:choose>
			</xsl:variable>
		  <xsl:if test="$hide='yes'"><xsl:attribute name="hide"><xsl:text>yes</xsl:text></xsl:attribute></xsl:if>
		 <xsl:apply-templates /></p>
</xsl:template>

<xsl:template match="MarginalNote">
		  <p class="MarginalNote">
		  <xsl:variable name="hide">
			 <xsl:choose>
					 <xsl:when test="contains(parent::*,'span class=')"><xsl:text>no</xsl:text></xsl:when>								
					 <xsl:otherwise><xsl:text>yes</xsl:text></xsl:otherwise>
			 </xsl:choose>
			</xsl:variable>
		  <xsl:if test="$hide='yes'"><xsl:attribute name="hide"><xsl:text>yes</xsl:text></xsl:attribute></xsl:if>
		 <xsl:apply-templates /></p>
</xsl:template>


<xsl:template match="DefinedTermEn">
		  <xsl:choose>
					 <xsl:when test="$language='fr' and parent::Text[parent::Definition[not(MarginalNote)]]">
								<!-- xsl:text>(</xsl:text -->
				 <!-- Old regulation style definitions with no marginal notes opposite language ones-->
							<em><xsl:apply-templates /></em>
							<!-- xsl:text>)</xsl:text -->
	  				</xsl:when>
					 <xsl:when test="$language='fr'">
							<xsl:text>&#x00AB;&#x2009;</xsl:text>
								<em><xsl:apply-templates /></em>
							<xsl:text>&#x2009;&#x00BB;</xsl:text>
					 </xsl:when>
					 <xsl:otherwise>
							<xsl:text>&#x201C;</xsl:text>
								<xsl:apply-templates />
							<xsl:text>&#x201D;</xsl:text>
					 </xsl:otherwise>
		  </xsl:choose>
</xsl:template>

<xsl:template match="DefinedTermFr">
		  <xsl:choose>
					 <xsl:when test="$language='en' and parent::Text[parent::Definition[not(MarginalNote)]]">
						 <!-- Old regulation style definitions with no marginal notes - opposite language  -->					 
					 <em><xsl:apply-templates /></em>
							<!-- xsl:text>)</xsl:text -->
					  </xsl:when>				 
					 <xsl:when test="$language='fr'">
							<xsl:text>&#x00AB;&#x2009;</xsl:text>
								<xsl:apply-templates />
							<xsl:text>&#x2009;&#x00BB;</xsl:text>
					 </xsl:when>
					 <xsl:otherwise>
							<xsl:text>&#x201C;</xsl:text>
								<em><xsl:apply-templates /></em>
							<xsl:text>&#x201D;</xsl:text>
					 </xsl:otherwise>
		  </xsl:choose>
</xsl:template>

<xsl:template match="XRefExternal">
		  <em><xsl:apply-templates /></em>
</xsl:template>

<xsl:template match="Language">
		 <xsl:choose>
			<xsl:when test="@xml:lang=$language">
					<xsl:apply-templates />
				</xsl:when>
				<xsl:otherwise>
				  <em><xsl:apply-templates /></em>
		 	</xsl:otherwise>
		 </xsl:choose>
</xsl:template>

<xsl:template match="XRefInternal">
		  <xsl:apply-templates />
</xsl:template>

<xsl:template match="Heading">
		  <xsl:apply-templates />
</xsl:template>

<xsl:template match="ScheduleFormHeading">
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="GroupHeading">
	  <xsl:apply-templates />
</xsl:template>

<xsl:template match="Group1-Part | Group2-Division | Group3-Subdivision | Group4 | Group5">
		  <xsl:apply-templates />
</xsl:template>

<xsl:template match="Heading[@level='1']/Label">
		<h1 class="Part">
			<xsl:apply-templates />
		</h1>
</xsl:template>

<xsl:template match="Heading[@level='1']/TitleText">
	<h1 class="Topic"  style="margin-top:1.0em;" >
		<xsl:apply-templates />
	</h1>
</xsl:template>

<xsl:template match="Heading[@level='2']/Label">
	<h2 class="Subheading">
		<xsl:apply-templates />
	</h2>
</xsl:template>

<xsl:template match="Heading[@level='2']/TitleText">
	<h2 class="Subheading"  style="margin-top:1.0em;" >
		<xsl:apply-templates />
	</h2>
</xsl:template>

<xsl:template match="Heading[@level='3']/Label">
	<h3 class="Subheading">
		<xsl:apply-templates />
	</h3>
</xsl:template>

<xsl:template match="Heading[@level='3']/TitleText">
	<h3 class="Subheading"  style="margin-top:1.0em;" >
		<xsl:apply-templates />
	</h3>
</xsl:template>

<xsl:template match="GroupHeading[@format-ref='group1-part']/TitleText">
	<h1 class="Topic"  style="margin-top:1.0em;" >
		<xsl:apply-templates />
	</h1>
</xsl:template>

<xsl:template match="GroupHeading[@format-ref='group1-part']/Label">
	<h1 class="Topic"  style="margin-top:1.0em;" >
		<xsl:apply-templates />
	</h1>
</xsl:template>

<xsl:template match="GroupHeading[@format-ref='group2-division']/Label">
	<h2 class="Subheading">
		<xsl:apply-templates />
	</h2>
</xsl:template>

<xsl:template match="GroupHeading[@format-ref='group2-division']/TitleText">
	<h2 class="Subheading"  style="margin-top:1.0em;" >
		<xsl:apply-templates />
	</h2>
</xsl:template>

<xsl:template match="GroupHeading[@format-ref='group3-subdivision']/Label">
	<h3 class="Subheading">
		<xsl:apply-templates />
	</h3>
</xsl:template>

<xsl:template match="GroupHeading[@format-ref='group3-subdivision']/TitleText">
	<h3 class="Subheading"  style="margin-top:1.0em;" >
		<xsl:apply-templates />
	</h3>
</xsl:template>

<xsl:template match="Label">
	<h5 style="margin-top:1.0em;" >
		<xsl:apply-templates />
	</h5>
</xsl:template>

<xsl:template match="TitleText">
	<h5 style="margin-top:1.0em;" >
		<xsl:apply-templates />
	</h5>
</xsl:template>

<xsl:template match="ScheduleFormHeading/Label">
		  <xsl:message>~<xsl:value-of select="." /><xsl:if test="following-sibling::TitleText"><xsl:text> </xsl:text><xsl:value-of select="following-sibling::TitleText" /></xsl:if></xsl:message>		  
		  <p class="Schedule"><span class="ScheduleHeading"><xsl:apply-templates /></span>
		  </p>
</xsl:template>

<xsl:template match="ScheduleFormHeading/TitleText">
		  <p class="Schedule"><span class="ScheduleHeading"><xsl:apply-templates /></span>
		  </p>
</xsl:template>

<xsl:template match="Heading/Label" priority="-1">
	<h5>
		<xsl:apply-templates />
	</h5>
</xsl:template>

<xsl:template match="Heading[@level='4']/TitleText">
	<h4 class="Subheading"  style="margin-top:1.0em;" >
		<xsl:apply-templates />
	</h4>
</xsl:template>

<xsl:template match="Heading[@level='5']/TitleText">
	<h5 class="Subheading"  style="margin-top:1.0em;" >
		<xsl:apply-templates />
	</h5>
</xsl:template>

<xsl:template match="Emphasis">
		  <xsl:choose>
					 <xsl:when test="@style='italic'">
 							<em><xsl:apply-templates /></em>
 				 </xsl:when>
					 <xsl:when test="@style='bold'">
								<strong><xsl:apply-templates /></strong>
					 </xsl:when>				 
					 <xsl:when test="@style='smallcaps'">
								<span style="font-variant: small-caps;"><xsl:apply-templates /></span>
					 </xsl:when>
					 <xsl:when test="@style='overbar'">
						<span style="text-decoration: overline;"><xsl:apply-templates /></span>
					 </xsl:when> 					 
 					 <xsl:when test="@style='underline'">
						<span style="text-decoration: underline;"><xsl:apply-templates /></span>
					 </xsl:when> 					 
 					 <xsl:when test="@style='regular'">
						<span style="text-decoration: none;font-weight: normal; font-style:regular;"><xsl:apply-templates /></span>
					 </xsl:when> 					 
		</xsl:choose>
</xsl:template>

<xsl:template match="BilingualGroup">
		  <xsl:apply-templates />
</xsl:template>

<xsl:template match="BilingualItemEn">
	 <xsl:choose>
					 <xsl:when test="$language='en'">
		  <p  style="padding-top:0em;margin-top:0em;padding-bottom:0.0em;margin-bottom:0.0em;" class="BilingualItemFirst">
					 <span lang="en"><xsl:apply-templates /></span>
		  </p>
	 </xsl:when>
	 <xsl:otherwise>
		  <p  style="padding-top:0em;margin-top:0em;padding-bottom:0.7em;" class="BilingualItemSecond">
			 <span lang="en"><xsl:apply-templates /></span>
		  </p>
	</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="BilingualItemFr">
	 <xsl:choose>
					 <xsl:when test="$language='fr'">
		  <p  style="padding-top:0em;margin-top:0em;padding-bottom:0.0em;margin-bottom:0.0em;" class="BilingualItemFirst">
					 <span lang="fr"><xsl:apply-templates /></span>
		  </p>
	 </xsl:when>
	 	<xsl:otherwise>
		  <p  style="padding-top:0em;margin-top:0em;padding-bottom:0.7em;" class="BilingualItemSecond">
			 <span lang="fr"><xsl:apply-templates /></span>
		  </p>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="Repealed">
		  <strong><!-- xsl:text>[</xsl:text><xsl:value-of select="name(.)" /><xsl:text>]</xsl:text-->
		  <xsl:apply-templates /></strong>
</xsl:template>

<xsl:template match="DefinitionEnOnly | DefinitionFrOnly">
		  <em><xsl:apply-templates /></em>
</xsl:template>


	<!-- width of borders around cells -->
	<xsl:variable name="border-width">0.4pt</xsl:variable>

	<!-- TODO: unhandled attributes:
		- under colspec: charoff
		- under entry: charoff
	-->
	
	<xsl:template match="table">
		<xsl:param name="current-language"/>
		<xsl:param name="bilingual"/>
			
		<xsl:apply-templates select="title">
			<xsl:with-param name="current-language"><xsl:value-of select="$current-language"/></xsl:with-param>
			<xsl:with-param name="bilingual"><xsl:value-of select="$bilingual"/></xsl:with-param>
		</xsl:apply-templates>
		
		<xsl:apply-templates select="*[not(self::title | self::space-before)]">
			<xsl:with-param name="current-language"><xsl:value-of select="$current-language"/></xsl:with-param>
			<xsl:with-param name="bilingual"><xsl:value-of select="$bilingual"/></xsl:with-param>

			<xsl:with-param name="colsep" select="@colsep"/>
			<xsl:with-param name="rowsep" select="@rowsep"/>
			<xsl:with-param name="rowbreak" select="@rowbreak"/>
	 </xsl:apply-templates>
	<xsl:apply-templates select="preceding-sibling::Caption[@position='under']" mode="pulled" /> 
	</xsl:template>

	<xsl:template match="FormulaDefinition">
		<xsl:apply-templates select="*[not(self::FormulaTerm)]" />
	</xsl:template>

<xsl:template match="FormulaTerm">
		  <xsl:apply-templates /><xsl:text>&#x00A0;</xsl:text>
	</xsl:template>


	<xsl:template match="Formula | FormulaGroup | FormulaParagraph">
			  <!-- xsl:message>! In a Formula tag:  <xsl:value-of select="name(.)" /></xsl:message -->
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="FormulaText | FormulaConnector">
		  <xsl:variable name="class">
					 <xsl:choose>
								<xsl:when test="parent::Provision">
										  <xsl:call-template name="GetClassFromProvision"><xsl:with-param name="provision"><xsl:value-of select="parent::Provision" /></xsl:with-param></xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
										  <xsl:value-of select="name(parent::*)" />
								</xsl:otherwise>
					 </xsl:choose>
		  </xsl:variable>
		  <xsl:variable name="hide">
			 <xsl:choose>
			 <xsl:when test="contains(parent::*,'span class=')"><xsl:text>no</xsl:text></xsl:when>
			 <xsl:otherwise><xsl:text>yes</xsl:text></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<p><xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute>
					  <xsl:if test="$hide='yes'"><xsl:attribute name="hide"><xsl:text>yes</xsl:text></xsl:attribute></xsl:if>
			<xsl:apply-templates /></p>
	</xsl:template>

	<xsl:template match="Oath">
			  <p class="Oath"><xsl:apply-templates /></p>
	</xsl:template>

	<xsl:template match="TableGroup">
		<xsl:apply-templates />
	</xsl:template>

<xsl:template match="Caption[@position='under']" mode="pulled">
		<p><xsl:apply-templates />
		</p>
</xsl:template>

<xsl:template match="Caption[@position='under']">
</xsl:template>


<xsl:template match="Caption">
		<p><xsl:apply-templates />
		</p>
</xsl:template>

	<xsl:template match="title">
		<p><xsl:apply-templates />
		</p>
	</xsl:template>

	<xsl:template match="tgroup">
		<xsl:param name="current-language"/>
		<xsl:param name="bilingual"/>
		<xsl:param name="rowbreak"/>
		<xsl:param name="colsep"/>
		<xsl:param name="rowsep"/>
		<table>
			<!-- if there's no title element, copy the attributes from TableGroup to table element -->
			<!-- (else copy them to title) -->
				
			<xsl:variable name="following-has-topdouble">
				<xsl:value-of select="boolean(.//row[1][@topdouble='yes'])"/>
			</xsl:variable>
			
			<xsl:if test="not(parent::table/@frame) or parent::table/@frame = 'all'">
				<xsl:attribute name="border-style">solid</xsl:attribute>
				<xsl:attribute name="border-width"><xsl:value-of select="$border-width"/></xsl:attribute>

				<xsl:choose>
					<xsl:when test="$following-has-topdouble = 'true'">
						<xsl:attribute name="border-before-style">double</xsl:attribute>
						<xsl:attribute name="border-before-width">2.25pt</xsl:attribute>
					</xsl:when>

					<xsl:otherwise>
						<xsl:attribute name="border-before-style">solid</xsl:attribute>
						<xsl:attribute name="border-before-width"><xsl:value-of select="$border-width"/></xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			
			<xsl:if test="parent::table/@frame='topbot' or parent::table/@frame='top'">
				<xsl:choose>
					<xsl:when test="$following-has-topdouble = 'true'">
						<xsl:attribute name="border-before-style">double</xsl:attribute>
						<xsl:attribute name="border-before-width">2.25pt</xsl:attribute>
					</xsl:when>
					
					<xsl:otherwise>
						<xsl:attribute name="border-before-style">solid</xsl:attribute>
						<xsl:attribute name="border-before-width"><xsl:value-of select="$border-width"/></xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		
			<xsl:if test="parent::table/@frame='topbot' or parent::table/@frame='bottom'">
				<xsl:attribute name="border-after-style">solid</xsl:attribute>
				<xsl:attribute name="border-after-width"><xsl:value-of select="$border-width"/></xsl:attribute>
			</xsl:if>
		
			<xsl:if test="parent::table/@frame='sides'">
				<xsl:attribute name="border-start-style">solid</xsl:attribute>
				<xsl:attribute name="border-start-width"><xsl:value-of select="$border-width"/></xsl:attribute>
			</xsl:if>

			<xsl:if test="parent::table/@frame='sides'">
				<xsl:attribute name="border-end-style">solid</xsl:attribute>
				<xsl:attribute name="border-end-width"><xsl:value-of select="$border-width"/></xsl:attribute>
			</xsl:if>
		
			<xsl:apply-templates>
				<xsl:with-param name="current-language" select="$current-language"/>
				<xsl:with-param name="bilingual" select="$bilingual"/>
				<xsl:with-param name="rowbreak" select="$rowbreak"/>

				<xsl:with-param name="all-colspecs">
					<xsl:copy-of select="colspec"/>
				</xsl:with-param>
				
				<xsl:with-param name="colsep">
					<xsl:choose>
						<xsl:when test="@colsep"><xsl:value-of select="@colsep"/></xsl:when>
						<xsl:otherwise><xsl:value-of select="$colsep"/></xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>

				<xsl:with-param name="rowsep">
					<xsl:choose>
						<xsl:when test="@rowsep"><xsl:value-of select="@rowsep"/></xsl:when>
						<xsl:otherwise><xsl:value-of select="$rowsep"/></xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>

				<xsl:with-param name="align" select="@align"/>
			</xsl:apply-templates>
	 </table>
	</xsl:template>
	
	<xsl:template match="colspec">
		<xsl:param name="current-language"/>
		<xsl:param name="bilingual"/>

		<xsl:if test="@charoff">
			<xsl:message>Warning: CALS charoff attribute is currently not supported</xsl:message>
		</xsl:if>
		
		<col>
			<xsl:attribute name="width">
				<xsl:choose>
					<!-- when fixed column width is specified -->
					<xsl:when test="@colwidth and @colwidth != '' and not(contains(@colwidth,'*'))">
						<!-- Get the width part by blanking out the units part and discarding -->
						<xsl:variable name="width" select="normalize-space(translate(@colwidth,
						       	'+-0123456789.abcdefghijklmnopqrstuvwxyz', '+-0123456789.'))"/>

						<!-- get the units by stripping out the digits -->
						<xsl:variable name="units" select="normalize-space(translate(@colwidth,
							'abcdefghijklmnopqrstuvwxyz+-0123456789.', 'abcdefghijklmnopqrstuvwxyz'))"/>
						
						<xsl:value-of select="$width"/>
						<xsl:choose>
							<!-- for picas convert CALS shorthand to xsl-fo -->
							<xsl:when test="$units = 'pi'"><xsl:text>pc</xsl:text></xsl:when>

							<!-- CALS default unit is points (pt) -->
							<xsl:when test="$units = ''"><xsl:text>pt</xsl:text></xsl:when>
							<xsl:otherwise><xsl:value-of select="$units"/></xsl:otherwise>
						</xsl:choose>
					</xsl:when>

					<!-- when proportional column width is specified -->
					<xsl:when test="@colwidth and @colwidth != '' and contains(@colwidth,'*')">
						<xsl:text>proportional-column-width(</xsl:text>
						<xsl:value-of select="substring-before(@colwidth, '*')"/>
						<xsl:text>)</xsl:text>
					</xsl:when>

					<!-- TODO: when mixed column widths is specified -->
					<!-- NOTE: mixed column widths are supported in full cals, but NOT exchange cals -->

					<!-- CALS default: 1* -->
					<xsl:otherwise>
						<xsl:text>proportional-column-width(1)</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			
			<xsl:if test="@align">
				<xsl:attribute name="align"><xsl:value-of select="@align"/></xsl:attribute>
			</xsl:if>
		</col>
	</xsl:template>

	<xsl:template match="tbody">
		<xsl:param name="current-language"/>
		<xsl:param name="bilingual"/>
		<xsl:param name="rowbreak"/>

		<xsl:param name="all-colspecs"/>
		<xsl:param name="colsep"/>
		<xsl:param name="rowsep"/>
		<xsl:param name="align"/>

		<tbody>
			<xsl:apply-templates>
				<xsl:with-param name="current-language"><xsl:value-of select="$current-language"/></xsl:with-param>
				<xsl:with-param name="bilingual"><xsl:value-of select="$bilingual"/></xsl:with-param>

				<xsl:with-param name="rowbreak" select="$rowbreak"/>
 				<xsl:with-param name="all-colspecs" select="$all-colspecs"/>
 				<xsl:with-param name="colsep" select="$colsep"/>
				<xsl:with-param name="rowsep" select="$rowsep"/>
				<xsl:with-param name="align" select="$align"/>
				<xsl:with-param name="valign" select="@valign"/>
			</xsl:apply-templates>
		</tbody>
	</xsl:template>

	<xsl:template match="thead">
		<xsl:param name="current-language"/>
		<xsl:param name="bilingual"/>
		<xsl:param name="all-colspecs"/>

		<xsl:param name="rowbreak"/>
		<xsl:param name="colsep"/>
		<xsl:param name="rowsep"/>
		<xsl:param name="align"/>

		<thead>
			<xsl:apply-templates>
				<xsl:with-param name="current-language"><xsl:value-of select="$current-language"/></xsl:with-param>
				<xsl:with-param name="bilingual"><xsl:value-of select="$bilingual"/></xsl:with-param>

				<xsl:with-param name="rowbreak" select="$rowbreak"/>
 				<xsl:with-param name="all-colspecs" select="$all-colspecs"/>
				<xsl:with-param name="colsep" select="$colsep"/>
				<xsl:with-param name="rowsep" select="$rowsep"/>
				<xsl:with-param name="align" select="$align"/>
				<xsl:with-param name="valign" select="@valign"/>
			</xsl:apply-templates>
		</thead>
	</xsl:template>	

	<xsl:template match="row">
		<xsl:param name="current-language"/>
		<xsl:param name="bilingual"/>

		<xsl:param name="rowbreak"/>
		<xsl:param name="all-colspecs"/>
		<xsl:param name="colsep"/>
		<xsl:param name="rowsep"/>
		<xsl:param name="align"/>
		<xsl:param name="valign"/>

		<tr>
			<!-- rowbreak from TableGroup: inherits to each row -->
			<xsl:if test="$rowbreak = 'no'">
				<xsl:attribute name="keep-together.within-page">always</xsl:attribute>
			</xsl:if>
			
			<!-- bottommarginspacing -->
			<xsl:if test="@bottommarginspacing">
				<xsl:attribute name="space-after">
					<xsl:value-of select="@bottommarginspacing"/>
					<xsl:text>pt</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="space-after.conditionality">retain</xsl:attribute>
			</xsl:if>
			
			<!-- height -->
			<xsl:if test="@height">
				<xsl:attribute name="height">
					<xsl:value-of select="@height"/>
				</xsl:attribute>
			</xsl:if>

			<!-- Current rowsep -->
			<xsl:variable name="currentRowsep">
				<xsl:choose>
					<!-- if defined on row, use it -->
					<xsl:when test="@rowsep"><xsl:value-of select="@rowsep"/></xsl:when>
					
					<!-- else use whatever's specified above -->
					<xsl:otherwise>
						<xsl:value-of select="$rowsep"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			
			<xsl:variable name="num-rows-remaining">
				<!-- If I'm part of the thead, I mustn't forget to count the rows belonging to tbody -->
				<xsl:value-of select="count(following-sibling::row) + count(../following-sibling::tbody/row)"/>
			</xsl:variable>

			<xsl:variable name="new-valign">
				<xsl:choose>
					<xsl:when test="@valign"><xsl:value-of select="@valign"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="$valign"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<xsl:for-each select="*">
				<xsl:variable name="column-number">
					<xsl:value-of select="position()"/>
				</xsl:variable>

				<!-- Pass down column/row information -->
				<xsl:apply-templates select=".">
					<xsl:with-param name="current-language"><xsl:value-of select="$current-language"/></xsl:with-param>
					<xsl:with-param name="bilingual"><xsl:value-of select="$bilingual"/></xsl:with-param>
					<xsl:with-param name="num-rows-remaining" select="number($num-rows-remaining)"/>
					<xsl:with-param name="all-colspecs" select="$all-colspecs"/>
					<xsl:with-param name="colsep" select="$colsep"/>
					<xsl:with-param name="rowsep" select="$currentRowsep"/>
					<xsl:with-param name="align" select="$align"/>
					<xsl:with-param name="valign" select="$new-valign"/>
				</xsl:apply-templates>
			</xsl:for-each>
		</tr>
	</xsl:template>

	<xsl:template match="entry">
		<xsl:param name="current-language"/>
		<xsl:param name="bilingual"/>

		<xsl:param name="num-rows-remaining"/>
		<xsl:param name="all-colspecs"/>
		<xsl:param name="colsep"/>
		<xsl:param name="rowsep"/>
		<xsl:param name="align"/>
		<xsl:param name="valign"/>

		<xsl:if test="@charoff">
			<xsl:message>Warning: CALS charoff attribute is currently not supported</xsl:message>
		</xsl:if>
		
		<td>
			
			<!-- Column Spanning -->
			<xsl:if test="@namest and @nameend and @namest != @nameend">
				<xsl:variable name="namest"><xsl:value-of select="@namest"/></xsl:variable>
				<xsl:variable name="nameend"><xsl:value-of select="@nameend"/></xsl:variable>

				<!-- count the number of colspecs occuring before the specified start and end columns to figure out which column numbers are referenced -->
				<!-- find the number of columns spanned by counting the number of columns between the two referenced -->
				<xsl:attribute name="colspan">
					<xsl:value-of select="count(msxsl:node-set($all-colspecs)/colspec[following-sibling::colspec[@colname = $nameend]
						and preceding-sibling::colspec[@colname = $namest]]) + 2" xmlns:msxsl="urn:schemas-microsoft-com:xslt"/>
				</xsl:attribute>
			</xsl:if>
		
			<!-- Row Spanning -->
			<xsl:if test="@morerows">
				<xsl:attribute name="rowspan"><xsl:value-of select="number(@morerows) + 1"/></xsl:attribute>
			</xsl:if>

			<!-- Horizontal Alignment -->
			<xsl:call-template name="setHorizontalAlignment">
				<xsl:with-param name="align" select="$align"/>
				<xsl:with-param name="all-colspecs" select="$all-colspecs"/>
			</xsl:call-template>
			
			<!-- Vertical Alignment -->
			<xsl:call-template name="setVerticalAlignment">
				<xsl:with-param name="valign" select="$valign"/>
			</xsl:call-template>

			<!-- colsep: Vertical Rules -->
			<xsl:call-template name="setColsep">
				<xsl:with-param name="colsep" select="$colsep"/>
				<xsl:with-param name="all-colspecs" select="$all-colspecs"/>
			</xsl:call-template>

			<!-- rowsep: Horizontal Rules -->
			<xsl:call-template name="setRowsep">
				<xsl:with-param name="rowsep" select="$rowsep"/>
				<xsl:with-param name="num-rows-remaining" select="$num-rows-remaining"/>
				<xsl:with-param name="all-colspecs" select="$all-colspecs"/>
			</xsl:call-template>

			<p>
				<!-- topmarginspacing -->
				<xsl:if test="parent::row/@topmarginspacing">
				  <xsl:attribute name="style"><xsl:text>space-before=</xsl:text><xsl:value-of select="parent::row/@topmarginspacing"/><xsl:text>pt</xsl:text>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates/>
			</p>
		</td>
	</xsl:template>

<!-- ************************************
	Named Templates
     ************************************ -->
	<!-- Horizontal Alignment -->
	<xsl:template name="setHorizontalAlignment">
		<xsl:param name="align"/>
		<xsl:param name="all-colspecs"/>
		
		<xsl:variable name="currentColName"><xsl:value-of select="@colname"/></xsl:variable>
		<xsl:variable name="currentAlign">
			<xsl:choose>
				<!-- if align is specified for this cell use it -->
				<xsl:when test="@align"><xsl:value-of select="@align"/></xsl:when>

				<xsl:when test="@colname and msxsl:node-set($all-colspecs)/colspec[@colname = $currentColName]/@align" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
					<xsl:value-of select="msxsl:node-set($all-colspecs)/colspec[@colname = $currentColName]/@align" xmlns:msxsl="urn:schemas-microsoft-com:xslt"/>
					<!-- xsl:when test="@colname and exsl:node-set($all-colspecs)/colspec[@colname = $currentColName]/@align" xmlns:exsl="http://exslt.org/common">
						<xsl:value-of select="exsl:node-set($all-colspecs)/colspec[@colname = $currentColName]/@align" xmlns:exsl="http://exslt.org/common"/ -->
				</xsl:when>

				<!-- otherwise use what's been passed down -->
				<xsl:otherwise>
					<xsl:value-of select="$align"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="$currentAlign = 'char' and string-length(@char) &gt; 0">
				<xsl:attribute name="text-align"><xsl:value-of select="@char"/></xsl:attribute>
			</xsl:when>

			<xsl:when test="string-length($currentAlign) &gt; 0">
				<xsl:attribute name="text-align"><xsl:value-of select="$currentAlign"/></xsl:attribute>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!-- Vertical Alignment -->
	<xsl:template name="setVerticalAlignment">
		<xsl:param name="valign"/>

		<xsl:variable name="current-valign">
			<xsl:choose>
				<xsl:when test="@valign"><xsl:value-of select="@valign"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="$valign"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:choose>
			<xsl:when test="$current-valign = 'top'">
				<xsl:attribute name="display-align">before</xsl:attribute>
			</xsl:when>

			<xsl:when test="$current-valign = 'middle'">
				<xsl:attribute name="display-align">center</xsl:attribute>
			</xsl:when>

			<xsl:when test="$current-valign = 'bottom'">
				<xsl:attribute name="display-align">after</xsl:attribute>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!-- rowsep: Horizontal Rules -->
	<xsl:template name="setRowsep">
		<xsl:param name="num-rows-remaining"/>
		<xsl:param name="rowsep"/>
		<xsl:param name="all-colspecs"/>
		
		<xsl:variable name="morerows">
			<xsl:choose>
				<xsl:when test="@morerows"><xsl:value-of select="number(@morerows)"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="number(0)"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!-- if @morerows equals the number of rows following the one I'm in then I'm part of the last row -->
		<xsl:if test="number($num-rows-remaining) != number($morerows)">
			<!-- determine rowsep of cell -->
			<xsl:variable name="currentColName"><xsl:value-of select="@colname"/></xsl:variable>
			<xsl:variable name="currentPos"><xsl:value-of select="position()"/></xsl:variable>
			<xsl:variable name="currentRowsep">
				<xsl:choose>
					<!-- if specified for this cell use it -->
					<xsl:when test="@rowsep"><xsl:value-of select="@rowsep"/></xsl:when>

					<!-- if a column name is specified, check to see if colsep is set -->
					<xsl:when test="@colname and msxsl:node-set($all-colspecs)/colspec[@colname = $currentColName]/@rowsep" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
						<xsl:value-of select="msxsl:node-set($all-colspecs)/colspec[@colname = $currentColName]/@rowsep" xmlns:msxsl="urn:schemas-microsoft-com:xslt"/>
						<!-- xsl:when test="@colname and exsl:node-set($all-colspecs)/colspec[@colname = $currentColName]/@rowsep" xmlns:exsl="http://exslt.org/common">
							<xsl:value-of select="exsl:node-set($all-colspecs)/colspec[@colname = $currentColName]/@rowsep" xmlns:exsl="http://exslt.org/common"/ -->
					</xsl:when>

					<!-- even if a column name isn't specified, check to see if colsep is set on corresponding colspec -->
					<xsl:when test="msxsl:node-set($all-colspecs)/colspec[$currentPos]/@rowsep" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
						<xsl:value-of select="msxsl:node-set($all-colspecs)/colspec[$currentPos]/@rowsep" xmlns:msxsl="urn:schemas-microsoft-com:xslt"/>
					</xsl:when>
					
					<!-- otherwise use whatever's been passed down -->
					<xsl:when test="string-length($rowsep) &gt; 0">
						<xsl:value-of select="$rowsep"/>
					</xsl:when>

					<!-- Default value: on -->
					<xsl:otherwise>1</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<xsl:variable name="following-has-topdouble">
				<xsl:value-of select="boolean(following::row[1][@topdouble='yes'])"/>
			</xsl:variable>

			<xsl:choose>
				<xsl:when test="number($currentRowsep) != 0 and $following-has-topdouble = 'true' and number($currentRowsep) != 0">
					<xsl:attribute name="border-after-style">double</xsl:attribute>
					<xsl:attribute name="border-after-width">2.25pt</xsl:attribute>
				</xsl:when>
				
				<xsl:when test="number($currentRowsep) != 0 and $following-has-topdouble = 'true'">
					<xsl:attribute name="border-after-style">double</xsl:attribute>
					<xsl:attribute name="border-after-width">2.25pt</xsl:attribute>
				</xsl:when>

				<xsl:when test="number($currentRowsep) != 0 ">
					<xsl:attribute name="border-after-style">solid</xsl:attribute>
					<xsl:attribute name="border-after-width"><xsl:value-of select="$border-width"/></xsl:attribute>
				</xsl:when>
				
				<xsl:otherwise>
					<xsl:attribute name="border-after-style">none</xsl:attribute>
					<xsl:attribute name="border-after-width">0pt</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>

	<!-- colsep: Vertical Rules -->
	<xsl:template name="setColsep">
		<xsl:param name="colsep"/>
		<xsl:param name="all-colspecs"/>

		<!-- if there are no entry following me, then I'm the last column so ignore me -->
		<xsl:if test="following-sibling::entry">
			<!-- determine colsep of cell -->
			<xsl:variable name="currentColName"><xsl:value-of select="@colname"/></xsl:variable>
			<xsl:variable name="currentPos"><xsl:value-of select="position()"/></xsl:variable>
			<xsl:variable name="currentColsep">
				<xsl:choose>
					<!-- if specified for this cell use it -->
					<xsl:when test="@colsep"><xsl:value-of select="number(@colsep)"/></xsl:when>

					<!-- if a column name is specified, check to see if colsep is set -->
					<xsl:when test="@colname and msxsl:node-set($all-colspecs)/colspec[@colname = $currentColName]/@colsep" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
						<xsl:value-of select="msxsl:node-set($all-colspecs)/colspec[@colname = $currentColName]/@colsep" xmlns:msxsl="urn:schemas-microsoft-com:xslt"/>
						<!-- xsl:when test="@colname and exsl:node-set($all-colspecs)/colspec[@colname = $currentColName]/@colsep" xmlns:exsl="http://exslt.org/common">
							<xsl:value-of select="exsl:node-set($all-colspecs)/colspec[@colname = $currentColName]/@colsep" xmlns:exsl="http://exslt.org/common"/ -->
					</xsl:when>

					<!-- even if a column name isn't specified, check to see if colsep is set on corresponding colspec -->
					<xsl:when test="msxsl:node-set($all-colspecs)/colspec[$currentPos]/@colsep" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
						<xsl:value-of select="msxsl:node-set($all-colspecs)/colspec[$currentPos]/@colsep" xmlns:msxsl="urn:schemas-microsoft-com:xslt"/>
					</xsl:when>

					<!-- otherwise use whatever's been passed down -->
					<xsl:when test="string-length($colsep) &gt; 0">
						<xsl:value-of select="$colsep"/>
					</xsl:when>

					<!-- Default value: on -->
					<xsl:otherwise>1</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<xsl:choose>
				<xsl:when test="number($currentColsep) != 0">
					<xsl:attribute name="border-end-style">solid</xsl:attribute>
					<xsl:attribute name="border-end-width"><xsl:value-of select="$border-width"/></xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="border-end-style">none</xsl:attribute>
					<xsl:attribute name="border-end-width">0pt</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>

	<xsl:template match="SignatureBlock">
		<xsl:apply-templates />
	</xsl:template>
	
	<xsl:template match="SignatureLine | SignatureName | SignatureTitle">
			  <div>
						 <xsl:attribute name="class"><xsl:choose>
											  <xsl:when test="@justification='center'">
														 <xsl:text>Centered</xsl:text>
											  </xsl:when>
											  <xsl:when test="@justification='left'">
														 <xsl:text>FlushLeft</xsl:text>
											  </xsl:when>
											  <xsl:otherwise><xsl:text>FlushRight</xsl:text></xsl:otherwise>
									</xsl:choose>
						</xsl:attribute>
						 <xsl:apply-templates />
			  </div>
	</xsl:template>

	<xsl:template match="FormGroup | Body">
			  <xsl:apply-templates />
	</xsl:template>

	<xsl:template match="Sup">
			  <sup><xsl:apply-templates /></sup>
	</xsl:template>

	<xsl:template match="Sub">
			  <sub><xsl:apply-templates /></sub>
	</xsl:template>

	<xsl:template match="FootnoteRef">
						 <sup><xsl:apply-templates /></sup>
	</xsl:template>

	<xsl:template match="Footnote">
				 <sup><xsl:apply-templates /></sup>
	</xsl:template>

<xsl:template match="Leader">
	<xsl:variable name="width"><xsl:value-of select="@length" /></xsl:variable>
	<xsl:variable name="border">
			  <xsl:choose>
						<xsl:when test="@leader='solid'"><xsl:text>border-bottom:1px solid black;</xsl:text></xsl:when>
						<xsl:when test="@leader='dash'"><xsl:text>border-bottom:1px dashed black;</xsl:text></xsl:when>
						<xsl:when test="@leader='dot'"><xsl:text>border-bottom:1px dotted black;</xsl:text></xsl:when>						
						<xsl:otherwise><xsl:text> </xsl:text></xsl:otherwise>
			 </xsl:choose>
	</xsl:variable>			 
			 <img src="/img/ii_spacer.gif">
						<xsl:attribute name="style"><xsl:value-of select="concat($width,$border,'height:0.8em;')" /></xsl:attribute></img>
</xsl:template>

<xsl:template match="LeaderRightJustified">
  <xsl:choose>
		<xsl:when test="@leader='solid'"><xsl:text>__________</xsl:text></xsl:when>
		<xsl:when test="@leader='dash'"><xsl:text>- - - - - - -</xsl:text></xsl:when>
		<xsl:when test="@leader='dot'"><xsl:text>.......</xsl:text></xsl:when>						
		<xsl:otherwise><xsl:text>&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;</xsl:text></xsl:otherwise>
 </xsl:choose>
</xsl:template>

<xsl:template match="LongTitle[ancestor::Schedule]">
		  <p class="LongTitle"><xsl:apply-templates /></p>
</xsl:template>

<xsl:template match="*">
		  <xsl:message>Missed:  <xsl:value-of select="name(.)" /></xsl:message>
		  <xsl:apply-templates />
</xsl:template>


</xsl:stylesheet>

