<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KB">
SELECT KB.ID, KB.Subject, KB.Status, KB.Author, KB.Posted, KB.KBTopics, KB.Details, KBTopics.KBTopics
FROM KB, KBTopics
WHERE KB.KBTopics = KBTopics.KBTopics
AND KB.Status IS NULL
ORDER BY KB.KBTopics, KB.ID, KB.Subject
</CFQUERY>

<cfset KBTopicHolder = "">
<CFOUTPUT Query="KB">
	<cfif KBTopicHolder IS NOT KB.KBTopics>
    <cfIf len(KBTopicHolder)><br></cfif>
    <b>#KBTopics#</b><br>
    </cfif>

	<cfif Subject is "">
    No Articles in this Topic exist.
    <cfelse>
    &nbsp;&nbsp; - <a href="KB.cfm?ID=#ID#">#Subject#</a><br>
    </cfif>

<cfset KBTopicHolder = KB.KBTopics>
</CFOUTPUT>