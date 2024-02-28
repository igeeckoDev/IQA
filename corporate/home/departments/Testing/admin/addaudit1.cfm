<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Add Audit - <cfoutput>#URL.AuditedBy#</cfoutput>">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif form.e_audittype2 eq "CB">
	<cfset form.e_audittype2 = "Local Function">
	<cfset CBAudit = "Yes">
<cfelse>
	<cfset CBAudit = "No">
</cfif>

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<!--- formatted textarea boxes --->
<cfinclude template="#SiteDir#SiteShared/incTextarea.cfm">

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
    <script language="JavaScript" src="#SiteDir#SiteShared/js/date.js"></script>
</cfoutput>

<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<cfif form.e_audittype2 is "Accred">
	<cflocation url="Accred_AddAudit.cfm?AuditedBy=#URL.AuditedBy#" addtoken="no">
<cfelseif form.AuditedBy is "VS" AND Form.e_AuditType2 is "Local Function"
	OR form.AuditedBy is "WiSE" AND Form.e_AuditType2 is "Local Function"
	OR form.AuditedBy is "ULE" AND Form.e_AuditType2 is "Local Function">
	<cflocation url="#form.AuditedBy#_AddAudit.cfm" addtoken="no">
</cfif>

<cfif form.e_audittype2 is "Field Services">
    <CFQUERY BLOCKFACTOR="100" NAME="FUS" Datasource="Corporate">
        SELECT * FROM FUSAreas
        ORDER BY Area
    </cfquery>
</cfif>

<!---
<CFQUERY BLOCKFACTOR="100" NAME="ExternalLocation" Datasource="Corporate">
	SELECT * FROM ExternalLocation
	WHERE ID <> 0
	ORDER BY ExternalLocation
</cfquery>
--->

<CFQUERY BLOCKFACTOR="100" NAME="KP" Datasource="Corporate">
SELECT KP FROM KP
ORDER BY KP
</cfquery>

<!--- removed for 2010, no longer used
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="RD">
SELECT RD.ID, RD.KPID, RD.RDNumber, RD.RD, KP.KP, KP.ID
FROM RD, KP
WHERE KP.ID = RD.KPID
ORDER BY KP.KP, RD.RD
</CFQUERY>
--->

<cflock scope="SESSION" timeout="60">
	<cfif URL.AuditedBy neq "Medical" AND URL.AuditedBy neq "UL Environment">
		<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
		SELECT * FROM IQAtblOffices
		WHERE Exist <> 'No'
		AND CB = 'No'
		AND SuperLocation = 'No'
		<cfif SESSION.Auth.AccessLevel NEQ "SU"
			AND SESSION.Auth.AccessLevel NEQ "Admin"
			AND SESSION.Auth.AccessLevel NEQ "IQAAuditor">
			<cfif isDefined("SESSION.Auth.SubRegion") AND len(SESSION.Auth.SubRegion)>
				AND SubRegion = '#SESSION.Auth.SubRegion#'
			<cfelse>
				AND Region = '#SESSION.Auth.Region#'
			</cfif>
		</cfif>
		ORDER BY OfficeName
		</cfquery>
	<cfelse>
		<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
		SELECT * FROM IQAtblOffices
		WHERE Exist <> 'No'
		AND CB = 'No'
		AND SuperLocation = 'No'
		ORDER BY OfficeName
		</cfquery>
	</cfif>
		
	<CFQUERY BLOCKFACTOR="100" NAME="CBAudits" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT * FROM CBAudits
	ORDER BY Name
	</cfquery>

	<CFQUERY BLOCKFACTOR="100" NAME="Auditor" Datasource="Corporate">
	SELECT *
    FROM AuditorList
	WHERE (Status = 'Active' OR Status = 'In Training')
    <!---
	<cfif SESSION.Auth.AccessLevel NEQ "SU"
		AND SESSION.Auth.AccessLevel NEQ "Admin"
		AND SESSION.Auth.AccessLevel NEQ "IQAAuditor"
		AND SESSION.Auth.AccessLevel NEQ "Field Services">
		<cfif isDefined("SESSION.Auth.SubRegion")>
            AND SubRegion = '#SESSION.Auth.SubRegion#'
        </cfif>
	</cfif>
    --->

	<!--- Corporate removed from below if statement 9/28/2014 --->
	<cfif form.e_audittype2 is "Program"
		OR form.e_audittype2 is "Local Function"
		OR form.e_audittype2 is "Local Function FS"
		OR form.e_audittype2 is "Global Function/Process"
		OR form.e_audittype2 is "Certification Body (CB) Audit"
		OR form.e_audittype2 is "Scheme Documentation Audit">
		AND QUALIFIED LIKE '%Quality System%'
		
		<cfif form.auditedby eq "IQA">
			AND IQA = 'Yes'
		</cfif>
	
	<cfelseif form.e_audittype2 is "Local Function CBTL">
		AND QUALIFIED LIKE '%CBTL%'
	<cfelse>
		AND QUALIFIED LIKE '%#form.e_audittype2#%'
	</cfif>
    <cfif url.AuditedBy NEQ "IQA">
        <!--- Adding an audit for another region --->
	<cfif isDefined("SESSION.Auth.SubRegion") AND len(SESSION.Auth.SubRegion)>
	        AND SubRegion = '#SESSION.Auth.SubRegion#'		
	<cfelse>
		AND Region = '#SESSION.Auth.Region#'
    	</cfif>

        <!--- /// --->
    </cfif>
	ORDER BY <cfif url.AuditedBy eq "IQA">IQA DESC,</cfif> Auditor
	</cfquery>
</cflock>

<br>
<div align="Left" class="blog-time">
Schedule/Edit an Audit Help - <A HREF="javascript:popUp('../webhelp/webhelp_scheduleaudit.cfm')">[?]</A></div>

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="addaudit2.cfm">
<cfoutput>
<input type="hidden" name="AuditedBy" value="#FORM.AuditedBy#">
<!---<cfif form.e_audittype2 is NOT "TPTDP">--->
<input type="hidden" name="AuditType" value="Quality System">

<cfif form.e_audittype2 eq "Scheme Documentation Audit">
	<input type="hidden" name="AuditType2" value="Program">
<cfelse>
	<input type="hidden" name="AuditType2" value="#form.e_audittype2#">
</cfif>
	
<!---<cfelse>
<input type="hidden" name="AuditType" value="#form.e_audittype2#">
<input type="hidden" name="AuditType2" value="N/A">
</cfif>
--->
</cfoutput>

<cfoutput>
<cfset maxyear = #curyear# + 3>
</cfoutput>

Audit Year: (required)<br>
<SELECT NAME="e_Year" displayname="Year">
		<option value="">Select Year Below
		<option value="">---
<cfloop index="i" to="#maxyear#" from="#lastyear#">
		<cfoutput><OPTION VALUE="#i#">#i#</cfoutput>
</cfloop>
</SELECT>
<br><br>

Month Scheduled: (required)<br>
<SELECT NAME="e_Month" displayname="Month">
		<option value="">Select Month Below
		<option value="">---
<cfloop index="i" to="12" from="1">
		<cfoutput><OPTION VALUE="#i#">#MonthAsString(i)#</cfoutput>
</cfloop>
</SELECT>
<br><br>

Start Date (please use this format - mm/dd/yyyy)<br>
<INPUT TYPE="Text" NAME="StartDate" VALUE="" onChange="return ValidateSDate()"><br><br>

<cfif form.e_audittype2 is NOT "Global Function/Process">
End Date (please use this format - mm/dd/yyyy)<br>
<INPUT TYPE="Text" NAME="EndDate" VALUE="" onChange="return ValidateEDate()"><br><br>
<cfelse>
* - End Date is not recorded for a Global Document Desk Audit, the Audit Report date will be used as the End Date.<br><br>
<INPUT TYPE="hidden" NAME="EndDate" VALUE="">
</cfif>

<cfif form.e_audittype2 is "Field Services">
Area(s) to be Audited: (this will be listed on the audit schedule)<br>
<INPUT TYPE="Text" NAME="e_AuditArea" size="125" VALUE="" displayname="Audit Area"><br><br>

Field Service Location:
<br>
<SELECT NAME="e_FUS" displayname="Field Service Location">
			<OPTION VALUE="">Select Location Below
			<OPTION VALUE="">---
<CFOUTPUT QUERY="FUS">
		<OPTION VALUE="#Area#">#Area#
</CFOUTPUT>
</SELECT>
<br><br>

<cfelse>
	<cfif URL.AuditedBy is "IQA">
		Business Unit(s) Audited: (Select at least one - hold control to select more than one)<br />
		<SELECT NAME="BusinessUnit" multiple="multiple" size="5">
			<OPTION VALUE="Commercial and Industrial" selected="Selected">Commercial and Industrial (Default)</OPTION>
			<OPTION VALUE="Consumer">Consumer</OPTION>
			<OPTION VALUE="Ventures/UL Software">Ventures/UL Software</OPTION>
		</SELECT><br /><br />
	</cfif>

Area(s) to be Audited: (this will be listed on the audit schedule)<br>
<cfif form.e_audittype2 is "Field Services">
	<INPUT TYPE="Text" NAME="e_AuditArea" size="125" VALUE="" displayname="Audit Area"><br><br>
<cfelseif form.e_audittype2 is "Local Function CBTL">
	<input type="hidden" name="e_AuditArea" Value="Processes, Labs, and CBTL">
	Processes, Labs, and CBTL<br><br>
<cfelse>
	<cfif CBAudit eq "Yes">
		<INPUT TYPE="Hidden" NAME="e_AuditArea" VALUE="Certification Body (CB) Audit">
		Certification Body (CB) Audit<br><br>
	<cfelseif form.e_audittype2 is "Scheme Documentation Audit">
		<INPUT TYPE="Hidden" NAME="e_AuditArea" VALUE="Scheme Documentation Audit">
		Scheme Documentation Audit<br><br>
	<cfelse>
		<INPUT TYPE="Text" NAME="e_AuditArea" size="75" VALUE="" displayname="Audit Area"><br><br>
	</cfif>
</cfif>

UL Location:
<!--- removed for 2015
<cfif form.e_audittype2 is "Corporate">
	<input type="hidden" name="OfficeName" Value="Corporate">
	Corporate
--->
<cfif form.e_audittype2 is "Global Function/Process">
	<input type="hidden" name="OfficeName" Value="Global">
	Global
<cfelseif form.e_audittype2 is "Program" OR form.e_AuditType2 is "Scheme Documentation Audit">
	<u>Location will be determined based on the Program selected on the next page</u>
<Cfelseif CBAudit is "Yes">
	<br>
	<Select Name="OfficeName">
		<cfoutput query="CBAudits">
			<OPTION VALUE="#Name#">#Name#
		</cfoutput>
	</select>
<cfelse>
	<br>
    <cflock scope="SESSION" timeout="60">
        <SELECT NAME="OfficeName">
        <CFOUTPUT QUERY="OfficeName">
            <cfif OfficeName NEQ "test location">
	            <OPTION VALUE="#OfficeName#">#OfficeName#
        	<cfelse>
            	<cfif SESSION.Auth.AccessLevel is "SU">
                	<OPTION VALUE="#OfficeName#">#OfficeName#
                </cfif>
			</cfif>
		</CFOUTPUT>
        </SELECT>
    </cflock>
</cfif>
<br><br>
</cfif>

<cfif form.e_audittype2 is NOT "Field Services">
Is this a Desk Audit?<br>
Yes <INPUT TYPE="Radio" name="Desk" value="1"> No <INPUT TYPE="Radio" name="Desk" value="0" checked><br><br>
</cfif>

<cflock scope="SESSION" timeout="60">
	<cfif SESSION.Auth.AccessLevel is "IQAAuditor">
        <cfoutput>
        <input type="hidden" name="e_LeadAuditor" value="#Session.Auth.Name#">
        Lead Auditor:<br>
        #Session.Auth.Name#
        </cfoutput>
    <cfelse>
        Lead Auditor: (required)<br>
        <SELECT NAME="e_LeadAuditor" displayname="Lead Auditor">
                <OPTION value="">Select Below
                <OPTION value="">---
			<CFOUTPUT QUERY="Auditor">
                <cfif AuditedBy eq "IQA">
					<cfif Lead eq "Yes" AND Status eq "Active" AND IQA eq "Yes">
                        <OPTION VALUE="#Auditor#" <cfif Auditor eq SESSION.Auth.Name>selected</cfif>>#Auditor#
                    </cfif>
				<cfelseif AuditedBy neq "IQA" AND AuditedBy neq "Field Services">
					<cfif Lead eq "Yes" AND Status eq "Active">
                        <OPTION VALUE="#Auditor#" <cfif Auditor eq SESSION.Auth.Name>selected</cfif>>#Auditor#
                    </cfif>
				<cfelse>
                	<cfif Status eq "Active">
	                    <OPTION VALUE="#Auditor#" <cfif Auditor eq SESSION.Auth.Name>selected</cfif>>#Auditor#
					</cfif>
                </cfif>
            </CFOUTPUT>
        </SELECT>
    </cfif>
</cflock>
<br><br>

Auditor:<br>
<SELECT NAME="Auditor" multiple="multiple">
		<OPTION value="- None -" selected>- None -
		<OPTION value="- None -">---
		<CFOUTPUT QUERY="Auditor">
            <cfif Status eq "Active">
                <OPTION VALUE="#Auditor#">#Auditor#
			</cfif>
        </CFOUTPUT>
</SELECT>
<br><br>

Auditors In Training:<br>
<SELECT NAME="AuditorInTraining" multiple="multiple">
		<OPTION value="- None -" selected>- None -
		<OPTION value="- None -">---
	<CFOUTPUT QUERY="Auditor">
        <cfif Status eq "In Training">
            <OPTION VALUE="#Auditor#">#Auditor#
		</cfif>
    </CFOUTPUT>
</SELECT>
<br><br>

<!--- SME and Audit Days --->
<cfif URL.AuditedBy eq "IQA">
Audit Days - Number of On-Site Days: (required)<br>
<SELECT NAME="e_AuditDays" displayname="Audit Days">

	<option value="">Select Audit Days
	<option value="">---
	<cfloop index="i" to="10" from="1">
		<cfoutput><OPTION VALUE="#i#">#i#</cfoutput>
	</cfloop>
</SELECT><br><br>

<CFQUERY Name="SME" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM SME
WHERE Status IS NULL
ORDER BY SME
</cfquery>

Subject Matter Expert: (SME)<br>
<SELECT NAME="SME">
		<OPTION value="- None -" selected>- None -
		<OPTION value="- None -">---
	<CFOUTPUT QUERY="SME">
	    <OPTION VALUE="#SME#">#SME#
    </CFOUTPUT>
</SELECT>
<br><br>
</cfif>

<!---<cfif form.e_audittype2 is "TPTDP">

Third Party:
<br>
<SELECT NAME="e_ExternalLocation" displayname="TPTDP Client">
		<OPTION VALUE="">Select TPTDP Client
		<OPTION VALUE="">---
<CFOUTPUT QUERY="ExternalLocation">
		<OPTION VALUE="#ExternalLocation#">#ExternalLocation#
</CFOUTPUT>
</SELECT>
<br><br>

Scope:<br>
<textarea WRAP="PHYSICAL" ROWS="4" COLS="70" NAME="e_Scope" Value="1.Verify the effective implementation of  CARs from the previous audit.<br>2. See specific scope letter for additional details." displayname="Scope">1.Verify the effective implementation of  CARs from the previous audit.<br>2. See specific scope letter for additional details.</textarea><br><br>

<cfelse>
--->

Primary Contact ('To' field of Scope Letter: external email address - ONE person)<br>
- Audit notification will be sent to this person<br>
<INPUT TYPE="Text" NAME="e_Email" size="125" VALUE="" displayname="Primary Contact"><br>
:: <a href="http://intranet.ul.com/ULSearch/Pages/people.aspx" target="_Blank">Look Up Email</a> - Use UL External Email addresses Only<br><br>
<!---
:: <a href="javascript:popUp('EmailLookup.cfm')">Lookup</a> Email Addresses<br /><br>
--->

Other Contacts ('CC' field of Scope Letter: external email addresses)<br>
- Audit notification will be sent to this person or persons (commas between the addresses)<br>
<INPUT TYPE="Text" NAME="Email2" size="125" VALUE="" displayname="Other Contacts"><br>
:: <a href="http://intranet.ul.com/ULSearch/Pages/people.aspx" target="_Blank">Look Up Email</a> - Use UL External Email addresses Only<br><br>
<!---
:: <a href="javascript:popUp('EmailLookup.cfm')">Lookup</a> Email Addresses<br /><br>
--->

<!---
    Key Processes:<br>
    <SELECT NAME="KP" multiple="multiple">
        <OPTION VALUE="- None -" SELECTED>- None -
    <CFOUTPUT QUERY="KP">
            <OPTION VALUE=" #KP#">#KP#
    </CFOUTPUT>
    </SELECT>
    <br><br>
--->

Reference Documents:<Br />
Corrective Action Request Process (00-QA-S0006)<Br />
Handling Data Backup and Retention Policy (00-IT-P0829)<Br />
UL Global Quality Manual (00-QA-P0001)<Br />
Global Records Policy (00-QA-P0026)<Br />
Document Management SOP (00-QA-S0003)<Br /><Br />

<b>Note</b>: <u>Please add additional Reference Documents to Attachment A of the Scope Letter.</u><br><br>

<!--- removed for 2010, no longer used
<cfset KPHolder = "">
<SELECT NAME="RD" multiple="multiple" size="8">
<option value="- None -" SELECTED>- None -
<option>
<CFOUTPUT Query="RD">
<cfif KPHolder IS NOT KPID>
<cfIf KPHolder is NOT "">
<option>
</cfif>
<option value="- None -!!">#KP#
</cfif>
<OPTION VALUE="#RD# (#RDNumber#)!!">&nbsp;&nbsp;- #RD# (#RDNumber#)
<cfset KPHolder = KPID>
</CFOUTPUT>
</SELECT>
<br><br>
--->

Scope:<br>
The Scope will be automatically added to the Audit.
<!---
<cfif curyear gte 2008>
<textarea WRAP="PHYSICAL" ROWS="17" COLS="90" NAME="e_Scope" displayname="Scope" Value="1. The scope of the assessment includes verifying implementation of  UL's Quality Management System as described in the Global Quality Manaual, 00-QA-P0001.  Additional functional, local and or program policies/procedures will also be utilized.  Specifics on the scope of this assessment are described in Attachment A. These logistics will be addressed during pre-audit communications and/or during the Opening Sessions at each location.<br>2. Verify the effective implementation of previously closed CARs (internal and accreditor).<br>3. Review any progress on open CARs.<br>4. Ensure that documents used are under the document control system.<br>5. Verify that documentation released since the last audit was conducted, meets the applicable UL and ISO 17025, ISO 17020, Guide 65, or ISO 17021 requirements.<br>6. See specific scope letter for additional details." displayname="Scope">1. The scope of the assessment includes verifying implementation of  UL's Quality Management System as described in the Global Quality Manaual, 00-QA-P0001. Additional functional, local and or program policies/procedures will also be utilized.  Specifics on the scope of this assessment are described in Attachment A. These logistics will be addressed during pre-audit communications and/or during the Opening Sessions at each location.
2. Verify the effective implementation of previously closed CARs (internal and accreditor).
3. Review any progress on open CARs.
4. Ensure that documents used are under the document control system.
5. Verify that documentation released since the last audit was conducted, meets the applicable UL and ISO 17025, ISO 17020, Guide 65, or ISO 17021 requirements.
6. See specific scope letter for additional details.
</textarea>
<cfelse>
<textarea WRAP="PHYSICAL" ROWS="17" COLS="90" NAME="e_Scope" displayname="Scope" Value="1. The scope of the assessment includes verifying implementation of the following UL Policies/Procedures: Conformity Assessment Manual (CAM), Global Testing Laboratory Policy (GTLP), Global Product Certification Policy (GPCP), and the Global Inspection Policy (GIP). Additional functional, local and or program policies/procedures will also be utilized.  Specifics on the scope of this assessment are described in Attachment A. We recognize that some policies/procedures may not be applicable to all locations. These logistics will be addressed during pre-audit communications and/or during the Opening Sessions at each location.<br>2.Verify the effective implementation of previously closed CARs (internal and accreditor).<br>3. Review any progress on open CARs.<br>4. Ensure that documents used are under the document control system.<br>5. Verify that documentation released since the last audit was conducted, meets the applicable UL and ISO 17025, ISO 17020, Guide 65, or ISO 17021 requirements. <br>6. See specific scope letter for additional details." displayname="Scope">1. The scope of the assessment includes verifying implementation of the following UL Policies/Procedures: Conformity Assessment Manual (CAM), Global Testing Laboratory Policy (GTLP), Global Product Certification Policy (GPCP), and the Global Inspection Policy (GIP). Additional functional, local and or program policies/procedures will also be utilized.  Specifics on the scope of this assessment are described in Attachment A. We recognize that some policies/procedures may not be applicable to all locations. These logistics will be addressed during pre-audit communications and/or during the Opening Sessions at each location.
2. Verify the effective implementation of previously closed CARs (internal and accreditor).
3. Review any progress on open CARs.
4. Ensure that documents used are under the document control system.
5. Verify that documentation released since the last audit was conducted, meets the applicable UL and ISO 17025, ISO 17020, Guide 65, or ISO 17021 requirements.
6. See specific scope letter for additional details.
</textarea>
--->
<br><br>

Notes:<br>
<textarea WRAP="PHYSICAL" ROWS="4" COLS="90" NAME="Notes" Value=""></textarea><br><br>

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">

</FORM>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->