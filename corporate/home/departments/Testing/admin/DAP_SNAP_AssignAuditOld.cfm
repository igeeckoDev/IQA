<!--- get office name from url variable AuditOfficeNameID --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Office">
SELECT OfficeName 
FROM IQAtblOffices
WHERE ID = #URL.AuditOfficeNameID#
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="OSHA SNAP Audits - Assign Auditor - #URL.AuditYear#-#URL.AuditID#: #Office.OfficeName#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif isDefined("Form.Submit")>

<!--- Update fields to assign auditor --->
<CFQUERY Name="Assign" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE xSNAPData
SET

AssignedTo = <cfif Form.Auditors eq "null">null<cfelse>'#FORM.Auditors#'</cfif>,
DueDate = #CreateODBCDate(Form.DueDate)#

WHERE 
AuditYear = #URL.AuditYear#
AND AuditID = #URL.AuditID#
And AuditOfficeNameID = #URL.AuditOfficenameID#
</CFQUERY>

<!--- Determine if audit is in first or second half of the year --->
<CFQUERY Datasource="UL06046" NAME="Month" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	AuditMonth
FROM 
	xSNAPDATA
WHERE 
	AuditYear = #URL.AuditYear#
AND AuditID = #URL.AuditID#
And AuditOfficeNameID = #URL.AuditOfficenameID#
</cfquery>

<!--- set half variable for cflocation tag --->
<cfif Month.AuditMonth LTE 6>
	<cfset Half = 1>
<cfelseif Month.AuditMonth GTE 7>
	<cfset Half = 2>
</cfif>

<!--- get office name --->
<CFQUERY Datasource="Corporate" NAME="Office">
SELECT OfficeName 
FROM IQAtblOffices
WHERE ID = #URL.AuditOfficeNameID#
</cfquery>

<cfif len(Form.Auditors)>
	<!--- get auditor email address for notification --->
    <CFQUERY Name="AuditorEmail" Datasource="Corporate">
    SELECT Email
    From AuditorList
    WHERE Auditor = '#Form.Auditors#'
    </CFQUERY>
    
    <cfmail	
    	to="#AuditorEmail.Email#"
        from="Internal.Quality_Audits@ul.com"
        bcc="Kai.Huang@ul.com"
        subject="OSHA SNAP Audit Assignment: #URL.AuditYear#-#URL.AuditID#-#URL.AuditOfficeNameID# (#Office.OfficeName#)"
        type="html">
        Audit Completion Due Date: #dateformat(form.DueDate, "mm/dd/yyyy")#<br /><br />
        
        Please contact Cliff Jones with any questions regarding this OSHA SNAP assignment.<br /><br />
	</cfmail>
</cfif>

<!--- redirect to OSHA SNAP Audits - Assignments Page --->
<cflocation url="DAP_SNAP_Audits.cfm?Year=#URL.AuditYear#&Half=#Half#&msg=#AuditYear#-#AuditID# #Office.OfficeName# has been assigned to #Form.Auditors#" addtoken="no">

<cfelse>

<!--- get list of corp iqa auditors --->
<CFQUERY Name="Auditors" Datasource="Corporate">
SELECT ID, Auditor, Status
From AuditorList
WHERE IQA = 'Yes'
ORDER BY Status, Auditor
</CFQUERY>

<!--- Check if there is a value in AssignedTo field. If so, populate the select box --->
<CFQUERY Datasource="UL06046" NAME="Check" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	AssignedTo
FROM 
	xSNAPDATA
WHERE 
	AuditYear = #URL.AuditYear#
AND AuditID = #URL.AuditID#
AND AuditOfficeNameID = #URL.AuditOfficenameID#

GROUP BY AssignedTo
</cfquery>

<!--- build form --->
<cfform action="DAP_SNAP_AssignAudit.cfm?#CGI.Query_String#">

<!--- auditor drop down ---->
Select Auditor:<Br>
<cfselect name="Auditors" required="Yes" message="Please select an Auditor">
	<option>Select Auditor Below</option>
    <option>---</option>
    <!--- If there is a value in AssignedTo field already, display it --->
   	<cfif isDefined("Check.AssignedTo")>
    	<cfoutput>
       		<option value="#Check.AssignedTo#" selected="selected">#Check.AssignedTo#</option>
		</cfoutput>
	</cfif>
	<!--- show auditor list --->
    <cfoutput query="Auditors">
    	<option value="#Auditor#">#Auditor#<cfif Status NEQ "Active"> (#Status#)</cfif></option>        
	</cfoutput>
    <option value="null">None (Remove Assignment)</option>
</cfselect><br><br>

Set Due Date:<br />
<div style="position:relative; z-index:3">
<cfinput type="datefield" name="DueDate" required="yes" message="Please include the due date" validate="date">
</div>

<br /><br />

<cfinput type="Submit" name="Submit" value="Assign Auditor">

</cfform>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->