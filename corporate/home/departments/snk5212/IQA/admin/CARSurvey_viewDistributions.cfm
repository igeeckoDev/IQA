<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href='CARSurvey_Distribution.cfm'>CAR Survey</a> - View Email Distributions">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
*

FROM
CARSurvey_Distribution

WHERE
ID <> 1

ORDER BY
Year_, Quarter
</CFQUERY>

<a href="CARSurvey_addDistribution.cfm">Add</a> Distribution<br><br>

<CFQUERY BLOCKFACTOR="100" name="DistributionCount" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as Count
FROM CARSurvey_DistributionDetails, CARSurvey_Distribution
WHERE CARSurvey_Distribution.Status = 'Sent'
AND CARSurvey_Distribution.ID = CARSurvey_DistributionDetails.dID
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="ResponseCount" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as Count
FROM CARSurvey_Users
WHERE Distribution_UserID IS NOT NULL
</CFQUERY>

<b>Response Rate for all Quarterly Distributions</b><br>
<cfoutput>
<cfset avg = #ResponseCount.Count# / #DistributionCount.Count#>
#ResponseCount.Count# Responses / #DistributionCount.Count# Recipients - #NumberFormat(avg * 100,"999.99")#%
<br><br>
</cfoutput>

<cfset YearHolder = "">

<cfif Distribution.RecordCount GT 0>
    <table border="1" width="700">
    	<tr>
	        <th>Year</th>
	        <th>Quarter</th>
	        <th>Responses</th>
	        <th>Recipients</th>
	        <th>Response Percent</th>
	        <th>View Distribution List</th>
	        <th>Status</th>
        </tr>
		<cfoutput query="Distribution">
			<CFQUERY BLOCKFACTOR="100" name="DistributionCount" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			SELECT Count(*) as Count
			FROM CARSurvey_DistributionDetails
			WHERE dID = #ID#
			</CFQUERY>

			<CFQUERY BLOCKFACTOR="100" name="ResponseCount" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			SELECT Count(*) as Count
			FROM CARSurvey_Users, CARSurvey_DistributionDetails, CARSurvey_Distribution
			WHERE CARSurvey_Distribution.ID = #ID#
			AND CARSurvey_Distribution.ID = CARSurvey_DistributionDetails.dID
			AND CARSurvey_DistributionDetails.ID = CARSurvey_Users.Distribution_UserID
			</CFQUERY>

			<cfif Year_ NEQ YearHolder AND len(Year_)>
			<tr>
				<th colspan="7" align="left">
	            	<b><u>#Year_#</u></b>
	            </th>
			</tr>
			</cfif>
		<tr>
            <td valign="top" align="center">
	            #Year_#
            </td>
            <td valign="top" align="center">
	            Quarter #Quarter#
            </td>
			<td valign="top" align="center">
				<cfif Status eq "Sent">
					#ResponseCount.Count#
				<cfelse>
					N/A
				</cfif>
			</td>
			<td valign="top" align="center">
				#DistributionCount.Count#
			</td>
			<td valign="top" align="center">
				<cfif Status eq "Sent">
					<cfset avg = #ResponseCount.Count# / #DistributionCount.Count#>
					#NumberFormat(avg * 100,"999.99")#%
				<cfelse>
					Not Sent
				</cfif>
			</td>
            <td valign="top" align="center">
	            <a href="CARSurvey_manageDistribution.cfm?ID=#ID#">View</a><br />
            </td>
            <td valign="top" align="center">
            	<cfif Status eq "Sent">Sent - #dateformat(SentDate, "mm/dd/yyyy")#<cfelse>Not Sent</cfif>
            </td>
        </tr>
	    <cfset YearHolder = Year_>
	    </cfoutput>
    </table>
<cfelse>
	No Distributions have been created<br><br>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->