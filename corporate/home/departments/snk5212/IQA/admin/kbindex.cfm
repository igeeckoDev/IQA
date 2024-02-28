<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KB">
SELECT KB.ID, KB.Subject, KB.Status, KB.Author, KB.Posted, KB.KBTopics, KB.Details, KBTopics.KBTopics
FROM KB, KBTopics
WHERE KB.KBTopics = KBTopics.KBTopics
AND KB.Status IS NULL
ORDER BY KB.KBTopics, KB.ID, KB.Subject
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "IQA / CAR Process Knowledge Base">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfinclude template="KBMenu.cfm">

<br><br>

<cfset KBTopicHolder = "">
<CFOUTPUT Query="KB">
<cfif KBTopics is NOT "test">
<cfif KBTopicHolder IS NOT KB.KBTopics>
<cfIf KBTopicHolder is NOT ""><br></cfif>
<b>#KBTopics#</b><br>
</cfif>
<cfif Subject is "">
No Articles in this Topic exist.
<cfelse>
<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.accesslevel is "SU" or SESSION.Auth.accesslevel is "Admin">
&nbsp;&nbsp; - <a href="KB.cfm?ID=#ID#">#Subject#</a> (<a href="kbedit.cfm?ID=#ID#">edit</a>)<br>
<cfelse>
<cfif Author is SESSION.AUTH.Name>
&nbsp;&nbsp; - <a href="KB.cfm?ID=#ID#">#Subject#</a> (<a href="kbedit.cfm?ID=#ID#">edit</a>)<br>
<cfelse>
&nbsp;&nbsp; - <a href="KB.cfm?ID=#ID#">#Subject#</a><br>
</cfif>
</cfif>
</cflock>
</cfif>
</cfif>
<cfset KBTopicHolder = KB.KBTopics>
</CFOUTPUT>


<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->