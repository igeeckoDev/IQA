<cfif URL.Type eq "Quality">
	<cfset Type eq "Responses from LQMs - Sites / New Programs, Processes, Sites, and Other Offerings">
<cfelseif URL.Type eq "Program">
	<cfset Type eq "Program/Service/Offering">
<cfelse>
	<cfset Type = "#URL.Type#">
</cfif>

<cfset sentDate = "">

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "IQA Audit Planning 2019 - #Type# List">
<cfinclude template="shared/StartOfPage.cfm">
<!--- / --->

<cfset SurveyYear = curyear + 1>
<cfset SurveyYearMinus = curyear>
<Cfset SurveyYearPlus = curyear+2>

<cfoutput>
<u>Currently Viewing:</u><br />
	<cfif URL.Type eq "Certification Body">
		: <a href="Distribution_2019.cfm?Type=Process">Process</a><br>
		: <b>#Type#</b><br>
		: <a href="Distribution_2019.cfm?Type=Program">Program/Service/Offering</a><br>
		: <a href="Distribution_2019.cfm?Type=Quality">Site Related (Engineering, Laboratory, Quality, Accreditation, etc)</a><br>
		: <a href="Distribution_2019.cfm?Type=New Area">New Area</a><br>
	<cfelseif URL.Type eq "Process">
		: <b>#Type#</b><br>
		: <a href="Distribution_2019.cfm?Type=Certification Body">Certification Body</a><br>
		: <a href="Distribution_2019.cfm?Type=Program">Program/Service/Offering</a><br>
		: <a href="Distribution_2019.cfm?Type=Quality">Site Related (Engineering, Laboratory, Quality, Accreditation, etc)</a><br>
		: <a href="Distribution_2019.cfm?Type=New Area">New Area</a><br>
	<cfelseif URL.Type eq "Program">
		: <a href="Distribution_2019.cfm?Type=Process">Process</a><br>
		: <a href="Distribution_2019.cfm?Type=Certification Body">Certification Body</a><br>
		: <b>Program/Service/Offering</b><br>
		: <a href="Distribution_2019.cfm?Type=Quality">Site Related (Engineering, Laboratory, Quality, Accreditation, etc)</a><br>
		: <a href="Distribution_2019.cfm?Type=New Area">New Area</a><br>
	<cfelseif URL.Type eq "Quality">
		: <a href="Distribution_2019.cfm?Type=Process">Process</a><br>
		: <a href="Distribution_2019.cfm?Type=Certification Body">Certification Body</a><br>
		: <a href="Distribution_2019.cfm?Type=Program">Program/Service/Offering</a><br>
		: <b>Site Related (Engineering, Laboratory, Quality, Accreditation, etc)</b><br>
		: <a href="Distribution_2019.cfm?Type=New Area">New Area</a><br>
	<cfelseif URL.Type eq "New Area">
		: <a href="Distribution_2019.cfm?Type=Process">Process</a><br>
		: <a href="Distribution_2019.cfm?Type=Certification Body">Certification Body</a><br>
		: <a href="Distribution_2019.cfm?Type=Program">Program/Service/Offering</a><br>
		: <a href="Distribution_2019.cfm?Type=Quality">Site Related (Engineering, Laboratory, Quality, Accreditation, etc)</a><br>
		: <a href="Distribution_2019.cfm?Type=New Area">New Area</a><br>
	</cfif>
	<br />
</cfoutput>

<cfif URL.Type eq "Program">
    <cfquery Datasource="Corporate" name="Distribution">
	SELECT ID, Program as Name, Type, Status
	FROM ProgDev
	WHERE IQA = 1
	AND Status IS NULL
	ORDER BY Program
	</cfquery>
<cfelseif URL.Type eq "Certification Body">
    <CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="Corporate">
    SELECT OfficeName as Name, ID
    FROM IQAtblOffices
    WHERE CB = 'Yes'
    ORDER BY OfficeName
    </CFQUERY>
<cfelseif URL.Type eq "Process">
	<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="Corporate">
    SELECT DISTINCT GlobalFunctions.Function as Name, GlobalFunctions.ID
    FROM AuditSchedule, GlobalFunctions
    WHERE 
	AuditSchedule.Area = GlobalFunctions.Function
	AND AuditSchedule.Year_ BETWEEN #SurveyYearMinus# AND #SurveyYearPlus#
	AND AuditSchedule.AuditedBy = 'IQA'
	AND AuditSchedule.AuditType2 = 'Global Function/Process'
    ORDER BY GlobalFunctions.Function
    </CFQUERY>
<cfelseif URL.Type eq "Quality" or URL.Type eq "Quality2" OR URL.Type eq "Laboratory" OR URL.Type eq "Operations">
	<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="Corporate">
    SELECT OfficeName as Name, ID, SNAPList_OfficeName as Name2
    FROM IQAtblOffices
    WHERE (CB <> 'Yes' OR CB IS NULL)
	AND Exist = 'Yes'
	AND Physical = 'Yes'
	AND (SuperLocation <> 'Yes' OR SuperLocation IS NULL)
    ORDER BY OfficeName
    </CFQUERY>
<cfelseif URL.Type eq "New Area">
	<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT SurveyArea as Name, ID, posted, postedBy, Responded, Type, SurveyArea_Description
	FROM AuditPlanning2019_Users
	WHERE SurveyType = 'New Area'
	<!----AND ID > 4---->
	ORDER BY SurveyType
	</CFQUERY>
</cfif>

<hr align="left"><br />

<b>Instructions</b><br />
	Select the "Submit Survey for this Area" link to open a survey for any Area listed below<br />
	OR<br /><br>
	
<cfoutput>
	Identify a new Program, Process Site, or an Accreditation, Business Unit, or other Offering<br>
	:: <A href="2019.cfm?NewArea=Yes&Type=New">Open Survey for a New Area</A><br /><br />
</cfoutput>

<cfif Distribution.recordcount GT 0>
<table border="1">
<tr>
	<th>Name</th>
	<th>Responses</th>
	
	<cfif URL.Type neq "New Area">
		<th>Submit Survey for this Area</th>
	<cfelseif URL.Type eq "New Area">
		<th>Description</th>
	</cfif>
</tr>

	<cfoutput query="Distribution">
		<tr>
			<td valign="top">#Name#</td>
			<td valign="top" align="left">
				
				<cfif URL.Type eq "New Area">
					<a href="2019_Details.cfm?ID=#ID#">View Survey</a><br>
					#replace(PostedBy,"),",")<br /><br />", "All")# #dateformat(Posted, "mm/dd/yyyy")#
				<cfelse>
					<CFQUERY BLOCKFACTOR="100" name="Responses" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
					SELECT Responded, Posted, PostedBy, ID as SurveyID
					FROM AuditPlanning2019_Users
					WHERE pID = #Distribution.ID#
					AND SurveyType = '#URL.Type#'
					<!----AND ID > 4---->
					</CFQUERY>				
						
					<cfif Responses.recordCount GT 0>
						<cfloop query="Responses">
							<a href="2019_Details.cfm?ID=#SurveyID#">View Survey</a><br>
							#replace(PostedBy,"),",")<br /><br />", "All")# #dateformat(Posted, "mm/dd/yyyy")#<Br><br>
						</cfloop>
					<cfelse>
						--
					</cfif>
				</cfif>
			</td>

			<cfif URL.Type neq "New Area">
				<td valign="top" align="center">
					<A href="2019.cfm?ID=#ID#&Type=#URL.Type#&NewArea=No"><img src="../../SiteImages/ico_article.gif" border="0" /></A>
				</td>
			<cfelseif URL.Type eq "New Area">
				<td>
					<cfif len(SurveyArea_Description)>
						#SurveyArea_Description#
					<cfelse>
						&nbsp;
					</cfif>
				</td>
			</cfif>
		</tr>
	</cfoutput>
</table>
<cfelse>
	<b>No Survey results for New Areas</b>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- / --->