<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "ULE - Edit Audit #URL.Year#-#URL.ID#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
SELECT * FROM IQAtblOffices
WHERE Exist = 'Yes'
AND Finance = 'Yes'
AND Physical = 'Yes'
AND ULE = 'Yes'
ORDER BY OfficeName
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Auditor" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM Auditors
WHERE Status IS NULL
AND ID <> 0
AND Type = 'ULE'
ORDER BY Auditor
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="Details" Datasource="Corporate">
SELECT 
	AuditSchedule.*, AuditSchedule.Year_ as Year
FROM 
	AuditSchedule
WHERE 
	AuditSchedule.ID = #URL.ID#
	AND AuditSchedule.Year_ = #URL.Year#
</CFQUERY>

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
    <script language="JavaScript" src="#SiteDir#SiteShared/js/date.js"></script>
    <script language="JavaScript" src="#SiteDir#SiteShared/js/sitePopUp.js"></script>
</cfoutput>

<cfoutput>					  
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="ULE_EditAudit_Submit.cfm?#CGI.QUERY_STRING#">
</cfoutput>

<br>
<cfoutput query="Details">
<b>Audit Year</b>:#Year#<br>

<INPUT TYPE="Hidden" NAME="AuditedBy" VALUE="ULE">
<INPUT TYPE="Hidden" NAME="AuditType" VALUE="ULE">
<INPUT TYPE="Hidden" NAME="AuditType2" VALUE="ULE - Site Audit">

<b>Month Scheduled</b>: #MonthAsString(month)#<br>
<b>Start Date</b>: <cfif len(StartDate)>#dateformat(StartDate, "mmmm dd, yyyy")#<cfelse>None Listed</cfif><br>
<b>End Date</b>: <cfif len(EndDate)>#dateformat(EndDate, "mmmm dd, yyyy")#<cfelse>None Listed</cfif><br><br />

<b>Changing the Audit Month/Dates</b><br>
 :: Please change the Audit Month/Dates via the links under <u>Audit Dates</u> on the <a href="auditdetails.cfm?#CGI.QUERY_STRING#">Audit Details</a> page.<br><Br>

<b>Auditor</b>:<br>
<SELECT NAME="e_Auditor" displayname="Auditor">
	<OPTION VALUE="">Select Auditor
	<option value="">---
    <option value="#Auditor#" selected>#Auditor#
</cfoutput>
<CFOUTPUT QUERY="Auditor">
	<OPTION VALUE="#Auditor#">#Auditor#
</CFOUTPUT>
</SELECT><br><br>

<u>Note</u> - If you do not see the Auditor in the drop down list above, please add the Auditor <a href="Auditors.cfm?Type=ULE">here</a>.<br><br>

<CFOUTPUT QUERY="Details">
<b>Site being Audited</b>:<br>
<SELECT NAME="e_OfficeName" displayname="Site Audited">
	<OPTION VALUE="">Select Site
	<option value="">---
    <option value="#OfficeName#" selected>#OfficeName#	
</cfoutput>
<CFOUTPUT QUERY="OfficeName">
	<OPTION VALUE="#OfficeName#">#OfficeName#
</CFOUTPUT>
</SELECT>
<br><br>

<CFOUTPUT QUERY="Details">
<b>Laboratory Name</b>:<Br />
<INPUT TYPE="TEXT" NAME="e_AuditArea" size="75" VALUE="#AuditArea#" displayname="Laboratory Name"><br /><br />

<!---
Reference Documents/Standards:<br>
* - Hold Ctrl to select multiple items<br>
<Select Name="e_Standards" multiple="multiple" displayname="Standards">
	<Option Value="None" selected>Select Reference Documents/Standards Below
	<Option Value="">---
<cfoutput query="Standards">
	<Option Value="#DocName# (#DocNumber#)!!">#DocName# (#DocNumber#)
</cfoutput>	
</SELECT>
<br><br>
--->

<b>Contacts</b><br />
 :: Please use External UL Email Addresses only. Please use the link below to look up emails.<br />
 :: The contacts below are used to populate the Scope Letter and receive audit notifications.<br />
 :: Primary Contact - Scope Letter - To.<br />
 :: Other Contacts - Scope Letter - cc.<br />
 :: Please separate email addresses with a comma in the 'Other Contacts' field below.<br /><br />

<b>Primary Contact Name</b>:<br />
<INPUT TYPE="TEXT" NAME="e_EmailName" size="75" VALUE="#EmailName#" displayname="Site Contact(s)"><br><br>

<b>Primary Contact Email</b>:<Br />
<INPUT TYPE="TEXT" NAME="e_Email" size="75" VALUE="#Email#" displayname="Site Contact(s)"><br>
:: <a href="javascript:sitePopUp('EmailLookup.cfm')">Lookup</a> Email Addresses<br><br />

<b>Other Contacts</b>:<br />
<INPUT TYPE="TEXT" NAME="Email2" size="75" VALUE="#Email2#"><br>
:: <a href="javascript:sitePopUp('EmailLookup.cfm')">Lookup</a> Email Addresses<br><br />

<b>Notes</b>:<br>
<textarea WRAP="PHYSICAL" ROWS="4" COLS="70" NAME="Notes" Value="">#Notes#</textarea><br><br>
</CFOUTPUT>

<INPUT TYPE="button" value="Save Audit" onClick=" javascript:checkFormValues(document.all('Audit'));">
</FORM>			  

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->