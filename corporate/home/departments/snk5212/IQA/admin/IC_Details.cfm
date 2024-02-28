<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="IC">
SELECT IC, ICComments, OfficeName, ID
FROM IQAtblOffices
WHERE ID = #URL.ID#
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "UL Locations - #IC.OfficeName# - International Certification Form Control">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<cfoutput query="IC">
<a href="IC.cfm">View IC Form Control Table</a><br><br>

<b>Office Name:</b><br>
#OfficeName# [<a href="IC_Edit.cfm?ID=#ID#">edit</a>]<br><br>

<b>IC Form Required</b>:<br />
<cfif IC is "Yes">Yes<cfelse>No</cfif><br><br>

<b>Comments</b>:<br> 
<cfif ICComments is "">
	No Comments
<cfelse>
<cfset Dump = #replace(ICComments, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "<br /><br />", "All")#>
	#Dump2#
</cfif>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->