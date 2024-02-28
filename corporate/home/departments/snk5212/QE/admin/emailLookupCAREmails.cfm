<cfsetting requestTimeOut="600">

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "CAR Process DB - Login Email Lookup">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->
			
<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="KBEmailList2"> 
SELECT DISTINCT EMAIL FROM CAR_LOGIN "LOGIN"
WHERE status IS NULL
AND (EMAIL IS NOT NULL 
AND EMAIL <> 'All' 
AND EMAIL <> 'Internal.Quality.Audits@us.ul.com' 
AND EMAIL <> 'Internal.Quality_Audits@ul.com')
ORDER BY Email
</CFQUERY>

<cfset lstEmails = #valueList(KBEmailList2.Email, ',')#>

<cfloop index="strEmails" list="#lstEmails#" delimiters=",">
	<cfset objEmails[strEmails] = "" />
</cfloop>

<cfset lstEmails = StructKeyList(objEmails) />

<cfoutput>
    <cfloop collection="#objEmails#" item="strEmails">
		<!--- find the location of the @ in the email address, findat is the count including the @ symbol --->
        <cfset FindAt = "#Find("@", strEmails) - 1#">
        <!--- set the username variable to everything left of the @ symbol --->
        <cfset Username = "#left(strEmails, FindAt)#">
        <!--- set altUsername to the email username plus ul.com --->
        <cfset altUsername = "#trim(Username)#@ul.com">
        
        #Username# - 
        
        <CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
        SELECT first_n_middle, last_name, preferred_name, employee_email
        FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW
        <!--- checking for either @xx.ul.com or @ul.com --->
        WHERE employee_email = '#strEmails#'
        OR employee_email = '#altUsername#'
        </CFQUERY>
    
        <cfif NameLookup.RecordCount eq 1>
            Ok
        <cfelseif NameLookup.RecordCount gt 1>
            Ok (#namelookup.recordcount# found)
        <cfelse>
            <b>Not Found</b>
        </cfif><br />
	</cfloop>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->