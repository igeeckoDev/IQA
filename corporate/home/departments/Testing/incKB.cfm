<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KB">
SELECT * FROM KB
WHERE ID = #URL.ID#
</CFQUERY>

<CFOUTPUT Query="KB">
<b>Subject</b><Br />
#Subject#<br><br />

<b>Date Posted</b><br />
#DateFormat(Posted, "mmmm dd, yyyy")#<br><br />

<b>Added to KB by</b><br />
#Added#<br><br />

<b>Author</b><br />
#Author#<br><br />

<b>CAR Training Related</b><br />
#CAR#<br /><br />

<b>Category</b><br />
#KBTopics#<br /><br />

<cfif len(File_)>
	<b>Attachment</b><br />
    <a href="../IQA/KB/Attachments/#File_#">View</a> (#File_#)<br><br>
</cfif>

<b>Details</b><br />
<cfset dump = #replace(Details, "<p>", "", "All")#>
<cfset dump2 = #replace(dump, "</p>", "<br><br>", "All")#>
#Dump2#
</CFOUTPUT>