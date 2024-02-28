<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<cfset Year = #Dateformat(now(), 'yyyy')#>
<cfset CurMonth = #Dateformat(now(), 'mm')#>
<cfset NextMonth = #CurMonth# + 1>

<CFQUERY BLOCKFACTOR="100" NAME="SelectAudits" Datasource="Corporate">
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT AuditSchedule.ID,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.Month, AuditSchedule.AuditArea, IQAtblOffices.RQM, IQAtblOffices.QM, IQAtblOffices.GM, IQAtblOffices.LES, IQAtblOffices.Other, IQAtblOffices.Other2
 FROM AuditSchedule, IQAtblOffices
 WHERE AuditSchedule.Month = #NextMonth#
 AND AuditSchedule.YEAR_=#Year# AND  AuditSchedule.AuditType <> 'TPTDP'
 AND  AuditSchedule.OfficeName = IQAtbloffices.OfficeName
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

Selected Audits:<br>
<CFOUTPUT query="SelectAudits">
- #Year#-#ID#, #Month#, #OfficeName#, #AuditType#, #AuditArea#, #RQM#, #QM#, #GM#, #LES#, #Other#, #Other2#<br>
</CFOUTPUT>

<cfmail
	query="SelectAudits"
	Group="OfficeName"
	from="Internal.Quality_Audits@ul.com"
	to=	"Bruce.A.Mahrenholz@ul.com, #RQM#, #QM#, #GM#, #LES#, #Other#, #Other2#"
	cc= "Kai.Huang@ul.com"
	subject="Audit Notification - #OfficeName#"
	Mailerid="Reminder">
This is an email reminder to inform you that #OfficeName# is scheduled for a <cfif AuditType is "Quality System">Quality System audit<cfelseif AuditType is "Technical Assessment">Technical Assessment audit<cfelseif AuditType is "Quality System,Technical Assessment">Quality System and Technical Assessment audit<cfelseif AuditType is "Quality System, Technical Assessment">Quality System and Technical Assessment audit<cfelse></cfif> in <cfif Trim(Month) is 1>January<cfelseif Trim(Month) is 2>February<cfelseif Trim(Month) is 3>March<cfelseif Trim(Month) is 4>April<cfelseif Trim(Month) is 5>May<cfelseif Trim(Month) is 6>June<cfelseif Trim(Month) is 7>July<cfelseif Trim(Month) is 8>August<cfelseif Trim(Month) is 9>September<cfelseif Trim(Month) is 10>October<cfelseif Trim(Month) is 11>November<cfelseif Trim(Month) is 12>December<cfelse></cfif>.

Should you have any questions, please see the Audit details on the IQA website:
http://#CGI.Server_Name#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#

Please inform all personnel who are associated with this audit.
</cfmail>

<cfoutput query="selectaudits">
<pre>
This is an email reminder to inform you that #OfficeName# is scheduled for a <cfif AuditType is "Quality System">Quality System audit<cfelseif AuditType is "Technical Assessment">Technical Assessment audit<cfelseif AuditType is "Quality System,Technical Assessment">Quality System and Technical Assessment audit<cfelseif AuditType is "Quality System, Technical Assessment">Quality System and Technical Assessment audit<cfelse></cfif> in <cfif Trim(Month) is 1>January<cfelseif Trim(Month) is 2>February<cfelseif Trim(Month) is 3>March<cfelseif Trim(Month) is 4>April<cfelseif Trim(Month) is 5>May<cfelseif Trim(Month) is 6>June<cfelseif Trim(Month) is 7>July<cfelseif Trim(Month) is 8>August<cfelseif Trim(Month) is 9>September<cfelseif Trim(Month) is 10>October<cfelseif Trim(Month) is 11>November<cfelseif Trim(Month) is 12>December<cfelse></cfif>.

Should you have any questions, please see the Audit details on the IQA website:
http://#CGI.Server_Name#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#

Please inform all personnel who are associated with this audit.
</pre>
<br><hr><br>
</cfoutput>
