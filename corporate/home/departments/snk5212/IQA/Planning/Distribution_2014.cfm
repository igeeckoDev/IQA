<cfif URL.Type eq "Quality">
	<cfset Type eq "Responses from LQMs - Sites / New Programs, Processes, Sites, and Other Offerings">
<cfelseif URL.Type eq "Program">
	<cfset Type eq "Program/Service/Offering">
<cfelse>
	<cfset Type = "#URL.Type#">
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "IQA Audit Planning 2014 - #Type# Distribution List">
<cfinclude template="shared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
<u>Distribution Lists - Currently Viewing:</u><br />
<cfif URL.Type eq "Laboratory">
	: <b>#Type#</b><br>
    : <a href="Distribution_2014.cfm?Type=Operations">Operations</a><br>
    : <a href="Distribution_2014.cfm?Type=Process">Process</a><br>
    : <a href="Distribution_2014.cfm?Type=Program">Program/Service/Offering</a><br>
    : <a href="Distribution_2014.cfm?Type=Quality">Responses from LQMs - Sites / New Programs, Processes, Sites, and Other Offerings</a><br>
    <!---: <a href="Distribution_2014.cfm?Type=New">New Program/Service/Offering</a>--->
<cfelseif URL.Type eq "Operations">
	: <a href="Distribution_2014.cfm?type=Laboratory">Laboratory</a><br>
    : <b>#Type#</b><br>
    : <a href="Distribution_2014.cfm?Type=Process">Process</a><br>
    : <a href="Distribution_2014.cfm?Type=Program">Program/Service/Offering</a><br>
    : <a href="Distribution_2014.cfm?Type=Quality">Responses from LQMs - Sites / New Programs, Processes, Sites, and Other Offerings</a><br>
    <!---: <a href="Distribution_2014.cfm?Type=New">New Program/Service/Offering</a>--->
<cfelseif URL.Type eq "Process">
	: <a href="Distribution_2014.cfm?type=Laboratory">Laboratory</a><br>
	: <a href="Distribution_2014.cfm?Type=Operations">Operations</a><br>
    : <b>#Type#</b><br>
    : <a href="Distribution_2014.cfm?Type=Program">Program/Service/Offering</a><br>
    : <a href="Distribution_2014.cfm?Type=Quality">Responses from LQMs - Sites / New Programs, Processes, Sites, and Other Offerings</a><br>
    <!---: <a href="Distribution_2014.cfm?Type=New">New Program/Service/Offering</a>--->
<cfelseif URL.Type eq "Program">
	: <a href="Distribution_2014.cfm?type=Laboratory">Laboratory</a><br>
	: <a href="Distribution_2014.cfm?Type=Operations">Operations</a><br>
    : <a href="Distribution_2014.cfm?Type=Process">Process</a><br>
    : <b>#Type#</b><br>
    : <a href="Distribution_2014.cfm?Type=Quality">Responses from LQMs - Sites / New Programs, Processes, Sites, and Other Offerings</a><br>
    <!---: <a href="Distribution_2014.cfm?Type=New">New Program/Service/Offering</a>--->
<cfelseif URL.Type eq "Quality">
	: <a href="Distribution_2014.cfm?type=Laboratory">Laboratory</a><br>
	: <a href="Distribution_2014.cfm?Type=Operations">Operations</a><br>
    : <a href="Distribution_2014.cfm?Type=Process">Process</a><br>
    : <a href="Distribution_2014.cfm?Type=Program">Program/Service/Offering</a><br>
    : <b>Responses from LQMs - Sites / New Programs, Processes, Sites, and Other Offerings</b><br>
    <!---: <a href="Distribution_2014.cfm?Type=New">New Program/Service/Offering</a>--->
<!---
<cfelseif URL.Type eq "New">
	: <a href="Distribution_2014.cfm?type=Laboratory">Laboratory</a><br>
	: <a href="Distribution_2014.cfm?Type=Operations">Operations</a><br>
    : <a href="Distribution_2014.cfm?Type=Process">Process</a><br>
    : <a href="Distribution_2014.cfm?Type=Program">Program/Service/Offering</a><br>
    : <a href="Distribution_2014.cfm?Type=Quality">Local Quality Managers / Sites Outside Public Safety</a><br>
    : <b>#Type#</b>
--->
</cfif><br />
</cfoutput>

<cfif URL.Type eq "Program">
    <CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT AuditPlanning2014_Users.ID as ID, AuditPlanning2014_Users.SentTo as SentTo, AuditPlanning2014_Users.Responded, AuditPlanning2014_Users.SurveyType, AuditPlanning2014_Users.PostedBy, AuditPlanning2014_Users.Posted, AuditPlanning2014_Users.SentDate, AuditPlanning2014_Users.SurveyFile, Corporate.ProgDev.Program as Name
    FROM AuditPlanning2014_Users, Corporate.ProgDev
    WHERE AuditPlanning2014_Users.SurveyType = 'Program'
    AND AuditPlanning2014_Users.pID = Corporate.ProgDev.ID
    ORDER BY Corporate.ProgDev.Program, AuditPlanning2014_Users.Responded, AuditPlanning2014_Users.Posted DESC
    </CFQUERY>
<cfelseif URL.Type eq "Process">
	<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT AuditPlanning2014_Users.ID as ID, AuditPlanning2014_Users.SentTo as SentTo, AuditPlanning2014_Users.Responded, AuditPlanning2014_Users.SurveyType, AuditPlanning2014_Users.PostedBy, AuditPlanning2014_Users.Posted, AuditPlanning2014_Users.SentDate, AuditPlanning2014_Users.SurveyFile, Corporate.GlobalFunctions.Function as Name
    FROM AuditPlanning2014_Users, Corporate.GlobalFunctions
    WHERE AuditPlanning2014_Users.SurveyType = 'Process'
    AND AuditPlanning2014_Users.pID = Corporate.GlobalFunctions.ID
    ORDER BY Corporate.GlobalFunctions.Function, AuditPlanning2014_Users.Responded, AuditPlanning2014_Users.Posted DESC
    </CFQUERY>

	<CFQUERY BLOCKFACTOR="100" name="Distribution2" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ID, SentTo, Type as Name, Responded, SurveyType, PostedBy, Posted, SentDate, SurveyFile
    FROM AuditPlanning2014_Users
    WHERE SurveyType = 'Process'
    AND pID = 0
    ORDER BY Type, Responded, Posted DESC
    </CFQUERY>
<cfelseif URL.Type eq "Quality" or URL.Type eq "Quality2">
	<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ID, SentTo, Responded, SurveyType, PostedBy, Posted, SentDate, Type, pID, SurveyFile
    FROM AuditPlanning2014_Users
    WHERE SurveyType = 'Quality' OR SurveyType = 'Quality2' OR SurveyType = 'New'
    ORDER BY SurveyType, Posted DESC, Responded
    </CFQUERY>
<cfelseif URL.Type eq "Laboratory">
	<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ID, SentTo, Type as Name, Responded, SurveyType, PostedBy, Posted, SentDate, SurveyFile
    FROM AuditPlanning2014_Users
    WHERE SurveyType = 'Laboratory'
    ORDER BY Type, Responded, Posted DESC
    </CFQUERY>
<cfelseif URL.Type eq "Operations">
	<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ID, SentTo, Type as Name, Responded, SurveyType, PostedBy, Posted, SentDate, SurveyFile
    FROM AuditPlanning2014_Users
    WHERE SurveyType = 'Operations'
    ORDER BY Type, Responded, Posted DESC
    </CFQUERY>
<!---
<cfelseif URL.Type eq "New">
	<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ID, SentTo as Name, Type, Responded, SurveyType, PostedBy, Posted, SentDate, SurveyFile
    FROM AuditPlanning2014_Users
    WHERE SurveyType = 'New'
    ORDER BY Posted DESC
    </CFQUERY>
--->
</cfif>

<hr align="left"><br />

<b>Instructions</b><br />
Select the "Open Blank Survey" link to open a survey for any Area listed below<br /><br />

OR<br /><br />

<cfoutput>
	Open the Survey for an Existing Program, Process, or Site<br>
	:: <A href="getEmpNo.cfm?UserID=Quality">Open Survey for Existing Area</A><br /><br>

	Identify a new Program, Process Site, or an Accreditation, Business Unit, or other Offering<br>
	:: <A href="getEmpNo.cfm?UserID=Quality2">Open Survey for a New Area</A><br /><br />
</cfoutput>

<hr align="left"><br />

<cfif URL.Type EQ "New">
	<cfoutput>
    <u>Open Blank Survey for #Type#</u><br />
        :: <A href="getEmpNo.cfm?UserID=#URL.Type#">Open Survey</A><br /><br />
    </cfoutput>
</cfif>

<cfif Distribution.RecordCount GT 0>
    <table border="1" width="900">
    <tr>
        <cfif Type neq "Laboratory" AND Type neq "Operations">
        	<th>Name</th>
        </cfif>
        <th>Response</th>
        <th>Posted Date</th>
        <cfif URL.Type NEQ "Quality" AND URL.Type NEQ "New">
        <th>Sent To</th>
        </cfif>
        <cfif URL.Type NEQ "Quality" AND URL.Type NEQ "New">
        <th>Date Sent</th>
        </cfif>
        <cfif URL.Type NEQ "New" AND URL.Type NEQ "Quality">
	        <th>Open Blank Survey</th>
		</cfif>
        <!---
		<th>Updated Survey Info (File)</th>
    	--->
	</tr>

    <cfset previousQueryName = "">

    <cfoutput query="Distribution">
        <tr>
        <cfif URL.Type eq "Quality">
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

       	<cfif Type neq "Laboratory" AND Type neq "Operations">
			<cfif previousQueryName eq Query.Name>
                <td>&nbsp;</td>
            <cfelse>
                <td valign="top">#Query.Name# <cfif SurveyType eq "Quality2" OR SurveyType eq "New"><b>(#SentTo#)</b></cfif></td>
            </cfif>
        </cfif>
            <td valign="top" align="center">
                <cfif Responded eq "Yes">
                    <a href="2014_Details.cfm?UserID=#ID#">View</a>
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

            <cfif URL.Type NEQ "Quality" AND URL.Type NEQ "New">
            <td valign="top">
                #replace(SentTo,",", "<br>", "All")#
            </td>
            </cfif>

            <cfif URL.Type NEQ "New" AND URL.Type NEQ "Quality">
            <td valign="top">
                <cfif len(SentDate)>
                    #dateformat(SentDate, "mm/dd/yyyy")#
                <cfelse>
                    Not Sent
                </cfif>
            </td>
            </cfif>
            <cfif URL.Type NEQ "New" AND URL.Type NEQ "Quality">
                <td valign="top" align="center">
                	<A href="getEmpNo.cfm?UserID=#ID#"><img src="../../SiteImages/ico_article.gif" border="0" /></A>
                </td>
			</cfif>
            <!---
            <td valign="Top" align="center">
            	<cfif len(SurveyFile)>
                	:: <a href="SurveyFiles/#Distribution.SurveyFile#">View File</a>
                <cfelse>
                	--
                </cfif>
            </td>
			--->
        </tr>
        <cfset previousQueryName = Query.Name>
    </cfoutput>
    <cfif URL.Type eq "Process">
        <cfoutput query="Distribution2">
            <tr>
                <td valign="top">#Name#</td>
                <td valign="top" align="center">
                    <cfif Responded eq "Yes">
                        <a href="2014_Details.cfm?UserID=#ID#">View</a>
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
    Surveys sent to the following Staff:<br><br>

<cfquery Datasource="Corporate" name="Quality">
SELECT Name, Email, Region, SubRegion, ID
From IQADB_LOGIN
WHERE AccessLevel = 'RQM'
AND Status IS NULL
ORDER BY Region, SubRegion
</cfquery>

<table border="1" width="800">
<tr>
	<th>Name</th>
    <th>Email</th>
    <th>Region/SubRegion</th>
    <th>Date Sent</th>
</tr>
<cfset i = 1>
<cfoutput query="Quality">
<tr>
	<td valign="top">#Name#</td>
    <Td valign="top">#Email#</Td>
    <Td valign="top">#Region# / #SubRegion#</Td>
    <td valign="top">2013-12-23</td>
</tr>
<cfset i = i+1>
</cfoutput>
<tr>
	<td valign="top">James Halsey</td>
    <Td valign="top">James.Halsey@ul.com</Td>
    <Td valign="top">AQS</Td>
    <td valign="top">2013-12-23</td>
</tr>
<tr>
	<td valign="top">Mark vandeWaterlaat</td>
    <Td valign="top">Mark.vandeWaterlaat@ul.com</Td>
    <Td valign="top">Life &amp; Health Sciences</Td>
    <td valign="top">2013-12-23</td>
</tr>
<tr>
	<td valign="top">John Newell</td>
    <Td valign="top">John.Newell@ul.com</Td>
    <Td valign="top">RFI Global / WiSE</Td>
    <td valign="top">2013-12-23</td>
</tr>
<tr>
	<td valign="top">Matt Marotto</td>
    <Td valign="top">Matthew.J.Marotto@ul.com</Td>
    <Td valign="top">Fremont / EMC / WiSE</Td>
    <td valign="top">2013-12-23</td>
</tr>
<tr>
	<td valign="top">Jim Feth</td>
    <Td valign="top">James.E.Feth@ul.com</Td>
    <Td valign="top">NACPO</Td>
    <td valign="top">2013-12-23</td>
</tr>
<tr>
	<td valign="top">Walt Ballek</td>
    <Td valign="top">Walter.E.Ballek@ul.com</Td>
    <Td valign="top">NACPO</Td>
    <td valign="top">2013-12-23</td>
</tr>
<tr>
	<td valign="top">Mike Jorgenson</td>
    <Td valign="top">Michael.Jorgenson@ul.com</Td>
    <Td valign="top">NACPO</Td>
    <td valign="top">2013-12-23</td>
</tr>
<tr>
	<td valign="top">Rod Morton</td>
    <Td valign="top">Rodney.E.Morton@ul.com</Td>
    <Td valign="top">NACPO</Td>
    <td valign="top">2013-12-23</td>
</tr>
</table>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- / --->