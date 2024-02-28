<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Reschedule Audit: #URL.year#-#URL.id#-#URL.auditedby#<br><br>">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<div align="Left" class="blog-time">
Reschedule Help - <A HREF="javascript:popUp('../webhelp/webhelp_reschedule.cfm')">[?]</A><br /><br />
</div>
		
<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
    <script language="JavaScript" src="#SiteDir#SiteShared/js/date.js"></script>
</cfoutput>

<!--- check for last year's audit --->
<cfquery name="AuditInfo" datasource="Corporate" blockfactor="100">
SELECT 
	Area, AuditType2, OfficeName, AuditArea, Month, ID
FROM 
	AuditSchedule
WHERE 
    Year_ = #url.year#
    AND ID = #url.ID#
</cfquery>

<!--- last year variable --->
<cfset lastYear = #URL.Year# - 1>

<!--- query to check for last year's audit --->
<Cfoutput query="AuditInfo">
    <cfquery name="check" datasource="Corporate" blockfactor="100">
    SELECT Month, ID, Year_, LeadAuditor
    FROM AuditSchedule
    WHERE AuditedBy = 'IQA'
    AND Area = '#Area#'
    AND AuditType2 = '#AuditType2#'
    AND OfficeName = '#OfficeName#'
    AND AuditArea = '#AuditArea#'
    AND Year_ = #lastYear#
    </cfquery>
    
    <cfif check.RecordCount GT 0>
        <cfloop query="check">
        	<b>Previous Audit</b><br />
        	<u>Audit Number</u>: <a href="auditDetails.cfm?ID=#ID#&Year=#Year_#">#Year_#-#ID#-IQA</a><br />
            <u>Month</u>: #MonthAsString(Month)#<Br />
            <u>Lead</u>: #LeadAuditor#<br />
        </cfloop><br />
	</cfif>
</Cfoutput>
					  
<CFQUERY BLOCKFACTOR="100" name="Reschedule" Datasource="Corporate">
SELECT AuditSchedule.*, AuditSchedule.Year_ as Year 
FROM AuditSchedule
WHERE ID = #URL.ID#
and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfoutput query="Reschedule">
<b>Current Audit To Be Rescheduled</b><br />
<u>Audit Number</u>: <a href="auditDetails.cfm?ID=#ID#&Year=#Year#">#Year#-#ID#-#AuditedBy#</a><br />
<u>Month</u>: #MonthAsString(Month)#<br />
<u>Lead</u>: #LeadAuditor#<br /><br />

<u>Note</u> - Audits must be conducted every 12 months. If an audit is rescheduled to be conducted more than 12 months after the previous audit, a record of the request and approval must be uploaded to the Audit Details page.<br /><br />

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="reschedule_fileupload.cfm?ID=#ID#&Year=#Year#" onSubmit="return validateForm();">
<INPUT TYPE="Hidden" NAME="ID" VALUE="#ID#">
<INPUT TYPE="Hidden" NAME="Year" VALUE="#Year#">

<b>Month Scheduled</b>: (required)<br>
<SELECT NAME="e_Month" displayname="Month">
		<option value="">Select Month Below
		<option value="">---
<cfloop index="i" to="12" from="1">
		<OPTION VALUE="#i#" <cfif Month is i>SELECTED</cfif>>#MonthAsString(i)#
</cfloop>
</SELECT>
<br><br>

<b>Start Date</b> (please use this format - mm/dd/yyyy) - <b class="warning">Required</b><br>
<INPUT TYPE="Text" NAME="StartDate" VALUE="<cfif StartDate is NOT ""><cfset Start = #StartDate#>#DateFormat(Start, 'mm/dd')#/#year#</cfif>" onchange="return ValidateSDate()" displayname="Start Date"><br><br>

<b class="warning">Note:</b> Start Date is required. If the start date is unknown, please put a 'placeholder' date and add a note to the Notes field on the Audit Details page that the actual audit date will be determined at a later date.<br /><br />

<b>End Date</b> (please use this format - mm/dd/yyyy)<br>
<INPUT TYPE="Text" NAME="EndDate" VALUE="<cfif EndDate is NOT ""><cfset End = #EndDate#>#DateFormat(End, 'mm/dd')#/#year#</cfif>" onchange="return ValidateEDate()"><br><br>

<cfset nextYear = #URL.Year# + 1>
<b>Reschedule for Next Year?</b><br>
<u>Note</u> - Selecting "Yes" will create a new audit in #nextYear# and mark this audit as "Rescheduled for Next Year". The Reschedule Notes will also indicate the new audit number for reference.<br /><br />

Yes <input type="radio" name="RescheduleNextYear" value="Yes"> 
No <input type="radio" name="RescheduleNextYear" value="No" Checked><br><br>

<b>Reschedule Notes</b>:<br>
<textarea WRAP="PHYSICAL" ROWS="7" COLS="70" NAME="e_Notes" displayname="Reschedule Notes" Value=""></textarea><br><br>

<input type="hidden" name="Resched" value="N/A" />

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">

</FORM>
</cfoutput>
<br><br>

Note - If you enter both a new month and new dates during the reschedule process, and the month selected does not match the months listed in the start and end dates, the month in the start and end date will take precidence.<br><br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->