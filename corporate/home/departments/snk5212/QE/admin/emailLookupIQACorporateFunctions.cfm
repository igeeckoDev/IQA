<cfsetting requestTimeOut="600">

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "IQA DB - Corporate Functions">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->
			
<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="GF">
SELECT * FROM CorporateFunctions
WHERE (status IS NULL OR Status = '')
ORDER BY Function
</CFQUERY>

<cfset xyz = #valueList(GF.Owner, ',')#>
<cfset myArrayList = ListToArray(xyz)>

<cfloop from="1" to="#arraylen(myArrayList)#" index="i">

<!--- find the location of the @ in the email address, findat is the count including the @ symbol --->
<cfset FindAt = "#Find("@", myArrayList[i]) - 1#">
<!--- set the username variable to everything left of the @ symbol --->
<cfset Username = "#left(myArrayList[i], FindAt)#">
<!--- set altUsername to the email username plus ul.com --->
<cfset altUsername = "#trim(Username)#@ul.com">

<CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
SELECT first_n_middle, last_name, preferred_name, employee_email 
FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
    <!--- checking for either @xx.ul.com or @ul.com --->
	WHERE employee_email = '#trim(myArrayList[i])#'
    OR employee_email = '#trim(altUsername)#'
</CFQUERY>

<cfoutput>
#Username# - <cfif NameLookup.RecordCount eq 1>Ok<cfelseif NameLookup.RecordCount gt 1>Ok (#namelookup.recordcount#)<cfelse><b>Not Found</b></cfif>
</cfoutput><br>
</cfloop>

<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->