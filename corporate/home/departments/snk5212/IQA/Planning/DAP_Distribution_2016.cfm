<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "DAP Audit Planning 2016 - Distribution List">
<cfinclude template="shared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ID, SentTo, Type as Name, Responded, SurveyType, PostedBy, Posted, SentDate, SurveyFile
FROM DAPAuditPlanning2016_Users
WHERE ID <> 1
ORDER BY SentTo
</CFQUERY>

<b>Dear BU managers, Industry Coordinators, and Operations Staff:</b><br><br>

Assignment of DAP Audits for 2016 has begun. Our ultimate goal is to ensure that your BU based Auditor supply (capacity) meets your BU Audit
needs (Audit demand / quality).<br><br>

To help us in the process, we are requesting your input in meeting our shared goal for the 2016 audit year. This information will be included
in our audit and training plans.<br><br>

<!---
<b>Instructions</b><br />
Select the "Open Blank Survey" link to open the survey<br /><br />

<cfoutput>
<u>Open Blank Survey</u><br />
    :: <A href="getEmpNo_DAP.cfm">Open Survey</A><br /><br />
</cfoutput>
--->

<hr align="left"><br />

<b>Questions / Comments</b><br>
Please contact <a href="mailto:Linda.M.Ziemnick@ul.com">Linda Ziemnick</a> (North America) or <a href="mailto:Larisa.Aoyagi@ul.com">Larisa Aoyagi</a> (EULA, AP) for questions about this Survey.<br><br>

<cfif Distribution.RecordCount GT 0>
    <table border="1" width="900">
    <tr>
        <th>View Response</th>
        <th>Posted Date</th>
        <th>Sent To</th>
        <th>Date Sent</th>
        <th>Open Blank Survey</th>
	</tr>

    <cfoutput query="Distribution">
        <tr>
            <td valign="top" align="center">
                <cfif Responded eq "Yes">
                    <a href="2016_DAP_Details.cfm?UserID=#ID#">View</a>
                <cfelse>
                    --
                </cfif>
            </td>
            <td valign="top">
                #dateformat(Posted, "mm/dd/yyyy")#<br>
                <cfif Responded eq "Yes">
                    #replace(PostedBy,"),",")<br /><br />", "All")#
                </cfif>
            </td>

            <td valign="top">
                #replace(SentTo,",", "<br>", "All")#
            </td>

            <td valign="top">
                <cfif len(SentDate)>
                    #dateformat(SentDate, "mm/dd/yyyy")#
                <cfelse>
                    Not Sent
                </cfif>
            </td>

            <td valign="top" align="center">
	           	<A href="getEmpNo_DAP.cfm?UserID=#ID#"><img src="../../SiteImages/ico_article.gif" border="0" /></A>
            </td>
        </tr>
    </cfoutput>
    </table>
<cfelse>
	No Responses<br><br>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- / --->