<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="check">
SELECT AuditSchedule.*, AuditSchedule.Year_ AS Year, AuditSchedule.ScopeLetter
FROM AuditSchedule
WHERE ID = #URL.ID# 
and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfif check.Year GTE 2010>
	<cfoutput query="check">
		<cfif NOT len(ScopeLetter)>
			<cflocation url="auditdetails.cfm?#CGI.QUERY_STRING#&Var=Report&Msg=No Scope Letter" addtoken="No">
		</cfif>
	</cfoutput>
</cfif>

<!--- 8/29/2007 updated findings/obs table to include new key processes for 9/2007 audits, if/then for old audits, also if/then for extra queries for new KP --->

<cfoutput>
    <script 
        language="javascript" 
        type="text/javascript" 
        src="#IQADir#/tinymce/jscripts/tiny_mce/tiny_mce.js">
    </script>
    
    <script language="javascript" type="text/javascript">
    tinyMCE.init({
        mode : "textareas",
        content_css : "#SiteDir#SiteShared/cr_style.css"
    });
    </script>
</cfoutput>

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
<cfelseif Audit.Year gte 2008>
	<cfif Audit.Year gt 2008>
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
<cfelseif Audit.Year lt 2007>
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="qKP">
	SELECT * FROM KP_Report
	ORDER BY Alpha
	</CFQUERY>
</cfif>

<CFQUERY name="Programs" Datasource="Corporate">
SELECT IQA, Program FROM ProgDev
WHERE IQA = 1
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

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title="Add Report">
<cfinclude template="SOP.cfm">

<!--- / --->
						  
<br><div class="blog-time">
Audit Report Help - <A HREF="javascript:popUp('#IQARootDir#webhelp/webhelp_auditreport.cfm')">[?]</A></div>	

<cfoutput query="Audit">		  
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ID="Audit" ACTION="Report2.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">

<B>Audit Report Number</b><br>
#Year#-#ID#<br><br>

<b>Location</b><br>
#OfficeName#<br>
<cfif AuditType is "Field Services">
#Area#<br>
Audit Area: #AuditArea#<br>
<cfelse>
	<cfif Trim(AuditArea) is "">
	<cfelse>
	Audit Area: #AuditArea#<br>
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
		<OPTION VALUE="#Program#!!">#Program#
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

<b>Audit Type</b><br>
#AuditType#, #AuditType2#<br><br>

<b>Scope</b><br>
<textarea WRAP="PHYSICAL" ROWS="10" COLS="90" NAME="e_Scope" displayname="Scope">#Scope#</textarea>
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

<b>Audit Summary</b><br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="Summary" displayname="Audit Summary">Please enter the Audit Summary</textarea><br><br>
</cfoutput>

<b>Non-Conformances</b><br>
Include the number of nonconformances and associated CAR numbers below.<br>
* Separate CAR numbers with a comma
<cfif Audit.Year is 2009 OR Audit.Year is 2008 AND Audit.Month gte 10>
<br><br>
<u>Update - October 2008</u><br><a href="../matrix.cfm" target="_blank">View</a> Matrix of Standard Categories for Non-Conformances and Audit Coverage
</cfif><br><br>
<table border="1">
<tr>
<td class="blog-title">Key Processes / Standard Categories</td>
<td class="blog-title" align="center">Number of Findings</td>
<td class="blog-title" align="center">Number of Observations</td>
<td class="blog-title" align="Center">CAR/Audit Finding Number(s)*</td>
</tr>
<tr>
<td class="blog-title">&nbsp;</td>
<td class="blog-title">&nbsp;</td>
<td class="blog-title">&nbsp;</td>
<td class="blog-title">&nbsp;</td>
</tr>
<CFoutput query="qKP">
<tr>
<td class="blog-content">#KP#</td>
<td align="center"><INPUT TYPE="TEXT" NAME="e_Count#alpha#" displayname="#KP# Number of Findings" VALUE="0" size="3"></td>
<td align="center"><INPUT TYPE="TEXT" NAME="e_OCount#alpha#" displayname="#KP# Number of Observations" VALUE="0" size="3"></td>
<Td><Input Type="Text" Name="e_CAR#alpha#" Value="0" displayname="#KP# CAR Numbers" size="25"></td>
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

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">

</FORM>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->

