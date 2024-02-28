<cfset Month = #Dateformat(now(), 'mm')#>
<cfset Day = #Dateformat(now(), 'dd')#>
<cfset Year = #Dateformat(now(), 'yyyy')#>

<CFQUERY BLOCKFACTOR="100" NAME="baseline" Datasource="Corporate"> 
SELECT *
 FROM Baseline
 WHERE YEAR_=#curyear#
</cfquery>

<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfset CurMonth = #Dateformat(now(), 'mm')#>

<cfif CurMonth is 12>
	<cfset NextMonth = 1>
	<cfset Year = #CurYear# + 1>
<cfelse>
	<cfset NextMonth = #CurMonth# + 1>
	<cfset Year = #CurYear#>
</cfif>

<cfset DayofMonth = #Dateformat(now(), 'dd')#>

<cfif baseline.baseline eq 0>
<cfelse>
<!--- run this part on first day of month only --->
<cfif DayofMonth is 29>

<CFQUERY BLOCKFACTOR="100" NAME="SelectAudits" Datasource="Corporate"> 
SELECT AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.Email2, AuditSchedule.AuditArea,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.AuditType2, AuditSchedule.Month, AuditSchedule.Area, AuditSchedule.Status, AuditSchedule.Approved, AuditSchedule.LeadAuditor, IQAtblOffices.RQM, IQAtblOffices.QM, IQAtblOffices.GM, IQAtblOffices.LES, IQAtblOffices.Other, IQAtblOffices.Other2
 FROM AuditSchedule, IQAtblOffices
 WHERE AuditSchedule.Status is null AND  AuditSchedule.Month = #NextMonth#
 AND AuditSchedule.YEAR_=#Year# AND  AuditSchedule.AuditType <> 'TPTDP'
 AND  AuditSchedule.AuditedBy = 'IQA'
 AND  AuditSchedule.OfficeName = IQAtbloffices.OfficeName
 AND  AuditSchedule.Approved = 'Yes'
 ORDER BY AuditSchedule.ID
</CFQUERY>

<cfoutput query="SelectAudits">
	<cfif AuditType2 eq "Program">
    	<cfset incSubject = "#Trim(Area)#">
	<cfelseif AuditType2 eq "Field Services">
    	<cfset incSubject = "Field Services - #trim(Area)#">
	<cfelseif AuditType2 is "Corporate" or AuditType2 is "Local Function" or AuditType2 is "Local Function FS" or audittype2 is "Local Function CBTL" or audittype2 is "Global Function/Process">
    	<cfset incSubject = "#Trim(OfficeName)# - #Trim(Area)#">
	<cfelseif AuditType2 is "MMS - Medical Management Systems">
    	<cfset incSubject = "#Trim(Area)#">
    </cfif>

<cfmail to="christopher.j.nicastro@ul.com" from="Internal.Quality_Audits@ul.com" subject="Audit Notification - Quality System Audit of #incSubject#" type="html" Mailerid="Reminder">
This is an email reminder to inform you that a Quality System Audit of <b>#incSubject#</b> is scheduled for #MonthAsString(Month)#.<br><br>

For more information about this audit, please view the Audit Details page on the IQA website:<br>
http://usnbkiqas100p/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#<br><br>

No action is required on your part at this time unless you foresee a scheduling conflict. The assigned lead auditor will contact you with specific scope information and to arrange the dates of the audit. The lead auditor assigned to this audit is <b>#LeadAuditor#</b> should you have any further questions.<br><br>
</cfmail>

This is an email reminder to inform you that a Quality System Audit of <b>#incSubject#</b> is scheduled for #MonthAsString(Month)#.<br><br>

For more information about this audit, please view the Audit Details:<br>
http://usnbkiqas100p/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#<br><br>

No action is required on your part at this time unless you foresee a scheduling conflict. The assigned lead auditor will contact you with specific scope information and to arrange the dates of the audit. The lead auditor assigned to this audit is <b>#LeadAuditor#</b> should you have any further questions.<br><br>
<br><hr><br>
</cfoutput>

<cfelse>
</cfif>
</cfif>

<!--- 2/5/2008
TP done for 2008
<cfset Year = #Dateformat(now(), 'yyyy')#>
<cfset NextYear = #Year# + 1>
<cfset Month = #Dateformat(now(), 'mm')#>
<cfset Day = #Dateformat(now(), 'dd')#>

<cfif Month is 2 or Month is 5 or Month is 8 or Month is 11>
	<cfif Day is 01>

<cfif month IS 2>
	<cfset n = 4>
	<cfset reportyear = #year# - 1>
<cfelseif month IS 5>
	<cfset n = 1>
	<cfset reportyear = #year#>
<cfelseif month IS 8>
	<cfset n = 2>
	<cfset reportyear = #year#>
<cfelseif month IS 11>
	<cfset n = 3>
	<cfset reportyear = #year#>
</cfif>

<CFQUERY Datasource="Corporate" Name="RC"> 
SELECT *
 FROM RC_Comments
 WHERE YEAR_=#reportyear# AND  Quarter = #n#

</CFQUERY>

<cfmail 
	to="William.R.Carney@ul.com, James.E.Feth@ul.com, Michael.L.Jorgenson@ul.com, Raymond.E.Burg@ul.com, Robert.E.Bernd@ul.com, Jodine.E.Hepner@ul.com" 
	from="Internal.Quality_Audits@ul.com"
	bcc="Christopher.J.Nicastro@ul.com, global.internalquality@ul.com"
	subject="Third Party Report Card - Quarter #Quarter#, #Year#"
	query="RC">Please view the Third Party Report Card for Quarter #quarter# of #year#:

http://#CGI.Server_Name#/departments/snk5212/iqa/report/report.cfm?year=#curyear#

Comments:
<cfset S1 = #ReplaceNoCase(Comments,"<br>",chr(13), "ALL")#>
#S1#
</cfmail>
	</cfif>
<cfelse>
</cfif>
--->