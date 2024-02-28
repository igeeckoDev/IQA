<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Requests to be a CAR Administrator">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="OpenRequests" DataSource="Corporate"> 
SELECT * FROM CARAdminRequest
WHERE Status IS NULL
ORDER BY ID
</cfquery>
		
<b>Open Requests</b>
<table width="650" border="1" cellpadding="1" cellspacing="1" valign="top">
 <tr align="center" valign="top">
	<td class="sched-title">Requestor Name</td>
	<td class="sched-title">Location</td>
	<td class="sched-title">Request Date</td>
 </tr>
<cfif OpenRequests.RecordCount neq 0>
<CFOUTPUT QUERY="OpenRequests">
 <tr>
	<td class="sched-content" valign="top">#Name# - 
<a href="#CARRootDir#RequestView.cfm?ID=#ID#">View Request Details</a></td>
	<td class="sched-content" valign="top">#Location#</td>
	<td class="sched-content" valign="top">#dateformat(posted, "mm/dd/yyyy")#</td>
 </tr>
 </CFOUTPUT>
<cfelse>
 <tr>
 	<td class="sched-content" valign="top" colspan="3">Currently there are no Open Requests</td>
 </tr>
</cfif>
</table><br><br>

<CFQUERY BLOCKFACTOR="100" NAME="CompletedRequests" DataSource="Corporate"> 
SELECT * FROM CARAdminRequest
WHERE Status IS NOT NULL
ORDER BY Status, ID
</cfquery>

<b>Completed Requests</b><br>
<table width="650" border="1" cellpadding="1" cellspacing="1" valign="top">
 <tr align="center" valign="top">
	<td class="sched-title">Requestor Name</td>
	<td class="sched-title">Location</td>
	<td class="sched-title">Request Date</td>
 </tr>
<cfset HolderStatus = "">
<CFOUTPUT QUERY="CompletedRequests">
<cfif HolderStatus IS NOT Status> 
<cfIf HolderStatus is NOT ""><br></cfif>
</td></tr><tr><td class="sched-title" align="left" colspan="3">Status - #Status#</cfif>
 <tr>
	<td class="sched-content" valign="top">#Name# - 
<a href="#CARRootDir#RequestView.cfm?ID=#ID#">View Request Details</a></td>
	<td class="sched-content" valign="top">#Location#</td>
	<td class="sched-content" valign="top">#dateformat(posted, "mm/dd/yyyy")#</td>
 </tr>
<cfset HolderStatus = Status>
</CFOUTPUT>
</table>

<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->