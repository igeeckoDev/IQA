<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	OfficeName, Industry, AuditType2, CCN, FileNumber, Program, ProjectNumber, RequestType, Standard
FROM 
	TechnicalAudits_AuditSchedule
WHERE
	ID = #URL.ID#
    AND Year_ = #URL.Year#
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Active" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * 
FROM Auditors
WHERE Status IS NULL
AND Type = 'TechnicalAudit'
AND ID <> 0
ORDER BY Auditor
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CCN" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Auditor, Count(Auditor) as CCNCount
FROM TechnicalAudits_AuditSchedule
WHERE CCN = '#Audit.CCN#'
AND Auditor IS NOT NULL
Group By Auditor
Order By Auditor
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Standard" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Auditor, Count(Auditor) as StandardCount
FROM TechnicalAudits_AuditSchedule
WHERE Standard = '#Audit.Standard#'
AND Auditor IS NOT NULL
Group By Auditor
Order By Auditor
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="AuditType2" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Auditor, Count(Auditor) as AuditType2Count
FROM TechnicalAudits_AuditSchedule
WHERE AuditType2 = '#Audit.AuditType2#'
AND Auditor IS NOT NULL
Group By Auditor
Order By Auditor
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Requested" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * 
FROM Auditors
WHERE Status = 'Requested'
AND Type = 'TechnicalAudit'
AND ID <> 0
ORDER BY Auditor
</cfquery>

<b>Audit Details</b><br />
<cfoutput query="Audit">
<u>Audit Number</u>: #URL.Year#-#URL.ID#-#URL.AuditedBy#<br />
<u>Project Number</u>: #ProjectNumber#<br />
<u>File Number</u>: #FileNumber#<br />
<u>Audit Type</u>: #AuditType2#<br />
<u>Request Type</u>: #RequestType#<br />
<u>Office Name</u>: #OfficeName#<Br />
<u>Industry</u>: #Industry#<br />
<u>Standard</u>: #Standard#<br />
<u>CCN</u>: #CCN#<br /><br />

<font class="warning"><b>Note:</b></font> If you do not find the auditor you wish to assign in the lists below, please <a href="#IQADir#TechnicalAudits_AssignAuditor_Request_Search.cfm?#CGI.QUERY_STRING#"><b>request an auditor</b></a>. Once you have selected the new auditor, you will be able to assign them. Technical Audit Manager will review this request and contact you if there are any issues.<br /><br />
</cfoutput>

<table border="1" cellpadding="1">
<tr>
<td class="sched-title" width="150">Auditor Name</td>
<td class="sched-title" width="75">Location</td>
<td class="sched-title" width="75">Department</td>
<td class="sched-title" width="75" align="center">Select</td>
</tr>
<!--- loop through Active, CCN, Standard, AuditType2, Requested queries --->
<cfloop list="Active,CCN,Standard,AuditType2,Requested" index="listElement">
<!--- Check for Auditors who are qualified for the CCN/Standard/AuditType2 of the audit --->
<tr>
<cfoutput>
   	<td class="sched-title" colspan="7">
    	<cfif listElement eq "Active" OR listElement eq "Requested">
    		#listElement# Auditors
        <cfelse>
        	Auditors currently qualified for #evaluate("Audit.#listElement#")#
        </cfif>
    </td>
</cfoutput>
</tr>
<cfif evaluate("#listElement#.recordCount") eq 0>
    <tr>
    <cfoutput>
        <td class="blog-content" colspan="7" align="center">
			<cfif listElement eq "Active" OR listElement eq "Requested">
                There are currently no #listElement# Auditors
            <cfelse>
                There are no Auditors currently qualified for  #evaluate("Audit.#listElement#")#
            </cfif>
        </td>
    </cfoutput>
    </tr>
<cfelse>
    <cfoutput query="#listElement#">

	<!--- auditor query --->
    <CFQUERY BLOCKFACTOR="100" NAME="Details" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT * 
    FROM Auditors
    WHERE Auditor = '#Auditor#'
    </cfquery>
            
    <tr>
    <td class="blog-content">#Auditor#</td>
	<td class="blog-content">#Details.Location#</td>
    <td class="blog-content">#Details.Dept#</td>
    <td class="blog-content" align="center">
	    <A href="#IQADir#TechnicalAudits_SelectAuditor_Action.cfm?#CGI.Query_String#&Auditor_EmpNo=#Details.EmpNo#">Select</A>
    </td>
    </tr>
    </cfoutput>
</cfif>
</cfloop>
</table>