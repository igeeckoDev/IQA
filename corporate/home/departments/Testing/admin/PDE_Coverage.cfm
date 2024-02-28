<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Coverage - PDE (added: April 2017)">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
<u>Select Year</u>: 
	<cfloop index=i from=2017 to=#curyear#>
		<a href="PDE_Coverage.cfm?Year=#i#">#i#</a> 
	</cfloop><br><br>
</cfoutput>

<CFQUERY Name="PDE" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM Report1_PDE
WHERE xGUID > 1
ORDER BY Industry, Name
</cfquery>

<table border=1>
<tr>
	<th>PDE Name</th>
	<th>PDE Industry</th>
	<th>Audit Number</th>
	<th>Site Name</th>
</tr>
	<cfoutput query="PDE">
		<tr>
			<td>#Name#</td>
			<td>#Industry#</td>
			<td align="center">#Year_#-#ID#</td>
			<td>#OfficeName#</td>			
		</tr>
	</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->