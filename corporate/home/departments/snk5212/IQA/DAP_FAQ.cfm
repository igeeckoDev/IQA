<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "DAP - Frequently Asked Questions">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

Please click a box to navigate to an area of interest.<br><br>

<!--- Heading Table --->
<table width="600" border="0" style="border-collapse: collapse;">
<tr>
	<td align="center">
		<div align="center">
			<A href="DAP_FAQ.cfm?#Lead Auditor">
				<img src="DAP_FAQ_Images\Lead Auditor.png" border="0" width="120">
			</a>
		</div>
	</td>
	<td align="center">
		<div align="center">
			<A href="DAP_FAQ.cfm?#Nonconformance Report (NCR)">
				<img src="DAP_FAQ_Images\Nonconformance Report (NCR).png" border="0" width="120">
			</a>
		</div>
	</td>
	<td align="center">
		<div align="center">
			<A href="DAP_FAQ.cfm?#Performance Monitoring and Enhancement">
				<img src="DAP_FAQ_Images\Performance Monitoring and Enhancement.png" border="0" width="120">
			</a>
		</div>
	</td>
	<td align="center">
		<div align="center">
			<A href="DAP_FAQ.cfm?#Technical">
				<img src="DAP_FAQ_Images\Technical.png" border="0" width="120">
			</a>
		</div>
	</td>
	<td align="center">
		<div align="center">
			<A href="DAP_FAQ.cfm?#General">
				<img src="DAP_FAQ_Images\General.png" border="0" width="120">
			</a>
		</div>
	</td>
</tr>
<tr>
	<td colspan="3">
		<hr class="faded" />
	</td>
</tr>
</table>

<!--->
<CFQUERY BLOCKFACTOR="100" NAME="FAQ_Areas" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM DAP_FAQ_Areas
WHERE Status = 'Active'
ORDER BY AreaName
</CFQUERY>

<b>Areas</b><br>
<CFOUTPUT QUERY="FAQ_Areas">
#AreaName#<br>
</cfoutput><br>
--->

<CFQUERY BLOCKFACTOR="100" NAME="DAP_FAQ" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT DAP_FAQ.ID, DAP_FAQ.Status, DAP_FAQ.Topic, DAP_FAQ.Content, DAP_FAQ.alphaID, DAP_FAQ_Areas.AreaName
FROM DAP_FAQ, DAP_FAQ_Areas
WHERE DAP_FAQ.Status = 'Active'
AND DAP_FAQ.AreaID = DAP_FAQ_Areas.ID
ORDER BY DAP_FAQ_Areas.ID, DAP_FAQ.alphaID
</CFQUERY>

<br>

<cfset AreaHolder = "">

<CFOUTPUT QUERY="DAP_FAQ">
<cfif AreaHolder IS NOT AreaName>
<cfIf AreaHolder is NOT ""><br></cfif>
<b><u>#AreaName#</u></b><br>
</cfif>

<a href="DAP_FAQ.cfm###ID#">## #alphaID#</a> - #Topic#<br>
<cfset AreaHolder = AreaName>
</CFOUTPUT><br>

<hr class="faded" /><br>

<cfset AreaHolder = "">

<CFOUTPUT QUERY="DAP_FAQ">
<cfif AreaHolder IS NOT AreaName>
<cfIf AreaHolder is NOT ""><br></cfif>

<a name="#AreaName#"></a>
<img src="DAP_FAQ_Images\#AreaName#.png" border="0" width="120"><br>
<b><u>#AreaName#</u></b><br><br>
</cfif>

<a name="#ID#"></a>
<B>#alphaID# - #Topic#</B><br><br>

<cfset dump = #replace(Content, "<p>", "", "All")#>
<cfset dump2 = #replace(dump, "</p>", "<br><br>", "All")#>
#dump2#<br>

<hr class="faded" /><br>

<cfset AreaHolder = AreaName>
</CFOUTPUT>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->