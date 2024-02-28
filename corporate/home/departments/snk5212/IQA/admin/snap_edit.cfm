<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Office">
SELECT OfficeName
FROM IQAtblOffices
WHERE ID = #URL.ID#
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "UL OSHA SNAP Sites - Edit - #Office.OfficeName#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="SNAP">
SELECT *
FROM IQAtblOffices
WHERE ID = #URL.ID#
</cfquery>

<cfoutput>
    <script
        language="javascript"
        type="text/javascript"
        src="#IQADir#/tinymce/jscripts/tiny_mce/tiny_mce.js">
    </script>

    <script language="javascript" type="text/javascript">
    tinyMCE.init({
        mode : "textareas",
        content_css : "#SiteDir#SiteShared/cr_style.css"
    });
    </script>
</cfoutput>

<br>
<cfif isDefined("URL.RequiredFields")>
	<cfif url.RequiredFields is "Yes">
		<font color="red"><u>Comments</u> and <u>Document the Revision</u> are both required fields.</font><br><br>
	</cfif>
</cfif>

<cfoutput query="SNAP">
<cfform name="addAlert" action="snap_update.cfm?#CGI.Query_String#" method="POST">
<b>Office Name:</b><br>
#OfficeName#<br><br />

<cfset selValue=#SNAP.SNAPAudit#>
<b>SNAP Status</b>: <cfif SNAPAudit eq 1>Yes<cfelse>No</cfif><br>

<cfinput type="radio" name="SNAPAudit" value="Yes" checked="#iif(selValue eq 1, de("true"), de("false"))#"> Yes
<cfinput type="radio" name="SNAPAudit" value="No" checked="#iif(selValue eq 0, de("true"), de("false"))#"> No
<br><br>

<b>SNAP Status Comments</b><Br>
<textarea WRAP="PHYSICAL" ROWS="10" COLS="60" NAME="SNAPComments"><cfif SNAPComments is "">No Comments<cfelse>#SNAPComments#</cfif></textarea>
<br><br>

<cfset selValue=#SNAP.SCCSite#>
<b>SCC Status</b>: <cfif SCCSite eq 1>Yes<cfelse>No</cfif><br>

<cfinput type="radio" name="SCCSite" value="Yes" checked="#iif(selValue eq 1, de("true"), de("false"))#"> Yes
<cfinput type="radio" name="SCCSite" value="No" checked="#iif(selValue eq 0, de("true"), de("false"))#"> No
<br><br>

<b>SCC Status Comments</b><Br>
<textarea WRAP="PHYSICAL" ROWS="10" COLS="60" NAME="SCCComments"><cfif SCCComments is "">No Comments<cfelse>#SCCComments#</cfif></textarea>
<br><br>

<b>Document the Revision</b><Br>
<textarea WRAP="PHYSICAL" ROWS="10" COLS="60" NAME="RevDetails">Please add comments to describe the changes</textarea>
<br><br>

<INPUT TYPE="Submit" value="Submit">
</cfform>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->