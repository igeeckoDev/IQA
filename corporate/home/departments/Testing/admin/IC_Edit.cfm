<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="IC">
SELECT IC, ICComments, OfficeName, ID
FROM IQAtblOffices
WHERE ID = #URL.ID#
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "UL Locations - #IC.OfficeName# - <a href='IC.cfm'>International Certification Form Control</a>">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

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
		<font color="red"><u>Comments</u> is a required field.</font><br><br>
	</cfif>
</cfif>

<cfoutput query="IC">
<cfform name="addAlert" action="IC_update.cfm?#CGI.Query_String#" method="POST">
<b>Office Name:</b><br>
#OfficeName#<br><br />

<cfset selValue=#IC.IC#>
<b>IC Required</b>: <cfif IC is "Yes">Yes<cfelse>No</cfif><br>

<cfinput type="radio" name="IC" value="Yes" checked="#iif(selValue eq 1, de("true"), de("false"))#"> Yes
<cfinput type="radio" name="IC" value="No" checked="#iif(selValue eq 0, de("true"), de("false"))#"> No
<br><br>

<b>Comments</b><Br>
<textarea WRAP="PHYSICAL" ROWS="10" COLS="60" NAME="ICComments">Please add comments about this change</textarea>
<br><br>

<INPUT TYPE="Submit" value="Submit">
</cfform>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->