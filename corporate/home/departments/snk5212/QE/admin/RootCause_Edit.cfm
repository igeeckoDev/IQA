<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "CAR Root Cause Category - Configuration - Edit/Delete">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
    <script 
        language="javascript" 
        type="text/javascript" 
        src="#CARDir#/tinymce/jscripts/tiny_mce/tiny_mce.js">
    </script>
    
    <script language="javascript" type="text/javascript">
    tinyMCE.init({
        mode : "textareas",
        content_css : "#SiteDir#SiteShared/cr_style.css"
    });
    </script>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" NAME="RootCause" DataSource="Corporate"> 
SELECT * FROM CAR_RootCause
WHERE ID = #URL.ID#
</cfquery>

<cfif isDefined("Form.Category")>

<cflock scope="SESSION" timeout="5">
<CFQUERY BLOCKFACTOR="100" NAME="Add" DataSource="Corporate"> 
UPDATE CAR_RootCause
SET
Category = '#Form.Category#',
Description = '#Form.Description#'

<!--- Old Update Log
updateLog = <cfqueryparam CFSQLTYPE="CF_SQL_CLOB" VALUE="<u>Date</u>: #curdate# #curtime#<br>
<u>Updated by</u>: #SESSION.AUTH.Username#<br><br>
<b>Initial Value</b>:<br>
<u>Category</u>: #RootCause.Category#<br>
<u>Description</u>: #RootCause.Description#<br />
<b>New Value</b>:<br>
<u>Category</u>: #Form.Category#<br>
<u>Description</u>: #Form.Description#
<u>Description of Change</u>: #Form.ChangeHistory#
<br /><hr />
#RootCause.updateLog#">
--->

WHERE ID = #URL.ID#
</cfquery>
</cflock>

<cflocation url="#CGI.SCRIPT_NAME#?#CGI.Query_String#&update=yes" addtoken="No">

<cfelse>

<cfif isDefined("url.update")>
	<cfif update is "yes">
		<font color="red">Updates Saved.</font> View FAQ Revision History for history.<br><br>
	</cfif>
</cfif>

<cfform name = "CarAdmin" action = "#CGI.SCRIPT_NAME#?#CGI.Query_String#" method = "post">

<cfoutput>
Edit Root Cause Category <b>#RootCause.Category#</b><br>
<cfinput name="Category" type="Text" size="75" value="#RootCause.Category#" required="Yes" message="Root Cause is a required field"><br><br>

Root Cause Description<br>
<textarea WRAP="PHYSICAL" ROWS="10" COLS="60" NAME="Description">#RootCause.Description#</textarea>
<br>

Change Description<br />
<textarea WRAP="PHYSICAL" ROWS="5" COLS="60" NAME="History">Please enter a description of the change</textarea>
<br />

<cfif RootCause.status eq 1>
<a href="RootCause_Remove_Confirm.cfm?ID=#URL.ID#&action=remove">Remove</a> this Root Cause from the active list
<cfelse>
<a href="RootCause_Remove_Confirm.cfm?ID=#URL.ID#&action=reinstate">Reinstate</a> this Root Cause to the active list
</cfif>
<br><br>

<A href="RootCause_UpdateLog.cfm?#CGI.Query_String#">View</A> Update Log for this Root Cause Category<br><br>
</cfoutput>

<input name="submit" type="submit" value="Edit CAR Source"><br><br>
</cfform>
</cfif>
						  
<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->