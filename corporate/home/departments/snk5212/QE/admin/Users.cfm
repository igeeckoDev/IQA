<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "CAR Process Website Users">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Accounts"> 
SELECT * FROM  CAR_LOGIN  "LOGIN" ORDER BY AccessLevel, UserName
</CFQUERY>

<table width="650" border="1" cellpadding="1" cellspacing="1" valign="top">

 <tr align="center" valign="top">
	<td class="sched-title">Username</td>
	<td class="sched-title">Name</td>
	<td class="sched-title">Email</td>	
	<td class="sched-title">Status</td>
 </tr>
<cfset Access = "">
<cfoutput query="Accounts">
<cfif Access IS NOT AccessLevel> 
	<cfif Access is NOT "">
		<br>
	</cfif>
	</td>
</tr>
<tr>
<td class="sched-title" colspan="4">
Access Level :: #AccessLevel#	
</cfif>
 <tr>
	<td class="sched-content" valign="top">
		#Username#
	</td>
	<td class="sched-content" valign="top">
		#Name#
	</td>
	<td class="sched-content" valign="top">
		<a href="mailto=#Email#">#email#</a>
	</td>	
	<td class="sched-content" valign="top">
		<cfif Status is "">Active<cfelse>#Status#</cfif>
	</td>
</tr>
<cfset Access = AccessLevel>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->