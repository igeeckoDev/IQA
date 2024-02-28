<!--- Start of Page File --->
<cfset subTitle = "ANSI / OSHA / SCC Reports - Update Notes">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfoutput>
<script
	language="javascript"
	type="text/javascript"
	src="#CARDir#tinymce/jscripts/tiny_mce/tiny_mce.js">
</script>

<script language="javascript" type="text/javascript">
tinyMCE.init({
	mode : "textareas",
	content_css : "#SiteDir#SiteShared/cr_style.css"
});
</script>
</cfoutput>

<cfquery name="Query" datasource="Corporate" blockfactor="100">
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->
SELECT YEAR_ as "Year", ID, QENotes
FROM AuditSchedule
WHERE ID = #URL.ID#  
AND Year_ = <cfqueryparam value="#URL.Year#" CFSQLTYPE="CF_SQL_INTEGER">
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</cfquery>

<cfif isdefined("form.upload")>

	<cfquery name="Update" datasource="Corporate" blockfactor="100">
	UPDATE AuditSchedule
	SET

	QENotes='#Form.QENotes#'

    WHERE
    ID = #URL.ID# 
    AND YEAR_ = <cfqueryparam value="#URL.Year#" CFSQLTYPE="CF_SQL_INTEGER">
    </cfquery>

   <cflocation url="ASReports_Details.cfm?#CGI.Query_String#" addtoken="No">

<cfelse>

<cfoutput query="Query">
<a href="ASReports_Details.cfm?#CGI.Query_String#">Return</a> to AS-#Year#-#ID# Details<br><br>

    <form action="#CGI.Script_Name#?#CGI.Query_String#" enctype="multipart/form-data" method="post">

	<cfif QENotes is "">
    	<cfset QENotes2 = "Please Add Notes">
    <cfelse>
    	<cfset QENotes2 = #QENotes#>
    </cfif>

	<u>Add Notes:</u><br>
	<textarea WRAP="PHYSICAL" ROWS="20" COLS="66" NAME="QENotes">#QENotes2#</textarea><br><br>

    <input type="Submit" name="upload" value="Save Notes">

    </form>
  </cfoutput>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->