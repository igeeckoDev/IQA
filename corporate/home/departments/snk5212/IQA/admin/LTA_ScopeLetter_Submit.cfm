<cfoutput>
	<cfif NOT isdefined("Form.e_AttachA")>
		<cflocation url="LTA_ScopeLetter_Send.cfm?#CGI.Query_String#&validate=No Attachment" addtoken="no">
	<cfelseif isDefined("Form.e_AttachA") AND NOT len(Form.e_AttachA)>
		<cflocation url="LTA_ScopeLetter_Send.cfm?#CGI.Query_String#&validate=No Attachment" addtoken="no">
	</cfif>
</cfoutput>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Laboratory Technical Audit - Scope Letter Sent">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfQUERY Datasource="Corporate" Name="Check">
SELECT * FROM Scope
WHERE 
	ID = #URL.ID# 
	AND YEAR_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<cfif check.recordcount GT 0>
	<cfoutput>
    #URL.Year#-#URL.ID# Scope has already been sent.<br><br>
    <a href="LTA_ScopeLetter_View.cfm?year=#url.year#&id=#url.id#">
    View</a> Scope Letter
    </cfoutput>
<cfelse>

<CFQUERY BLOCKFACTOR="100" name="Details" Datasource="Corporate">
SELECT 
	AuditSchedule.*, AuditSchedule.Year_ as Year, Auditors_LTA.Auditor as AuditorName, Auditors_LTA.Email as AuditorEmail
FROM 
	AuditSchedule, Auditors_LTA
WHERE 
	AuditSchedule.ID = #URL.ID#
	AND AuditSchedule.Year_ = #URL.Year#
    AND AuditSchedule.Auditor = Auditors_LTA.Auditor
</CFQUERY>

<!--- Add Scope Letter record in Scope Table --->
<CFQUERY Datasource="Corporate" Name="EnterScope">
INSERT INTO Scope(ID, Year_)
VALUES (#URL.ID#, #URL.Year#)
</CFQUERY>

<!--- Ensure that Attachment A exists --->
<cfif Form.e_AttachA is NOT "">

<!--- Upload File and Rename to Year-ID-Attach.zip/pdf --->
<CFFILE ACTION="UPLOAD" 
FILEFIELD="e_AttachA" 
DESTINATION="#IQARootPath#ScopeLetters\" 
NAMECONFLICT="OVERWRITE">

<cfset FileName="#Form.e_AttachA#">

<cfset NewFileName="#URL.Year#-#URL.ID#-Attach.#cffile.ClientFileExt#">
 
<cffile
    action="rename"
    source="#FileName#"
    destination="#IQARootPath#ScopeLetters\#NewFileName#">
	
</cfif>

<!--- Add data to Scope Table --->
<CFQUERY Datasource="Corporate" Name="EnterScope">
UPDATE Scope
SET

AttachA='#NewFileName#',
<!---
Name='#Form.Name#',
Title='#Form.Title#',
--->
Name='#Details.EmailName#',
ContactEmail='#Details.Email#',
<!---
Phone='#Form.Phone#',
--->
<cfif len(Details.Email2)>
	cc='#Details.Email2#',
</cfif>
AuditorEmail='#Details.AuditorEmail#',
Auditor='#Details.AuditorName#',
DateSent=#CreateODBCDate(CurDate)#

WHERE 
ID = #URL.ID# 
AND YEAR_ = #URL.Year#
</cfquery>

<!--- update AuditSchedule Table with Scope Letter status and sent date --->
<CFQUERY Datasource="Corporate" Name="ScopeEntered">
UPDATE AuditSchedule
SET

ScopeLetter = 'Entered',
ScopeLetterDate = #CreateODBCDate(CurDate)#

WHERE 
ID = #URL.ID# 
AND YEAR_ = #URL.Year#
</cfquery>

<CFQUERY blockfactor="100" Datasource="Corporate" Name="Scope"> 
SELECT AuditSchedule.ID,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.AuditedBy, AuditSchedule.OfficeName, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.Auditor, AuditSchedule.AuditArea, AuditSchedule.Email, AuditSchedule.Email2, Scope.ContactEmail, Scope.Auditor as AuditorName, Scope.DateSent, Scope.AttachA, Scope.AuditorEmail, Scope.CC, Scope.Name

FROM AuditSchedule, Scope

WHERE AuditSchedule.YEAR_ = #URL.Year#
AND AuditSchedule.ID = #URL.ID#
AND Scope.ID = #URL.ID#
AND Scope.Year_ = #URL.Year#
</CFQUERY>

	<cfmail 
	to="#ContactEmail#" 
	from="Todd.L.Corriveau@ul.com" 
	cc="#AuditorEmail#, #cc#" 
	bcc="#AuditorEmail#, Todd.L.Corriveau@ul.com, Bruce.R.Proper@ul.com"
	mimeattach="#IQARootPath#ScopeLetters\#AttachA#"
	subject="Laboratory Technical Audit of #OfficeName# - #AuditArea#" 
	query="Scope"><cfinclude template="LTA_Scope_Email.cfm">
"Attachment A" File: #AttachA#

    </cfmail>

<cflocation url="LTA_ScopeLetter_View.cfm?#CGI.QUERY_STRING#" addtoken="no">

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->