<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle="Program Report Card - Approach and Effectiveness Criteria">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<CFQUERY BLOCKFACTOR="100" name="getAreas" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
select AreaName, ID
from ProgramReportCard_Areas
order by ID
</cfquery>

<cfoutput query="getAreas">
<Table border="1" width="800" style="border-collapse: collapse;">
<tr valign="top">
	<th align="left">#AreaName#</th>
</tr>

<tr valign="top">
	<td align="left"><b>Approach</b></td>
</tr>

<tr valign="top">
	<td>
		<u>Criteria</u><Br><br>

		<CFQUERY BLOCKFACTOR="100" name="getCriteria" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		select Rating, CriteriaText
		from ProgramReportCard_Criteria
		where AreaID = #ID#
		and criteriaType = 'Approach'
		order by Rating
		</cfquery>

		<cfloop query="getCriteria">
		#Rating#: #CriteriaText#<br>
		</cfloop><br>
	</td>
</tr>

<tr valign="top">
	<td align="left"><b>Effectiveness</b></td>
</tr>

<tr valign="top">
	<td>
		<u>Criteria</u><br><br>

		<CFQUERY BLOCKFACTOR="100" name="getCriteria" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		select Rating, CriteriaText
		from ProgramReportCard_Criteria
		where AreaID = #ID#
		and criteriaType = 'Effectiveness'
		order by Rating
		</cfquery>

		<cfloop query="getCriteria">
		#Rating#: #CriteriaText#<br>
		</cfloop><br>
	</td>
</tr>
</cfoutput>
</table><br><br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->