<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "CAR Root Cause Update History">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="RootCause" DataSource="Corporate"> 
SELECT * FROM CAR_RootCause
WHERE ID = #URL.ID#
</cfquery>

<cfoutput query="RootCause">
<b>Current Category Name</b>:<br>
#Category#<br><br>

<b>Current Description</b>:<br>
<cfset Dump = #replace(Description, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "<Br><br>", "All")#>
#Dump2#

<hr><br>

<b>Update History</b>:<br>
<cfset Dump = #replace(UpdateLog, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "<Br><br>", "All")#>
#Dump2#
</CFOUTPUT>

<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->