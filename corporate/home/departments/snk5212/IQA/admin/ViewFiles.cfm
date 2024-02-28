<!--- Query to get Category Name from URL.ID --->
<CFQUERY DataSource="Corporate" Name="Categories">
SELECT CARFilesCategory.CategoryName
FROM CARFilesCategory
WHERE CARFilesCategory.CategoryID = #URL.CategoryID#
</Cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#Request.SiteTitle# - #Categories.CategoryName# - View Files">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif isDefined("url.uploaded") AND isDefined("url.Rev") AND isDefined("url.DocName")>
	<cfoutput>
    <font color="red"><b>#URL.DocName# [RevNo #URL.Rev#] has been uploaded</b></font>
    </cfoutput><br /><br />
</cfif>

<cfoutput>
<cfif URL.CategoryID EQ 7 or URL.CategoryID EQ 10>
	<cfif SESSION.Auth.AccessLevel eq "SU" >
    	<Cfinclude template="qViewFiles.cfm">
        <br><br />
        <cflock scope="Session" timeout="5">
            <cfif isDefined("Session.Auth.IsLoggedIn")>
                <cfif SESSION.Auth.AccessLevel eq "SU" >
                    <a href="CARFilesNewFile.cfm?CategoryID=#URL.CategoryID#"><b>Add</b></a> a new File<br><br>
                </cfif>
            </cfif>
        </cflock>
    <cfelse>
    	Page Restricted
    </cfif>
<cfelseif URL.CategoryID EQ 5>
	<cfif SESSION.Auth.AccessLevel eq "SU" OR SESSION.Auth.UserName eq "Adams">
    	<Cfinclude template="qViewFiles.cfm">
        <br><br />
        <cflock scope="Session" timeout="5">
            <cfif isDefined("Session.Auth.IsLoggedIn")>
                <cfif SESSION.Auth.AccessLevel eq "SU">
                    <a href="CARFilesNewFile.cfm?CategoryID=#URL.CategoryID#"><b>Add</b></a> a new File<br><br>
                </cfif>
            </cfif>
        </cflock>
    <cfelse>
    	Page Restricted
    </cfif>
<cfelseif URL.CategoryID EQ 18>
    	<Cfinclude template="qViewFiles.cfm">
        <br><br />
        <cflock scope="Session" timeout="5">
            <cfif isDefined("Session.Auth.IsLoggedIn")>
                <cfif SESSION.Auth.AccessLevel eq "SU" OR SESSION.Auth.UserName eq "Adams" OR SESSION.Auth.UserName eq "Berger" OR SESSION.Auth.UserName eq "Eng">
                    <a href="CARFilesNewFile.cfm?CategoryID=#URL.CategoryID#"><b>Add</b></a> a new File<br><br>
                </cfif>
            </cfif>
        </cflock>
<cfelseif URL.CategoryID EQ 16>
	<cfif SESSION.Auth.AccessLevel eq "SU" OR SESSION.Auth.UserName eq "Huang" >
    	<Cfinclude template="qViewFiles.cfm">
        <br><br />
        <cflock scope="Session" timeout="5">
            <cfif isDefined("Session.Auth.IsLoggedIn")>
                <cfif SESSION.Auth.AccessLevel eq "SU">
                    <a href="CARFilesNewFile.cfm?CategoryID=#URL.CategoryID#"><b>Add</b></a> a new File<br><br>
                </cfif>
            </cfif>
        </cflock>
    <cfelse>
    	Page Restricted
    </cfif>
<cfelse>
	<Cfinclude template="qViewFiles.cfm">
    <br><br />
    <cflock scope="Session" timeout="5">
        <cfif isDefined("Session.Auth.IsLoggedIn")>
            <cfif SESSION.Auth.AccessLevel eq "SU">
                <a href="CARFilesNewFile.cfm?CategoryID=#URL.CategoryID#"><b>Add</b></a> a new File<br><br>
            </cfif>
        </cfif>
    </cflock>
</cfif>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->