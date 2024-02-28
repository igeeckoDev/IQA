<cfif URL.Type eq "ProgramNew">
	<cfset Type = "New Process, Program, Service, or Offering">
<cfelseif URL.Type eq "Other Sites">
	<cfset Type = "Sites Outside of Public Safety">
<cfelseif URL.Type eq "Quality">
	<cfset Type eq "Local Quality Managers">
<cfelseif URL.Type eq "Program">
	<cfset Type eq "Program/Service/Offering">
<cfelse>
	<cfset Type = "#URL.Type#">
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "IQA Audit Planning 2013 - #Type# Distribution List">
<cfinclude template="shared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
<cfif URL.Type eq "Lab">
	: <b>#Type#</b><br>
    : <a href="Distribution_2013.cfm?Type=Operations">Operations</a><br>
    : <a href="Distribution_2013.cfm?Type=Other Sites">Sites Outside of Public Safety</a><br>
    : <a href="Distribution_2013.cfm?Type=Process">Process</a><br>
    : <a href="Distribution_2013.cfm?Type=Program">Program/Service/Offering</a><br>
    : <a href="Distribution_2013.cfm?Type=Quality">Local Quality Managers</a><br>
    : <a href="Distribution_2013.cfm?Type=ProgramNew">New Program/Service/Offering</a>
<cfelseif URL.Type eq "Operations">
	: <a href="Distribution_2013.cfm?Type=Lab">Lab</a><br>
    : <b>#Type#</b><br>
    : <a href="Distribution_2013.cfm?Type=Other Sites">Sites Outside of Public Safety</a><br>
    : <a href="Distribution_2013.cfm?Type=Process">Process</a><br>
    : <a href="Distribution_2013.cfm?Type=Program">Program/Service/Offering</a><br>
    : <a href="Distribution_2013.cfm?Type=Quality">Local Quality Managers</a><br>
    : <a href="Distribution_2013.cfm?Type=ProgramNew">New Program/Service/Offering</a>
<cfelseif URL.Type eq "Other Sites">
	: <a href="Distribution_2013.cfm?Type=Lab">Lab</a><br>
	: <a href="Distribution_2013.cfm?Type=Operations">Operations</a><br>
    : <b>#Type#</b><br>
    : <a href="Distribution_2013.cfm?Type=Process">Process</a><br>
    : <a href="Distribution_2013.cfm?Type=Program">Program/Service/Offering</a><br>
    : <a href="Distribution_2013.cfm?Type=Quality">Local Quality Managers</a><br>
    : <a href="Distribution_2013.cfm?Type=ProgramNew">New Program/Service/Offering</a>
<cfelseif URL.Type eq "Process">
	: <a href="Distribution_2013.cfm?Type=Lab">Lab</a><br>
	: <a href="Distribution_2013.cfm?Type=Operations">Operations</a><br>
    : <a href="Distribution_2013.cfm?Type=Other Sites">Sites Outside of Public Safety</a><br>
    : <b>#Type#</b><br>
    : <a href="Distribution_2013.cfm?Type=Program">Program/Service/Offering</a><br>
    : <a href="Distribution_2013.cfm?Type=Quality">Local Quality Managers</a><br>
    : <a href="Distribution_2013.cfm?Type=ProgramNew">New Program/Service/Offering</a>
<cfelseif URL.Type eq "Program">
	: <a href="Distribution_2013.cfm?Type=Lab">Lab</a><br>
	: <a href="Distribution_2013.cfm?Type=Operations">Operations</a><br>
    : <a href="Distribution_2013.cfm?Type=Other Sites">Sites Outside of Public Safety</a><br>
    : <a href="Distribution_2013.cfm?Type=Process">Process</a><br>
    : <b>#Type#</b><br>
    : <a href="Distribution_2013.cfm?Type=Quality">Local Quality Managers</a><br>
    : <a href="Distribution_2013.cfm?Type=ProgramNew">New Program/Service/Offering</a>
<cfelseif URL.Type eq "Quality">
	: <a href="Distribution_2013.cfm?Type=Lab">Lab</a><br>
	: <a href="Distribution_2013.cfm?Type=Operations">Operations</a><br>
    : <a href="Distribution_2013.cfm?Type=Other Sites">Sites Outside of Public Safety</a><br>
    : <a href="Distribution_2013.cfm?Type=Process">Process</a><br>
    : <a href="Distribution_2013.cfm?Type=Program">Program/Service/Offering</a><br>
    : <b>#Type#</b><br>
    : <a href="Distribution_2013.cfm?Type=ProgramNew">New Program/Service/Offering</a>
<cfelseif URL.Type eq "ProgramNew">
	: <a href="Distribution_2013.cfm?Type=Lab">Lab</a><br>
	: <a href="Distribution_2013.cfm?Type=Operations">Operations</a><br>
    : <a href="Distribution_2013.cfm?Type=Other Sites">Sites Outside of Public Safety</a><br>
    : <a href="Distribution_2013.cfm?Type=Process">Process</a><br>
    : <a href="Distribution_2013.cfm?Type=Program">Program/Service/Offering</a><br>
    : <a href="Distribution_2013.cfm?Type=Quality">Local Quality Managers</a><br>
    : <b>#Type#</b>
</cfif><br /><br />
</cfoutput>

<cfif URL.Type eq "Program">
    <CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT AuditPlanning2013_Users.ID as ID, AuditPlanning2013_Users.SentTo as SentTo, AuditPlanning2013_Users.Responded, AuditPlanning2013_Users.SurveyType, AuditPlanning2013_Users.PostedBy, AuditPlanning2013_Users.Posted, AuditPlanning2013_Users.SentDate, AuditPlanning2013_Users.SurveyFile, Corporate.ProgDev.Program as Name
    FROM AuditPlanning2013_Users, Corporate.ProgDev
    WHERE AuditPlanning2013_Users.SurveyType = 'Program'
    AND AuditPlanning2013_Users.pID = Corporate.ProgDev.ID
    ORDER BY Corporate.ProgDev.Program, AuditPlanning2013_Users.Responded, AuditPlanning2013_Users.Posted DESC
    </CFQUERY>
<cfelseif URL.Type eq "Process">
	<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT AuditPlanning2013_Users.ID as ID, AuditPlanning2013_Users.SentTo as SentTo, AuditPlanning2013_Users.Responded, AuditPlanning2013_Users.SurveyType, AuditPlanning2013_Users.PostedBy, AuditPlanning2013_Users.Posted, AuditPlanning2013_Users.SentDate, AuditPlanning2013_Users.SurveyFile, Corporate.GlobalFunctions.Function as Name
    FROM AuditPlanning2013_Users, Corporate.GlobalFunctions
    WHERE AuditPlanning2013_Users.SurveyType = 'Process'
    AND AuditPlanning2013_Users.pID = Corporate.GlobalFunctions.ID
    ORDER BY Corporate.GlobalFunctions.Function, AuditPlanning2013_Users.Responded, AuditPlanning2013_Users.Posted DESC
    </CFQUERY>

	<CFQUERY BLOCKFACTOR="100" name="Distribution2" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ID, SentTo, Type as Name, Responded, SurveyType, PostedBy, Posted, SentDate, SurveyFile
    FROM AuditPlanning2013_Users
    WHERE SurveyType = 'Process'
    AND pID = 0
    ORDER BY Type, Responded, Posted DESC
    </CFQUERY>
<cfelseif URL.Type eq "Quality">
	<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ID, SentTo, Responded, SurveyType, PostedBy, Posted, SentDate, Type, pID, SurveyFile
    FROM AuditPlanning2013_Users
    WHERE SurveyType = 'Quality' OR SurveyType = 'Quality2'
    ORDER BY Posted DESC, Responded
    </CFQUERY>
<cfelseif URL.Type eq "Other Sites">
	<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ID, SentTo, Type as Name, Responded, SurveyType, PostedBy, Posted, SentDate, SurveyFile
    FROM AuditPlanning2013_Users
    WHERE SurveyType = 'Other Sites'
    ORDER BY Type, Responded, Posted DESC
    </CFQUERY>
<cfelseif URL.Type eq "Lab">
	<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ID, SentTo, Type as Name, Responded, SurveyType, PostedBy, Posted, SentDate, SurveyFile
    FROM AuditPlanning2013_Users
    WHERE SurveyType = 'Lab'
    ORDER BY Type, Responded, Posted DESC
    </CFQUERY>
<cfelseif URL.Type eq "Operations">
	<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ID, SentTo, Type as Name, Responded, SurveyType, PostedBy, Posted, SentDate, SurveyFile
    FROM AuditPlanning2013_Users
    WHERE SurveyType = 'Operations'
    ORDER BY Type, Responded, Posted DESC
    </CFQUERY>
<cfelseif URL.Type eq "ProgramNew">
	<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ID, SentTo, Type, Responded, SurveyType, PostedBy, Posted, SentDate, SurveyFile
    FROM AuditPlanning2013_Users
    WHERE SurveyType = 'ProgramNew'
    ORDER BY Posted DESC
    </CFQUERY>
</cfif>

<cfif URL.Type EQ "Quality2" OR URL.Type EQ "Quality">
	<cfoutput>
    <u>Open Blank Survey for #Type#</u><br />
        :: <A href="getEmpNo.cfm?UserID=#URL.Type#">Open Survey</A> (with Program, Process, and Site drop downs)<br />
        :: <A href="getEmpNo.cfm?UserID=Quality2">Open Survey</A> (with Open Text Field for Survey Area)<br /><br />
    </cfoutput>
<cfelseif URL.Type EQ "ProgramNew">
	<cfoutput>
    <u>Open Blank Survey for #Type#</u><br />
        :: <A href="getEmpNo.cfm?UserID=#URL.Type#">Open Survey</A><br /><br />
    </cfoutput>
</cfif>

<cfif Distribution.RecordCount GT 0>
    <table border="1">
    <tr>
        <th>Name</th>
        <th>Response</th>
        <th>Posted Date</th>
        <th>Sent To</th>
        <cfif URL.Type NEQ "Quality">
        <th>Date Sent</th>
        </cfif>
        <cfif URL.Type NEQ "ProgramNew" AND URL.Type NEQ "Quality">
	        <th>Open Blank Survey</th>
		</cfif>
        <th>Updated Survey Info (File)</th>
    </tr>

    <cfoutput query="Distribution">
        <tr>
        <cfif URL.Type eq "ProgramNew">
            <CFQUERY BLOCKFACTOR="100" name="Query" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
            SELECT ExtraField_Text as Name
            FROM AuditPlanning2013_Answers
            WHERE UserID = #pID#
            AND qID = 1
            </CFQUERY>
        <cfelseif URL.Type eq "Quality">
        	<cfif Type eq "Program">
           	    <CFQUERY BLOCKFACTOR="100" name="Query" Datasource="Corporate">
                SELECT ID, Program as Name
                FROM ProgDev
                WHERE ID = #pID#
                </cfquery>
            <cfelseif Type eq "Site">
            	<CFQUERY BLOCKFACTOR="100" Name="Query" datasource="Corporate">
                SELECT OfficeName as Name
                From IQAtblOffices
                WHERE ID = #pID#
                </CFQUERY>
            <cfelseif Type eq "Process">
                <CFQUERY BLOCKFACTOR="100" name="Query" Datasource="Corporate">
                SELECT ID, Function as Name
                FROM GlobalFunctions
                WHERE ID = #pID#
                </cfquery>
            <cfelse>
            	<cfset Query.Name = Type>
			</cfif>
		<cfelse>
        	<cfset Query.Name = Name>
		</cfif>

            <td valign="top">#Query.Name#</td>
            <td valign="top" align="center">
                <cfif Responded eq "Yes">
                    <a href="2013_Details.cfm?UserID=#ID#">View</a>
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
            <cfif URL.Type NEQ "Quality">
            <td valign="top">
                <cfif len(SentDate)>
                    #dateformat(SentDate, "mm/dd/yyyy")#
                <cfelse>
                    Not Sent
                </cfif>
            </td>
            </cfif>
            <cfif URL.Type NEQ "ProgramNew" AND URL.Type NEQ "Quality">
                <td valign="top" align="center">
                	<A href="getEmpNo.cfm?UserID=#ID#"><img src="../../SiteImages/ico_article.gif" border="0" /></A>
                </td>
			</cfif>
            <td valign="Top" align="center">
            	<cfif len(SurveyFile)>
                	:: <a href="SurveyFiles/#Distribution.SurveyFile#">View File</a>
                <cfelse>
                	--
                </cfif>
            </td>
        </tr>
    </cfoutput>
    <cfif URL.Type eq "Process">
        <cfoutput query="Distribution2">
            <tr>
                <td valign="top">#Name#</td>
                <td valign="top" align="center">
                    <cfif Responded eq "Yes">
                        <a href="2013_Details.cfm?UserID=#ID#">View</a>
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
                <cfif URL.Type NEQ "Quality">
                <td valign="top">
                    <cfif len(SentDate)>
                        #dateformat(SentDate, "mm/dd/yyyy")#
                    <cfelse>
                        Not Sent
                    </cfif>
                </td>
                </cfif>
                <td valign="top" align="center">
                	<A href="getEmpNo.cfm?UserID=#ID#"><img src="../../SiteImages/ico_article.gif" border="0" /></A>
                </td>
                <td valign="top" align="center">
					<cfif len(SurveyFile)>
                        :: <a href="SurveyFiles/#Output.SurveyFile#">View File</a>
                    <cfelse>
                        --
                    </cfif>
	            </td>
            </tr>
        </cfoutput>
    </cfif>
    </table>
<cfelse>
	No Responses<br><br>
</cfif>

<cfif URL.Type eq "Quality">
	<br /><Br />
    Surveys sent to the following LQMs on November 13, 2012:<br><br>

    <cfquery Datasource="Corporate" name="Quality">
    SELECT Name, Email, Region, SubRegion, ID
    From IQADB_LOGIN
    WHERE AccessLevel = 'RQM'
    AND Status IS NULL
    ORDER BY Region, SubRegion
    </cfquery>

<cfset temp = QueryAddRow(Quality)>
<cfset Temp = QuerySetCell(Quality, "Email", "James.E.Feth@ul.com,Walter.E.Ballek@ul.com,Michael.Jorgenson@ul.com,Rodney.E.Morton@ul.com")>

    <table border="1">
    <tr>
        <th>Name</th>
        <th>Email</th>
        <th>Region/SubRegion</th>
    </tr>
    <cfset i = 1>
    <cfoutput query="Quality">
    <tr>
        <td valign="top"><cfif len(Name)>#Name#<cfelse>--</cfif></td>
        <Td valign="top"><cfif len(Email)>#replace(Email, ",", "<br />", "All")#<cfelse>--</cfif></Td>
        <Td valign="top"><cfif len(Region) AND len(SubRegion)>#Region# / #SubRegion#<cfelse>--</cfif></Td>
    </tr>
    <cfset i = i+1>
    </cfoutput>
    </table>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- / --->