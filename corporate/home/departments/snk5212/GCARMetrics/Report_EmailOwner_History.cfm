<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset SubTitle = "CAR Trend Reports - <a href=Report_Owners.cfm>Functional Group Owners</a> - Email History">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfquery name="selectEmails" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * 
FROM GCAR_METRICS_SentEmail
ORDER BY SendDate DESC, ID
</cfquery>

<table border="1">
<tr>
	<th align="center">Date Sent</th>
    <th align="center">Subject</th>
    <th align="center">From</th>
    <th align="center">View Email</th>
    <th align="center">View Report</th>
</tr>
<cfoutput query="selectEmails">
<tr>
    <td valign="top">#dateformat(SendDate, "mm/dd/yyyy")#</td>
    <td valign="top">#Subject#</td>
    <td valign="top">#SendFrom#</td>
    <td valign="top" align="center">
    	<a href="Report_EmailOwner_Details.cfm?ID=#ID#">
        	<img src="#SiteDir#SiteImages/emailicon_small.png" border="0" alt="View Email" />
        </a>
    </td>
    <td valign="top" align="center">
    	<cfif ReportID NEQ "All">
            <a href="Report_Details.cfm?ID=#ReportID#">
                <img src="#SiteDir#SiteImages/report_small.png" border="0" alt="View Report" />
            </a>
        <cfelse>
        --
        </cfif>
    </td>
</tr>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->