<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "Glossary of Terms">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfquery name="Terms" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * from GCAR_Metrics_GlossaryTerms
<cfif isDefined("URL.ID")>
	<cfif URL.ID neq "All">
	WHERE ID = #URL.ID#
	</cfif>
</cfif>
ORDER BY ID
</cfquery>

<cfoutput query="Terms">
 <img src="../SiteImages/arrow2_bullet.gif"> <a href="Glossary.cfm###ID#">#GlossaryTerm#</a><br>
</cfoutput><br><hr width="75%" align="center"><br>

<cfoutput query="Terms">
<a name="#ID#"></a>
<b>#numberformat(ID, 9)# - #GlossaryTerm#</b><br>
	<cfquery name="Glossary" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT * FROM GCAR_Metrics_Glossary
	
	WHERE GlossaryID = #ID#
	AND RevNumber = (SELECT MAX(RevNumber) from GCAR_Metrics_Glossary WHERE GlossaryID = #ID#)
	</cfquery>
	
<cfset RevNo = #numberformat(Glossary.RevNumber, 9)#>
<cfset RevDate = #dateformat(Glossary.RevDate, "mm/dd/yyyy")#>
	
#Glossary.GlossaryText#<br><br>

<!---<span class="blog-small" align="left">
(Revision Number - #RevNo#, Author - #Glossary.RevAuthor#, Date - #dateformat(RevDate, "mm/dd/yyyy")#)
</span>--->

<hr width="75%" align="center"><Br>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->