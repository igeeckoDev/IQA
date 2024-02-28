<cfoutput>
	<link href="#REQUEST.CSS#" rel="stylesheet" media="screen">
</cfoutput>

<cfif cgi.script_name is "/departments/snk5212/qe/qFAQ.cfm">
<div class="blog-content">
<font color="red">
	To print this item, Press Control-P or select "Print" in your browser.
    <cfif isDefined("URL.ID")>
		<cfif URL.ID eq 12 OR URL.ID eq 14>
    		<br />Print in Landscape.
		</cfif>
    </cfif>
</font><br /><br />
</div>
</cfif>

<cfif cgi.script_name is "/departments/snk5212/qe/qFAQ.cfm">
	<Br><div class="blog-date" align="center"><cfoutput>#Request.SiteTitle# - FAQ</cfoutput></div>
<cfelseif cgi.script_name is "/departments/snk5212/qe/FAQ.cfm">
	<div class="blog-title"><a href="qFAQ.cfm">Print</a> Full FAQ</div>
</cfif>

<cfquery name="FAQ" datasource="Corporate" blockfactor="100">
SELECT * FROM CAR_FAQ "FAQ"
WHERE Status IS NULL
<cfif isdefined("URL.ID")>
	AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif CGI.SCRIPT_Name is "/departments/snk5212/qe/carOwners.cfm"
	or CGI.SCRIPT_Name is "/departments/snk5212/qe/admin/carOwners.cfm">
	AND Category = 'Owner'
    OR Category = 'Both'
<cfelseif CGI.SCRIPT_Name is "/departments/snk5212/qe/carAdmins.cfm"
	or CGI.SCRIPT_Name is "/departments/snk5212/qe/admin/carAdmins.cfm">
	AND Category = 'Admin'
    OR Category = 'Both'
</cfif>
ORDER BY ID
</cfquery>

<cflock scope="Session" timeout="5">
	<cfif IsDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">
		<a href="admin/addfaq.cfm">Add</a> Question<br>
	</cfif>

<cfif NOT isdefined("URL.ID")>
	<br>
	<cfoutput query="FAQ">
		<cfif ID neq 0>
		<!--- ID = 0 is a test case, do not display --->
		<span class="blog-content">#ID# - <a href="FAQ.cfm###ID#">#question#</a> <cfif IsDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU"> [<a href="#CARAdminDir#editFAQ.cfm?ID=#ID#">edit</a>]</a> #category#</cfif><br></span>
		</cfif>
	</cfoutput>
	<br><Br>
</cfif>
<br>

<Table>
<cfoutput query="FAQ">
	<cfif ID neq 0>
	 <tr>
	 <cfif cgi.script_name is "/departments/snk5212/qe/qFAQ.cfm">
	 <td class="blog-content">
	 <cfelse>
	 <td class="blog-faqitem">
	 </cfif>
	<!--- ID = 0 is a test case, do not display --->
		<a name="#ID#"></a>
		<B>#ID# - #question#</B> <cfif IsDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">[<a href="#CARAdminDir#editFAQ.cfm?ID=#ID#">edit</a>]</a></cfif>
        <cfif cgi.script_name neq "/departments/snk5212/qe/qFAQ.cfm">
        	[<a href="qFAQ.cfm?ID=#ID#">Print</a>]
        </cfif>
		<Br>Category: <cfif Category eq "Both">CAR Admin and CAR Owner<cfelse>CAR #Category#</cfif>

	<br><br>#Content#<cfif cgi.script_name is "/departments/snk5212/qe/qFAQ.cfm"><br></cfif>

<cfif len(AttachedFile)>
	<a href="FAQ\#AttachedFile#"><b>View</b></a> #AttachedFile#<br /><br />
</cfif>

<cfif include is "Yes">
	<!---<cfif ID eq 14>
		<cfinclude template="#IQARootDir#matrix.cfm">
	<cfelse>--->
		<cfinclude template="FAQ#ID#.cfm">
	<!---</cfif>--->
</cfif>
	</td>
	</tr>
	</cfif>
</cfoutput>
</TABLE>
</cflock>