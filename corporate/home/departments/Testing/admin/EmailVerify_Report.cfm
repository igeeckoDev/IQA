<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Email">
SELECT AuditType, AuditType2, Email, Email2 FROM AuditSchedule
WHERE ID = #URL.ID# AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<!--- Email Address Verification - Primary Contact--->

<!--- there is a value (one or more) in Email field --->
<cfif len(Email.Email)>
	<cfset xyz = #valueList(Email.Email, ',')#>
	<cfset myArrayList = ListToArray(xyz)>

<!--- more than one item in Primary Contact Array --->
<cfif arraylen(myArrayList) gt 1>
   	<cflocation url="auditdetails.cfm?id=#url.id#&year=#url.year#&var=Scope&msg=MultiplePC" addtoken="No">	
<cfelse>
<!--- /// --->

<cfloop from="1" to="#arraylen(myArrayList)#" index="i">
	<CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
	SELECT first_n_middle, last_name, preferred_name, employee_email 
	FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
	WHERE employee_email = '#TRIM(myArrayList[i])#'
	</CFQUERY>

<!--- More than one name found to match email. This SHOULD NOT HAPPEN, but even if it does, it needs to be corrected --->
	<cfif NameLookup.RecordCount gt 1>
		<cflocation url="auditdetails.cfm?id=#url.id#&year=#url.year#&var=Report&msg=MultipleMatchPC" addtoken="No">
<!--- No match --->
	<cfelseif NameLookup.RecordCount eq 0>
		<cflocation url="auditdetails.cfm?id=#url.id#&year=#url.year#&var=Report&msg=NoMatchPC" addtoken="No">
	<!--- cfelseif NameLookup.RecordCount eq 1 Primary OK - Check Other Contacts --->
	</cfif>
</cfloop>
</cfif>

<cfelse>
<!--- Blank Email field --->
	<cflocation url="auditdetails.cfm?id=#url.id#&year=#url.year#&var=Report&msg=NOPC" addtoken="No">
</cfif>    

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Email2">
SELECT Email2 FROM AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<!--- Email Address Verification - Other Contacts --->

<cfif len(Email2.Email2)>
	<cfset xyz = #valueList(Email2.Email2, ',')#>
	<cfset myArrayList = ListToArray(xyz)>
	
<cfset errors = 0>
<cfloop from="1" to="#arraylen(myArrayList)#" index="i">
	<CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
	SELECT first_n_middle, last_name, preferred_name, employee_email 
	FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
	WHERE employee_email = '#TRIM(myArrayList[i])#'
	</CFQUERY>

	<cfif NameLookup.RecordCount eq 0>
		<cfset errors = #errors# + 1>
	<cfelse>
		<cfset errors = #errors#>
	</cfif>
</cfloop>

	<cfif errors eq 0>
		<cflocation url="Report1.cfm?ID=#URL.ID#&Year=#URL.Year#" addtoken="No">
	<cfelseif errors gt 0>
		<cflocation url="auditdetails.cfm?id=#url.id#&year=#url.year#&var=Report&msg=CCError" addtoken="No">
	</cfif>
<cfelse>
	<cflocation url="Report1.cfm?ID=#URL.ID#&Year=#URL.Year#" addtoken="No">
</cfif>