<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Office">
SELECT OfficeName
FROM IQAtblOffices
WHERE ID = #URL.ID#
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href=SNAP.cfm>UL OSHA SNAP Sites</a> - Details - #Office.OfficeName#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="SNAP">
SELECT *
FROM IQAtblOffices
WHERE ID = #URL.ID#
</cfquery>

<cfquery Datasource="Corporate" name="RH">
SELECT ID, OfficeNameId, RevNo, RevDate, RevAuthor, RevDetails
FROM SNAP_RH
WHERE RevNo = (SELECT MAX(RevNo) from SNAP_RH WHERE OfficeNameID = #url.id#)
AND OfficeNameID = #url.id#
</CFQUERY>

<cfoutput query="SNAP">
<b>Office Name:</b><br>
#OfficeName# [<a href="SNAP_Edit.cfm?ID=#ID#">edit</a>]<br><br>

<!---
<b>SNAP Site</b>:<br />
<cfif SNAPSite eq 1>Yes<cfelse>No</cfif><br><br>
--->

<b>SNAP Site</b>:<br />
<cfif SNAPAudit eq 1>Yes<cfelse>No</cfif><br><br>

<b>Comments</b>:<br>
<cfif SNAPComments is "">
	No Comments
<cfelse>
<cfset Dump = #replace(SNAPComments, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "<br /><br />", "All")#>
	#Dump2#
</cfif>

<b>SCC Site</b>:<br />
<cfif SCCSite eq 1>Yes<cfelse>No</cfif><br><br>

<b>Comments</b>:<br>
<cfif NOT len(SCCComments)>
	No Comments
<cfelse>
<cfset Dump = #replace(SCCComments, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "<br /><br />", "All")#>
	#Dump2#
</cfif>

</cfoutput>

<cfoutput query="RH" group="RevNo">
<b>Current Revision</b><br>
<u>Revision Number</u>: #RevNo#<br>
<u>Revision Date</u>: #dateformat(RevDate, "mmmm dd, yyyy")#<br>
<u>Revision Author</u>: #RevAuthor#<br>
<u>Revision Details</u>: #RevDetails#<Br><br>

<b>Full Revision History</b><br>
<A HREF="javascript:popUp('SNAP_rh.cfm?ID=#url.ID#')">View</a> Revision History<br><br>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->