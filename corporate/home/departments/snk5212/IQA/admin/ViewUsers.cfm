<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "IQA Audit Database Users">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Accounts">
SELECT *
FROM IQADB_LOGIN
ORDER BY AccessLevel, Status DESC, Region, SubRegion, UserName
</CFQUERY>

<a href="ViewUsers_Add.cfm">Add User</a><br><br>

<table border="1">
    <tr align="center" valign="top">
        <th>Username</th>
        <th>Name</th>
        <th>Email</th>
        <th>Status</th>
        <th>
        <cflock scope="session" timeout="5">
            <cfif SESSION.Auth.AccessLevel eq "SU">
		        View<br />Details
            </cfif>
        </cflock>
		</th>
    </tr>
<cfset Access = "">
<cfoutput query="Accounts">
	<cfif Access IS NOT AccessLevel>
    <tr>
        <th align="center" colspan="5">
        	Access Level : <cfif len(AccessLevel)>#AccessLevel#<cfelse>For use with mailing lists - do not delete</cfif>
        </th>
    </tr>
    </cfif>
	<tr>
        <td valign="top">
            <cfif Status eq "Test"><u>Test Account</u>: </cfif>#Username# (<b>#TotalLogins#</b>)
        </td>
        <td valign="top">
            <cfif len(Name)>#Name#<cfelse>None</cfif>
			<cfif AccessLevel eq "RQM"><Br />#Region#<Br />#SubRegion#</cfif>
        </td>
        <td valign="top">
            <cfif len(email)>#email#<cfelse>None</cfif>
        </td>
        <td valign="top">
            <cfif Status is "">
                Active
            <cfelseif Status is "removed">
                <font class="warning">Inactive</font>
            <cfelseif Status is "test">
                <font class="warning">Test Account</font>
            <cfelse>
                #Status#
            </cfif>
        </td>
        <td valign="top" align="center">
        	<cflock scope="session" timeout="5">
	            <cfif SESSION.Auth.AccessLevel eq "SU">
    		    	<a href="ViewUsers_Detail.cfm?ID=#ID#"><img src="#IQADir#images/ico_article.gif" border="0" alt="View Details" /></a>
                <cfelse>
                	&nbsp;
            	</cfif>
        	</cflock>
        </td>
	</tr>
	<cfset Access = AccessLevel>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->