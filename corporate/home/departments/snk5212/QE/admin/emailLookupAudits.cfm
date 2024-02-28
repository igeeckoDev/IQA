<cfsetting requesttimeout="600">

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "IQA DB - Audit Contacts Verification - #URL.Field#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->
			
<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Audits"> 
SELECT 
<cfif URL.Field eq "Email" OR URL.Field eq "Email2">
	DBMS_LOB.SUBSTR(#URL.Field#, 500) CLOB_Data
</cfif>
FROM AuditSchedule
WHERE Year_ = #URL.Year#
AND Status IS NULL
AND (#URL.Field# IS NOT NULL OR #URL.Field# <> '')
ORDER BY ID
</CFQUERY>

<cfset lstEmails = #valueList(Audits.CLOB_Data, ',')#>

<cfloop index="strEmails" list="#lstEmails#" delimiters=",">
	<cfset objEmails[strEmails] = "" />
</cfloop>

<cfset lstEmails = StructKeyList(objEmails) />

<cfoutput>
    <cfloop collection="#objEmails#" item="strEmails">
		#strEmails# / 	
		<!--- find the location of the @ in the email address, findat is the count including the @ symbol --->
        <cfset FindAt = "#Find("@", strEmails) - 1#">
        <!--- set the username variable to everything left of the @ symbol --->
        <cfset Username = "#left(strEmails, FindAt)#">
        <!--- set altUsername to the email username plus ul.com --->
        <cfset altUsername = "#trim(Username)#@ul.com">
        
        #Username# - 
    
        <CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
        SELECT employee_email 
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