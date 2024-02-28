<CFQUERY BLOCKFACTOR="100" name="Log" DataSource="Corporate">
SELECT * FROM PathCount
WHERE Path IS NOT NULL
ORDER BY Path
</cfquery>

<cfset var=ArrayNew(2)>
<cfset i = 1>
<cfoutput query="Log">
<cfset var[i][1] = '#Log.Path#'>
<cfset var[i][2] = '#Log.CountOfID#'>
<cfset i = i + 1>
</cfoutput>

<cfoutput>
#var[1][1]# - #var[1][2]#<br><br>
</cfoutput>

<cfloop index="i" from="1" to="#ArrayLen(var)#">
<CFQUERY BLOCKFACTOR="100" name="Log2" DataSource="Corporate">
SELECT * FROM PathCount2
WHERE Path = '#var[i][1]#'
ORDER BY Path
</cfquery>
<cfoutput query="Log2">
#Path# - #CountOfID#<br>
</cfoutput>
<hr>
</cfloop>