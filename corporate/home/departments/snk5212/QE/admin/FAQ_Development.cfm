<!--- Start of Page File --->
<cfset subTitle = "Frequently Asked Questions (FAQ)">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

CAR Owners<br>
CAR Champions<br>

<cfquery name="FAQ" datasource="Corporate" blockfactor="100">
SELECT *
FROM CAR_FAQ
WHERE Status IS NULL
<cfif isdefined("URL.ID")>
	AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
</cfif>
AND ID > 0
ORDER BY ID
</cfquery>

<cflock scope="Session" timeout="5">

<cfif NOT isdefined("URL.ID")>
	<cfoutput query="FAQ">
		#ID# - <a href="FAQ.cfm###ID#">#question#</a><br>
	</cfoutput>
	<br><Br>
</cfif>
<br>

<Table>
	<cfoutput query="FAQ">
		 <tr>
			 <td class="blog-content">
				<a name="#ID#"></a>
				<B>#ID# - #question#</B>
				<cfif IsDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">
					&nbsp;<a href="#CARAdminDir#editFAQ.cfm?ID=#ID#"><img src="#IQADir#images/ico_article.gif" border="0"></a>
				</cfif><br>

				#Content#<br>

				<cfif len(AttachedFile)>
					<a href="FAQ\#AttachedFile#"><b>View</b></a> #AttachedFile#<br /><br />
				</cfif>

				<cfif include is "Yes">
					<!---<cfif ID eq 14>
						<cfinclude template="#IQARootDir#matrix.cfm">
					<cfelse>--->
						<cfinclude template="#CARRootDir#FAQ#ID#.cfm">
					<!---</cfif>--->
				</cfif>
			</td>
		</tr>
	</cfoutput>
</TABLE>
</cflock>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->