<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Report - Publish Confirmation">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="Type" Datasource="Corporate"> 
SELECT AuditType, ID, AuditedBy, YEAR_ as "Year", AuditType2, AuditType
FROM AuditSchedule
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfif Type.AuditType2 is "Local Function" or Type.AuditType2 is "Local Function FS" or Type.AuditType2 is "Local Function CBTL">

<CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate"> 
SELECT AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.Email2, AuditSchedule.AuditType2, AuditSchedule.LeadAuditor, AUDITSCHEDULE.YEAR_ as "Year", AuditSchedule.Approved, AuditSchedule.Area, IQAtblOffices.OfficeName, IQAtblOffices.RQM, IQAtblOffices.QM, IQAtblOffices.GM, IQAtblOffices.LES, IQAtblOffices.Other, IQAtblOffices.Other2, IQAtblOffices.Regional1, IQAtblOffices.Regional2, IQAtblOffices.Regional3
FROM AuditSchedule, IQAtblOffices
WHERE AuditSchedule.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND AuditSchedule.ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND AuditSchedule.AuditedBy = <cfqueryparam value="#URL.AuditedBy#" cfsqltype="cf_sql_varchar">
AND AuditSchedule.OfficeName = IQAtbloffices.OfficeName
</CFQUERY>

<cfelseif Type.AuditType2 is "Program">

<CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate"> 
SELECT AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.Email2, AuditSchedule.AuditType2, AuditSchedule.LeadAuditor, AUDITSCHEDULE.YEAR_ as "Year", AuditSchedule.Area, AuditSchedule.Approved, IQAtblOffices.OfficeName, IQAtblOffices.RQM, IQAtblOffices.QM, IQAtblOffices.GM, IQAtblOffices.LES, IQAtblOffices.Other, IQAtblOffices.Other2, ProgDev.Program, ProgDev.PMEmail, ProgDev.POEmail
FROM AuditSchedule, IQAtblOffices, ProgDev
WHERE AuditSchedule.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND AuditSchedule.ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND AuditSchedule.AuditedBy = <cfqueryparam value="#URL.AuditedBy#" cfsqltype="cf_sql_varchar">
AND AuditSchedule.OfficeName = IQAtbloffices.OfficeName
AND AuditSchedule.Area = ProgDev.Program
</CFQUERY>

<cfelseif Type.AuditType2 is "Corporate">

<CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate"> 
SELECT AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.Email2, AuditSchedule.AuditType2, AuditSchedule.LeadAuditor, AUDITSCHEDULE.YEAR_ as "Year", AuditSchedule.Approved, AuditSchedule.Area, IQAtblOffices.OfficeName, IQAtblOffices.RQM, IQAtblOffices.QM, IQAtblOffices.GM, IQAtblOffices.LES, IQAtblOffices.Other, IQAtblOffices.Other2, IQAtblOffices.Regional1, IQAtblOffices.Regional2, IQAtblOffices.Regional3
FROM AuditSchedule, IQAtblOffices
WHERE AuditSchedule.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND AuditSchedule.ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND AuditSchedule.AuditedBy = <cfqueryparam value="#URL.AuditedBy#" cfsqltype="cf_sql_varchar">
AND AuditSchedule.OfficeName = IQAtbloffices.OfficeName
</CFQUERY>

<cfelseif Type.AuditType2 is "Global Function/Process">

<CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate"> 
SELECT AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.Email2, AuditSchedule.AuditType2, AuditSchedule.LeadAuditor, AUDITSCHEDULE.YEAR_ as "Year", AuditSchedule.Approved, AuditSchedule.Area, IQAtblOffices.OfficeName, IQAtblOffices.RQM, IQAtblOffices.QM, IQAtblOffices.GM, IQAtblOffices.LES, IQAtblOffices.Other, IQAtblOffices.Other2, IQAtblOffices.Regional1, IQAtblOffices.Regional2, IQAtblOffices.Regional3
FROM AuditSchedule, IQAtblOffices
WHERE AuditSchedule.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND AuditSchedule.ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND AuditSchedule.AuditedBy = <cfqueryparam value="#URL.AuditedBy#" cfsqltype="cf_sql_varchar">
AND AuditSchedule.OfficeName = IQAtbloffices.OfficeName
</CFQUERY>


<cfelseif Type.AuditType2 is "Field Services">

<CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate"> 
SELECT AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.Email2, AuditSchedule.AuditType2, AuditSchedule.LeadAuditor, AUDITSCHEDULE.YEAR_ as "Year", AuditSchedule.Area, AuditSchedule.Approved
FROM AuditSchedule
WHERE AuditSchedule.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND  AuditSchedule.ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND  AuditSchedule.AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<cfelseif Type.AuditType2 is "MMS - Medical Management Systems">

<CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate">
SELECT 
AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.Email2, AuditSchedule.AuditType2, AuditSchedule.LeadAuditor, AuditSchedule.Year_ AS "Year", AuditSchedule.Area, AuditSchedule.Approved

FROM 
AuditSchedule

WHERE AuditSchedule.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND AuditSchedule.ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND AuditSchedule.AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

</cfif>

<cfoutput query="Notify">					  
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="report_publish.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#">
<br>
Do you wish to publish the report for Audit #year#-#id#-#auditedby#?<br><br>

The following email will be sent when you publish this report:<br><br>

----------------------------------------------------------------<br>
<b>To:</b> 
<cfif Type.AuditType2 is "Field Services">
	#trim(Email)#
<cfelseif Type.AuditType2 is "MMS - Medical Management Systems">
	#trim(Email)#
<cfelseif Type.AuditType2 is "Program">
	#trim(Email)# 
<cfelseif Type.AuditType2 is "Corporate" or Type.AuditType2 is "Global Function/Process">
	#Trim(Email)# 
<cfelseif Type.AuditType2 is "Local Function" or Type.AuditType2 is "Local Function FS" or Type.AuditType2 is "Local Function CBTL">
	#trim(Email)#
</cfif><br>

<b>From:</b> Internal Quality Audits (Internal.Quality_Audits@ul.com)<br>

<b>cc:</b> <cfif Type.AuditType2 is "Program">#trim(PMEmail)#, #trim(POEmail)#,</cfif>
<cfif len(Email2)>#Email2#,</cfif> 
<cfif Type.AuditType2 NEQ "MMS - Medical Management Systems">
	<cfif len(RQM)>#RQM#,</cfif> 
	<cfif len(QM)>#QM#,</cfif> 
	<cfif len(GM)>#GM#,</cfif> 
	<cfif len(LES)>#LES#,</cfif> 
	<cfif len(Other)>#Other#,</cfif> 
	<cfif len(Other2)>#Other2#,</cfif> 
		<cfif Type.auditedby is NOT "IQA">
			<cfif len(Regional1)>#Regional1#,</cfif> 
			<cfif len(Regional2)>#Regional2#,</cfif> 
			<cfif len(Regional3)>#Regional3#,</cfif> 
		</cfif>
</cfif>
<cfif Type.AuditType2 is "Field Services">
	John.Carlin@ul.com, Steven.J.Schmid@ul.com
</cfif><Br />

<b>bcc:</b> Internal.Quality_Audits@ul.com, <cflock scope="SESSION" timeout="60">#SESSION.Auth.Email#</cflock><br>

<cfif AuditType2 eq "Program">
	<cfset incSubject = "#Trim(Area)#">
<cfelseif AuditType2 eq "Field Services">
	<cfset incSubject = "Field Services - #trim(Area)#">
<cfelseif AuditType2 is "Corporate" or AuditType2 is "Local Function" or AuditType2 is "Local Function FS" or audittype2 is "Local Function CBTL" or audittype2 is "Global Function/Process">
	<cfset incSubject = "#Trim(OfficeName)# - #Trim(Area)#">
<cfelseif AuditType2 is "MMS - Medical Management Systems">
	<cfset incSubject = "#Trim(Area)#">
</cfif>

<b>Subject:</b> <cfif auditedby NEQ "IQA">IRegional Audit Completed (#year#-#id#-#auditedby#)<cfelse>Audit Completed - Quality System Audit of #incSubject#</cfif><br><br>

The Quality System Audit of #incSubject# has been completed.<br /><br />

You can review the Audit Summary, Findings/Observations and Audit Coverage by following the link to the Audit Report below:<br />
<a href="http://#CGI.SERVER_NAME#/departments/snk5212/IQA/Report_Output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">
http://#CGI.SERVER_NAME#/departments/snk5212/IQA/Report_Output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#
</a>
<br><br>

Audit Details:<br>
<a href="http://#CGI.SERVER_NAME#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#">
http://#CGI.SERVER_NAME#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#
</a>
<br><br>

Please contact #LeadAuditor# for any questions or comments.<br /><br />

The 
<cfif Type.AuditType2 is "Local Function" or Type.AuditType2 is "Local Function FS" or Type.AuditType2 is "Local Function CBTL">
	Local Quality Manager is 
<cfelseif Type.AuditType2 is "Program">
	Program Manager and Program Owner are 
<cfelseif Type.AuditType2 is "Corporate">
	Corporate Process Owner is 
<cfelseif Type.AuditType2 is "Global Function/Process">
	Global Process Owner is 
<cfelseif Type.AuditType2 is "Field Services">
	Field Service Quality Rep is 
<cfelseif Type.AuditType2 is "MMS - Medical Management Systems">
	MMS Program Manager is 
</cfif>
responsible for forwarding this information to parties associated or responsible for the areas covered in this audit.<br>
----------------------------------------------------------------<br><br>

<!--- Explantion on how to access CARs for this audit with link to web help --->

* - <u>Site Contacts</u> can be found under the "UL Office Related" link under "Contacts". <u>Primary Audit Contacts</u> are listed on the Audit Details page. <u>Global and Corporate Process Owners</u> are listed under Corporate Functions and Global Function/Process. <u>Program Managers and Program Owners</u> are listed on the UL Programs Master List.<br><br>

<INPUT TYPE="Submit" name="Publish" Value="Confirm to Publish Report">
<INPUT TYPE="Submit" name="Publish" Value="Cancel">

</FORM>
</cfoutput>	  

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->