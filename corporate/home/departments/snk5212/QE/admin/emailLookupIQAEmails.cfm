<cfsetting requestTimeOut="600">

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "IQA DB - Login Email Check">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->
			
<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="KBEmailList"> 
SELECT DISTINCT Email FROM IQADB_LOGIN "LOGIN" 
WHERE status IS NULL
AND (AccessLevel = 'RQM' OR AccessLevel = 'SU' OR AccessLevel = 'Admin' OR AccessLevel = 'IQAAuditor')
AND (EMAIL IS NOT NULL AND EMAIL <> 'Internal.Quality_Audits@ul.com' AND EMAIL <> 'Internal.Quality.Audits@us.ul.com')
ORDER BY Email
</CFQUERY>

<cfset Emails = #valueList(KBEmailList.Email, ',')#>
<cfset myArrayList = ListToArray(Emails)>

<cfloop from="1" to="#arraylen(myArrayList)#" index="i">

<!--- find the location of the @ in the email address, findat is the count including the @ symbol --->
<cfset FindAt = "#Find("@", myArrayList[i]) - 1#">
<!--- set the username variable to everything left of the @ symbol --->
<cfset Username = "#left(myArrayList[i], FindAt)#">
<!--- set altUsername to the email username plus ul.com --->
<cfset altUsername = "#trim(Username)#@ul.com">

	<CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
	SELECT DISTINCT employee_email 
	FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
    <!--- checking for either @xx.ul.com or @ul.com --->
	WHERE employee_email = '#myArrayList[i]#'
    OR employee_email = '#altUsername#'
	</CFQUERY>

<cfoutput>
#Username# - <cfif NameLookup.RecordCount eq 1>Ok<cfelseif NameLookup.RecordCount gt 1>Ok (#namelookup.recordcount#)<cfelse><b>Not Found</b></cfif>
</cfoutput><br>
</cfloop>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->