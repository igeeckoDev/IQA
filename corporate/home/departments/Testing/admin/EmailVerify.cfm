<cfoutput>
	<link href="#Request.CSS#" rel="stylesheet" media="screen">
</cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Email">
SELECT #URL.Field# as Contact
FROM AuditSchedule
WHERE ID = #URL.ID# AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfset xyz = #valueList(Email.Contact, ',')#>
<cfset myArrayList = ListToArray(xyz)>

<div class="Blog-Title">
Email Address Verification
</div><br>

<div class="Blog-content">
<cfloop from="1" to="#arraylen(myArrayList)#" index="i">
    <CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
    SELECT first_n_middle, last_name, preferred_name, employee_email
    FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW
    WHERE UPPER(employee_email) = '#UCASE(TRIM(myArrayList[i]))#'
    </CFQUERY>

	<cfoutput>
    #myArrayList[i]# -
        <cfif NameLookup.RecordCount eq 1>
            Ok
        <cfelseif NameLookup.RecordCount gt 1>
            Ok (#namelookup.recordcount#)
        <cfelse>
            <b>Not Found</b>
        </cfif>
    </cfoutput><br>
</cfloop>
</div>