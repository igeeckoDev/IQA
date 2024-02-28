<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Add Audit - <cfoutput>#URL.AuditedBy#</cfoutput>">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

Schedule/Edit an Audit Help - <A HREF="javascript:popUp('../webhelp/webhelp_scheduleaudit.cfm')">[?]</A><Br /><br />

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

<cflock scope="SESSION" timeout="5">
	<cfif SESSION.Auth.AccessLevel is "IQAAuditor" or SESSION.Auth.AccessLevel is "Auditor">
        <CFQUERY BLOCKFACTOR="100" NAME="Qual" Datasource="Corporate">
        SELECT Auditor, status, auditor, qualified
        FROM AuditorList
        WHERE Status = 'Active'
        AND QUALIFIED LIKE '%CBTL%'
        AND Auditor = '#SESSION.Auth.Name#'
        </cfquery>

        <cfif qual.recordcount is 0>
            <cfset cbtlqual = 0>
        <cfelse>
            <cfset cbtlqual = 1>
        </cfif>
    </cfif>
</cflock>

<cfoutput>
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="addaudit1.cfm?AuditedBy=#URL.AuditedBy#">
<input type="hidden" name="AuditedBy" value="#URL.AuditedBy#">

Type of Audit: (required)<br>
<SELECT NAME="e_AuditType2" displayname="Specific Audit Type">
    <OPTION VALUE="">Select Audit Type
    <OPTION VALUE="">---
    <cfif url.auditedby is "Field Services">
        <option value="Field Services" selected>Field Services
    <cfelseif url.auditedby is "WiSE">
    	<OPTION VALUE="Accred">Accreditor Audit
        <OPTION VALUE="Local Function">Technical Audit
	<cfelseif url.auditedby is "Medical" OR url.auditedby is "UL Environment">
		<OPTION VALUE="Accred">Accreditation (External) Audit
		<OPTION VALUE="Local Function">Site Audit
		<OPTION VALUE="CB">Certification Body (CB, including associated Schemes) Audit
    <cfelseif URL.AuditedBy IS NOT "IQA">
        <OPTION VALUE="Accred">Accreditation
        <OPTION VALUE="Local Function">Local Function (Site Audit)
			<cflock scope="SESSION" timeout="60">
				<cfif SESSION.Auth.AccessLevel is "IQAAuditor" or SESSION.Auth.AccessLevel is "Auditor">
					<cfif cbtlqual is 1>
						<OPTION VALUE="Local Function CBTL">Local Function and CBTL
					</cfif>
				<cfelseif SESSION.Auth.AccessLevel is "SU" or SESSION.Auth.AccessLevel is "Admin" or SESSION.Auth.AccessLevel is "RQM">
					<OPTION VALUE="Local Function CBTL">Local Function and CBTL
				</cfif>
			</cflock>
		<cfelse>
		<cfif URL.AuditedBy is "IQA">
			<!--- No more Corporate audits starting in 2015
			<OPTION VALUE="Corporate">Corporate
			<OPTION VALUE="EHS - Environmental Health and Saftey">EHS - Environmental Health and Saftey
			<OPTION VALUE="Field Services">Field Services
			<OPTION VALUE="Lab Scope Review">Lab Scope Review
			--->
			
			<OPTION VALUE="CB">Certification Body (CB) Audit
			<OPTION VALUE="Global Function/Process">Global Function/Process
			<OPTION VALUE="Local Function">Local Function (Site Audit - CAS and/or Laboratory)
			<OPTION VALUE="MMS - Medical Management Systems">MMS - Medical Management Systems
			<OPTION VALUE="Program">Program (for non-ISO/IEC 17065 programs/schemes)
			<OPTION VALUE="Scheme Documentation Audit">Scheme Documentation Audit
			
			<!--- TPTDP removed Jan 2008
			<OPTION VALUE="TPTDP">TPTDP
			/// --->
		</cfif>
    <cfif url.AuditedBy neq "LAB" AND url.AuditedBy neq "VS" AND url.AuditedBy neq "WiSE" AND url.AuditedBy neq "ULE" AND url.AuditedBy NEQ "IQA">
		<OPTION VALUE="Local Function FS">Local Function and Field Services
		<OPTION VALUE="Technical Assessment">Technical Assessment
    </cfif>
</cfif>
</SELECT>
<br><br>
</cfoutput>
<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">

</FORM>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->