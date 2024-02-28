<b>Reference Documents</b> (if applicable)<br>
<!---
<cfif auditedby is "IQA">
--->
<cfif Year gte 2010>
	Corrective Action Request Process (00-QA-S0006)<br>
	<cfif Year lt 2013 OR Year eq 2013 AND Month lte 6>
    	SOP Handling Data Backup and Retention (00-IT-S0025)<br>
    <cfelseif Year GT 2013 OR Year eq 2013 AND Month gte 7>
    	Handling Data Backup and Retention Policy (00-IT-P0829)<br />
	</cfif>
	UL Global Quality Manual (00-QA-P0001)<br>
	Global Records Policy (00-QA-P0026)<br>
	Document Management SOP (00-QA-S0003)<br><br>
	Please see Attachment A of the Scope Letter for additional Reference Documents<br>
<cfelseif Year gte 2008 AND Year lt 2010>
	Corrective Action Request Process (00-QA-S0006)<br>
	Backup of Controlled Documents Policy (00-IT-P0027)<br>
	SOP Handling Data Backup and Retention (00-IT-S0025)<br>
	UL Global Quality Manual (00-QA-P0001)<br>
	Global Records Policy (00-QA-P0026)<br>
	Document Management SOP (00-QA-S0003)<br>
		<cfif audittype2 is "Local Function" or audittype is "Local Function FS" or audittype is "Local Function CBTL">
        	UL Mark Certification Program Policy Manual (00-CE-P0001)<br>
		</cfif>
	<cfset Dump0 = #replace(RD, "Data Recording!!,", "Data Recording,", "All")#>
	<cfset Dump0a = #replace(Dump0, "Purchase!!,", "Purchase,", "All")#>
	<cfset Dump0b = #replace(Dump0a, "Receipt!!,", "Receipt,", "All")#>
	<cfset Dump1 = #replace(Dump0b, "- None -!!,", "", "All")#>	
	<cfset Dump1a = #replace(Dump1, "- None -", "", "All")#>
	<cfset Dump2 = #replace(Dump1a, "NoChanges!!,", "", "All")#>	
	<cfset Dump3 = #replace(Dump2, "NoChanges,", "", "All")#>
	<cfset Dump3A = #replace(Dump3, "NoChanges", "", "All")#>
    <cfset Dump3B = #replace(Dump3A, "UM!!", "UM,", "All")#>
    <cfset Dump3C = #replace(Dump3B, "FO!!", "FO,", "All")#>
	<cfset Dump3D = #replace(Dump3C, "<Br><br>", "<br>", "All")#>    

	<cfset Dump3E = #replace(Dump3D, "!!,", "<br>", "All")#>	
	
	<cfset Dump4 = #replace(Dump3E, "Corrective Action Request Process (00-QA-S0006)<br>", "", "All")#>
	<cfset Dump5 = #replace(Dump4, "Backup of Controlled Documents Policy (00-IT-P0027)<br>", "", "All")#>
	<cfset Dump6 = #replace(Dump5, "SOP Handling Data Backup and Retention (00-IT-S0025)<br>", "", "All")#>
	<cfset Dump7 = #replace(Dump6, "UL Global Quality Manual (00-QA-P0001)<br>", "", "All")#>
	<cfset Dump8 = #replace(Dump7, "Global Records Policy (00-QA-P0026)<br>", "", "All")#>
	<cfset Dump9 = #replace(Dump8, "Document Management SOP (00-QA-S0003)<br>", "", "All")#>	
	
	<cfset Dump10 = #replace(Dump9, "Corrective Action Request Process (00-QA-S0006)<br>,", "", "All")#>
	<cfset Dump11 = #replace(Dump10, "Backup of Controlled Documents Policy (00-IT-P0027)<br>,", "", "All")#>
	<cfset Dump12 = #replace(Dump11, "SOP Handling Data Backup and Retention (00-IT-S0025)<br>,", "", "All")#>
	<cfset Dump12A = #replace(Dump12, "UL Global Quality Manual (00-QA-P0001)<br>,", "", "All")#>
	<cfset Dump12B = #replace(Dump12A, "Global Records Policy (00-QA-P0026)<br>,", "", "All")#>
	<cfset Dump12C = #replace(Dump12B, "Document Management SOP (00-QA-S0003)<br>,", "", "All")#>
	
	<cfset Dump13 = #replace(Dump12C, "Corrective Action Request Process 00-QA-S0006<br>,", "", "All")#>
	<cfset Dump14 = #replace(Dump13, "Backup of Controlled Documents Policy 00-IT-P0027<br>,", "", "All")#>
	<cfset Dump15 = #replace(Dump14, "SOP Handling Data Backup and Retention 00-IT-S0025<br>,", "", "All")#>
	<cfset Dump16 = #replace(Dump15, "UL Global Quality Manual 00-QA-P0001<br>,", "", "All")#>
	<cfset Dump17 = #replace(Dump16, "Global Records Policy 00-QA-P0026<br>,", "", "All")#>
	<cfset Dump18 = #replace(Dump17, "Document Management SOP 00-QA-S0003<br>,", "", "All")#>	
	
	<cfset Dump19 = #replace(Dump18, "Global Testing Laboratory Policy 00-LC-P0030<br>,", "", "All")#>
	<cfset Dump20 = #replace(Dump19, "Conformity Assessment Manual CAM<br>,", "", "All")#>
	<cfset Dump21 = #replace(Dump20, "Global Product Certification Process 00-IC-P0028<br>,", "", "All")#>
	<cfset Dump22 = #replace(Dump21, "Global Inspection Policy 00-GI-P0027<br>,", "", "All")#>
	<cfset Dump23 = #replace(Dump22, "Global Testing Laboratory Policy (00-LC-P0030)<br>,", "", "All")#>
	
	<cfset Dump24 = #replace(Dump23, "Conformity Assessment Manual (CAM)<br>,", "", "All")#>
	<cfset Dump25 = #replace(Dump24, "Global Product Certification Process (00-IC-P0028)<br>,", "", "All")#>
	<cfset Dump26 = #replace(Dump25, "Global Inspection Policy (00-GI-P0027)<br>,", "", "All")#>
	<cfset Dump27 = #replace(Dump26, "Document Management Policy (00-QA-P0002)<br>,", "", "All")#>
	<cfset Dump28 = #replace(Dump27, "Document Management Policy 00-QA-P0002<br>,", "", "All")#>

	<cfset Dump29 = #replace(Dump28, "!!", "", "All")#>
	<cfset Dump30 = #replace(Dump29, "<br>,", "<br>", "All")#>
	<cfoutput>#Dump30#</cfoutput><br>

<cfelseif Year eq 2004>
	<cfif RD is "">
		Will be implemented in 2005<br>
	<cfelse>
		<cfoutput>#RD#</cfoutput>
	</cfif>

<cfelseif Year eq 2007>
	Corrective Action Request Process (00-QA-S0006)<br>
	Backup of Controlled Documents Policy (00-IT-P0027)<br>
	Document Management Policy (00-QA-P0002)<br>
	Global Testing Laboratory Policy (00-LC-P0030)<br>
	Conformity Assessment Manual (CAM)<br>
	Global Product Certification Process (00-IC-P0028)<br>
	Global Inspection Policy (00-GI-P0027)<br>
	<cfset Dump8 = #replace(RD, "- None -", "", "All")#>
	<cfset Dump8a = #replace(Dump8, "NoChanges!!,", "", "All")#>	
	<cfset Dump9 = #replace(Dump8a, "NoChanges", "", "All")#>
	<cfset Dump10 = #replace(Dump9, "NoChanges,", "", "All")#>
	<cfset Dump11 = #replace(Dump10, ", ", "! ", "All")#>
	<cfset Dump12 = #replace(Dump11, ",", "<br>", "All")#>
	<cfset Dump13 = #replace(Dump12, "! ", ", ", "All")#>
	<cfset Dump14 = #replace(Dump13, "!!", "", "All")#>	
	<cfset Dump1 = #replace(Dump14, "Corrective Action Request Process 00-QA-S0006", "", "All")#>
	<cfset Dump2 = #replace(Dump1, "Backup of Controlled Documents Policy 00-IT-P0027", "", "All")#>
	<cfset Dump3 = #replace(Dump2, "Document Management Policy 00-QA-P0002", "", "All")#>
	<cfset Dump4 = #replace(Dump3, "Global Testing Laboratory Policy 00-LC-P0030", "", "All")#>
	<cfset Dump5 = #replace(Dump4, "Conformity Assessment Manual CAM", "", "All")#>
	<cfset Dump6 = #replace(Dump5, "Global Product Certification Process 00-IC-P0028", "", "All")#>
	<cfset Dump7 = #replace(Dump6, "Global Inspection Policy 00-GI-P0027", "", "All")#>

	<cfoutput>#Dump7#</cfoutput><br>
	
<cfelseif Year eq 2006 OR Year eq 2005>
    Corrective Action Request Process (00-QA-S0006)<br>
    Backup of Controlled Documents Policy (00-IT-P0027)<br>
    Document Management Policy (00-QA-P0002)<br>
    Global Testing Laboratory Policy (00-LC-P0030)<br>
    Conformity Assessment Manual (CAM)<br>
    Global Product Certification Process (00-IC-P0028)<br>
    Global Inspection Policy (00-GI-P0027)<br>
    <cfset Dump8 = #replace(RD, "- None -", "", "All")#>
    <cfset Dump9 = #replace(Dump8, "NoChanges", "", "All")#>
    <cfset Dump1 = #replace(Dump9, "Corrective Action Request Process 00-QA-S0006", "", "All")#>
    <cfset Dump2 = #replace(Dump1, "Backup of Controlled Documents Policy 00-IT-P0027", "", "All")#>
    <cfset Dump3 = #replace(Dump2, "Document Management Policy 00-QA-P0002", "", "All")#>
    <cfset Dump4 = #replace(Dump3, "Global Testing Laboratory Policy 00-LC-P0030", "", "All")#>
    <cfset Dump5 = #replace(Dump4, "Conformity Assessment Manual CAM", "", "All")#>
    <cfset Dump6 = #replace(Dump5, "Global Product Certification Process 00-IC-P0028", "", "All")#>
    <cfset Dump7 = #replace(Dump6, "Global Inspection Policy 00-GI-P0027", "", "All")#>
    <cfoutput>#Dump7#</cfoutput><br>
</cfif>
<!---
<cfelse>
<!--- if not IQA --->
	<cfif trim(RD) is "" or trim(RD) is "- none -">
    None Specified
    <cfelse>
    <cfset Dump8 = #replace(RD, "- None -", "", "All")#>
    <cfset Dump9 = #replace(Dump8, "NoChanges", "", "All")#>
    <cfset Dump9a = #replace(Dump9, "NoChanges", "", "All")#>
    <cfset Dump10 = #replace(Dump9a, ", ", "! ", "All")#>
    <cfset Dump11 = #replace(Dump10, ",", "<br>", "All")#>
    <cfset Dump12 = #replace(Dump11, "! ", ", ", "All")#>
    <cfoutput>#Dump12#</cfoutput>
    </cfif>
</cfif>
--->
<br>