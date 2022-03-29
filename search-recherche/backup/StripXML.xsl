<?xml version="1.0"?>

<xsl:transform
  xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version='1.1'
>

<xsl:output
	method="html"
	encoding="utf-8"
	omit-xml-declaration="yes"
	indent="yes"/>

<xsl:param name="Language" select="'en'" />
<xsl:param name="LawType" select="'Acts'" />

<xsl:template match="/">
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="Root">
		 <xsl:apply-templates />
</xsl:template>

<xsl:template match="p[@hide='yes']">
	<p><xsl:text>[...]</xsl:text></p>
</xsl:template>

  <xsl:template match="hgroup[not(descendant::span[@class='hit'])]">
    <p><xsl:text>[...]</xsl:text></p>
  </xsl:template>

  <xsl:template match="dt[@hide='yes']">
    <!--<dt><xsl:text>[...]</xsl:text></dt> -->
  </xsl:template>
  <xsl:template match="dd[@hide='yes']">
    <!-- <dd><xsl:text>[...]</xsl:text></dd>-->
  </xsl:template>
  <xsl:template match="li[@hide='yes' or not(descendant::span[@class='hit'])]">
    <li><p><xsl:text>[...]</xsl:text></p></li>
  </xsl:template>
  
  <xsl:template match="ul[@hide='yes' or not(descendant::span[@class='hit'])]">
      <p><xsl:text>[...]</xsl:text></p>
  </xsl:template>

<!-- for list-item provisions ... and other divs such as ReadAsText and Citation-->
    <xsl:template match="div[@hide='yes' or not(descendant::span[@class='hit'])and not(@class='listItemLabel')] ">
        <p><xsl:text>[...]</xsl:text></p>
    </xsl:template>

<xsl:template match="div[@class='heading' and not(descendant::span[@class='hit']) and following-sibling::*[1][not(descendant::span[@class='hit'])]]"> <!--or following-sibling::Table[1][not(descendant::span[@class='hit'])] -->
  <p><xsl:text>[...]</xsl:text></p> <!--Matches headings wihtout hits in Schedules when the next item also doesnt have a hit -->
</xsl:template>

<!-- RULES TO MATCH SOME OF THE STATIC CONTENT-->
  <xsl:template match="ul[ancestor::div[@class='tops'] and not(descendant::span[@class='hit'])]">
    <p><xsl:text>[...]</xsl:text></p>
  </xsl:template>
    <xsl:template match="li[ancestor::ul[@class='privateActs'] and not(descendant::span[@class='hit'])]">
        <li><p><xsl:text>[...]</xsl:text></p></li>
    </xsl:template>
    <xsl:template match="p[ancestor::div[@class='tops'] or ancestor::div[@class='ConstBody'] or ancestor::div[@class='searchable'] and not(descendant::span[@class='hit'])]">
        <p><xsl:text>[...]</xsl:text></p>
    </xsl:template>

<xsl:template match="table[not(descendant::span[@class='hit'])]">
</xsl:template>

<xsl:template match="tr[not(descendant::span[@class='hit']) and not(parent::thead)]">
</xsl:template>

  <xsl:template match="figure[not(descendant::span[@class='hit'])]">
  </xsl:template>
  
<xsl:template match="@rowspan" />
        <!-- remove rowspan attribute from rows with hits-->

<xsl:template match="p[@class='MarginalNote' and not(descendant::span[@class='hit']) and following-sibling::*[1][not(descendant::span[@class='hit'])]]">
<!-- remove Marginal Notes if its not a hit and the following piece is not a hit-->
</xsl:template>
  <xsl:template match="h6[@class='MarginalNote' and not(descendant::span[@class='hit']) and following-sibling::*[1][not(descendant::span[@class='hit'])]]">
    <!-- remove Marginal Notes if its not a hit and the following piece is not a hit-->
  </xsl:template>

<xsl:template match="p[@class='caption']">
	<xsl:copy>
		<xsl:copy-of select="@*"/>
		<!-- Process children (do not copy them blindly) -->
		<xsl:apply-templates/>
	</xsl:copy>
</xsl:template>

<xsl:template match="p[descendant::span[@class='hit']]">
	<xsl:copy>
		<xsl:copy-of select="@*"/>
		<!-- Process children (do not copy them blindly) -->
		<xsl:apply-templates/>
	</xsl:copy>
</xsl:template>

    <!-- CATCH-ALL (NO CHANGE) -->
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>

</xsl:transform>
