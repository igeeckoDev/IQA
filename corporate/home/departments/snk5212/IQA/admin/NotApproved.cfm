<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audits Awaiting Approval">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.AccessLevel is "SU" OR SESSION.Auth.AccessLevel is "Admin" OR Session.Auth.UserName is "Carlisle">
    <CFQUERY BLOCKFACTOR="100" NAME="NotApproved" Datasource="Corporate">
        SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year" 
        FROM AuditSchedule
        WHERE Approved <> 'Yes'
        AND status IS NULL
        ORDER By AuditedBy, ID
    </cfquery>
<cfelseif SESSION.Auth.AccessLevel is "RQM" OR SESSION.Auth.AccessLevel is "OQM" or SESSION.Auth.AccessLevel is "Field Services">
    <CFQUERY BLOCKFACTOR="100" NAME="NotApproved" Datasource="Corporate">
        SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year" 
        FROM AuditSchedule
        WHERE AuditedBy = '#SESSION.AUTH.SubRegion#'
        AND Approved <> 'Yes'
        AND status IS NULL
        ORDER By AuditedBy, ID
    </cfquery>
<cfelseif SESSION.Auth.AccessLevel is "AS">
    <CFQUERY BLOCKFACTOR="100" NAME="NotApproved" Datasource="Corporate">
        SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year" 
        FROM AuditSchedule
        WHERE AuditedBy = 'AS'
        AND Approved <> 'Yes'
        AND status IS NULL
        ORDER By AuditedBy, ID
    </cfquery>
<cfelseif SESSION.Auth.AccessLevel is "Finance">
    <CFQUERY BLOCKFACTOR="100" NAME="NotApproved" Datasource="Corporate">
        SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year" 
        FROM AuditSchedule
        WHERE AuditedBy = 'Finance'
        AND Approved <> 'Yes'
        AND status IS NULL
        ORDER By AuditedBy, ID
    </cfquery>
<cfelseif SESSION.Auth.AccessLevel is "QRS">
    <CFQUERY BLOCKFACTOR="100" NAME="NotApproved" Datasource="Corporate">
        SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year" 
        FROM AuditSchedule
        WHERE AuditedBy = 'QRS'
        AND Approved <> 'Yes'
        AND status IS NULLORDER By AuditedBy, ID
    </cfquery>
<cfelseif SESSION.Auth.AccessLevel is "IQAAuditor">
    <CFQUERY BLOCKFACTOR="100" NAME="NotApproved" Datasource="Corporate">
        SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year"
        FROM AuditSchedule 
        WHERE LeadAuditor = '#SESSION.Auth.Name#'
        AND Approved <> 'Yes'
        AND status IS NULL
        ORDER By AuditedBy, ID
    </cfquery>
<cfelseif SESSION.Auth.AccessLevel is "Laboratory Technical Audit">
    <CFQUERY BLOCKFACTOR="100" NAME="NotApproved" Datasource="Corporate">
        SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year"
        FROM AuditSchedule 
        WHERE AuditedBy = 'LAB' 
        AND Approved <> 'Yes'
        AND status IS NULL
        ORDER By AuditedBy, ID
    </cfquery>
<cfelseif SESSION.Auth.AccessLevel is "Verification Services">
    <CFQUERY BLOCKFACTOR="100" NAME="NotApproved" Datasource="Corporate">
        SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year"
        FROM AuditSchedule 
        WHERE AuditedBy = 'VS' 
        AND Approved <> 'Yes'
        AND status IS NULL
        ORDER By AuditedBy, ID
    </cfquery>
<cfelseif SESSION.Auth.AccessLevel is "UL Environment">
    <CFQUERY BLOCKFACTOR="100" NAME="NotApproved" Datasource="Corporate">
        SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year"
        FROM AuditSchedule 
        WHERE AuditedBy = 'ULE' 
        AND Approved <> 'Yes'
        AND status IS NULL
        ORDER By AuditedBy, ID
    </cfquery>
<cfelseif SESSION.Auth.AccessLevel is "WiSE">
    <CFQUERY BLOCKFACTOR="100" NAME="NotApproved" Datasource="Corporate">
        SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year"
        FROM AuditSchedule 
        WHERE AuditedBy = 'WiSE' 
        AND Approved <> 'Yes'
        AND status IS NULL
        ORDER By AuditedBy, ID
    </cfquery>
<cfelseif SESSION.Auth.AccessLevel is "Technical Audit">
    <CFQUERY BLOCKFACTOR="100" NAME="NotApproved" Datasource="Corporate">
        SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year"
        FROM AuditSchedule 
        WHERE AuditedBy = 'TechAudit' 
        AND Approved <> 'Yes'
        AND status IS NULL
        ORDER By AuditedBy, ID
    </cfquery>
<cfelse>
</cfif>
</cflock>

<cfset RegHolder=""> 

<cfif NotApproved.recordcount is 0>
There are no Scheduled Audits that have not been approved.
<cfelse>
<cfoutput query="NotApproved">
<cfif RegHolder IS NOT AuditedBy> 
<cfIf RegHolder is NOT ""><br></cfif>
<b><u>#AuditedBy#</u></b><br> 
</cfif>
<cfif AuditedBy is NOT "AS">
#Year#-#ID#-#AuditedBy#
<cfelse>
#AuditedBy#-#Year#-#ID#
</cfif> 
<a href="AuditDetails.cfm?ID=#ID#&Year=#Year#">View</a> :: <a href="audit_ok.cfm?ID=#ID#&Year=#Year#&auditedby=#auditedby#">Approve</a>

<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.AccessLevel is "SU"> :: <a href="remove.cfm?ID=#ID#&Year=#Year#&auditedby=#auditedby#">Delete</a></CFIF>
</cflock>

<br>
<cfset RegHolder = AuditedBy>
</cfoutput><br><br>

<u>Note</u> - These audits will not show up on the Audit Schedule or Calendar unless they are approved.
</cfif><br><br>						  
					
<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->