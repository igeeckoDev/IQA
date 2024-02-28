<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "#Request.SiteTitle# - Send Email - View">
<cfinclude template="SOP.cfm">

<!--- / --->

<cfquery name="Email" datasource="Corporate" blockfactor="100"> 
SELECT * FROM IQADB_SendEmail
WHERE ID = #URL.ID#
</cfquery>

<cfoutput query="Email">
<b>Date Sent</b> - #dateformat(SendDate, "mm/dd/yyyy")#<br />
<b>To</b> - #SendTo#<br />
<b>From/BCC</b> - #Author#<br />
<b>CC</b> - <cfif len(SendCC)>#SendCC#<cfelse>None</cfif><br />
<b>Reference</b> - #Reference#<br /><br />

<b>Message</b><br />
<cfset Dump = #replace(EmailBody, "<p>", "", "All")#>
#replace(Dump, "</p>", "<br /><br />", "All")#
</cfoutput>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->