<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<CFQUERY BLOCKFACTOR="100" name="Check" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT ID,YEAR_ as "Year", AuditedBy, AuditType, AuditType2, RD
 FROM AuditSchedule
 WHERE YEAR_='2008' AND  AuditedBy = 'IQA'
 AND  AuditType = 'Quality System'
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<cfoutput query="Check">
#year#-#id#-#auditedby# (#audittype2#)<br>
	Corrective Action Request Process (00-QA-S0006)<br>
	Backup of Controlled Documents Policy (00-IT-P0027)<br>
	SOP Handling Data Backup and Retention (00-IT-S0025)<br>
	UL Global Quality Manual (00-QA-P0001)<br>
	Global Forms Management Process (00-QA-S0026)<br>
	Document Management SOP (00-QA-S0003)<br>
	<cfif audittype2 is "Local Function" or audittype is "Local Function FS" or audittype is "Local Function CBTL">UL Mark Certification Program Policy Manual (00-CE-P0001)<br></cfif>
	<cfset Dump0 = #replace(RD, "Data Recording!!,", "Data Recording,", "All")#>	
<cfset Dump0a = #replace(Dump0, "Purchase!!,", "Purchase,", "All")#>
<cfset Dump0b = #replace(Dump0a, "Receipt!!,", "Receipt,", "All")#>
	<cfset Dump1 = #replace(Dump0b, "- None -!!,", "", "All")#>	
	<cfset Dump1a = #replace(Dump1, "- None -", "", "All")#>
	<cfset Dump2 = #replace(Dump1a, "NoChanges!!,", "", "All")#>	
	<cfset Dump3 = #replace(Dump2, "NoChanges,", "", "All")#>
	<cfset Dump3A = #replace(Dump3, "NoChanges", "", "All")#>	
	<cfset Dump3B = #replace(Dump3A, "!!,", "<br>", "All")#>	
	<cfset Dump4 = #replace(Dump3B, "Corrective Action Request Process (00-QA-S0006),", "", "All")#>
	<cfset Dump5 = #replace(Dump4, "Backup of Controlled Documents Policy (00-IT-P0027),", "", "All")#>
	<cfset Dump6 = #replace(Dump5, "SOP Handling Data Backup and Retention (00-IT-S0025),", "", "All")#>
	<cfset Dump7 = #replace(Dump6, "UL Global Quality Manual (00-QA-P0001),", "", "All")#>
	<cfset Dump8 = #replace(Dump7, "Global Forms Management Process (00-QA-S0026),", "", "All")#>
	<cfset Dump9 = #replace(Dump8, "Document Management SOP (00-QA-S0003),", "", "All")#>
	<cfset Dump13 = #replace(Dump9, "Corrective Action Request Process 00-QA-S0006,", "", "All")#>
	<cfset Dump14 = #replace(Dump13, "Backup of Controlled Documents Policy 00-IT-P0027,", "", "All")#>
	<cfset Dump15 = #replace(Dump14, "SOP Handling Data Backup and Retention 00-IT-S0025,", "", "All")#>
	<cfset Dump16 = #replace(Dump15, "UL Global Quality Manual 00-QA-P0001,", "", "All")#>
	<cfset Dump17 = #replace(Dump16, "Global Forms Management Process 00-QA-S0026,", "", "All")#>
	<cfset Dump18 = #replace(Dump17, "Document Management SOP 00-QA-S0003,", "", "All")#>
	<cfset Dump19 = #replace(Dump18, "Global Testing Laboratory Policy 00-LC-P0030,", "", "All")#>
	<cfset Dump20 = #replace(Dump19, "Conformity Assessment Manual CAM,", "", "All")#>
	<cfset Dump21 = #replace(Dump20, "Global Product Certification Process 00-IC-P0028,", "", "All")#>
	<cfset Dump22 = #replace(Dump21, "Global Inspection Policy 00-GI-P0027,", "", "All")#>
	<cfset Dump23 = #replace(Dump22, "Global Testing Laboratory Policy (00-LC-P0030),", "", "All")#>
	<cfset Dump24 = #replace(Dump23, "Conformity Assessment Manual (CAM),", "", "All")#>
	<cfset Dump25 = #replace(Dump24, "Global Product Certification Process (00-IC-P0028),", "", "All")#>
	<cfset Dump26 = #replace(Dump25, "Global Inspection Policy (00-GI-P0027),", "", "All")#>
	<cfset Dump27 = #replace(Dump26, "Document Management Policy (00-QA-P0002),", "", "All")#>
	<cfset Dump28 = #replace(Dump27, "Document Management Policy 00-QA-P0002,", "", "All")#>
	<cfset Dump29 = #replace(Dump28, "!!", "", "All")#>
#Dump29#<br><br>#year#-#id#<br><br>#rd#<br><hr><br>
</cfoutput>