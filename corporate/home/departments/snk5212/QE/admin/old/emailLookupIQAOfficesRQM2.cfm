<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "IQA DB - Login Email Check - RQM">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->
			
<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="IQAOffices"> 
SELECT RQM FROM IQAtblOffices
WHERE Exist = 'Yes'
ORDER BY RQM
</CFQUERY>

<cfset RQM = #valueList(IQAOffices.RQM, ',')#>
<cfset myArrayList = ListToArray(RQM)>

<cfloop from="1" to="#arraylen(myArrayList)#" index="i">
	<CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
	SELECT employee_email 
	FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
	WHERE employee_email = '#TRIM(myArrayList[i])#'
	</CFQUERY>

<cfoutput>
#myArrayList[i]# - <cfif NameLookup.RecordCount eq 1>Ok<cfelseif NameLookup.RecordCount gt 1>Ok (#namelookup.recordcount#)<cfelse><b>Not Found</b></cfif>
</cfoutput><br>
</cfloop>

<br><Br>
<!--- Create a structure to hold the email list --->
<cfset objEmails = StructNew() />

<!--- Loop over the list to add mappings to the struct --->
<cfloop index="strEmails" list="#RQM#" delimiters=",">

	<!--- Store key/value pair. In this case, we don't 
	really care about the value (hence storing "" as value.
	We only care about the key.
	--->
	<cfset objEmails[ strEmails ] = "" />
	
</cfloop>

<!--- Convert the now unique key values into a list --->
<cfset RQM = StructKeyList( objEmails ) />

<cfset myArrayList = ListToArray(RQM)>

<cfloop from="1" to="#arraylen(myArrayList)#" index="i">
	<CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
	SELECT employee_email 
	FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
	WHERE employee_email = '#TRIM(myArrayList[i])#'
	</CFQUERY>

<cfoutput>
#myArrayList[i]# - <cfif NameLookup.RecordCount eq 1>Ok<cfelseif NameLookup.RecordCount gt 1>Ok (#namelookup.recordcount#)<cfelse><b>Not Found</b></cfif>
</cfoutput><br>
</cfloop>

<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->