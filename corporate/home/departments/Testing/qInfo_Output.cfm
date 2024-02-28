<CFQUERY BLOCKFACTOR="100" name="output" Datasource="Corporate">
SELECT ID, Name AS "nName", Moves, NewFacilities, Changes, Scheduling, Posted 
FROM Info
ORDER BY Name, Posted DESC
</CFQUERY>

<br>

<cfif output.recordcount eq 0>
There is no data currently available.
<cfelse>

<b>Submitted By:</b><br>
<cfset NameHolder = "">					  
<cfoutput query="output">
<cfif NameHolder IS NOT nName> 
<cfIf len(NameHolder)><br></cfif>
#nName#<br>
</cfif>
 - <a href="info_detail.cfm?ID=#ID#">#Dateformat(Posted, 'mm/dd/yyyy')#</a><br>
<cfset NameHolder = nName> 
</cfoutput>					  					  

</cfif>