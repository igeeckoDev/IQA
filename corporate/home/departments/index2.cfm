<cfset A = "Hello17199">

<cfoutput>
#A#
</cfoutput>

==<br><br>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate2" NAME="Accounts">
SELECT *
FROM Corporate.IQADB_LOGIN
ORDER BY AccessLevel, Status DESC, Region, SubRegion, UserName
</CFQUERY>

<CFQUERY DataSource="Corporate2" Name="BaseLine">
    SELECT * FROM Corporate.BASELINE
    
    </cfquery>

<cfdump var="#Accounts#">
<cfdump var="#Baseline#">