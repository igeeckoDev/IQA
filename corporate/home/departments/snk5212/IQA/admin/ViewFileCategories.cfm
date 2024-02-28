<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#Request.SiteTitle# View File Categories">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<a href="CARFilesCategories.cfm">Add Category</a><br><br>

<!--- Query to get Category Names --->
<CFQUERY DataSource="Corporate" Name="Categories">
SELECT CategoryName, CategorySecure, CategoryID
FROM CARFilesCategory
WHERE CategoryID <> 0  AND CategoryID <> 2 AND CategoryID <> 4
ORDER BY CategoryName
</Cfquery>

<cfoutput query="Categories">
	<cfif CategorySecure eq "Yes">
    	<cfif CategoryName CONTAINS "CAR">
        	<cfif SESSION.Auth.AccessLevel eq "SU">
            	:: <a href="ViewFiles.cfm?CategoryID=#CategoryID#">#CategoryName#</a><br>
            <cfelse>
            	:: #CategoryName#<br>
            </cfif>
		<cfelseif CategoryName CONTAINS "DAP">
        	<cfif SESSION.Auth.AccessLevel eq "SU">
            	:: <a href="ViewFiles.cfm?CategoryID=#CategoryID#">#CategoryName#</a><br>
            <cfelse>
            	:: #CategoryName#<br>
            </cfif>
        <cfelseif CategoryName CONTAINS "IQA">
        	<cfif SESSION.Auth.AccessLevel eq "SU" OR SESSION.Auth.UserName eq "Huang">
            	:: <a href="ViewFiles.cfm?CategoryID=#CategoryID#">#CategoryName#</a><br>
            <cfelse>
            	:: #CategoryName#<br>
            </cfif>
        </cfif>
    <cfelse>
		:: <a href="ViewFiles.cfm?CategoryID=#CategoryID#">#CategoryName#</a><br>
	</cfif>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->