<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href='CARSurvey_Distribution.cfm'>CAR Survey</a> - Survey Response List">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfinclude template="CARSurvey_menuItems.cfm">

<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
CARSurvey_Users.ID, CARSurvey_Users.SentTo, CARSurvey_Users.Responded,
CARSurvey_Users.PostedBy, CARSurvey_Users.Posted, CARSurvey_Users.SentDate,
CARSurvey_Users.GivenName, CARSurvey_Users.GivenEmail, CARSurvey_Users.Distribution_UserID

FROM
CARSurvey_Users

WHERE
ID <> 1
<cfif isDefined("URL.sort") AND len(url.sort)>
AND
	<cfif URL.sort eq "Ad">
		SentTo = 'Ad Hoc Response'
	<cfelseif URL.sort eq "GCAR">
		SentTo = 'GCAR Email'
	</cfif>
</cfif>

ORDER BY
CARSurvey_Users.Posted DESC
</CFQUERY>

Currently Viewing: <b><cfif isDefined("URL.sort") AND len(url.sort)>#url.sort#<cfelse>All Responses</cfif></b><br>
Change View: [<a href="CARSurvey_Distribution.cfm">All</a>] : [<a href="CARSurvey_Distribution.cfm?sort=Ad">Ad Hoc Responses</a>] : [<a href="CARSurvey_Distribution.cfm?sort=GCAR">GCAR Email Respones</a>]<br><br>

<cfset MonthHolder = "">
<cfset MonthHolder_Previous = "">

<cfif Distribution.RecordCount GT 0>
    <table border="1" width="650">
    	<tr>
	        <th>Posted Date</th>
	        <th>Name/Email</th>
	        <th>Survey Source</th>
	        <th>View Survey Results</th>
        </tr>
		<cfoutput query="Distribution">
		<cfset Posted_DateFormat = #dateformat(Posted, "mm/dd/yyyy")#>
		<cfset MonthHolder = #DatePart("m", Posted_DateFormat)#>

		<cfif MonthHolder NEQ MonthHolder_Previous>
		<tr>
			<th colspan="4" align="left">
            	<a name="#datepart("m", Posted_DateFormat)#"></a><b><u>#MonthAsString(datepart("m", Posted_DateFormat))# #datepart("yyyy", Posted_DateFormat)#</u></b>
            </th>
		</tr>
		</cfif>

			<tr>
	            <td valign="top">
		            <div align="left">
			            #dateformat(Posted, "mm/dd/yyyy")#
		            </div>
	            </td>
	            <td valign="top">
					Name: <cfif isDefined("GivenName") AND len(GivenName)>#GivenName#<cfelse>N/A</cfif><br />
					Email: <cfif isDefined("GivenEmail") AND len(GivenEmail)>#GivenEmail#<cfelse>N/A</cfif>
	            </td>
	            <td valign="top">
					#SentTo#
				</td>
	            <td valign="top" align="center">
		            <a href="CARSurvey_Details.cfm?UserID=#ID#">View</a><br />
	            </td>
	        </tr>
	    <cfset MonthHolder_Previous = MonthHolder>
	    </cfoutput>
    </table>
<cfelse>
	No Responses<br><br>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->