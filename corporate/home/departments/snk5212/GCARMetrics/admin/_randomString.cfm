<cfset chars = "0123456789abcdefghiklmnopqrstuvwxyz" / >
<cfset strLength = 12001 / >
<cfset randout = "" / >

<cfloop from="1" to="#strLength#" index="i">
	<cfset rnum = ceiling(rand() * len(chars)) / >
	<cfif rnum EQ 0 ><cfset rnum = 1 / ></cfif>
	<cfset randout = randout & mid(chars, rnum, 1) / >
</cfloop>

<cfdump var="#randout#">