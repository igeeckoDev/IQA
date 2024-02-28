<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - SR/CAR Closure Information">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<CFQUERY NAME="SRCAR" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM TechnicalAudits_SRCAR
WHERE AuditID = #URL.ID#
AND AuditYear = #URL.Year#
</CFQUERY>

<b>SR / CAR Information Entered</b><br />

<table border="1">
<tr>
    <th align="center">Issue Type</th>
    <th align="center">Number</th>
    <th align="center">Due Date</th>
    <th align="center">Additional SR/CAR Numbers</th>
</tr>
<cfoutput query="SRCAR">
<tr>
    <td valign="top">#IssueType#</td>
    <td valign="top">#SRCARNumber#</td>
    <td valign="top">#Dateformat(SRCARClosedDueDate, "mm/dd/yyyy")#</td>
    <td valign="top"><cfif len(SRCAR_AdditionalNumbers)>#replace(SRCAR_AdditionalNumbers, ",", "<br />", "All")#<cfelse>N/A</cfif></td>
</tr>
</cfoutput>
</table><br /><br />

<cfoutput>
<form action="TechnicalAudits_SRCAR_StatusUpdate_Action.cfm?#CGI.Query_String#&Action=Corrective Actions Completed" enctype="multipart/form-data" method="post">

<b>Is the #SRCAR.IssueType# (#SRCAR.SRCARNumber#) Closed?</b><br />
Yes <input type="checkbox" name="YesNoItem" value="Yes" /> No <input type="checkbox" name="YesNoItem" value="No" /><br /><br />

If Yes, Upload Audit Report:<br />
[file upload placeholder]<br /><br />

<input type="File" size="50" name="File"><br><br />
    
<cfif isDefined("Form.EmpNo")>
	<input type="hidden" name="EmpNo" value="#Form.EmpNo#" />
</cfif>

<input type="Submit" name="upload" value="Update #SRCAR.IssueType# Information">
</form>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->