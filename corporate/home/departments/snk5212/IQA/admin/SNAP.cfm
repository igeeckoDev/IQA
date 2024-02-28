<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "UL Sites - OSHA SNAP and SCC Status">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="SNAP">
SELECT SNAPSite, SNAPComments, OfficeName, ID, SNAPAudit, SNAPList_OfficeName, SCCSite
FROM IQAtblOffices
WHERE finance = 'Yes'
AND Exist = 'Yes'
AND Physical = 'Yes'
AND SuperLocation <> 'Yes'
AND CB <> 'Yes'
ORDER BY SNAPList_OfficeName
</cfquery>

 :: <a href="SNAPRHLog.cfm">Revision History Log</a><br><br>

<b>UL LLC Site Status</b> (posted on April 26 2017)<br>
<a href="https://ul.sharepoint.com/sites/quality/539/Shared Documents/Staff Directories/Staff Assigned to Invalid Locations in Oracle" target="_blank">Staff in Oracle with INVALID location</a><br><br>
 
<b>Notes</b><br>
<u>OSHA SNAP Sites</u> require 2 audits each year. 1 is part of the "Processes" (or "Processes and Labs") audit, the other is conducted in the other half of the year. (approx 6 months before or after the Processes/Processes and Labs audit)<br><br>
<u>SCC Sites</u> require that SCC Certification Body Accreditation Program Requirements are considered in the "Processes" (or "Processes and Labs") audit.<br><br>
 
<table border="1" width="800">
<tr>
<td class="blog-title" align="center">IQA DB Office Name</td>
<td class="blog-title" align="center">Office Name<br />(per Keith Mowry's OSHA SNAP List)</td>
<td class="blog-title" align="center">OSHA SNAP Status</td>
<td class="blog-title" align="center">SCC Status</td>
<td class="blog-title" align="center">Comments/<br>Details</td>
</tr>
<cfoutput query="SNAP">
<tr>
<td class="blog-content">#OfficeName#
	<cflock scope="Session" timeout="5">
		<cfif Session.Auth.AccessLevel eq "SU" or SESSION.Auth.AccessLevel eq "Admin">
		[<a href="Snap_Edit.cfm?ID=#ID#">edit</a>]
		</cfif>
	</cflock>
</td>
<td class="blog-content" align="left">#SNAPList_OfficeName#</td>
<td class="blog-content" align="center"><cfif SNAPAudit eq 1><b>x</b><cfelse>--</cfif></td>
<td class="blog-content" align="center"><cfif SCCSite eq 1><b>x</b><cfelse>--</cfif></td>
<td class="blog-content" align="center"><a href="Snap_Details.cfm?ID=#ID#">view</a></td>
</tr>
</cfoutput>
</table><br><br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->