<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle="Edit Report Page 3 - Report Card">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfoutput>
Note: If this page has no information other than the 'Save and Continue' and 'Reset Form' buttons, please follow this link:<br>
<a href="Report3_ReportCardAdd.cfm?#CGI.QUERY_STRING#?Report4=Edit">Report Page 3: Report Card</a><br><br>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" name="outputOfReportData" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
	ProgramReportCard_Report3.Rating, ProgramReportCard_Report3.Comments, ProgramReportCard_Areas.AreaName, ProgramReportCard_Report3.CriteriaType,
	ProgramReportCard_Areas.ID
FROM
	ProgramReportCard_Report3, ProgramReportCard_Areas
WHERE
	ProgramReportCard_Areas.ID = ProgramReportCard_Report3.AreaID
	AND ProgramReportCard_Report3.ID = #URL.ID#
	AND ProgramReportCard_Report3.Year_ = #URL.Year#
ORDER BY
	ProgramReportCard_Areas.ID, ProgramReportCard_Report3.CriteriaType
</cfquery>

<cfset AreaHolder = "">

<cfform action="Report3_ReportCardEdit_Submit.cfm?ID=#URL.ID#&Year=#URL.Year#" method ="post" id="myform" name="myform">

<cfoutput query="outputOfReportData">
<Table border="1" width="800">

<cfif AreaHolder IS NOT AreaName>
	<cfIf len(Areaholder)></cfif>

	<tr valign="top">
		<th colspan="3">#AreaName#</th>
	</tr>
</cfif>

<tr valign="top">
	<td colspan="3" align="center"><b>#CriteriaType#</b></td>
</tr>

<tr valign="top">
	<td width="60%">

		<CFQUERY BLOCKFACTOR="100" name="getCriteria" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		select CriteriaText, Rating
		from ProgramReportCard_Criteria
		where AreaID = #ID#
		and criteriaType = '#CriteriaType#'
		order by Rating
		</cfquery>

		<u>Criteria:</u><br>
		<cfloop query="getCriteria">
			#getCriteria.Rating#: #getCriteria.CriteriaText#<br>
		</cfloop>
	</td>
	<td width="7%">
		<u>Rating:</u> #Rating#<br><br>

		<cfselect
		    queryposition="below"
		    name="AreaID#ID#_#CriteriaType#_Rating"
		    data-bvalidator="required"
		    data-bvalidator-msg="#AreaName# - #CriteriaType# - Rating">
			    <option></option>
			    <option value="#Rating#" selected>#Rating#</option>
			    <option value="5">5</option>
		        <option value="4">4</option>
		        <option value="3">3</option>
		        <option value="2">2</option>
		        <option value="1">1</option>
		</cfselect>
	</td>
	<td width="33%">
		<u>Comments:</u> #Comments#<br><br>

		<cftextarea
			name="AreaID#ID#_#CriteriaType#_Notes"
		    data-bvalidator="required"
			data-bvalidator-msg="#AreaName# - #CriteriaType# - Comments"
			cols="26"
		    rows="8">#Comments#</cftextarea>
	</td>
</tr>
</table>
<cfset AreaHolder = AreaName>
</cfoutput><br><Br>

<input type="submit" value="Save and Continue">
<input type="reset" value="Reset Form">
</cfform>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->