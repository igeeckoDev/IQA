<CFQUERY BLOCKFACTOR="100" name="MonthCheck" Datasource="Corporate">
SELECT Month, StartDate, EndDate, AuditedBy
FROM AuditSchedule
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfif MonthCheck.Month eq Form.e_Month>
   	<cflocation url="clear_dates.cfm?#CGI.QUERY_STRING#&msg=No Changes Made - the Audit Month submitted is the same as the stored month">
</cfif>

<CFQUERY BLOCKFACTOR="100" name="AddDates" Datasource="Corporate">
UPDATE AuditSchedule
SET

Month=#form.e_month#,
StartDate=null,
EndDate=null

WHERE ID = #URL.ID#
and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfif MonthCheck.AuditedBy eq "AS">
<CFQUERY BLOCKFACTOR="100" name="NewMonth" Datasource="Corporate">
SELECT Month, AuditedBy, ASContact
FROM AuditSchedule
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
</CFQUERY>

    <cfmail
        to="Global.InternalQuality@ul.com"
        from="Internal.Quality_Audits@ul.com"
        subject="AS-#URL.Year#-#URL.ID# - Audit Date Change"
        type="html">
        The Audit Month have changed for AS-#URL.Year#-#URL.ID#<br /><br />

        The Audit Month has been changed to <b>#MonthAsString(NewMonth.Month)#</b>.<Br />
        No Audit Dates are listed at this time.<br /><br />

        Old Dates:<br />
        Start Date - #dateformat(MonthCheck.StartDate, "mm/dd/yyyy")#<br />
        End Date - #dateformat(MonthCheck.EndDate, "mm/dd/yyyy")#<br /><Br />

        <a href="http://usnbkiqas100p/departments/snk5212/IQA/auditdetails.cfm?id=#URL.ID#&year=#URL.Year#">View</a> Audit Details<br /><br />

        <cflock scope="session" timeout="5">
        Please contact #NewMonth.ASContact# (AS Contact for this audit) for more information.<Br />
        Date change made by: #SESSION.Auth.Name#.<br /><br />
        </cflock>
	</cfmail>
</cfif>

<cflocation url="auditdetails.cfm?#CGI.QUERY_STRING#" ADDTOKEN="No">