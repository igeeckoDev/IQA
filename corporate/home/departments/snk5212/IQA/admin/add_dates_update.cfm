<CFQUERY BLOCKFACTOR="100" name="DateCheck" Datasource="Corporate">
SELECT StartDate, EndDate, AuditedBy
FROM AuditSchedule
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfif NOT isDate(Form.EndDate)>
	<cfif DateCheck.StartDate eq Form.e_StartDate>
    	<cflocation url="add_dates.cfm?#CGI.QUERY_STRING#&msg=No Changes Made - the Audit Dates submitted are the same as the stored dates">
    </cfif>
<cfelse>
	<cfif DateCheck.StartDate eq Form.e_StartDate AND DateCheck.EndDate eq Form.EndDate>
    	<cflocation url="add_dates.cfm?#CGI.QUERY_STRING#&msg=No Changes Made - the Audit Dates submitted are the same as the stored dates">
    </cfif>
</cfif>

<cfif isDefined("Form.e_StartDate") AND isDefined("Form.EndDate")>
	<cfset CompareDate = Compare(FORM.e_StartDate, FORM.EndDate)>
</cfif>

<cfset m = #DateFormat(Form.e_StartDate, 'mm')#>

<CFQUERY BLOCKFACTOR="100" name="AddDates" DataSource="Corporate">
UPDATE AuditSchedule
SET

<cfif Form.e_StartDate is "" AND Form.EndDate is "">
StarteDate=null,
EndDate=null,
Month='#form.month#',
<cfelseif Form.e_StartDate is NOT "" AND Form.EndDate is "">
StartDate=#CreateODBCDate(FORM.e_StartDate)#,
EndDate=#CreateODBCDate(FORM.e_StartDate)#,
<cfset m = #DateFormat(Form.e_StartDate, 'mm')#>
Month='#m#'
<cfelseif Form.e_Startdate is NOT "" AND Form.EndDate is NOT "">
	<cfif CompareDate eq -1>
		StartDate=#CreateODBCDate(FORM.e_StartDate)#,
		EndDate=#CreateODBCDate(FORM.EndDate)#,
		<cfset m = #DateFormat(Form.e_StartDate, 'mm')#>
		Month='#m#'
	<cfelseif CompareDate eq 0>
		StartDate=#CreateODBCDate(FORM.e_StartDate)#,
		EndDate=#CreateODBCDate(FORM.e_StartDate)#,
		<cfset m = #DateFormat(Form.e_StartDate, 'mm')#>
		Month='#m#'
	<cfelseif CompareDate eq 1>
		StartDate=#CreateODBCDate(FORM.EndDate)#,
		EndDate=#CreateODBCDate(FORM.e_StartDate)#,
		<cfset m = #DateFormat(Form.EndDate, 'mm')#>
		Month='#m#'
	</cfif>
<cfelseif Form.e_Startdate is "" AND Form.EndDate is NOT "">
StartDate=#CreateODBCDate(FORM.EndDate)#,
EndDate=#CreateODBCDate(FORM.EndDate)#,
<cfset m = #DateFormat(Form.End, 'mm')#>
Month='#m#'
</cfif>

WHERE ID = #URL.ID#
and Year_ = '#URL.YEAR#'
</CFQUERY>

<cfif DateCheck.AuditedBy eq "IQA">
	<CFQUERY BLOCKFACTOR="100" name="Audit" Datasource="Corporate">
    SELECT *
    FROM AuditSchedule
    WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
    </CFQUERY>

	<Cfset AuditorCCEmails = "">

	<!--- add lead auditor field email --->
    <cfif len(Audit.LeadAuditor)>
        <cfloop index = "ListElement" list = "#Audit.LeadAuditor#">
            <Cfoutput>
                <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
                SELECT Email
                FROM AuditorList
                WHERE Auditor = '#trim(ListElement)#'
                </CFQUERY>

                <cfset AuditorCCEmails = listAppend(AuditorCCEmails, "#AuditorEmail.Email#")>
            </cfoutput>
        </cfloop>
    </cfif>

    <!--- add auditor field emails --->
    <cfif len(Audit.Auditor)>
        <cfloop index = "ListElement" list = "#Audit.Auditor#">
            <Cfoutput>
                <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
                SELECT Email
                FROM AuditorList
                WHERE Auditor = '#trim(ListElement)#'
                </CFQUERY>

                <cfset AuditorCCEmails = listAppend(AuditorCCEmails, "#AuditorEmail.Email#")>
            </cfoutput>
        </cfloop>
    </cfif>

    <!--- add auditor in training field emails --->
    <cfif len(Audit.AuditorInTraining)>
        <cfloop index = "ListElement" list = "#Audit.AuditorInTraining#">
            <Cfoutput>
                <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
                SELECT Email
                FROM AuditorList
                WHERE Auditor = '#trim(ListElement)#'
                </CFQUERY>

                <cfset AuditorCCEmails = listAppend(AuditorCCEmails, "#AuditorEmail.Email#")>
            </cfoutput>
        </cfloop>
    </cfif>
    <!--- /// --->

    <cfmail
        to="#AuditorCCEmails#"
        from="Internal.Quality_Audits@ul.com"
        cc="Internal.Quality_Audits@ul.com"
        subject="#URL.Year#-#URL.ID#-IQA - Audit Dates have been added"
        query="Audit"
        type="html">
The following audit now has audit dates listed. You are listed as a member of the audit team.<br /><br />

The Audit Dates are:<br />
Start Date - #dateformat(StartDate, "mm/dd/yyyy")#<br />
<cfif StartDate neq EndDate>
End Date - #dateformat(EndDate, "mm/dd/yyyy")#<br />
<cfelse>
Note - This is a one day audit<br />
</cfif><br />

Please view the audit details for additional information:<Br /><br />

<a href="http://usnbkiqas100p/departments/snk5212/IQA/AuditDetails.cfm?ID=#ID#&Year=#Year_#">Audit Details</a>
	</cfmail>
</cfif>

<cfif DateCheck.AuditedBy eq "AS">
	<CFQUERY BLOCKFACTOR="100" name="NewDates" Datasource="Corporate">
	SELECT StartDate, EndDate, ASContact
	FROM AuditSchedule
	WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
	AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
	</CFQUERY>

    <cfmail
        to="Global.InternalQuality@ul.com"
        from="Internal.Quality_Audits@ul.com"
        subject="AS-#URL.Year#-#URL.ID# - Audit Date Change"
        type="html">
        The audit dates have changed for AS-#URL.Year#-#URL.ID#<br /><br />

        New Dates:<br />
        Start Date - #dateformat(NewDates.StartDate, "mm/dd/yyyy")#<br />
        End Date - #dateformat(NewDates.EndDate, "mm/dd/yyyy")#<br /><br />

        Old Dates:<br />
        Start Date - #dateformat(DateCheck.StartDate, "mm/dd/yyyy")#<br />
        End Date - #dateformat(DateCheck.EndDate, "mm/dd/yyyy")#<br /><Br />

        <a href="http://usnbkiqas100p/departments/snk5212/IQA/auditdetails.cfm?id=#URL.ID#&year=#URL.Year#">View</a> Audit Details<br /><br />

        <cflock scope="session" timeout="5">
        Please contact #NewDates.ASContact# (AS Contact for this audit) for more information.<Br />
        Date change made by: #SESSION.Auth.Name#.<br /><br />
        </cflock>
	</cfmail>
</cfif>

<cflocation url="auditdetails.cfm?id=#URL.ID#&year=#URL.Year#" addtoken="No">