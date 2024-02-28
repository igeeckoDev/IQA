<cfif URL.Type eq "Quality">
	<cfset Type eq "Responses from LQMs - Sites / New Programs, Processes, Sites, and Other Offerings">
<cfelseif URL.Type eq "Program">
	<cfset Type eq "Program/Service/Offering">
<cfelse>
	<cfset Type = "#URL.Type#">
</cfif>

<cfset sentDate = "December 2, 2016">

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "IQA Audit Planning 2017 - #Type# Distribution List">
<cfinclude template="shared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
<u>Distribution Lists - Currently Viewing:</u><br />
<cfif URL.Type eq "Laboratory">
	: <b>#Type#</b><br>
    : <a href="Distribution_2017.cfm?Type=Operations">Operations</a><br>
    : <a href="Distribution_2017.cfm?Type=Process">Process</a><br>
	: <a href="Distribution_2017.cfm?Type=CB">Certification Body</a><br>
    : <a href="Distribution_2017.cfm?Type=Program">Program/Service/Offering</a><br>
    : <a href="Distribution_2017.cfm?Type=Quality">Responses from LQMs - Sites / New Programs, Processes, Sites, and Other Offerings</a><br>
    <!---: <a href="Distribution_2017.cfm?Type=New">New Program/Service/Offering</a>--->
<cfelseif URL.Type eq "Operations">
	: <a href="Distribution_2017.cfm?type=Laboratory">Laboratory</a><br>
    : <b>#Type#</b><br>
    : <a href="Distribution_2017.cfm?Type=Process">Process</a><br>
	: <a href="Distribution_2017.cfm?Type=CB">Certification Body</a><br>
    : <a href="Distribution_2017.cfm?Type=Program">Program/Service/Offering</a><br>
    : <a href="Distribution_2017.cfm?Type=Quality">Responses from LQMs - Sites / New Programs, Processes, Sites, and Other Offerings</a><br>
    <!---: <a href="Distribution_2017.cfm?Type=New">New Program/Service/Offering</a>--->
<cfelseif URL.Type eq "Certification Body" OR URL.TYpe eq "CB">
	: <a href="Distribution_2017.cfm?type=Laboratory">Laboratory</a><br>
	: <a href="Distribution_2017.cfm?Type=Operations">Operations</a><br>
	: <a href="Distribution_2017.cfm?Type=Process">Process</a><br>
    : <b>#Type#</b><br>
    : <a href="Distribution_2017.cfm?Type=Program">Program/Service/Offering</a><br>
    : <a href="Distribution_2017.cfm?Type=Quality">Responses from LQMs - Sites / New Programs, Processes, Sites, and Other Offerings</a><br>
    <!---: <a href="Distribution_2017.cfm?Type=New">New Program/Service/Offering</a>--->
<cfelseif URL.Type eq "Process">
	: <a href="Distribution_2017.cfm?type=Laboratory">Laboratory</a><br>
	: <a href="Distribution_2017.cfm?Type=Operations">Operations</a><br>
    : <b>#Type#</b><br>
	: <a href="Distribution_2017.cfm?Type=CB">Certification Body</a><br>
    : <a href="Distribution_2017.cfm?Type=Program">Program/Service/Offering</a><br>
    : <a href="Distribution_2017.cfm?Type=Quality">Responses from LQMs - Sites / New Programs, Processes, Sites, and Other Offerings</a><br>
    <!---: <a href="Distribution_2017.cfm?Type=New">New Program/Service/Offering</a>--->
<cfelseif URL.Type eq "Program">
	: <a href="Distribution_2017.cfm?type=Laboratory">Laboratory</a><br>
	: <a href="Distribution_2017.cfm?Type=Operations">Operations</a><br>
    : <a href="Distribution_2017.cfm?Type=Process">Process</a><br>
	: <a href="Distribution_2017.cfm?Type=CB">Certification Body</a><br>
    : <b>Program/Service/Offering</b><br>
    : <a href="Distribution_2017.cfm?Type=Quality">Responses from LQMs - Sites / New Programs, Processes, Sites, and Other Offerings</a><br>
    <!---: <a href="Distribution_2017.cfm?Type=New">New Program/Service/Offering</a>--->
<cfelseif URL.Type eq "Quality" OR URL.Type eq "Site">
	: <a href="Distribution_2017.cfm?type=Laboratory">Laboratory</a><br>
	: <a href="Distribution_2017.cfm?Type=Operations">Operations</a><br>
    : <a href="Distribution_2017.cfm?Type=Process">Process</a><br>
	: <a href="Distribution_2017.cfm?Type=CB">Certification Body</a><br>
    : <a href="Distribution_2017.cfm?Type=Program">Program/Service/Offering</a><br>
    : <b>Responses from LQMs - Sites / New Programs, Processes, Sites, and Other Offerings</b><br>
    <!---: <a href="Distribution_2017.cfm?Type=New">New Program/Service/Offering</a>--->
<!---
<cfelseif URL.Type eq "New">
	: <a href="Distribution_2017.cfm?type=Laboratory">Laboratory</a><br>
	: <a href="Distribution_2017.cfm?Type=Operations">Operations</a><br>
    : <a href="Distribution_2017.cfm?Type=Process">Process</a><br>
    : <a href="Distribution_2017.cfm?Type=Program">Program/Service/Offering</a><br>
    : <a href="Distribution_2017.cfm?Type=Quality">Local Quality Managers / Sites Outside Public Safety</a><br>
    : <b>#Type#</b>
--->
</cfif><br />
</cfoutput>

<cfif URL.Type eq "Program">
    <CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT AuditPlanning2017_Users.ID as ID, AuditPlanning2017_Users.SentTo as SentTo, AuditPlanning2017_Users.Responded, AuditPlanning2017_Users.SurveyType, AuditPlanning2017_Users.PostedBy, AuditPlanning2017_Users.Posted, AuditPlanning2017_Users.SentDate, AuditPlanning2017_Users.SurveyFile, Corporate.ProgDev.Program as Name
    FROM AuditPlanning2017_Users, Corporate.ProgDev
    WHERE AuditPlanning2017_Users.SurveyType = 'Program'
    AND AuditPlanning2017_Users.pID = Corporate.ProgDev.ID
    ORDER BY Corporate.ProgDev.Program, AuditPlanning2017_Users.Responded, AuditPlanning2017_Users.Posted DESC
    </CFQUERY>
<cfelseif URL.Type eq "Certification Body" OR URL.Type eq "CB">
    <CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT AuditPlanning2017_Users.ID as ID, AuditPlanning2017_Users.SentTo as SentTo, AuditPlanning2017_Users.Responded,
	AuditPlanning2017_Users.SurveyType, AuditPlanning2017_Users.PostedBy, AuditPlanning2017_Users.Posted, AuditPlanning2017_Users.SentDate,
	AuditPlanning2017_Users.SurveyFile, Corporate.IQAtblOffices.OfficeName as Name
    FROM AuditPlanning2017_Users, Corporate.IQAtblOffices
    WHERE AuditPlanning2017_Users.SurveyType = 'Certification Body'
    AND AuditPlanning2017_Users.pID = Corporate.IQAtblOffices.ID
    ORDER BY Corporate.IQAtblOffices.OfficeName, AuditPlanning2017_Users.Responded, AuditPlanning2017_Users.Posted DESC
    </CFQUERY>
<cfelseif URL.Type eq "Process">
	<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT AuditPlanning2017_Users.ID as ID, AuditPlanning2017_Users.SentTo as SentTo, AuditPlanning2017_Users.Responded, AuditPlanning2017_Users.SurveyType, AuditPlanning2017_Users.PostedBy, AuditPlanning2017_Users.Posted, AuditPlanning2017_Users.SentDate, AuditPlanning2017_Users.SurveyFile, Corporate.GlobalFunctions.Function as Name
    FROM AuditPlanning2017_Users, Corporate.GlobalFunctions
    WHERE AuditPlanning2017_Users.SurveyType = 'Process'
    AND AuditPlanning2017_Users.pID = Corporate.GlobalFunctions.ID
    ORDER BY Corporate.GlobalFunctions.Function, AuditPlanning2017_Users.Responded, AuditPlanning2017_Users.Posted DESC
    </CFQUERY>

	<CFQUERY BLOCKFACTOR="100" name="Distribution2" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ID, SentTo, Type as Name, Responded, SurveyType, PostedBy, Posted, SentDate, SurveyFile
    FROM AuditPlanning2017_Users
    WHERE SurveyType = 'Process'
    AND pID = 0
    ORDER BY SentTo
    </CFQUERY>
<cfelseif URL.Type eq "Quality" or URL.Type eq "Quality2">
	<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ID, SentTo, Responded, SurveyType, PostedBy, Posted, SentDate, Type, pID, SurveyFile
    FROM AuditPlanning2017_Users
    WHERE SurveyType = 'Quality' OR SurveyType = 'Quality2' OR SurveyType = 'New'
    ORDER BY SurveyType, SentTo
    </CFQUERY>
<cfelseif URL.Type eq "Laboratory">
	<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ID, SentTo, Type as Name, Responded, SurveyType, PostedBy, Posted, SentDate, SurveyFile
    FROM AuditPlanning2017_Users
    WHERE SurveyType = 'Laboratory'
    ORDER BY SentTo
    </CFQUERY>
<cfelseif URL.Type eq "Operations">
	<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ID, SentTo, Type as Name, Responded, SurveyType, PostedBy, Posted, SentDate, SurveyFile
    FROM AuditPlanning2017_Users
    WHERE SurveyType = 'Operations'
    ORDER BY SentTo
    </CFQUERY>
<!---
<cfelseif URL.Type eq "New">
	<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ID, SentTo as Name, Type, Responded, SurveyType, PostedBy, Posted, SentDate, SurveyFile
    FROM AuditPlanning2017_Users
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
                    <a href="2017_Details.cfm?UserID=#ID#">View</a>
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
                        <a href="2017_Details.cfm?UserID=#ID#">View</a>
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
AND Username <> 'IP_RQM'
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
    <Td valign="top"><cfif Region eq "Europe">#Region#<cfelse>#Region# / #SubRegion#</cfif></Td>
    <td valign="top">#sentDate#</td>
</tr>
<cfset i = i+1>
</cfoutput>

<cfoutput>
	<tr>
		<td valign="top">Jim Feth</td>
		<Td valign="top">James.E.Feth@ul.com</Td>
		<Td valign="top">CPO</Td>
		<td valign="top">#sentDate#</td>
	</tr>
	<tr>
		<td valign="top">Walt Ballek</td>
		<Td valign="top">Walter.E.Ballek@ul.com</Td>
		<Td valign="top">CPO</Td>
		<td valign="top">#sentDate#</td>
	</tr>
	<tr>
		<td valign="top">Rod Morton</td>
		<Td valign="top">Rodney.E.Morton@ul.com</Td>
		<Td valign="top">CPO</Td>
		<td valign="top">#sentDate#</td>
	</tr>
	<tr>
		<td valign="top">Luis Feijo</td>
		<Td valign="top">Luis.Feijo@ul.com</Td>
		<Td valign="top">Testtech</Td>
		<td valign="top">#sentDate#</td>
	</tr>
	<tr>
		<td valign="top">Harish Patel</td>
		<Td valign="top">Harish.Patel@ul.com</Td>
		<Td valign="top">Life and Health Sciences</Td>
		<td valign="top">#sentDate#</td>
	</tr>
	<tr>
		<td valign="top">Michael Schneider</td>
		<Td valign="top">Michael.Schneider@ul.com</Td>
		<Td valign="top">Global Quality</Td>
		<td valign="top">#sentDate#</td>
	</tr>
	<tr>
		<td valign="top">John Carlin</td>
		<Td valign="top">John.Carlin@ul.com</Td>
		<Td valign="top">Field Services</Td>
		<td valign="top">#sentDate#</td>
	</tr>
	<tr>
		<td valign="top">Dale Hendricks</td>
		<Td valign="top">Dale.C.Hendricks@ul.com</Td>
		<Td valign="top">Field Services</Td>
		<td valign="top">#sentDate#</td>
	</tr>
	<tr>
		<td valign="top">Jan Behrendt Ibsoe</td>
		<Td valign="top">JanBehrendt.Ibsoe@ul.com</Td>
		<Td valign="top">DEWI</Td>
		<td valign="top">#sentDate#</td>
	</tr>
	<tr>
		<td valign="top">Hiromi Yamaoka</td>
		<Td valign="top">Hiromi.Yamaoka@ul.com</Td>
		<Td valign="top">Japan</Td>
		<td valign="top">#sentDate#</td>
	</tr>
	<tr>
		<td valign="top">Erica Qin</td>
		<Td valign="top">Erica.Qin@ul.com</Td>
		<Td valign="top">Guangzhou</Td>
		<td valign="top">#sentDate#</td>
	</tr>
	<tr>
		<td valign="top">Kila Yang</td>
		<Td valign="top">Kila.Yang@ul.com</Td>
		<Td valign="top">Taiwan</Td>
		<td valign="top">#sentDate#</td>
	</tr>
	<tr>
		<td valign="top">Vinutha M.U.</td>
		<Td valign="top">Vinutha.mu@ul.com </Td>
		<Td valign="top">India</Td>
		<td valign="top">#sentDate#</td>
	</tr>
	<tr>
		<td valign="top">Siddarth S.</td>
		<Td valign="top">Siddharth.S@ul.com</Td>
		<Td valign="top">India</Td>
		<td valign="top">#sentDate#</td>
	</tr>
	<tr>
		<td valign="top">Balina Ling</td>
		<Td valign="top">Balina.Ling@ul.com</Td>
		<Td valign="top">Suzhou</Td>
		<td valign="top">#sentDate#</td>
	</tr>
	<tr>
		<td valign="top">Joey Cheng</td>
		<Td valign="top">Joey.Cheng@ul.com</Td>
		<Td valign="top">ULE</Td>
		<td valign="top">#sentDate#</td>
	</tr>
	<tr>
		<td valign="top">Keith Mowry</td>
		<Td valign="top">Keith.A.Mowry@ul.com </Td>
		<Td valign="top">Accreditation Services</Td>
		<td valign="top">#sentDate#</td>
	</tr>
	<tr>
		<td valign="top">Rick Titus</td>
		<Td valign="top">Rick.A.Titus@ul.com</Td>
		<Td valign="top">Accreditation Services</Td>
		<td valign="top">#sentDate#</td>
	</tr>
</cfoutput>
</table>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- / --->