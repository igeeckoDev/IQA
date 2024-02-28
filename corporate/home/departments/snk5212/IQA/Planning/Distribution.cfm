<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Planning 2012 - #URL.Type# Distribution List">
<cfinclude template="shared/StartOfPage.cfm">
<!--- / --->

View: 
<cfif URL.Type eq "Program">
	<b>Program</b> : <a href="Distribution.cfm?Type=Process">Process</a> : <a href="Distribution.cfm?Type=Site">Site</a> : <a href="Distribution.cfm?Type=Other">Other</a> : <a href="Distribution.cfm?Type=New">New</a>
<cfelseif URL.Type eq "Process">
	<a href="Distribution.cfm?Type=Program">Program</a> : <b>Process</b> : <a href="Distribution.cfm?Type=Site">Site</a> : <a href="Distribution.cfm?Type=Other">Other</a> : <a href="Distribution.cfm?Type=New">New</a>
<cfelseif URL.Type eq "Site">
	<a href="Distribution.cfm?Type=Program">Program</a> : <a href="Distribution.cfm?Type=Process">Process</a> : <b>Site</b> : <a href="Distribution.cfm?Type=Other">Other</a> : <a href="Distribution.cfm?Type=New">New</a>
<cfelseif URL.Type eq "Other">
	<a href="Distribution.cfm?Type=Program">Program</a> : <a href="Distribution.cfm?Type=Process">Process</a> : <a href="Distribution.cfm?Type=Site">Site</a> :  <b>Other</b> : <a href="Distribution.cfm?Type=New">New</a>
<cfelseif URL.Type eq "New">
	<a href="Distribution.cfm?Type=Program">Program</a> : <a href="Distribution.cfm?Type=Process">Process</a> : <a href="Distribution.cfm?Type=Site">Site</a> :  <a href="Distribution.cfm?Type=Other">Other</a> : <b>New</b>
</cfif><Br><br>

<cfif URL.Type eq "Program">
    <CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT AuditPlanning_Users.ID as ID, AuditPlanning_Users.SentTo as SentTo, AuditPlanning_Users.Responded, AuditPlanning_Users.SurveyType, AuditPlanning_Users.PostedBy, AuditPlanning_Users.Posted, AuditPlanning_Users.SentDate, Corporate.ProgDev.Program as Name
    FROM AuditPlanning_Users, Corporate.ProgDev
    WHERE AuditPlanning_Users.Type = 'Program'
    AND AuditPlanning_Users.pID = Corporate.ProgDev.ID
    ORDER BY Corporate.ProgDev.Program, AuditPlanning_Users.Responded, AuditPlanning_Users.Posted DESC
    </CFQUERY>
<cfelseif URL.Type eq "Process">
	<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT AuditPlanning_Users.ID as ID, AuditPlanning_Users.SentTo as SentTo, AuditPlanning_Users.Responded, AuditPlanning_Users.SurveyType, AuditPlanning_Users.PostedBy, AuditPlanning_Users.Posted, AuditPlanning_Users.SentDate, Corporate.GlobalFunctions.Function as Name
    FROM AuditPlanning_Users, Corporate.GlobalFunctions
    WHERE AuditPlanning_Users.Type = 'Process'
    AND AuditPlanning_Users.pID = Corporate.GlobalFunctions.ID
    ORDER BY Corporate.GlobalFunctions.Function, AuditPlanning_Users.Responded, AuditPlanning_Users.Posted DESC
    </CFQUERY>
<cfelseif URL.Type eq "Site">
	<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT AuditPlanning_Users.ID as ID, AuditPlanning_Users.SentTo as SentTo, AuditPlanning_Users.Responded, AuditPlanning_Users.SurveyType, AuditPlanning_Users.PostedBy, AuditPlanning_Users.Posted, AuditPlanning_Users.SentDate, Corporate.IQAtblOffices.OfficeName as Name
    FROM AuditPlanning_Users, Corporate.IQAtblOffices
    WHERE AuditPlanning_Users.Type = 'Site'
    AND AuditPlanning_Users.pID = Corporate.IQAtblOffices.ID
    ORDER BY AuditPlanning_Users.Posted DESC, Corporate.IQAtblOffices.OfficeName, AuditPlanning_Users.Responded
    </CFQUERY>
<cfelseif URL.Type eq "Other">
	<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ID, SentTo, Type as Name, Responded, SurveyType, PostedBy, Posted, SentDate
    FROM AuditPlanning_Users
    WHERE Type = 'VS' OR Type = 'WiSE' OR Type = 'ULE' OR Type = 'Lab'
    ORDER BY Type, Responded, Posted DESC
    </CFQUERY>
<cfelseif URL.Type eq "New">
	<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ID, SentTo, Type, Responded, SurveyType, PostedBy, Posted, SentDate, Request as Name
    FROM AuditPlanning_Users
    WHERE Type = 'New'
    ORDER BY Posted DESC
    </CFQUERY>
</cfif>

<cfif Distribution.RecordCount GT 0>
    <table border="1">
    <tr>
        <th>Name</th>
        <th>Response</th>
        <th>Posted Date</th>
        <th>Sent To</th>
        <cfif URL.Type NEQ "Site">
        <th>Date Sent</th>
        </cfif>
    </tr>
    
    <cfoutput query="Distribution">
        <tr>
            <td valign="top">#Name#</td>
            <td valign="top" align="center">
            	<cfif Responded eq "Yes">
                	<a href="2012_Details.cfm?UserID=#ID#">View</a>
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
            <cfif URL.Type NEQ "Site">
            <td valign="top">
            	<cfif len(SentDate)>
                	#dateformat(SentDate, "mm/dd/yyyy")#
                <cfelse>
                	Not Sent
                </cfif>
            </td>
            </cfif>
        </tr>
    </cfoutput>
    </table>
<cfelse>
	No Responses
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- / --->