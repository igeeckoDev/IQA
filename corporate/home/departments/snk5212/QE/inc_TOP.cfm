<cfif cgi.script_name is NOT "/departments/snk5212/qe/qFAQ.cfm">
<CFQUERY BLOCKFACTOR="100" name="PageID" DataSource="Corporate">
SELECT * FROM RH
WHERE RH.filename = '#replace(cgi.script_name, "admin/", "", "All")#'
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="introText" DataSource="Corporate">
SELECT * FROM page_content, RH
WHERE RH.filename = '#replace(cgi.script_name, "admin/", "", "All")#'
AND page_content.pageID = RH.ID
AND Title = 'Intro Text'
AND page_content.RevNo = (SELECT MAX(RevNo) FROM page_content WHERE PageID = #PageID.ID#)
</cfquery>

<cflock scope="Session" Timeout="5">
	<cfif introText.recordcount eq 0>
	<cfoutput>
		<cfif IsDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">
	<a href="#CARAdminDir#topAdd2.cfm?filename=#replace(cgi.script_name, "admin/", "", "All")#">Add</a> Introductory Text for this page.<Br><br>
		</cfif>
	</cfoutput>
	<cfelse>
		<cfoutput query="introText">
		<cfset dump = #replace(content, "<p>", "", "All")#>
		<cfset dump2 = #replace(dump, "</p>", "<br><br>", "All")#>
		#dump2# <cfif IsDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">[<a href="#CARAdminDir#topAdd2.cfm?filename=#replace(cgi.script_name, "admin/", "", "All")#">Edit</a>] Intro Text<br><br></cfif>
		<!---[Revision #RevNo# #dateformat(RevDate, "mm/dd/yyyy")#]--->
		</cfoutput>
	</cfif>
</cflock>
</cfif>