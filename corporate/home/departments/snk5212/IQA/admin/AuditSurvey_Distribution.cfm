<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Survey - Response/Distribution List for #URL.Year#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfinclude template="AuditSurvey_menuItems.cfm">

<cflock scope="SESSION" timeout="10">
	<cfif SESSION.Auth.AccessLevel eq "IQAAuditor">
		<CFQUERY BLOCKFACTOR="100" NAME="AuditorProfile" Datasource="Corporate">
		SELECT ID, Lead, Auditor
		FROM AuditorList
		<cfif SESSION.Auth.Username neq "Jessen">
			WHERE Auditor = '#SESSION.Auth.Name#'
		</cfif>
		</cfquery>
	</cfif>

	<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT
	UL06046.AuditSurvey_Users.ID, UL06046.AuditSurvey_Users.AuditYear, UL06046.AuditSurvey_Users.AuditId, UL06046.AuditSurvey_Users.SentTo,
	UL06046.AuditSurvey_Users.Responded, UL06046.AuditSurvey_Users.PostedBy, UL06046.AuditSurvey_Users.Posted, UL06046.AuditSurvey_Users.SentDate,
	UL06046.AuditSurvey_Users.GivenName, UL06046.AuditSurvey_Users.GivenEmail, Corporate.AuditSchedule.Month, Corporate.AuditSchedule.OfficeName,
	Corporate.AuditSchedule.Area, Corporate.AuditSchedule.AuditType2, Corporate.AuditSchedule.AuditedBy, Corporate.AuditSchedule.LeadAuditor

	FROM
	UL06046.AuditSurvey_Users, Corporate.AuditSchedule

	WHERE
	UL06046.AuditSurvey_Users.AuditYear = '#URL.Year#'
	<cfif SESSION.Auth.AccessLevel eq "IQAAuditor" AND AuditorProfile.Lead eq "Yes">
		AND Corporate.AuditSchedule.LeadAuditor = '#AuditorProfile.Auditor#'
	</cfif>
	AND UL06046.AuditSurvey_Users.AuditYear = Corporate.AuditSchedule.Year_
	AND UL06046.AuditSurvey_Users.AuditID = Corporate.AuditSchedule.ID
	AND Corporate.AuditSchedule.AuditedBy = 'IQA'

	ORDER BY
	Corporate.AuditSchedule.Month, UL06046.AuditSurvey_Users.AuditID, UL06046.AuditSurvey_Users.Responded, UL06046.AuditSurvey_Users.Posted DESC
	</CFQUERY>
</cflock>

View Year:<br>
<SELECT NAME="Year" displayname="Year" ONCHANGE="location = this.options[this.selectedIndex].value;">
		<option value="">Select Year Below
		<option value="">---
<cfloop index="i" to="#curyear#" from="2014">
		<cfoutput><OPTION VALUE="#CGI.SCRIPT_NAME#?Year=#i#">#i#</cfoutput>
</cfloop>
</SELECT>
<br><br>

<cfif Distribution.RecordCount GT 0>
    <table border="1" width="650">
    <Cfset AuditIDHolder = "">
    <cfset MonthHolder = "">
	<cfset previousRow = "">

    <cfoutput query="Distribution">
    	<cfif MonthHolder IS NOT Month>
			<cfif len(MonthHolder)>
            	<tr>
                	<td colspan="5" align="right">
                    	<a href="##Top">Top <img src="#IQADIR#images/top.gif" alt="" height="7" width="5" border="0"></a>&nbsp;
                    </td>
                </tr>
			</cfif>
            <tr>
                <th colspan="5" align="left">
                    <a name="#Month#"></a><b><u>#MonthAsString(Month)#</u></b>
                </th>
            </tr>
            <tr>
                <th>Audit Number</th>
                <th>Response</th>
                <th>Posted Date</th>
                <th>Sent To</th>
                <th>Date Sent</th>
            </tr>
	</cfif>
	<cfif AuditIDHolder IS NOT AuditID>
        <tr>
            <td align="left" colspan="5">
                <a href="AuditDetails.cfm?ID=#AuditID#&Year=#AuditYear#">#AuditYear#-#AuditID#-IQA</a><br />
                #Area# | #OfficeName# | #AuditType2# | #LeadAuditor#
            </td>
        </tr>
    </cfif>
        <tr>
			<td>&nbsp;</td>
            <td valign="top" align="center">
                <cfif Responded eq "Yes">
                    <a href="AuditSurvey_Details.cfm?UserID=#ID#">View</a><br />
                	<img src="#IQADIR#images/green.jpg" border="0">
				<cfelse>
                	N/A<br />
                    <img src="#IQADIR#images/red.jpg" border="0">
                </cfif>
            </td>

            <td valign="top">
                <cfif isDefined("Posted") AND len(Posted)>
                    <div align="left">
                    #dateformat(Posted, "mm/dd/yyyy")#
						<cfif Responded eq "Yes">
                            <br />Name: <cfif isDefined("GivenName")>#GivenName#<cfelse>N/A</cfif>
                            <br />Email: <cfif isDefined("GivenEmail")>#GivenEmail#<cfelse>N/A</cfif>
                            <!---#replace(PostedBy,"),",")<br /><br />", "All")#--->
                        </cfif>
                    </div>
				<cfelse>
                	<div align="center">
                    N/A
                	</div>
				</cfif>
            </td>

            <td valign="top">
                <cfif SentTo NEQ "Referred">
                	#replace(SentTo,",", "<br>", "All")#
                <Cfelse>
                	#SentTo#
                </cfif>
            </td>

            <td valign="top">
                <cfif len(SentDate)>
                    #dateformat(SentDate, "mm/dd/yyyy")#
                <cfelse>
                	--
                </cfif>
            </td>
        </tr>
        <cfset AuditIDHolder = AuditID>
        <cfset previousRow = AuditID>
        <cfset MonthHolder = Month>
    </cfoutput>
    </table>
<cfelse>
	No Responses<br><br>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->