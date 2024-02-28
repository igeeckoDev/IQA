<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle="Add Report Page 3 - Report Card">

<!---#URL.Year#-#URL.ID#-#URL.AuditedBy#--->

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<!--- included for Form Validation and Formatted Form Textarea boxes --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

<CFQUERY BLOCKFACTOR="100" name="getAreas" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
select AreaName, ID
from ProgramReportCard_Areas
order by ID
</cfquery>

<cfform action="Report3_ReportCardAdd_Submit.cfm?#CGI.QUERY_STRING#" method ="post" id="myform" name="myform">

<cfoutput query="getAreas">
<Table border="1" width="800">
<tr valign="top">
	<th colspan="3">#AreaName#</th>
</tr>

<tr valign="top">
	<td colspan="3" align="center"><b>Approach</b></td>
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

	<td>
		<u>Rating</u><br><br>

		<cfselect
		    queryposition="below"
		    name="AreaID#ID#_Approach_Rating"
		    data-bvalidator="required"
		    data-bvalidator-msg="#AreaName# - Approach - Rating">
			    <option></option>
			    <option value="5">5</option>
		        <option value="4">4</option>
		        <option value="3">3</option>
		        <option value="2">2</option>
		        <option value="1">1</option>
		</cfselect>
	</td>

	<td>
		<u>Comments</u><br /><br>

		<cftextarea
			name="AreaID#ID#_Approach_Notes"
		    data-bvalidator="required"
			data-bvalidator-msg="#AreaName# - Approach - Comments"
			cols="20"
		    rows="8">No Comments Added</cftextarea>
	</td>
</tr>

<tr valign="top">
	<td colspan="3" align="center"><b>Effectiveness</b></td>
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
		</cfloop>
	</td>

	<td>
		<u>Rating</u><br><br>

		<cfselect
		    queryposition="below"
		    name="AreaID#ID#_Effectiveness_Rating"
		    data-bvalidator="required"
		    data-bvalidator-msg="#AreaName# - Effectiveness - Rating">
			    <option></option>
			    <option value="5">5</option>
		        <option value="4">4</option>
		        <option value="3">3</option>
		        <option value="2">2</option>
		        <option value="1">1</option>
		</cfselect>
	</td>

	<td>
		<u>Comments</u><br /><br>

		<cftextarea
			name="AreaID#ID#_Effectiveness_Notes"
		    data-bvalidator="required"
			data-bvalidator-msg="#AreaName# - Effectiveness - Comments"
			cols="20"
		    rows="8">No Comments Added</cftextarea>
	</td>
</tr>
</cfoutput>
</table><br><br>

<input type="submit" value="Save and Continue">
<input type="reset" value="Reset Form">
</cfform>

<!--- required for form validation --->
<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->