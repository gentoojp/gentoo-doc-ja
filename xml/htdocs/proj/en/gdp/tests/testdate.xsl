<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:func="http://exslt.org/functions"
                xmlns:exslt="http://exslt.org/common"
                extension-element-prefixes="func exslt" >

<xsl:output encoding="UTF-8" method="xml" indent="yes" doctype-system="/dtd/guide.dtd"/>

<xsl:include href="/xsl/inserts.xsl" />

<xsl:param name="date">1967-06-05</xsl:param>
<xsl:variable name="userfile" select='document("/proj/en/devrel/roll-call/userinfo.xml")'/>

<!-- Start outputting data -->
<xsl:template match="/doc">

<xsl:variable name="xav" select="concat(exslt:node-set($userfile)/userlist/user[@username = 'neysx']/realname/firstname, ' * ', exslt:node-set($userfile)/userlist/user[@username = 'neysx']/realname/familyname)"/>

<guide link="testdate.xml">
<title>Test Date Formatting</title>

<author title="Author">
  <mail link="neysx@gentoo.org">
    <xsl:value-of select="$xav"/>
  </mail>
</author>

<abstract>
This page shows how dates are formatted for each language
</abstract>

<license/>

<version>1.3</version>
<date><xsl:value-of select="func:today()"/></date>
<!--<date>2005-01-14</date>-->

<chapter>
<title>Introduction</title>
<section>
<title>Some information</title>
<body>

<p>
In order to be able to process the date elements in XSLT or scripts, we have
added support for a <e>YYYY-MM-DD</e> formatted date element.
</p>

<p>
Besides, some people have been very creative and dates are formatted in many
different ways in English and in many translations. This allows for consistency
across all pages.
</p>

<p>
XSLT 2.0 has some date formatting routines but XSLT 1.0 hasn't and it seems
like we'll have to do with it for quite a while.
</p>

<p>
Fortunately, we do not need any advanced date checking and validating library.
All we need is to be able to display YYYY-MM-DD in a limited set of languages.
</p>

<p>
The table below shows different examples of dates formatted for different
languages.
</p>

<p>
The <c>&lt;date&gt;</c> element in our documentation is expected to be
formatted as <e>YYYY-MM-DD</e> so that it can be easily used in automatic
processing. If a date does not match that pattern, it is copied verbatim for
backwards compatibility. Otherwise, it is formatted for the given language
according to the lang attribute of the root element. The default language is
English of course.
</p>

</body>
</section>
<section>
<title>Test and send feedback</title>
<body>

<p>
The dates below have been formatted based on my limited knowledge of dates in
plenty of languages, on how they currently appear in the docs and on your
feedback. Some guesses are probably right, some less because of the many
different formats currently used.
</p>

<p>
Check whether month names should be capitalized. I know they should in English
and they must not in French. I noticed some languages used capitalization but
the output of <c>date</c> differs. Please check and let me know.
</p>

</body>
</section>
</chapter>

<chapter>
<title>The Dates</title>
<section>
<body>

<p>
You can try with your own values by appending a date parameter to the url like
this <uri>?date=2004-12-25#doc_chap2</uri>. The date will be displayed in the
first column.
</p>

<table>
<tr>
 <ti>Lang&#160;\&#160;Date</ti>
 <th><xsl:value-of select="$date" /></th>
 <xsl:for-each select="//doc/date"><xsl:sort select="."/><th><xsl:value-of select="." /></th></xsl:for-each>
</tr>
    <xsl:apply-templates select="lang/code">
     <xsl:sort select="."/>
    </xsl:apply-templates>
</table>
</body>
</section>
</chapter>
</guide>
</xsl:template>

  <xsl:template match="code">
    <xsl:variable name="LL" select="."/>
    <tr>
     <th><xsl:value-of select="$LL" /></th>
     <ti><xsl:copy-of select="func:format-date($date,$LL)" /></ti>
     <xsl:for-each select="//doc/date"><xsl:sort select="."/>
       <ti>
        <xsl:if test="$LL='he'">
          <xsl:attribute name="dir">RTL</xsl:attribute>
        </xsl:if>
        <xsl:copy-of select="func:format-date(.,$LL)"/>
       </ti>
     </xsl:for-each>
    </tr>
  </xsl:template>

</xsl:stylesheet>
