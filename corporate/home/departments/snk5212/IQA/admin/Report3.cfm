<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle="Add Report Page 3 - #URL.Year#-#URL.ID#-#URL.AuditedBy#">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfoutput>
	<script language="JavaScript" src="../webhelp/webhelp.js"></script>
</cfoutput>

<!--- included for Form Validation and Formatted Form Textarea boxes --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="a">
SELECT ID, YEAR_ as "Year"
FROM Report2
WHERE ID = #URL.ID#
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfif a.recordcount is 0>
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="FirstEntry">
	INSERT INTO Report2(ID, Year_, AuditedBy)
	VALUES (#URL.ID#, <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">, '#URL.AuditedBy#')
	</cfquery>
</cfif>

<!---
<cfloop index="i" from="1" to="20">
	<cfparam name="#Evaluate("Form.e_Comments#i#")#" default="N/A">
    <cfparam name="#Evaluate("Form.e_VCAR#i#")#" default="0">
</cfloop>
--->

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Check">
SELECT Month, AuditType, AuditType2, ID, YEAR_ as "Year", AuditedBy, Desk, StartDate, OfficeName
FROM AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<!--- added for November 2017 audits and forward - implemented on 11/20/2017 --->
	<cfif check.Year eq 2017 AND check.Month GTE 11 AND check.ID eq 73 
		OR check.Year eq 2017 AND check.Month GTE 11 AND check.ID eq 71 
		OR check.Year eq 2017 AND check.Month GTE 11 AND check.ID eq 74 
		OR check.Year eq 2017 AND check.Month GTE 11 AND check.ID eq 166
		OR check.Year eq 2017 AND check.Month GTE 11 AND check.ID eq 159 
		OR check.Year eq 2017 AND check.Month GTE 11 AND check.ID eq 383 
		OR check.Year eq 2017 AND check.Month GTE 11 AND check.ID eq 200 
		OR check.Year eq 2017 AND check.Month GTE 11 AND check.ID eq 81 
		OR check.Year eq 2017 AND check.Month GTE 11 AND check.ID eq 82 
		OR check.Year eq 2017 AND check.Month GTE 11 AND check.ID eq 80 
		OR check.Year eq 2017 AND check.Month GTE 11 AND check.ID eq 135
		OR check.Year eq 2017 AND check.Month EQ 12
		OR check.Year GTE 2018>
		
		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
		UPDATE Report2
		SET
		
		CARsNotVerified = '#Form.CARsNotVerified#',
		CARsNotVerified_checkbox = 'Yes'
		
		WHERE ID = #URL.ID#
		AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
		AND AuditedBy = '#URL.AuditedBy#'
		</CFQUERY>
	</cfif>
<!--- /// --->

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE Report2
SET

Comments1='#Form.e_Comments1#',
Comments2='#Form.e_Comments2#',
Comments3='#Form.e_Comments3#',
Comments4='#Form.e_Comments4#',
Comments5='#Form.e_Comments5#',
Comments6='#Form.e_Comments6#',
Comments7='#Form.e_Comments7#',
Comments8='#Form.e_Comments8#',
Comments9='#Form.e_Comments9#',
Comments10='#Form.e_Comments10#',
Comments11='#Form.e_Comments11#',
Comments12='#Form.e_Comments12#',
Comments13='#Form.e_Comments13#',
Comments14='#Form.e_Comments14#',
Comments15='#Form.e_Comments15#',
Comments16='#Form.e_Comments16#',
Comments17='#Form.e_Comments17#',
Comments18='#Form.e_Comments18#',
Comments19='#Form.e_Comments19#',
Comments20='#Form.e_Comments20#',
VCAR1='#Form.e_VCAR1#',
VCAR2='#Form.e_VCAR2#',
VCAR3='#Form.e_VCAR3#',
VCAR4='#Form.e_VCAR4#',
VCAR5='#Form.e_VCAR5#',
VCAR6='#Form.e_VCAR6#',
VCAR7='#Form.e_VCAR7#',
VCAR8='#Form.e_VCAR8#',
VCAR9='#Form.e_VCAR9#',
VCAR10='#Form.e_VCAR10#',
VCAR11='#Form.e_VCAR11#',
VCAR12='#Form.e_VCAR12#',
VCAR13='#Form.e_VCAR13#',
VCAR14='#Form.e_VCAR14#',
VCAR15='#Form.e_VCAR15#',
VCAR16='#Form.e_VCAR16#',
VCAR17='#Form.e_VCAR17#',
VCAR18='#Form.e_VCAR18#',
VCAR19='#Form.e_VCAR19#',
VCAR20='#Form.e_VCAR20#'

WHERE ID = #URL.ID#
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE AuditSchedule
SET

Report='2'

WHERE ID = #URL.ID#
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Check">
SELECT Month, AuditType, AuditType2, AuditArea, ID, YEAR_ as "Year", AuditedBy, Desk
FROM AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<!--- Global Desk and Scheme Documentation audits do not do this page, go to Report_edit4.cfm with url.skip = yes --->
<cfif Check.Desk is "Yes" AND Check.AuditType2 is "Global Function/Process"
	OR Check.AuditType2 eq "Program" AND Check.AuditArea eq "Scheme Documentation Audit">

	<cflocation url="Report4new.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#&skip=Yes" addtoken="no">

<!--- non-17065 Program audits and CB audits do the new "report card" version of this page, go to Report_ReportCardAdd.cfm --->
<cfelseif Check.AuditType2 eq "Program" AND Check.AuditArea NEQ "Scheme Documentation Audit"
	OR Check.AuditType2 eq "Local Function" AND Check.AuditArea EQ "Certification Body (CB) Audit">

	<cflocation url="Report3_ReportCardAdd.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#" addtoken="no">

</cfif>

<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function popUp(URL) {
day = new Date();
id = day.getTime();
eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=300,height=450,left = 490,top = 412');");
}
// End -->
</script>

<br><div class="blog-time">
Audit Report Help - <A HREF="javascript:popUp('../webhelp/webhelp_auditreport.cfm')">[?]</A></div><br>

<cfoutput>
<FORM id="myform" name="myform" METHOD="POST" ENCTYPE="multipart/form-data" ACTION="Report4new.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#&Skip=No">

<cfif Check.Desk eq "No" AND Check.AuditType2 eq "Global Function/Process"
	OR Check.AuditType2 eq "Program" AND Check.Year LTE 2014
	OR Check.AuditType2 eq "Local Function" AND Check.AuditArea neq "Certification Body (CB) Audit">

<cfif Check.Year GT 2014>
	Note: Effectiveness Criteria can be found at the bottom of the page.<br><br>

	Document Control Implementation<br><br>
	Yes <input type="Radio" Name="DC" Value="Yes">
	No <INPUT TYPE="Radio" NAME="DC" value="No">
	N/A <INPUT TYPE="Radio" NAME="DC" value="NA">
	Cannot Determine Effectiveness <INPUT TYPE="Radio" NAME="DC" value="Cannot Determine Effectiveness" data-bvalidator="required" data-bvalidator-msg="Select Document Control Implementation Effectiveness - Yes/No/NA Box"><br>

	Please add comments:<br>
	<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="e_DCComments" Value="" data-bvalidator="required" data-bvalidator-msg="Document Control Implementation - Comments"></textarea>
	<br><br>

	Management Review Implementation<br><br>
	Yes <input type="Radio" Name="MR" Value="Yes">
	No <INPUT TYPE="Radio" NAME="MR" value="No">
	N/A <INPUT TYPE="Radio" NAME="MR" value="NA">
	Cannot Determine Effectiveness <INPUT TYPE="Radio" NAME="MR" value="Cannot Determine Effectiveness" data-bvalidator="required" data-bvalidator-msg="Select Management Review Implementation Effectiveness - Yes/No/NA Box"><br>

	Please add comments:<br>
	<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="e_MRComments" Value="" data-bvalidator="required" data-bvalidator-msg="Management Review Implementation - Comments"></textarea>
	<br><br>

	Corrective Action Implementation<br><br>
	Yes <input type="Radio" Name="CA" Value="Yes">
	No <INPUT TYPE="Radio" NAME="CA" value="No">
	N/A <INPUT TYPE="Radio" NAME="CA" value="NA">
	Cannot Determine Effectiveness <INPUT TYPE="Radio" NAME="CA" value="Cannot Determine Effectiveness" data-bvalidator="required" data-bvalidator-msg="Select Corrective Action Implementation Effectiveness - Yes/No/NA Box"><br>

	Please add comments:<br>
	<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="e_CAComments" Value="" data-bvalidator="required" data-bvalidator-msg="Corrective Action Implementation - Comments"></textarea>
	<br><br>

	Records Implementation<br><br>
	Yes <input type="Radio" Name="RE" Value="Yes">
	No <INPUT TYPE="Radio" NAME="RE" value="No">
	N/A <INPUT TYPE="Radio" NAME="RE" value="NA">
	Cannot Determine Effectiveness <INPUT TYPE="Radio" NAME="RE" value="Cannot Determine Effectiveness" data-bvalidator="required" data-bvalidator-msg="Select Records Implementation Effectiveness - Yes/No/NA Box"><br>

	Please add comments:<br>
	<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="e_REComments" Value="" data-bvalidator="required" data-bvalidator-msg="Records Implementation - Comments"></textarea>
	<br><br>

	Internal Audits Implementation<br><br>
	Yes <input type="Radio" Name="IA" Value="Yes">
	No <INPUT TYPE="Radio" NAME="IA" value="No">
	N/A <INPUT TYPE="Radio" NAME="IA" value="NA">
	Cannot Determine Effectiveness <INPUT TYPE="Radio" NAME="IA" value="Cannot Determine Effectiveness" data-bvalidator="required" data-bvalidator-msg="Select Internal Audits Implementation Effectiveness - Yes/No/NA Box"><br>

	Please add comments:<br>
	<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="e_IAComments" Value="" data-bvalidator="required" data-bvalidator-msg="Internal Audits Implementation - Comments"></textarea>
	<br><br>

	<!--- added Feb 4 2009 --->
	Access to Files and Records via the UL Network<br><br>
	Yes <input type="Radio" Name="Net" Value="Yes">
	No <INPUT TYPE="Radio" NAME="Net" value="No">
	N/A <INPUT TYPE="Radio" NAME="Net" value="NA">
	Cannot Determine Effectiveness <INPUT TYPE="Radio" NAME="Net" value="Cannot Determine Effectiveness" data-bvalidator="required" data-bvalidator-msg="Select File and Records Access on UL Net - Yes/No/NA Box"><Br>

	Please add comments:<br>
	<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="e_NetComments" Value="" data-bvalidator="required" data-bvalidator-msg="Access to Files/Records on UL Net - Comments"></textarea>
	<br><br>
<cfelseif Check.Year LTE 2014>
	Document Control implementation effective?<br>
	<A HREF="javascript:popUp('help.cfm?ID=1')">[View Effectiveness Criteria]</A>
	<br>
	Yes <input type="Radio" Name="DC" Value="Yes">
	No <INPUT TYPE="Radio" NAME="DC" value="No">
	N/A <INPUT TYPE="Radio" NAME="DC" value="NA">
	Cannot Determine Effectiveness <INPUT TYPE="Radio" NAME="DC" value="Cannot Determine Effectiveness" data-bvalidator="required" data-bvalidator-msg="Select Document Control Implementation Effectiveness - Yes/No/NA Box"><br>

	Please add comments:<br>
	<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="e_DCComments" Value="" data-bvalidator="required" data-bvalidator-msg="Document Control Implementation - Comments"></textarea>
	<br><br>

	Management Review implementation effective?<br>
	<A HREF="javascript:popUp('help.cfm?ID=2')">[View Effectiveness Criteria]</A>
	<br>
	Yes <input type="Radio" Name="MR" Value="Yes">
	No <INPUT TYPE="Radio" NAME="MR" value="No">
	N/A <INPUT TYPE="Radio" NAME="MR" value="NA">
	Cannot Determine Effectiveness <INPUT TYPE="Radio" NAME="MR" value="Cannot Determine Effectiveness" data-bvalidator="required" data-bvalidator-msg="Select Management Review Implementation Effectiveness - Yes/No/NA Box"><br>

	Please add comments:<br>
	<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="e_MRComments" Value="" data-bvalidator="required" data-bvalidator-msg="Management Review Implementation - Comments"></textarea>
	<br><br>

	Corrective Action implementation effective?<br>
	<A HREF="javascript:popUp('help.cfm?ID=3')">[View Effectiveness Criteria]</A>
	<br>
	Yes <input type="Radio" Name="CA" Value="Yes">
	No <INPUT TYPE="Radio" NAME="CA" value="No">
	N/A <INPUT TYPE="Radio" NAME="CA" value="NA">
	Cannot Determine Effectiveness <INPUT TYPE="Radio" NAME="CA" value="Cannot Determine Effectiveness" data-bvalidator="required" data-bvalidator-msg="Select Corrective Action Implementation Effectiveness - Yes/No/NA Box"><br>

	Please add comments:<br>
	<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="e_CAComments" Value="" data-bvalidator="required" data-bvalidator-msg="Corrective Action Implementation - Comments"></textarea>
	<br><br>

	Records implementation effective?<br>
	<A HREF="javascript:popUp('help.cfm?ID=4')">[View Effectiveness Criteria]</A>
	<br>
	Yes <input type="Radio" Name="RE" Value="Yes">
	No <INPUT TYPE="Radio" NAME="RE" value="No">
	N/A <INPUT TYPE="Radio" NAME="RE" value="NA">
	Cannot Determine Effectiveness <INPUT TYPE="Radio" NAME="RE" value="Cannot Determine Effectiveness" data-bvalidator="required" data-bvalidator-msg="Select Records Implementation Effectiveness - Yes/No/NA Box"><br>

	Please add comments:<br>
	<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="e_REComments" Value="" data-bvalidator="required" data-bvalidator-msg="Records Implementation - Comments"></textarea>
	<br><br>

	Internal Audits implementation effective?<br>
	<A HREF="javascript:popUp('help.cfm?ID=5')">[View Effectiveness Criteria]</A>
	<br>
	Yes <input type="Radio" Name="IA" Value="Yes">
	No <INPUT TYPE="Radio" NAME="IA" value="No">
	N/A <INPUT TYPE="Radio" NAME="IA" value="NA">
	Cannot Determine Effectiveness <INPUT TYPE="Radio" NAME="IA" value="Cannot Determine Effectiveness" data-bvalidator="required" data-bvalidator-msg="Select Internal Audits Implementation Effectiveness - Yes/No/NA Box"><br>

	Please add comments:<br>
	<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="e_IAComments" Value="" data-bvalidator="required" data-bvalidator-msg="Internal Audits Implementation - Comments"></textarea>
	<br><br>

	<!--- added Feb 4 2009 --->
	Does the Site have access to files and records via the UL Network?<br>
	<A HREF="javascript:popUp('help.cfm?ID=7')">[View Effectiveness Criteria]</A>
	<br>
	Yes <input type="Radio" Name="Net" Value="Yes">
	No <INPUT TYPE="Radio" NAME="Net" value="No">
	N/A <INPUT TYPE="Radio" NAME="Net" value="NA">
	Cannot Determine Effectiveness <INPUT TYPE="Radio" NAME="Net" value="Cannot Determine Effectiveness" data-bvalidator="required" data-bvalidator-msg="Select File and Records Access on UL Net - Yes/No/NA Box"><Br>

	Please add comments:<br>
	<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="e_NetComments" Value="" data-bvalidator="required" data-bvalidator-msg="Access to Files/Records on UL Net - Comments"></textarea>
	<br><br>
</cfif>

</cfif>

<!---
External Calibration included in Audit?<br>
<A HREF="javascript:popUp('help.cfm?ID=8')">[View Effectiveness Criteria]</A>
<br>
Yes <input type="Radio" Name="Cal" Value="Yes" Checked> No <INPUT TYPE="Radio" NAME="Cal" value="No"> N/A <INPUT TYPE="Radio" NAME="IA" value="NA"><br>

Please add comments:<br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="e_CalComments" Value="" displayname="External Calibration Comments"></textarea>
<br><br>
--->

<input type="submit" value="Save and Continue">
<input type="reset" value="Reset Form">
</FORM>
</cfoutput>

<cfif Check.Year GT 2014>
<br><Br>
<b>Effectiveness Criteria</b><br><br>

<!--- DC --->
<u>Criteria for Document Control Implementation</u><br>
<u>Evaluation</u>: If a Document Control Process is not providing the availability of current, approved, and accessible documents it is deemed
ineffective.<br><br>

<u>Effectiveness</u>: To verify effectiveness, sample documents to see if they are accessible by those who need them to accomplish work, that
the documents are current based on a controlled master list, no obsolete documents are being used, and the documents have been approved for use.<br>
<u>Cannot Determine Effectiveness Definition</u>: Requirements are approved and published; however, evidence is not available to demonstrate complete
implementation. This is typically used in situations where newly introduced or changed processes have not operated long enough to accumulate the
necessary evidence to demonstrate effective implementation.  This is also used in situations where evidence is not available or provided for mature
processes. Typically, a nonconformance is written in these situations.<br><br>

<hr><br><br>

<!--- MR --->
<u>Criteria for Management Review Implementation</u><br>
<u>Evaluation</u>: If the Management Review Process does not adequately address the minimum requirements of the standard (ISO 17025, 17065, etc.)
and internal requirements it is deemed ineffective.<br><br>

<u>Effectiveness</u>: Based on the organizational level that the review is conducted, verify that decisions/actions from the review are deployed,
tracked and completed in the expected timeframe. Verify that any unresolvable issues are elevated to higher levels within the organization.
Conclusion of Management Review indicates effectiveness status of management system and all inputs/outputs were adequately addressed.<br><br>

<u>Cannot Determine Effectiveness Definition</u>: Requirements are approved and published; however, evidence is not available to demonstrate complete
implementation. This is typically used in situations where newly introduced or changed processes have not operated long enough to accumulate the necessary
evidence to demonstrate effective implementation.  This is also used in situations where evidence is not available or provided for mature processes.
Typically, a nonconformance is written in these situations.<br><br>

<hr><br><br>

<!--- CA --->
<u>Criteria for Corrective Action Implementation</u><br>
<u>Evaluation</u>: If the previously identified issues continue to occur, Corrective Action implementation is not effective.<Br><br>

<u>Effectiveness</u>: To verify effectiveness, sample recent CARs to see if action was effectively implemented in the expected timeframe.
After evaluating a sample of Corrective Actions records, if the same problem and/or root cause has not occurred the process is deemed effective.
Additionally, if problems are identified internally or externally, and action is being taken to resolve them the process is deemed effective.<br><br>

<u>Cannot Determine Effectiveness Definition</u>: Requirements are approved and published; however, evidence is not available to demonstrate
complete implementation. This is typically used in situations where newly introduced or changed processes have not operated long enough to accumulate
the necessary evidence to demonstrate effective implementation. This is also used in situations where evidence is not available or provided for mature
processes. Typically, a nonconformance is written in these situations.<br><br>

<hr><br><br>

<!--- Records --->
<u>Criteria for Records Implementation</u><br>
<u>Evaluation</u>: If the Records Control Process is not supporting the traceability, accuracy, maintenance, and accessibility of records it is
deemed ineffective.<br><br>

<u>Effectiveness</u>: Verify that a sample of records exist as a result of processes audited. Records must be complete and accurate, legible,
maintained as required (retention time and storage), traceable to the activity/process that generated them; protected from loss or damage.
Electronically stored records shall require a backup/security process.<br><br>

<u>Cannot Determine Effectiveness Definition</u>: Requirements are approved and published; however, evidence is not available to demonstrate
complete implementation. This is typically used in situations where newly introduced or changed processes have not operated long enough to
accumulate the necessary evidence to demonstrate effective implementation.  This is also used in situations where evidence is not available or
provided for mature processes. Typically, a nonconformance is written in these situations.<br><br>

<hr><br><br>

<!--- IA --->
<u>Criteria for Internal Audit Implementation</u><br>
<u>Evaluation</u>: If the Internal Audit Process is not identifying the local and/or systemic weaknesses in the quality management system it is
deemed ineffective.<br><br>

<u>Effectiveness</u>: To verify effectiveness, sample recent internal audits/plans to assure all elements/areas of the QMS were audited.
Compare internal findings with the findings identified in external audits.  The process is deemed effective if external audits are not uncovering
recurring quality management system compliance issues.<br><br>

<u>Cannot Determine Effectiveness Definition</u>: Requirements are approved and published; however, evidence is not available to demonstrate complete
implementation. This is typically used in situations where newly introduced or changed processes have not operated long enough to accumulate the
necessary evidence to demonstrate effective implementation. This is also used in situations where evidence is not available or provided for mature
processes. Typically, a nonconformance is written in these situations.<br><br>

<hr><br><br>

<u>Criteria for Access to Files and Records via the UL Network</u><br>
<u>Evaluation</u>: This function is effective if staff physically located at a site demonstrate that they have access to original files or records.<br><br>

<u>Effectiveness</u>: Verify that staff at the site being audited have access to the UL Network via transmission of email correspondence or actual
witnessing staff accessing files or records. Files/records can be documents via the Document Control System, access into ePro, DMS. eComm, Lotus Notes
email, CAR Database, etc.<br><br>

<u>Cannot Determine Effectiveness Definition</u>: Requirements are approved and published, however, evidence is not available to demonstrate complete
implementation. Typically used in situations where newly introduced or changed processes have not operated long enough to accumulate the necessary
evidence to demonstrate implementation. Also used in situations where evidence is not available or provided for mature processes. Typically, a
nonconformance is written in these situations.<br><br>
</cfif>

<!--- required for form validation --->
<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->