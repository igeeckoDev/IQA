<cflock scope="Session" timeout="5">
	<cfif SESSION.Auth.Andon NEQ "Yes">
		<cflocation url="authorization.cfm?page=Andon" addtoken="no">
	</cfif>
</cflock>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title="Andon Checklist - Review Data">
<cfinclude template="SOP.cfm">

<!--- / --->

<cfquery name="newRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM Andon
WHERE ID = #URL.ID#
</cfquery>

<br />

<cfoutput query="newRow">
	<cfif len(L2Name) AND len(L2Dept) AND len(L2Location)
		OR
		len(L3Name) AND len(L3Dept) AND len(L3Location)>
In order to finalize this record, please <b>Submit</b> if everything is correct, or <b>Edit</b> if changes are required.<br>
 :: <b><a href="Andon_OK.cfm?#CGI.QUERY_STRING#">Submit</a></b> checklist<br>
 :: <b><a href="Andon_Edit.cfm?#CGI.QUERY_STRING#">Edit</a></b> checklist<br><br>
	<cfelse>
		<font color="red"><u>Action Required</u></font> - L2 OR L3 Information (Name, Department, <u>and</u> Location) is required.<br /><br />
         :: <b><a href="Andon_Edit.cfm?#CGI.QUERY_STRING#">Edit</a></b> checklist<br><br>  		
	</cfif>
</cfoutput>

<cfoutput query="newRow">
<b>Andon Checklist ID</b>: #ID#<br>
<b>Date Submitted</b>: #dateformat(AuditDate, "mm/dd/yyyy")# #timeformat(AuditDate, "HH:MM:SS")#<br>
<b>Auditor</b>: #AuditorName#<br>
<b>L2 Information</b>: <cfif len(L2Name)>#L2Name#<cfelse>[not entered]</cfif> / <cfif len(L2Dept)>#L2Dept#<cfelse>[not entered]</cfif> / <cfif len(L2Location)>#L2Location#<cfelse>[not entered]</cfif><Br>
<b>L3 Information</b>: <cfif len(L3Name)>#L3Name#<cfelse>[not entered]</cfif> / <cfif len(L3Dept)>#L3Dept#<cfelse>[not entered]</cfif> / <cfif len(L3Location)>#L3Location#<cfelse>[not entered]</cfif><Br>
<b>CCN</b>: #CCN#<br>
<b>Sector</b>: #Sector#<br><br>
<cfloop index="i" from="1" to="9">
	<b>Question #i#</b><br>
	<cfset var1=Evaluate("Q#i#")>
	<cfset var2=Evaluate("Q#i#Comments")>
	<u>Answer</u>: #var1# <cfif i eq 7>Hours</cfif><br>
	<u>Comments</u>: #var2#<br><br>
</cfloop>
</cfoutput>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->