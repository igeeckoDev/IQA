<CFQUERY BLOCKFACTOR="100" name="carowner" DataSource="Corporate">
SELECT * FROM page_content, RH
WHERE RH.filename = '#replace(cgi.script_name, "admin/", "", "All")#'
AND page_content.pageID = RH.ID
AND Title <> 'Intro Text'
ORDER BY title DESC
</cfquery>

<cfinclude template="inc_TOP.cfm">

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
				<a href="#link#" target="_blank">#linkText#</a><br>
			</cfif>
			#content#
		</cfif><br>
	</cfoutput>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="KB">
SELECT KB.ID, KB.Subject, KB.CAR, KB.Status, KB.Author, KB.Posted, KB.KBTopics, KB.Details, KBTopics.KBTopics 

FROM KB, KBTopics

WHERE KB.KBTopics = KBTopics.KBTopics
AND KB.Status IS NULL
AND KB.KBTopics = 'CAR Administration Tips'

ORDER BY KB.KBTopics, Subject
</CFQUERY>

<br>
<cfset KBTopicHolder = "">
<CFOUTPUT Query="KB">
<cfif KBTopicHolder IS NOT KB.KBTopics>
<cfIf KBTopicHolder is NOT ""><br></cfif>
<b>#KBTopics#</b><br>
</cfif>
<cfif Subject is "">
No Articles in this Topic exist.
<cfelse>
&nbsp;&nbsp; - <a href="#CARRootDir#KB.cfm?ID=#ID#">#Subject#</a><br>
</cfif>
<cfset KBTopicHolder = KB.KBTopics>
</CFOUTPUT>
</cfif>