<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Scope Letter Sent">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<!--- check if IQA, add to confirm table --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Check">
SELECT AuditedBy, Year_ AS Year
FROM AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cflock scope="Session" timeout="5">
	<cfif Check.AuditedBy eq "IQA">
		<cfif Check.year GTE 2016>
			<CFQUERY BLOCKFACTOR="100" name="Time" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			INSERT INTO IQAScopeConfirm(ID, Year_, Confirm, Auditor)
			VALUES(#URL.ID#, #URL.Year#, 'Checked', '#SESSION.Auth.Username#')
			</cfquery>
		</cfif>
	</cfif>
</cflock>


<cfQUERY Datasource="Corporate" Name="Check">
SELECT * FROM Scope
WHERE ID = #URL.ID#
AND YEAR_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<cfif check.recordcount is 0>
    <CFQUERY blockfactor="100" Datasource="Corporate" Name="SelectAudit">
    SELECT AuditSchedule.ID,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.AuditedBy, AuditSchedule.OfficeName, AuditSchedule.StartDate,
	AuditSchedule.EndDate, AuditSchedule.LeadAuditor, AuditSchedule.Auditor as Aud, AuditSchedule.Area, AuditSchedule.AuditType2,
	AuditSchedule.AuditType, AuditSchedule.AuditArea, AuditSchedule.Scope, AuditSchedule.Report, AuditSchedule.Plan, AuditSchedule.ScopeLetter,
	AuditSchedule.FollowUp, AuditSchedule.Status, AuditSchedule.RescheduleStatus, AuditSchedule.Approved, AuditSchedule.KP, AuditSchedule.RD,
	AuditSchedule.Notes, AuditSchedule.RescheduleNotes, AuditSchedule.Month, AuditSchedule.Email, AuditSchedule.Email2, AuditSchedule.RescheduleNextYear,
	AuditSchedule.Agenda, AuditSchedule.ASContact, AuditSchedule.SiteContact, AuditSchedule.ScopeLetterDate, AuditorList.Auditor, AuditorList.Phone,
	AuditorList.Email, auditschedule.desk, Auditschedule.SME

    FROM AuditSchedule, AuditorList
    WHERE AuditSchedule.YEAR_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    AND AuditSchedule.ID = #URL.ID#
    AND AuditSchedule.LeadAuditor = AuditorList.Auditor
    </CFQUERY>

	<cfset CurDate = #Dateformat(now(), 'mm/dd/yyyy')#>
    <cfset CurYear = #Dateformat(now(), 'yyyy')#>

    <CFQUERY Datasource="Corporate" Name="EnterScope">
    INSERT INTO Scope(ID, Year_)
    VALUES (#URL.ID#, <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">)
    </CFQUERY>

	<cfif Form.e_AttachA is NOT "">
        <CFFILE ACTION="UPLOAD"
        FILEFIELD="e_AttachA"
        DESTINATION="#IQARootPath#ScopeLetters\Temp"
        NAMECONFLICT="OVERWRITE">

        <!--- removed oct 9 2009
        accept="application/pdf, application/x-zip-compressed, application/msword"
        --->

        <cfset FileName="#Form.e_AttachA#">

        <cfset NewFileName="#URL.Year#-#URL.ID#-Attach.#cffile.ClientFileExt#">

        <cffile
            action="rename"
            source="#FileName#"
            destination="#IQARootPath#ScopeLetters\Temp\#NewFileName#">

        <cffile
            action="move"
            source="#IQARootPath#ScopeLetters\Temp\#NewFileName#"
            destination="#IQARootPath#ScopeLetters\">
    </cfif>

    <CFQUERY Datasource="Corporate" Name="EnterScope">
    UPDATE Scope
    SET

    AttachA='#NewFileName#',
    Name='#Form.Name#',
    Title='#Form.Title#',
    ContactEmail='#Form.ContactEmail#',
    Phone='#Form.Phone#',
    <cfif SelectAudit.AuditType2 is "Field Services">
    StartTime=#CreateODBCTime(Form.StartTime)#,
    </cfif>
    <cfif len(form.cc)>
    cc='#form.cc#',
    </cfif>
    AuditorEmail='#Form.AuditorEmail#',
    Auditor='#SelectAudit.LeadAuditor#',
    DateSent=#CreateODBCDate(CurDate)#

    WHERE ID = #URL.ID#
    AND YEAR_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    </cfquery>

    <CFQUERY Datasource="Corporate" Name="ScopeEntered">
    UPDATE AuditSchedule
    SET

    ScopeLetter = 'Entered',
    StartDate = #CreateODBCDate(Form.StartDate)#,
    <cfif Form.EndDate is "" or Form.EndDate eq Form.StartDate>
    EndDate = #CreateODBCDate(Form.StartDate)#,
    <cfelse>
    EndDate = #CreateODBCDate(Form.EndDate)#,
    </cfif>
    ScopeLetterDate = #CreateODBCDate(CurDate)#

    WHERE ID = #URL.ID#
    AND YEAR_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    </cfquery>

    <CFQUERY blockfactor="100" Datasource="Corporate" Name="Scope">
    SELECT AuditSchedule.ID,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.AuditedBy, AuditSchedule.OfficeName, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.LeadAuditor, AuditSchedule.Auditor As Aud, AuditSchedule.Area, AuditSchedule.AuditType2, AuditSchedule.AuditType, AuditSchedule.AuditArea, AuditSchedule.Scope, AuditSchedule.Report, AuditSchedule.Plan, AuditSchedule.ScopeLetter, AuditSchedule.FollowUp, AuditSchedule.Status, AuditSchedule.RescheduleStatus, AuditSchedule.Approved, AuditSchedule.KP, AuditSchedule.RD, AuditSchedule.Notes, AuditSchedule.RescheduleNotes, AuditSchedule.Month, AuditSchedule.Email, AuditSchedule.Email2, AuditSchedule.RescheduleNextYear, AuditSchedule.Agenda, AuditSchedule.ASContact, AuditSchedule.SiteContact, Scope.Title, Scope.Name, Scope.ContactEmail, Scope.Auditor, Scope.Phone, Scope.DateSent, Scope.AttachA, Scope.AuditorEmail, Scope.CC, auditschedule.desk

    FROM AuditSchedule, Scope

    WHERE AuditSchedule.YEAR_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    AND AuditSchedule.ID = #URL.ID#
    AND Scope.ID = #URL.ID#
    AND Scope.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    </CFQUERY>
</cfif>

<!---
<cflocation url="AuditDetails.cfm?ID=#URL.ID#&Year=#URL.Year#" addtoken="No">
--->

<cfif check.recordcount is 0>

<cfoutput query="Scope">

<cfif year gte 2008>
	<cfinclude template="#IQARootDIR#IQAScope4.cfm">
<!--- End of New Scope for 2008+ --->
<cfelse>
<cfif url.audittype2 is "Field Services">
	<cfif year lt 2006>
	<cfinclude template="FSTemplate4_old.cfm">
	<cfelseif year is 2006>
		<cfif month lte 8>
		<cfinclude template="FSTemplate4_old.cfm">
		<cfelseif month gte 9>
		<cfinclude template="FSTemplate4.cfm">
		</cfif>
	<cfelseif year gte 2007>
	<cfinclude template="FSTemplate4.cfm">
	</cfif>
<cfelse>
<cfif year lt 2006>
	<cfif url.audittype2 is "Program">
	<cfinclude template="QSwProgTemplate4_old.cfm">
	<cfelseif url.audittype2 is "Corporate" or url.audittype2 is "Local Function" or url.audittype2 is "Local Function FS" or url.audittype2 is "Local Function CBTL" or url.audittype2 is "Global Function/Process">
	<cfinclude template="QSTemplate4_old.cfm">
	</cfif>
<cfelseif year is 2006>
	<cfif month lte 7>
		<cfif url.audittype2 is "Program">
		<cfinclude template="QSwProgTemplate4_old.cfm">
		<cfelseif url.audittype2 is "Corporate" or url.audittype2 is "Local Function" or url.audittype2 is "Local Function FS" or url.audittype2 is "Local Function CBTL" or url.audittype2 is "Global Function/Process">
		<cfinclude template="QSTemplate4_old.cfm">
		</cfif>
	<cfelseif month gte 8>
		<cfif audittype2 is "Program">
		<cfinclude template="QSwProgTemplate4.cfm">
		<cfelseif url.audittype2 is "Corporate" or url.audittype2 is "Local Function" or url.audittype2 is "Local Function FS" or url.audittype2 is "Local Function CBTL" or url.audittype2 is "Global Function/Process">
		<cfinclude template="QSTemplate4.cfm">
		</cfif>
	</cfif>
<cfelseif year gte 2007>
	<cfif url.audittype2 is "Program">
	<cfinclude template="QSwProgTemplate4.cfm">
	<cfelseif url.audittype2 is "Corporate" or url.audittype2 is "Local Function" or url.audittype2 is "Local Function FS" or url.audittype2 is "Local Function CBTL" or url.audittype2 is "Global Function/Process">
	<cfinclude template="QSTemplate4.cfm">
	</cfif>
</cfif>
</cfif>
</cfif>

"Attachment A" File: <a href="#IQARootDir#scopeletters/#AttachA#">#AttachA#</a><br>

<!--- Fix for the PSE Mark difficulties with the cfmail subject line --->
<cfif Area eq "&lt;PS&gt;E Mark (JP) (JP CO)">
    <cfset incArea = "<PS>E Mark (JP) (JP CO)">
<!--- Fix for the PSE Mark difficulties with the cfmail subject line --->
<cfelseif Area eq "&lt;PS&gt;E Mark (JP) (US CO)">
    <cfset incArea = "<PS>E Mark (JP) (US CO)">
<!--- all other programs --->
<cfelse>
    <cfset incArea = "#Area#">
</cfif>
<!--- /// --->

</cfoutput>

<cfif Scope.AuditType2 is "Program">
	<cfmail
	to="#ContactEmail#"
	from="#AuditorEmail#"
	cc="Internal.Quality_Audits@ul.com, #cc#"
	bcc="#AuditorEmail#"
	mimeattach="#IQARootPath#ScopeLetters\#AttachA#"
	subject="Quality System Audit of #Trim(incArea)#"
	query="Scope"
	type="HTML">
<cfif year gte 2008>
	<cfinclude template="#IQARootDir#IQAScope3_HTML.cfm">
<cfelseif year lt 2006>
	<cfinclude template="QSwProgTemplate3_old.cfm">
<cfelseif year is 2006>
	<cfif month lte 7>
		<cfinclude template="QSwProgTemplate3_old.cfm">
	<cfelseif month gte 8>
		<cfinclude template="QSwProgTemplate3.cfm">
	</cfif>
<cfelseif year eq 2007>
	<cfinclude template="QSwProgTemplate3.cfm">
</cfif>
Attached File: #AttachA#
</cfmail>

<cfelseif Scope.AuditType2 is "Field Services">
	<cfmail
	to="#ContactEmail#"
	from="#AuditorEmail#"
	cc="Internal.Quality_Audits@ul.com, #cc#"
	bcc="#AuditorEmail#"
	mimeattach="#IQARootPath#ScopeLetters\#AttachA#"
	subject="Quality System Audit of Field Servies - #trim(incArea)#"
	query="Scope"
	type="HTML">
<cfif year gte 2008>
	<cfinclude template="#IQARootDir#IQAScope3_HTML.cfm">
<cfelseif year lt 2006>
	<cfinclude template="FSTemplate3_old.cfm">
<cfelseif year is 2006>
	<cfif month lte 8>
		<cfinclude template="FSTemplate3_old.cfm">
	<cfelseif month gte 9>
		<cfinclude template="FSTemplate3.cfm">
	</cfif>
<cfelseif year eq 2007>
	<cfinclude template="FSTemplate3.cfm">
</cfif>
Attached File: #AttachA#
</cfmail>

<cfelseif Scope.AuditType2 is "Corporate"
	or Scope.AuditType2 is "Local Function FS"
	or Scope.audittype2 is "Local Function CBTL"
	or Scope.audittype2 is "Global Function/Process">

	<cfmail
	to="#ContactEmail#"
	from="#AuditorEmail#"
	cc="Internal.Quality_Audits@ul.com, #cc#"
	bcc="#AuditorEmail#"
	mimeattach="#IQARootPath#ScopeLetters\#AttachA#"
	subject="Quality System Audit of #Trim(OfficeName)# - #Trim(incArea)#"
	query="Scope"
	type="HTML">
<cfif year gte 2008>
	<cfinclude template="#IQARootDir#IQAScope3_HTML.cfm">
<cfelseif year lt 2006>
	<cfif month lte 7>
        <cfinclude template="QTemplate3_old.cfm">
    <cfelseif month gte 8>
        <cfinclude template="QSTemplate3.cfm">
	</cfif>
<cfelseif year eq 2007>
	<cfinclude template="QSTemplate3.cfm">
</cfif>
Attached File: #AttachA#
</cfmail>

<!--- edited to check for SNAP Sites for Process and Labs audits and send to appropriate contacts --->
<cfelseif Scope.AuditType2 is "Local Function">

<!---
<!--- check if a SNAP Site - if so, cc Bruce Proper and Todd Corriveau - Bruce.R.Proper@ul.com, Todd.L.Corriveau@ul.com --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Super">
SELECT SNAPSite, SuperLocation, ID
FROM IQAtblOffices
WHERE OfficeName = '#Scope.OfficeName#'
</cfquery>

<cfset isSNAPSite = "No">

<CFIF Super.SuperLocation eq "Yes">
    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="SuperLocs">
    SELECT SNAPSite, SuperLocationID, ID, OfficeName
    FROM IQAtblOffices
    WHERE SuperLocationID = #Super.ID#
    ORDER BY OfficeName
    </cfquery>

	<cfif SuperLocs.recordcount GTE 1>
        <cfloop query="SuperLocs">
            <cfif SNAPSite is "Yes">
            	<cfset isSNAPSite = "Yes">
            </cfif>
        </cfloop>
    </cfif>
<cfelse>
    <cfif Super.SNAPSite is "Yes">
		<cfset isSNAPSite = "Yes">
    <cfelse>
    	<cfset isSNAPSite = "No">
    </cfif>
</CFIF>

<cfif Scope.Area eq "Processes and Labs" AND isSNAPSite eq "Yes">
	<cfset SNAPSiteCC = "">
<cfelse>
	<cfset SNAPSiteCC = "">
</cfif>
--->

<cfmail
	to="#ContactEmail#"
	from="#AuditorEmail#"
	cc="Internal.Quality_Audits@ul.com, #cc#"
	bcc="#AuditorEmail#"
	mimeattach="#IQARootPath#ScopeLetters\#AttachA#"
	subject="Quality System Audit of #Trim(OfficeName)# - #Trim(incArea)#"
	query="Scope"
	type="HTML">
<cfif year gte 2008>
	<cfinclude template="#IQARootDir#IQAScope3_HTML.cfm">
<cfelseif year lt 2006>
	<cfif month lte 7>
        <cfinclude template="QTemplate3_old.cfm">
    <cfelseif month gte 8>
        <cfinclude template="QSTemplate3.cfm">
    </cfif>
<cfelseif year eq 2007>
	<cfinclude template="QSTemplate3.cfm">
</cfif>
Attached File: #AttachA#
</cfmail>

<!--- New Scope 4/17/2009 to include MMS --->
<cfelseif Scope.audittype2 is "MMS - Medical Management Systems">

	<cfmail
	to="#ContactEmail#"
	from="#AuditorEmail#"
	cc="Internal.Quality_Audits@ul.com, #cc#"
	bcc="#AuditorEmail#"
	mimeattach="#IQARootPath#ScopeLetters\#AttachA#"
	subject="Quality System Audit of #AuditType2#"
	query="Scope"
	type="HTML">
    <cfinclude template="#IQARootDir#IQAScope3_HTML.cfm">
	    Attached File: #AttachA#
    </cfmail>
</cfif>

<cfelse>

<cfoutput>
#URL.Year#-#URL.ID# Scope has already been sent.<br><br>
<a href="#IQARootDir#scopeletter_view.cfm?year=#url.year#&id=#url.id#">
View</a> Scope Letter
</cfoutput>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->