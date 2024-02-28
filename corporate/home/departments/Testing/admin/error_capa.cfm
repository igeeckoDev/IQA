<CFQUERY BLOCKFACTOR="100" NAME="Notify" DataSource="Corporate">
UPDATE ERROR_IQA
SET
Response='Entered',
<cfset N1 = #ReplaceNoCase(FORM.e_issue,chr(13),"<br>", "ALL")#>
Issue='#N1#',
<cfset N2 = #ReplaceNoCase(FORM.e_CAshort,chr(13),"<br>", "ALL")#>
CAshort='#N2#',
<cfset N3 = #ReplaceNoCase(FORM.e_CAlong,chr(13),"<br>", "ALL")#>
CAlong='#N3#',
<cfset N3 = #ReplaceNoCase(FORM.e_PAshort,chr(13),"<br>", "ALL")#>
PAshort='#N3#',
<cfset N5 = #ReplaceNoCase(FORM.e_PAlong,chr(13),"<br>", "ALL")#>
PAlong='#N5#'

WHERE ID = #URL.ID#
</CFQUERY>

<cfoutput>
	<cflocation url="error_view.cfm?id=#url.id#" ADDTOKEN="No">
</cfoutput>