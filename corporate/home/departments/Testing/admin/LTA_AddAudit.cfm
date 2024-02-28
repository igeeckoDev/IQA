<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Laboratory Technical Audit - Add Audit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
SELECT OfficeName
FROM IQAtblOffices
WHERE Exist = 'Yes'
AND Finance = 'Yes'
AND Physical = 'Yes'

UNION

SELECT OfficeName 
FROM IQAtblOffices
WHERE SuperLocation = 'Yes'

ORDER BY OfficeName
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Auditor" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM Auditors
WHERE Status IS NULL
AND ID <> 0
AND Type = 'LTA'
ORDER BY Auditor
</cfquery>

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
    <script language="JavaScript" src="#SiteDir#SiteShared/js/date.js"></script>
    <script language="JavaScript" src="#SiteDir#SiteShared/js/sitePopUp.js"></script>
</cfoutput>
		  
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="LTA_AddAudit_Submit.cfm">

<cfoutput>
<cfset maxyear = #curyear# + 3>
</cfoutput>

<br>
Audit Year: (required)<br>
<SELECT NAME="e_Year" displayname="Year">
		<option value="">Select Year Below
		<option value="">---
<cfloop index="i" to="#maxyear#" from="#curyear#">
		<cfoutput><OPTION VALUE="#i#">#i#</cfoutput>
</cfloop>
</SELECT>
<br><br>

<INPUT TYPE="Hidden" NAME="AuditedBy" VALUE="LAB">
<INPUT TYPE="Hidden" NAME="AuditType" VALUE="Laboratory Technical Audit">
<INPUT TYPE="Hidden" NAME="AuditType2" VALUE="Laboratory Technical Audit">

Month Scheduled: (required)<br>
<SELECT NAME="e_Month" displayname="Month">
	<option value="">Select Month
	<option value="">---
<cfloop index="i" to="12" from="1">
		<cfoutput><OPTION VALUE="#i#">#MonthAsString(i)#</cfoutput>
</cfloop>
</SELECT>
<br><br>

Start Date (please use this format - mm/dd/yyyy)<br>
<INPUT TYPE="Text" NAME="StartDate" VALUE="" onchange="return ValidateSDate()"><br><br>

End Date (please use this format - mm/dd/yyyy)<br>
<INPUT TYPE="Text" NAME="EndDate" VALUE="" onchange="return ValidateEDate()"><br><br>

Auditor: (required)<br>
<SELECT NAME="e_Auditor" displayname="Auditor">
	<OPTION VALUE="">Select Auditor
	<option value="">---	
<CFOUTPUT QUERY="Auditor">
	<OPTION VALUE="#Auditor#">#Auditor#
</CFOUTPUT>
</SELECT><br><br>

<u>Note</u> - If you do not see the Auditor in the drop down list above, please add the Auditor <a href="Auditors.cfm?Type=LTA">here</a>.<br><br>

Site being Audited: (required)<br>
<SELECT NAME="e_OfficeName" displayname="Site Audited">
	<OPTION VALUE="">Select Site
	<option value="">---		
<CFOUTPUT QUERY="OfficeName">
	<OPTION VALUE="#OfficeName#">#OfficeName#
</CFOUTPUT>
</SELECT>
<br><br>

Laboratory Name / Scope of Audit: (required)<Br />
<INPUT TYPE="TEXT" NAME="e_AuditArea" size="75" VALUE="" displayname="Laboratory Name"><br /><br />

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
 :: Primary Contact - Scope Letter - To.<br>
 :: Other Contacts - Scope Letter - cc.<br>
 :: Please separate email addresses with a comma in the 'Other Contacts' field below<br /><br />
 
Primary Contact Name: (required)<br />
<INPUT TYPE="TEXT" NAME="e_EmailName" size="75" VALUE="" displayname="Primary Contact Name"><br><br />

Primary Contact Email: (required)<Br />
<INPUT TYPE="TEXT" NAME="e_Email" size="75" VALUE="" displayname="Primary Contact Email Address"><br>
:: <a href="javascript:sitePopUp('EmailLookup.cfm')">Lookup</a> Email Addresses<br><br />

Other Contacts/Scope Letter 'cc' Field:<br />
<INPUT TYPE="TEXT" NAME="Email2" size="75" VALUE=""><br>
:: <a href="javascript:sitePopUp('EmailLookup.cfm')">Lookup</a> Email Addresses<br><br />

Notes:<br>
<textarea WRAP="PHYSICAL" ROWS="4" COLS="70" NAME="Notes" Value=""></textarea><br><br>

<INPUT TYPE="button" value="Save Audit" onClick=" javascript:checkFormValues(document.all('Audit'));">

</FORM>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->