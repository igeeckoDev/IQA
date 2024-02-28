<!--- DV_CORP_002 02-APR-09 --->
<CFQUERY BLOCKFACTOR="100" name="carowner" DataSource="Corporate">
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: d4444d64-8170-4075-9395-6a3c00bd3169 Variable Datasource name --->
SELECT * FROM page_content, RH
WHERE RH.filename = '#replace(cgi.script_name, "admin/", "", "All")#'
AND page_content.pageID = RH.ID
ORDER BY title
<!---TODO_DV_CORP_002_End: d4444d64-8170-4075-9395-6a3c00bd3169 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<cfif carowner.recordcount eq 0>
	This page currently has no content.
<cfelse>
	<cfoutput query="carowner">
		<cfif len(trim(title))>
			<div class="blog-title">#title#</div>
		</cfif>
		<cfif NOT len(trim(content))>
			This page currently has no content.
		<cfelse>
			<cfif len(trim(link))>
				<a href="#link#">#linkText#</a><br>
			</cfif>
			#content#
		</cfif><br><br>
	</cfoutput>
</cfif>