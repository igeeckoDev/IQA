<cfif url.Type eq "TechnicalAudit">
	<cfset AuditorType = "Technical Audit">
<cfelse>
	<cfset AuditorType = url.Type>
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#AuditorType# - <a href=Auditors.cfm?Type=#URL.Type#>Auditor List</a> - Auditor Details">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Name="Auditors" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * 
From Auditors
WHERE ID = #URL.ID#
</CFQUERY>

<cfif isDefined("URL.msg")>
	<cfoutput>
    	<font class="warning">#url.msg#</font><br /><br />
    </cfoutput>
</cfif>

<CFOUTPUT query="Auditors">
<b>Auditor Details</b> <a href="Auditors_Edit.cfm?ID=#URL.ID#&Type=#URL.Type#">[Edit]</a><br><br>

<u>Auditor Name</u>:<br>
#Auditor#
<br><br>

<u>Location</u>:<br>
#Location#
<br><br>

<cfif Type eq "TechnicalAudit">
<u>Department Number</u>:<br />
#Dept#
<br /><br />
</cfif>

<u>Auditor Email</u>:<br />
#Email#
<br /><br />

<u>Current Status</u>:<br>
<cfif Status NEQ "Removed">
	<cfif NOT len(status)>
        Active (#dateformat(ActiveDate, "mm/dd/yyyy")#)
	<cfelse>
    	#Status#
    </cfif>
<cfelse>
	#Status# (#dateformat(RemoveDate, "mm/dd/yyyy")#)
</cfif>
<br><Br>

<cfif Type eq "TechnicalAudit">

<CFQUERY BLOCKFACTOR="100" NAME="AuditType" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as Count, AuditType2 as Item
FROM TechnicalAudits_AuditSchedule
WHERE Auditor = '#Auditor#'
GROUP BY AuditType2
ORDER BY Count DESC
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CCNs" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as Count, CCN as Item
FROM TechnicalAudits_AuditSchedule
WHERE Auditor = '#Auditor#'
AND CCN IS NOT NULL
GROUP BY CCN
ORDER BY Count DESC
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Standards" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as Count, Standard as Item
FROM TechnicalAudits_AuditSchedule
WHERE Auditor = '#Auditor#'
AND Standard IS NOT NULL
GROUP BY Standard
ORDER BY Count DESC
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Industry" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as Count, Industry as Item
FROM TechnicalAudits_AuditSchedule
WHERE Auditor = '#Auditor#'
AND Industry IS NOT NULL
GROUP BY Industry
ORDER BY Count DESC
</cfquery>

<b>Audits Conducted</b><br />
This section shows Audits Conducted for this auditor by Audit Type, CCN, Standard, and Industry. This includes Audits they are scheduled to conduct.<br /><br /> 

<u>Audit Types</u><br />
<cfif AuditType.RecordCount eq 0>
This auditor has not conducted any audits stored in this system<br />
<cfelse>
	<cfloop query="AuditType">
    #Item# (#Count#)<br />
    </cfloop>
</cfif><br />

<u>Primary CCNs</u><br />
<cfif CCNs.RecordCount eq 0>
This auditor has not conducted any audits stored in this system<br />
<cfelse>
	<cfloop query="CCNs">
    #Item# (#Count#)<br />
    </cfloop>
</cfif><br />

<u>Primary Standards</u><br />
<cfif Standards.RecordCount eq 0>
This auditor has not conducted any audits stored in this system<br />
<cfelse>
	<cfloop query="Standards">
    #Item# (#Count#)<br />
    </cfloop>
</cfif><br />

<u>Industry</u><br />
<cfif Industry.RecordCount eq 0>
This auditor has not conducted any audits stored in this system<br />
<cfelse>
	<cfloop query="Industry">
    #Item# (#Count#)<br />
    </cfloop>
</cfif><br />

</cfif>

<!---
    <u>Audit Types Qualified/Trained to Conduct</u>: <a href="Auditors_Qualification.cfm?ID=#URL.ID#&Type=#URL.Type#">[Add/Edit]</a><br />
    <cfif len(Qualified)>
        #replace(Qualified, ",", "<br />", "All")#
    <cfelse>
        None Listed
    </cfif><br /><br />
    
    <u>Qualified CCNs</u>: <a href="Auditors_CCN.cfm?ID=#URL.ID#&Type=#URL.Type#">[Add/Edit]</a><br />
    <cfif len(CCN)>
        #replace(CCN, ",", "<br />", "All")#
    <cfelse>
        None Listed
    </cfif><br /><br />
    
    <u>Qualified Standards</u>: <a href="Auditors_Standard.cfm?ID=#URL.ID#&Type=#URL.Type#">[Add/Edit]</a><br />
    <cfif len(Standard)>
        #replace(Standard, ",", "<br />", "All")#
    <cfelse>
        None Listed
    </cfif><br /><br />
--->

<u>History</u><br>
<cfif len(History)>
	<a href="Auditors_Details_History.cfm?ID=#URL.ID#&Type=#URL.Type#">View History</a>
<cfelse>
	No History
</cfif>
</CFOUTPUT>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->