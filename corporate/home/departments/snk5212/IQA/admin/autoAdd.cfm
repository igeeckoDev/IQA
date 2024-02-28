<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Audits - Add to Schedule">
<cfinclude template="SOP.cfm">

<!--- / --->

<cfset nextyr = #curyear# + 1>

<CFQUERY Name="maxID" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT MAX(ID)+1 as maxID
 FROM AuditSchedule
 WHERE YEAR_=#nextyr#
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<CFQUERY Name="maxGUID" Datasource="Corporate">
SELECT MAX(xGUID)+1 as maxGUID FROM AuditSchedule
</CFQUERY>

<CFQUERY Name="Audits" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT *
 FROM AuditSchedule
 WHERE AuditedBY = 'IQA'  AND 
	Approved = 'Yes'  AND YEAR_=#curyear# AND 
	(Status IS NULL OR Status = '')
 ORDER BY ID
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<cfif Audits.RecordCount gt 0>
<cfset n = 0><!--- Total number of Audits added --->

<cfif maxID.recordcount gt 0>
	<cfset i = #maxID.maxID#><!--- Counter for ID of Audit to be added --->
<cfelse>
	<cfset i = 1>
</cfif>

<cfset j = #maxGUID.maxGUID#><!--- Counter for xGUID to be added ---->
<cfset RDList = "Corrective Action Request Process (00-QA-S0006)<br>Backup of Controlled Documents Policy (00-IT-P0027)<br>SOP Handling Data Backup and Retention (00-IT-S0025)<br>UL Global Quality Manual (00-QA-P0001)<br>Global Records Policy (00-QA-P0026)<br>Document Management SOP (00-QA-S0003)<br>">

<cfset setScope = "1. The scope of the assessment includes verifying implementation of UL Quality Management System as described in the Global Quality Manaual, 00-QA-P0001.  Additional functional, local and or program policies/procedures will also be utilized.  Specifics on the scope of this assessment are described in Attachment A. These logistics will be addressed during pre-audit communications and/or during the Opening Sessions at each location.<br>2. Verify the effective implementation of previously closed CARs (internal and accreditor).<br>3. Review any progress on open CARs.<br>4. Ensure that documents used are under the document control system.<br>5. Verify that documentation released since the last audit was conducted, meets the applicable UL and ISO 17025, ISO 17020, Guide 65, or ISO 17021 requirements.<br>6. See specific scope letter for additional details.">

<cfset setGDScope = "1. Review the policy/program manual against the applicable standard requirements for compliance (ISO 17025, Guide 65, etc)<br>2. Review the policy/program manual against the Global Quality Manual requirements.<br>3. Review the SOP(s) against the UL policy/Global Quality Manual for compliance<br>&nbsp;&nbsp;&nbsp;3a.Review any local docs to see if there are conflicts<br>&nbsp;&nbsp;&nbsp;3b Ensure record retention, location, etc is defined in all SOP's<br>4. Ensure necessary stakeholders have approved the document<br>5. Ensure the document meets the 2 year review & other document control policy/procedure requirements">

<cfoutput query="Audits">
    <CFQUERY Name="AuditsAdd" DataSource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->
INSERT INTO AuditSchedule (xGUID,ID,YEAR_,AuditedBy,OfficeName,Area,AuditArea,AuditType,AuditType2,Month,Scheduler,Auditor,LeadAuditor,KP,RD,Scope,Approved,Status,Desk,Notes)
 VALUES(#j#,#i#,#nextyr#,'IQA','#OfficeName#','#Area#','#AuditArea#','#AuditType#','#AuditType2#',#Month#,'<u>Username:</u> Auto Add (IQA Admin)<br><u>Time:</u>
#curtimedate#','#Auditor#','#LeadAuditor#',<CFQUERYPARAM VALUE='#KP#'>,<CFQUERYPARAM VALUE='#RDList#'>,<CFQUERYPARAM VALUE='<cfif audittype2 is "Global Function/Process" AND Desk is "Yes">#setGDScope#<cfelse>#setScope#</cfif>'>,'Yes','','#Desk#',<CFQUERYPARAM VALUE='#Notes#'>)

<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

    <b>#year#-#ID#-#auditedby#</b><br> Added as #nextyr#-#i#-#auditedby# (GUID - #j#)<br><br />
<cfset n = n+1>
<cfset i = i+1>
<cfset j = j+1>
</cfoutput>
</cfif><br /><br />

<cfoutput>
Result - #n# audits added to #nextyr# for IQA<br /><br />
</cfoutput>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->