<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<CFQUERY BLOCKFACTOR="100" name="log" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->
SELECT * FROM IQADB_LOGIN "LOGIN" 
ORDER BY Status DESC, TotalLogins DESC
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Access Log">
<cfinclude template="SOP.cfm">

<!--- / --->

<br>
<table border="1" width="650">
<tr>
<td class="blog-title">
	Username
</td>
<td class="blog-title">
	Name / Email
</td>
<td class="blog-title">
	Access Level
</td>
<td class="blog-title">
	Status
</td>
<td class="blog-title">
	Total Logins
</td>
<td class="blog-title">
	View Access Log
</td>
</tr>
<cfoutput query="log">
<tr>
<td class="blog-content">
	#username#
</td>
<td class="blog-content">
	<cfif Name is NOT "">#Name# [<a href="user2_edit.cfm?id=#ID#">edit</a>]<cfelse>None Listed</cfif>
</td>
<td class="blog-content">
<cfif accesslevel is "RQM">
	#AccessLevel# - #SubRegion#/#Region#<cfif office is NOT "">/#Office#</cfif>
<cfelse>
	#AccessLevel#	
</cfif>
</td>
<td class="blog-content">
<cfif status is "">
	Active
<cfelse>
    #Status#
</cfif>
</td>
<td class="blog-content">
#TotalLogins#
</td>
<td class="blog-content">
	<a href="user.cfm?ID=#ID#">View</a>
</td>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->