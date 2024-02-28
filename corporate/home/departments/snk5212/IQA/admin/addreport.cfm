<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Upload Audit Report">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<script language="JavaScript" src="../webhelp/webhelp.js"></script>
<script language="JavaScript" src="file.js"></script>

<div align="Left" class="blog-time">
Report Upload Help - <A HREF="javascript:popUp('../webhelp/webhelp_reportupload.cfm')">[?]</A></div><br>						  
						  
<CFQUERY BLOCKFACTOR="100" name="AddReport" Datasource="Corporate">
SELECT * FROM AuditSchedule
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfif addreport.auditedby is NOT "Field Services">
    <CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate"> 
    SELECT 
    	AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy, 		
        AuditSchedule.Email, AuditSchedule.Email2, AUDITSCHEDULE.YEAR_ as Year, AuditSchedule.Approved, 
        IQAtblOffices.OfficeName, IQAtblOffices.RQM, IQAtblOffices.QM, IQAtblOffices.GM, IQAtblOffices.LES, 
        IQAtblOffices.Other, IQAtblOffices.Other2, IQAtblOffices.Regional1, IQAtblOffices.Regional2, 
        IQAtblOffices.Regional3
     FROM 
     	AuditSchedule, IQAtblOffices
     WHERE 
     	AuditSchedule.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
     	AND AuditSchedule.ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
     	AND AuditSchedule.OfficeName = IQAtbloffices.OfficeName
    </CFQUERY>
<cfelse>
    <CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate"> 
    SELECT 
    	AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy, 
        AuditSchedule.Email, AuditSchedule.Email2, AUDITSCHEDULE.YEAR_ as Year, AuditSchedule.Area, 
        AuditSchedule.Approved
     FROM 
     	AuditSchedule
     WHERE 
     	AuditSchedule.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
     	AND AuditSchedule.ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
    </CFQUERY>
</cfif>

<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.accesslevel is "SU" 
	or SESSION.Auth.accesslevel is "Admin" 
	or SESSION.Auth.SubRegion is AddReport.AuditedBy 
	or AddReport.LeadAuditor is "#SESSION.AUTH.NAME#" 
	or AddReport.Auditor is "#SESSION.AUTH.NAME#">

<cfoutput query="AddReport">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="addreport_update.cfm?ID=#ID#&Year=#Year#&auditedby=#auditedby#">
<INPUT TYPE="Hidden" NAME="ID" VALUE="#ID#">
<INPUT TYPE="Hidden" NAME="Year" VALUE="#Year#">

<cfif Approved eq "Yes">
The following email will be sent when you upload/publish the report for Audit #year#-#id#-#auditedby#:<br><br>

----------------------------------------------------------------<br><br>

<b>To:</b> 
<cfif AuditType2 is "Field Services">
	#notify.Email#
<cfelse>
#trim(notify.Email)#, #trim(notify.RQM)#, #trim(notify.QM)#, #trim(notify.GM)#, #trim(notify.LES)#, #trim(notify.Other)#, #trim(notify.Other2)#, #trim(notify.regional1)#, #trim(notify.regional2)#, #trim(notify.regional3)#
</cfif><br>

<b>cc:</b> <cfif AuditType2 is "Field Services">John.Carlin@ul.com, Clint.Ferguson@ul.com,</cfif>#notify.Email2#<br>

<b>From:</b> UL Audit Database<br>
<b>Subject:</b> <cfif auditedby is "Field Services">Field Services Regional<cfelse>Regional</cfif> Audit of #OfficeName# Completed (#year#-#id#-#auditedby#)<br><br>

<cfif auditedby is "Field Services">Field Services</cfif> Regional Audit #year#-#id# of #OfficeName# has been completed and the audit report has been published to the UL Audit Database website.<br><br>

<!---
<cfif auditedby is NOT "Field Services">
You can access the audit report by following the link below:<br>
<a href="http://#CGI.SERVER_NAME#/departments/snk5212/IQA/Report_Output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">
http://#CGI.Server_Name#/departments/snk5212/IQA/Report_Output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#
</a>
<br><br>
</cfif>
--->

You can access the audit details by following the link below, which includes a link to the audit report:<Br>
<a href="http://#CGI.SERVER_NAME#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#">
http://#CGI.Server_Name#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#
</a>
<br><br>

The <cfif audittype2 is NOT "Field Services">Local Quality Manager is <cfelse>Field Service Quality Rep is </cfif> responsible for forwarding this information to parties associated or responsible for the areas covered in this audit.<br><br>

----------------------------------------------------------------<br><br>
<cfelse>
<u>NOTE</u> - This audit is not approved to the Audit Schedule. No notifications will be sent<br><br>
</cfif>

Upload Audit Report:<br>
File must be PDF Format. File will be renamed <B>#Year#-#ID#.pdf</b><br>
<INPUT NAME="File" SIZE=50 TYPE="FILE">

<cfif AuditType2 is "Local Function CBTL">
<input Name="CBTL" Type="Hidden" Value="1">
<cfelse>
<input Name="CBTL" Type="Hidden" Value="0">
</cfif>
<br><br>
<INPUT TYPE="Submit" value="Upload Report">

</FORM>
</cfoutput>

<cfelse>

</CFIF>
</cflock>	

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->