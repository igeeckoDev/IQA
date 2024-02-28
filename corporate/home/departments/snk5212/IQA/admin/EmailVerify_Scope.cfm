<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Email">
SELECT AuditType, AuditType2, Email
FROM AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
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

<!--- find the location of the @ in the email address, findat is the count including the @ symbol --->
<cfset FindAt = "#Find("@", myArrayList[i]) - 1#">

<cfif FindAt eq -1>
	<cflocation url="auditdetails.cfm?id=#url.id#&year=#url.year#&var=Scope&msg=InvalidEmail" addtoken="No">
<cfelse>
	<!--- set the username variable to everything left of the @ symbol --->
    <cfset Username = "#left(myArrayList[i], FindAt)#">
    <!--- set altUsername to the email username plus ul.com --->
    <cfset altUsername = "#trim(Username)#@ul.com">
</cfif>

	<CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
	SELECT first_n_middle, last_name, preferred_name, employee_email
	FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW
    <!--- checking for either @xx.ul.com or @ul.com --->
	WHERE UPPER(employee_email) = '#UCASE(myArrayList[i])#'
    OR UPPER(employee_email) = '#UCASE(altUsername)#'
	</CFQUERY>

<!--- More than one name found to match email. This SHOULD NOT HAPPEN, but even if it does, it needs to be corrected --->
	<cfif NameLookup.RecordCount gt 1>
		<cflocation url="auditdetails.cfm?id=#url.id#&year=#url.year#&var=Scope&msg=MultipleMatchPC" addtoken="No">
<!--- No match --->
	<cfelseif NameLookup.RecordCount eq 0>
		<cflocation url="auditdetails.cfm?id=#url.id#&year=#url.year#&var=Scope&msg=NoMatchPC" addtoken="No">
	<!--- cfelseif NameLookup.RecordCount eq 1 Primary OK - Check Other Contacts --->
	</cfif>
</cfloop>
</cfif>

<cfelse>
<!--- Blank Email field --->
	<cflocation url="auditdetails.cfm?id=#url.id#&year=#url.year#&var=Scope&msg=NOPC" addtoken="No">
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Email2">
SELECT Email2
FROM AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<!--- Email Address Verification - Other Contacts --->

<cfif len(Email2.Email2)>
	<cfset xyz = #valueList(Email2.Email2, ',')#>
	<cfset myArrayList = ListToArray(xyz)>

<cfset errors = 0>
<cfloop from="1" to="#arraylen(myArrayList)#" index="i">

<!--- find the location of the @ in the email address, findat is the count including the @ symbol --->
<cfset FindAt = "#Find("@", myArrayList[i]) - 1#">

<cfif FindAt eq -1>
	<cflocation url="auditdetails.cfm?id=#url.id#&year=#url.year#&var=Scope&msg=InvalidEmail" addtoken="No">
<cfelse>
	<!--- set the username variable to everything left of the @ symbol --->
    <cfset Username = "#left(myArrayList[i], FindAt)#">
    <!--- set altUsername to the email username plus ul.com --->
    <cfset altUsername = "#trim(Username)#@ul.com">
</cfif>

	<CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
	SELECT first_n_middle, last_name, preferred_name, employee_email
	FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW
    <!--- checking for either @xx.ul.com or @ul.com --->
	WHERE UPPER(employee_email) = '#UCASE(myArrayList[i])#'
    OR UPPER(employee_email) = '#UCASE(altUsername)#'
	</CFQUERY>

	<cfif NameLookup.RecordCount eq 0>
		<cfset errors = #errors# + 1>
	<cfelse>
		<cfset errors = #errors#>
	</cfif>
</cfloop>

	<cfif errors eq 0>
		<cflocation url="ScopeLetter_Send.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditType=#Email.AuditType#&AuditType2=#Email.AuditType2#" addtoken="No">
	<cfelseif errors gt 0>
		<cflocation url="auditdetails.cfm?id=#url.id#&year=#url.year#&var=Scope&msg=CCError" addtoken="No">
	</cfif>
	<!--- no emails in cc - go ahead to scope --->
<cfelse>
	<cflocation url="ScopeLetter_Send.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditType=#Email.AuditType#&AuditType2=#Email.AuditType2#" addtoken="No">
</cfif>