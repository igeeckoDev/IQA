<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "#Request.SiteTitle# - Send Email - Views">
<cfinclude template="SOP.cfm">

<!--- / --->

<br />

<cfquery name="Email" datasource="Corporate" blockfactor="100"> 
SELECT * FROM IQADB_SendEmail
WHERE ID > 1
ORDER BY Reference, SendTo, ID
</cfquery>

<cfif Email.RecordCount eq 0>
No Emails have been sent yet.
<cfelseif Email.RecordCount gte 1>

<cfset RefHolder = "">
<cfset ToHolder = "">

<cfoutput query="Email">
<cfif RefHolder IS NOT Reference> 
	<cfset ToHolder = "">
<cfIf RefHolder is NOT ""><br></cfif>
<b><u>Reference:</u></b> #Reference#<br> 
</cfif>

<cfif ToHolder IS NOT SendTo> 
<cfIf ToHolder is NOT ""><br></cfif>
&nbsp;&nbsp;<u>Sent To:</u> #SendTo#<br> 
</cfif>

&nbsp;&nbsp;&nbsp;&nbsp; <img src="../images/ico_article.gif" border="0"> #dateformat(SendDate, "mm/dd/yyyy")# - <a href="SendEmail_ViewID.cfm?ID=#ID#">#Subject#</a><br>
 
<cfset RefHolder = Reference>
<cfset ToHolder = SendTo>
</cfoutput>

</cfif>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->
