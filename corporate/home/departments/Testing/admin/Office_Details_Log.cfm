<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Office">
SELECT OfficeName
FROM IQAtblOffices
WHERE ID = #URL.ID#
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "UL Locations - #Office.OfficeName# - Activity Log">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Details">
SELECT *
FROM IQAtblOffices
WHERE ID = #URL.ID#
</CFQUERY>

<b>Details</b><br />
<cfoutput query="Details">
<u>Office Name</u>: <a href="Office_Details.cfm?ID=#ID#">#OfficeName#</a><Br>
<u>Region</u>: #Region#<br>
<u>SubRegion</u>: #SubRegion#<br><Br />

<b>Activity Log</b><br />
#Log#
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->