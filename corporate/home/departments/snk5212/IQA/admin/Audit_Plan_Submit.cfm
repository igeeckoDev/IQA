<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="a"> 
SELECT *
FROM PLAN
WHERE YEAR_ = #URL.Year# 
AND OfficeName = '#URL.OfficeName#' 
AND START_ = #URL.Start# 
AND AuditedBy = '#URL.AuditedBy# '
</CFQUERY>

<cfif a.recordcount is 0>
    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="FirstEntry"> 
    INSERT INTO Plan (OfficeName, START_, YEAR_, AuditedBy)
    VALUES('#URL.OfficeName#', #URL.Start#, #URL.Year#, '#URL.AuditedBy#')
    </cfquery>
</cfif>

<cfquery name="Input" Datasource="Corporate">
UPDATE Plan
SET 

<cfloop index="x" list="#form.fieldnames#">
	<cfoutput>
        <cfif x lt 10>
            A00#x# = #form[x]#,
        <cfelse>
            A0#x# = #form[x]#,
        </cfif>
    </cfoutput>
</cfloop>
Placeholder=0

WHERE Year_ = #URL.Year# 
AND OfficeName = '#URL.OfficeName#' 
AND Start_ = #URL.Start#
AND AuditedBy = '#URL.AuditedBy#'
</cfquery>

<cflocation url="Audit_Plan.cfm?Officename=#URL.Officename#&Year=#URL.Year#&Start=#URL.Start#&auditedby=#url.auditedby#" ADDTOKEN="No">