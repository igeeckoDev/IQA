<CFQUERY BLOCKFACTOR="100" name="docs" DataSource="Corporate"> 
SELECT * From Docs
ORDER BY Document
</cfquery>

<cfinclude template="inc_TOP.cfm">

<cfif docs.recordcount eq 0>
	This page currently has no content.
<cfelse>
	<cfoutput query="Docs">
		<cfif len(trim(link))>
			<cfif len(trim(documentnumber))>
				#Document# :: <a href="#link#">#DocumentNumber#</a><br>
			<cfelse>
				#Document# :: <a href="#link#">View</a><br>
			</cfif>
		<cfelse>
			#Document# :: #DocumentNumber# (Currently no link to this document)<br>
		</cfif>
	</cfoutput>
</cfif>