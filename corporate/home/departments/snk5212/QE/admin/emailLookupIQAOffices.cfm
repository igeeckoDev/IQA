<cfsetting requestTimeOut="600">

<!---
<Cfoutput>
	#lstEmails.ReplaceAll(",", "<br />")#
</Cfoutput>
--->

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "IQA DB - Login Email Check - #URL.Field#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->
			
<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="IQAOffices"> 
SELECT 
<cfif URL.Field eq "Other" OR URL.Field eq "Other2">
	DISTINCT DBMS_LOB.SUBSTR(#URL.Field#, 500) CLOB_Data
<cfelse>
	DISTINCT #URL.Field# as CLOB_Data
</cfif>
FROM IQAtblOffices
WHERE Exist = 'Yes'
ORDER BY CLOB_Data
</CFQUERY>

<cfset lstEmails = #valueList(IQAOffices.CLOB_Data, ',')#>

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
        SELECT employee_email 
        FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
		<!--- checking for either @xx.ul.com or @ul.com --->
        WHERE employee_email = '#strEmails#'
        OR employee_email = '#altUsername#'
        </CFQUERY>
    
        <cfif NameLookup.RecordCount eq 1>
            Ok
        <cfelseif NameLookup.RecordCount gt 1>
            Ok (#namelookup.recordcount#)
        <cfelse>
            <b>Not Found</b>
        </cfif>
        <br />
	</cfloop>
</cfoutput>

<!---
<cfset myArrayList = ListToArray(lstEmails)>

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
--->

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->