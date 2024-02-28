<cfset SR=ArrayNew(2)>

<cfoutput>
	<cfloop index=i from=1 to=37>
		<CFSET SR[#i#][1] = "SR#i#">
	</cfloop>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View">
SELECT * FROM Report
WHERE ID = 1 AND Year_ = 2015
</cfquery>

<cfoutput query="View">
	<cfloop index=i from=1 to=37>
		#SR1#
	</cfloop>
</cfoutput>

<!---
<cfoutput>
	<cfloop index=i from=1 to=37>
		#SR[i][1]# - #SR[i][2]#<br>
	</cfloop>
</cfoutput>
--->