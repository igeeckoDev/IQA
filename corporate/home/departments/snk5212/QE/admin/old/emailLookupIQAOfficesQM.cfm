<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "IQA DB - Login Email Check - QM">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->
			
<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="IQAOffices"> 
SELECT * FROM IQAtblOffices
WHERE Exist = 'Yes'
ORDER BY OfficeName
</CFQUERY>

<cfset xyz = #valueList(IQAOffices.QM, ',')#>
<cfset myArrayList = ListToArray(xyz)>

<cfloop from="1" to="#arraylen(myArrayList)#" index="i">
<CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
SELECT first_n_middle, last_name, preferred_name, employee_email 
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