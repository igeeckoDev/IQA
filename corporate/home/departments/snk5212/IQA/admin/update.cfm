<CFQUERY BLOCKFACTOR="100" name="Check" Datasource="Corporate">
SELECT Auditschedule.*, Auditschedule.Year_ as Year
FROM AuditSchedule
WHERE ID = <cfqueryparam value="#url.ID#" CFSQLTYPE="CF_SQL_INTEGER">
AND Year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
</CFQUERY>

<cfif Check.audittype2 is "Technical Assessment">
	<cfelseif Check.audittype is "TPTDP">
    <cfelseif Check.AuditType2 is "N/A">
    <cfelseif Check.year lte 2005>
    <cfelseif check.audittype2 is "Local Function CBTL">
    <cfelseif check.audittype2 is "Program">
	<cfelseif check.audittype2 is "Scheme Documentation Audit">
    <cfelseif check.audittype2 is "MMS - Medical Management Systems">
	<cfelseif check.audittype2 is "Global Function/Process">
	<cfelseif check.audittype2 is "Corporate">
	<cfelse>

		<cfif check.audittype2 is "Field services">
            <CFQUERY BLOCKFACTOR="100" NAME="Query" Datasource="Corporate">
            UPDATE AuditSchedule
            SET

            Area = null

            WHERE ID = <cfqueryparam value="#url.ID#" CFSQLTYPE="CF_SQL_INTEGER">
            AND Year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
            </CFQUERY>
        <cfelse>
            <cfif form.e_area is "NoChanges">
            <cfelse>
                <CFQUERY BLOCKFACTOR="100" NAME="Query" Datasource="Corporate">
                UPDATE AuditSchedule
                SET

                Area='#Form.e_Area#'

                WHERE ID = <cfqueryparam value="#url.ID#" CFSQLTYPE="CF_SQL_INTEGER">
                AND Year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
                </CFQUERY>
        </cfif>
	</cfif>
</cfif>

<CFQUERY BLOCKFACTOR="100" NAME="ScheduleEdit" Datasource="Corporate">
SELECT Auditschedule.*, Auditschedule.Year_ as Year
FROM AuditSchedule
WHERE ID = <cfqueryparam value="#url.ID#" CFSQLTYPE="CF_SQL_INTEGER">
AND Year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
</CFQUERY>

<cflocation url="auditdetails.cfm?ID=#URL.ID#&Year=#URL.Year#" addtoken="no">