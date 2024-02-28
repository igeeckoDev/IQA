<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="check">
SELECT AuditSchedule.*, AuditSchedule.Year_ AS Year, AuditSchedule.ScopeLetter, AuditSchedule.AuditedBy
FROM AuditSchedule
WHERE ID = #URL.ID#
and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfif check.Year GTE 2010 AND check.AuditedBy NEQ "VS" AND check.AuditedBy NEQ "ULE">
	<cfoutput query="check">
		<cfif NOT len(ScopeLetter)>
			<cflocation url="auditdetails.cfm?#CGI.QUERY_STRING#&Var=Report&Msg=No Scope Letter" addtoken="No">
		</cfif>
	</cfoutput>
</cfif>

<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle="Add Report Page 1 - #check.Year#-#check.ID#-#check.AuditedBy#">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

<!--- 8/29/2007 updated findings/obs table to include new key processes for 9/2007 audits, if/then for old audits, also if/then for extra queries for new KP --->

<!--- formatted textarea boxes --->
<cfinclude template="#SiteDir#SiteShared/incTextarea.cfm">

<script language="JavaScript" src="../webhelp/webhelp.js"></script>
<cfset CurDate = #Dateformat(now(), 'mm/dd/yyyy')#>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Audit">
SELECT AuditSchedule.*, AuditSchedule.Year_ AS Year
FROM AuditSchedule
WHERE ID = #URL.ID#
and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<!--- addition of sector drop down for 9/2008 audits and forward --->
<cfif Audit.Year is 2008>
	<cfif Audit.Month gte 9>
        <CFQUERY BLOCKFACTOR="100" NAME="Sector" DataSource="Corporate">
        SELECT *
        FROM CAR_SECTOR "SECTOR"
        ORDER BY Sector
        </cfquery>
	</cfif>
<cfelseif Audit.Year gt 2008>
    <CFQUERY BLOCKFACTOR="100" NAME="Sector" DataSource="Corporate">
    SELECT *
    FROM CAR_SECTOR "SECTOR"
    ORDER BY Sector
    </cfquery>
</cfif>

<!--- 8/22/2007 - 9/2007 audits and forward will use an expanded list of Key Processes.--->
<!--- Old list retained for past audits --->
<cfif Audit.Year is 2007>
	<cfif Audit.Month gte 9>
		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="qKP">
		SELECT * FROM KP_Report_2
		ORDER BY Alpha
		</CFQUERY>
	<cfelse>
		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="qKP">
		SELECT * FROM KP_Report
		ORDER BY Alpha
		</CFQUERY>
	</cfif>
<cfelseif Audit.Year eq 2008 OR Audit.Year eq 2009>
	<cfif Audit.Year eq 2009>
		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="qKP">
		SELECT Title as KP, ID as alpha FROM Clauses_2009Jan1
		ORDER BY ID
		</CFQUERY>
	<cfelseif Audit.Year eq 2008>
		<cfif Audit.Month lte 9>
			<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="qKP">
			SELECT * FROM KP_Report_2
			ORDER BY Alpha
			</CFQUERY>
		<cfelseif Audit.Month gt 9>
			<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="qKP">
			SELECT Title as KP, ID as alpha FROM Clauses
			ORDER BY ID
			</CFQUERY>
		</cfif>
	</cfif>
<cfelseif Audit.Year gte 2010>
	<cfif Audit.Year eq 2010>
		<cfif Audit.Month lt 9>
			<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="qKP">
			SELECT Title as KP, ID as alpha FROM Clauses_2009Jan1
			ORDER BY ID
			</CFQUERY>
		<cfelseif Audit.Month gte 9>
			<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="qKP">
			SELECT Title as KP, ID as alpha FROM Clauses_2010SEPT1
			ORDER BY ID
			</CFQUERY>
		</cfif>
	<cfelseif Audit.Year gte 2011>
		
		<cfif Audit.year lt 2019>

		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="qKP">
		SELECT Title as KP, ID as alpha FROM Clauses_2010SEPT1
		ORDER BY ID
		</CFQUERY>
	
		<cfelse>

		<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="qKP">
		SELECT Title as KP, ID as alpha FROM Clauses_2018May17
		ORDER BY ID
		
		</CFQUERY>
		</cfif>

	</cfif>
<cfelseif Audit.Year lt 2007>
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="qKP">
	SELECT * FROM KP_Report
	ORDER BY Alpha
	</CFQUERY>
</cfif>

<CFQUERY name="Programs" Datasource="Corporate">
SELECT IQA, Program FROM ProgDev
WHERE IQA = 1
AND
	(Status IS NULL
	OR Status = 'Under Review'
	OR Status = 'Pending')
ORDER BY Program
</CFQUERY>

<cflock scope="SESSION" timeout="60">
	<cfif SESSION.Auth.accesslevel is "RQM">
        <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Offices">
        SELECT * FROM IQAtblOffices
        WHERE Exist <> 'No'
        AND SubRegion = '#Session.Auth.SubRegion#'
        ORDER BY OfficeName
        </CFQUERY>
	<cfelse>
		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Offices">
        SELECT * FROM IQAtblOffices
        WHERE Exist <> 'No'
        ORDER BY OfficeName
        </CFQUERY>
	</cfif>
</cflock>

<br><div class="blog-time">
Audit Report Help - <A HREF="javascript:popUp('#IQARootDir#webhelp/webhelp_auditreport.cfm')">[?]</A></div><br />

<cfoutput query="Audit">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ID="Audit" ACTION="Report2new.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">

<B>Audit Report Number</b><br>
#Year#-#ID#<br><br>

<b>Location</b><br>
<!--- count the number of offices in the string, we're counting the delimeter (!) and adding 1, since one office would have no delimeters --->
<cfset numOffices = 1 + (len(OfficeName) - len(replace(OfficeName, "!", "", "All")))>

<!--- if there is more than one office listed --->
<cfif numOffices GT 1>
	<!--- replace the delimeter with a break --->
	#replace(OfficeName, "!", "<br />", "All")#
<!--- if there is one office --->
<cfelseif numOffices EQ 1>
	#OfficeName#<br />
</cfif><br />

<cfif AuditType is "Field Services">
#Area#<br>
<b>Audit Area</b><br />
#AuditArea#<br>
<cfelse>
	<cfif Trim(AuditArea) is "">
	<cfelse>
	<b>Audit Area</b><br />
    #AuditArea#<br>
	#Area#<br>
	</cfif>
</cfif><br>

<b>Other Locations Included in Audit</b><br>
This Audit included a sampling of the program/process activities associated with the following sites:<br>
</cfoutput>
<SELECT NAME="Offices" multiple="multiple" size="6" displayname="Additional Offices">
		<OPTION VALUE="None" selected>- None -
		<OPTION VALUE="None">----
<CFOUTPUT QUERY="Offices">
		<OPTION VALUE="#OfficeName#!!">#OfficeName#
</CFOUTPUT>
</SELECT>
<br><br>

<cfif Audit.Year is 2008>
	<cfif Audit.Month gte 9>
<b>Sectors</b><br>
This Audit included a sampling of the process activities associated with the following Sectors:<br>
<SELECT NAME="Sector" multiple="multiple" size="6" displayname="Sector">
		<OPTION VALUE="None" selected>- None -
		<OPTION VALUE="None">----
	<CFOUTPUT QUERY="Sector">
		<OPTION VALUE="#Sector#!!">#Sector#
	</CFOUTPUT>
</SELECT><br><br>
	</cfif>
<cfelseif Audit.Year gt 2008>
<b>Sectors</b><br>
This Audit included a sampling of the process activities associated with the following Sectors:<br>
<SELECT NAME="Sector" multiple="multiple" size="6" displayname="Sector">
		<OPTION VALUE="None" selected>- None -
		<OPTION VALUE="None">----
	<CFOUTPUT QUERY="Sector">
		<OPTION VALUE="#Sector#!!">#Sector#
	</CFOUTPUT>
</SELECT><br><br>
</cfif>

<cfif Audit.AuditType2 is NOT "Program">
<b>Programs Sampled During Audit</b><br>
This Audit was conducted on the specified process/location. (See Location/Audit Area above)<br>
The following programs were active at the time of the audit and randomly sampled as a representation of process/location activities.<br>
<SELECT NAME="Programs" multiple="multiple" size="6" displayname="Programs">
		<OPTION VALUE="None" selected>- None -
		<OPTION VALUE="None">----
<CFOUTPUT QUERY="Programs">
	<cfif Program is NOT "_test">
		<cfif Program eq "<PS>E Mark (JP) (JP CO)">
			<OPTION VALUE="&lt;PS&gt;E Mark (JP) (JP CO)!!">#Program#
		<cfelse>
			<OPTION VALUE="#Program#!!">#Program#
		</cfif>
	</cfif>
</CFOUTPUT>
</SELECT>
<br><br>
</cfif>

<cfoutput query="Audit">
<b>Audit Dates</b><br>
<!--- uses incDates.cfc --->
<cfinvoke
	component="IQA.Components.incDates"
    returnvariable="DateOutput"
    method="incDates">

	<cfif len(StartDate)>
        <cfinvokeargument name="StartDate" value="#StartDate#">
    <cfelse>
        <cfinvokeargument name="StartDate" value="">
    </cfif>

	<cfif len(EndDate)>
        <cfinvokeargument name="EndDate" value="#EndDate#">
    <cfelse>
        <cfinvokeargument name="EndDate" value="">
    </cfif>

    <cfinvokeargument name="Status" value="#Status#">
    <cfinvokeargument name="RescheduleNextYear" value="#RescheduleNextYear#">
</cfinvoke>

<!--- output of incDates.cfc --->
#DateOutput#
<br /><br />

<b>Audit Report Date</b><br>
<input Type="text" Name="e_ReportDate" Value="#CurDate#" displayname="Report Date" onChange="return ValidateDate()"><br><br>

<b>Auditor(s)</b><br>
<cfif Trim(LeadAuditor) is "" or Trim(LeadAuditor) is "- None -">
	<cfif Trim(Auditor) is "" or Trim(Auditor) is "- None -">
	No Auditors Listed<br>
	<cfelse>
	#Auditor#<br>
	</cfif>
<cfelseif Trim(Auditor) is "" or Trim(Auditor) is "- None -">
#LeadAuditor#, Lead<br>
<CFELSE>
#LeadAuditor#, Lead<br>
#Auditor#<br>
</cfif><br>

<cfif len(SME)>
<B>Suject Matter Expert</B><br>
#SME#<br><br>
</cfif>

<b>Audit Type</b><br>
#AuditType#, #AuditType2#<br><br>

<b>Scope</b><br>
<textarea WRAP="PHYSICAL" ROWS="10" COLS="90" NAME="e_Scope" displayname="Scope">#Request.IQAScope2015#</textarea>
<br>

<cfif year gt 2009 OR year eq 2009 AND month gte 4>
	<b>Primary Contact</b><br>
	<INPUT TYPE="hidden" NAME="KCInfo" VALUE="#Email#">
	<cfset Dump = #replace(Email, ",", "<br>", "All")#>
	<cfset Dump1 = #replace(Dump, ", ", "<br>", "All")#>
	#Dump1#
	<br><br>

	<b>Other Contacts</b><br>
	<INPUT TYPE="hidden" NAME="KCInfo2" VALUE="#Email2#">
	<cfset Dump = #replace(Email2, ",", "<br>", "All")#>
	<cfset Dump1 = #replace(Dump, ", ", "<br>", "All")#>
	<cfif len(Dump)>
		#Dump1#
	<cfelse>
		None Listed
	</cfif>
	<br><br>
<cfelse>
	<b>Contact Email</b><br>
	<INPUT TYPE="TEXT" NAME="e_KCInfo" size="110" VALUE="#Email#" displayname="Contact Email">
	<INPUT TYPE="hidden" NAME="KCInfo2" VALUE="#Email2#">
	<br><br>
</cfif>
</cfoutput>

<cfoutput query="Audit">
<b>Audit Summary</b><br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="Summary" displayname="Audit Summary">Please enter the Audit Summary</textarea><br><br>

<cfif Audit.Year GTE 2016
	OR Audit.Year EQ 2015 AND Audit.Month GT 10
	OR Audit.Year EQ 2015 AND Audit.StartDate GTE "10/12/2015">
<b>Opportunities for Improvement (OFI) / Preventive Actions</b><br>
<u>Instuctions</u>: Please provide any OFIs as suggestion statements, with ample detail (requirement, document number(s), system affected, etc) to allow the auditees to fully understand the OFI. If applicable, please provide a "So What" statement should there be a possible future impact or risk to business, accreditation, etc.<br><Br>

<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="OFIs" displayname="Opportunities for Improvement (OFI) / Preventive Actions">Please enter any OFIs / Preventive Actions</textarea><br><br>
</cfif>
</cfoutput>

<b>Non-Conformances</b><br>
Include the number of nonconformances and associated CAR numbers below.<br>
* Separate CAR and SR numbers with a comma
<cfif Audit.Year is 2010 AND Audit.Month gte 9 OR Audit.Year gte 2011>
<br><br>
<u>Update - July 2013</u><br><a href="../matrix.cfm" target="_blank">View</a> Matrix of Standard Categories for Non-Conformances and Audit Coverage
</cfif><br><br>
<table border="1">
<tr>
<td class="blog-title">Key Processes / Standard Categories</td>
<td class="blog-title" align="center">Number of Findings</td>
<td class="blog-title" align="center">Number of Observations</td>
<td class="blog-title" align="center">CAR/Audit Finding Number(s)*</td>
<cfif Audit.Year gte 2010>
	<td class="blog-title" align="center">SR Number(s)*</td>
</cfif>
</tr>
<tr>
<td class="blog-title">&nbsp;</td>
<td class="blog-title">&nbsp;</td>
<td class="blog-title">&nbsp;</td>
<td class="blog-title">&nbsp;</td>
<cfif Audit.Year gte 2010>
	<td class="blog-title">&nbsp;</td>
</cfif>
</tr>
<CFoutput query="qKP">
<tr>
<td class="blog-content">#KP#</td>
<td align="center"><INPUT TYPE="TEXT" NAME="e_Count#alpha#" displayname="#KP# Number of Findings" VALUE="0" size="3"></td>
<td align="center"><INPUT TYPE="TEXT" NAME="e_OCount#alpha#" displayname="#KP# Number of Observations" VALUE="0" size="3"></td>
<Td><Input Type="Text" Name="e_CAR#alpha#" Value="0" displayname="#KP# CAR Numbers" size="25"></td>
<cfif Audit.Year gte 2010>
	<td><input type="text" name="e_SR#alpha#" value="0" displaymame="#KP# SR Numbers" size="25"></td>
</cfif>
</tr>
</CFoutput>
<!--- 9/2007 audits will use expanded KP list --->
<!--- before 9/2007 the 'other' category remains --->
<cfif Audit.Year is 2007>
	<cfif Audit.Month lt 9>
	<tr>
	<td class="blog-content">Other</td>
	<td align="center"><INPUT TYPE="TEXT" NAME="e_CountOther" displayname="Other - Number of Findings" VALUE="0" size="3" onChange="return numbers()"></td>
	<td align="center"><INPUT TYPE="TEXT" NAME="e_OCountOther" displayname="Other - Number of Observations" VALUE="0" size="3" onChange="return numbers()"></td>
	<Td><Input Type="Text" Name="e_CAROther" Value="0" displayname="Other - CAR Numbers" size="25" onChange="return numberlist()"></td>
	</tr>
	</cfif>
<cfelseif Audit.Year gt 2007>
<cfelseif Audit.Year lt 2007>
	<tr>
	<td class="blog-content">Other</td>
	<td align="center"><INPUT TYPE="TEXT" NAME="e_CountOther" displayname="Other - Number of Findings" VALUE="0" size="3" onChange="return numbers()"></td>
	<td align="center"><INPUT TYPE="TEXT" NAME="e_OCountOther" displayname="Other - Number of Observations" VALUE="0" size="3" onChange="return numbers()"></td>
	<Td><Input Type="Text" Name="e_CAROther" Value="0" displayname="Other - CAR Numbers" size="25" onChange="return numberlist()"></td>
	</tr>
</cfif>
</table><br>

<b>Positive Observations</b><br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="BestPrac" displayname="Positive Observations"></textarea><br><br>

<cfif Audit.AuditedBy eq "IQA">
	<cfif Audit.year GTE 2015>
		<cfoutput>
			<b>Audit Planning / Post Audit Time (Hours)</b><br>
			Please provide the number of hours spent (by the audit team) during the Audit Planning and Post Audit phases.
			Please include time spent on specific training (beyond scheme/standard training) that was essential to conducting this audit.<br><br>

			Audit Planning:<br>
			<Input Type="Text" Name="e_PlanningTime" Value="0" displayname="Audit Planning Time"><br><br>

			Post Audit:<br>
			<Input Type="Text" Name="e_ReportingTime" Value="0" displayname="Audit Reporting Time"><br><br>

			Categories on the Time Allocation Excel Spreadsheet to be included in the totals above:<br>
			<u>Audit Planning</u><br>
				Review of Previous Audits<br>
				Audit Specific Training<br>
				Schedule Coordination, Communication<br>
				Travel Planning<br>
				Documentation Review<br>
				Searching for and Review of CARs to be Verified<br>
				Project Review<br><br>

			<u>Post Audit:</u><br>
				Reporting (Forms, Report, Attachments) and CAR Writing<br>
				Editing and Compiling Pathnotes<br><br>

			Note: This information will not be posted in the audit report.<br><br>
		</cfoutput>
	</cfif>
</cfif><br><br>
	
<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">

</FORM>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->