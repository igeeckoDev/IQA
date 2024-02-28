<cflock scope="Session" timeout="5">
	<cfif SESSION.Auth.Andon NEQ "Yes">
		<cflocation url="authorization.cfm?page=Andon" addtoken="no">
	</cfif>
</cflock>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title="Andon Checklist - Submitted">
<cfinclude template="SOP.cfm">

<!--- / --->

<cfquery name="AddnewRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE Andon
SET

Complete='Yes'

WHERE ID = #URL.ID#
</cfquery>

<br>
Checklist ID <cfoutput>#URL.ID#</cfoutput> has been successfully submitted.<br /><br />

<b><a href="Andon_Add.cfm">Add</a></b> new checklist<br /><br />

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->