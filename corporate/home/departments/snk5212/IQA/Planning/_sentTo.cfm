<CFQUERY BLOCKFACTOR="100" name="Recipients" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT SentTo 
from UL06046.AuditPlanning2017_Users
Where SentTo <> 'LQM Response'
</CFQUERY>

<cfoutput>
	<cfset strList = valueList(Recipients.SentTo, ",")>
	<cfset strList = replace(strList, ",", "<br>", "All")>
	
	<br><br>---<br><br>
	</cfoutput>

<cfloop list=#strList# index=i>
	<cfset listStruct[i] = i />
</cfloop>

<cfoutput>
#structKeyList(listStruct)#
</cfoutput>

