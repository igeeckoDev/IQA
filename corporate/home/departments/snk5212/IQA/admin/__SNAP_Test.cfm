<cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Super">
SELECT SNAPSite, SuperLocation, ID, OfficeName
FROM IQAtblOffices
WHERE OfficeName = 'Brea, California'
</cfquery>

<cfset isSNAPSite = "No">

<CFIF Super.SuperLocation eq "Yes">
    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="SuperLocs">
    SELECT SNAPSite, SuperLocationID, ID, OfficeName
    FROM IQAtblOffices
    WHERE SuperLocationID = #Super.ID#
    ORDER BY OfficeName
    </cfquery>
    
	<cfif SuperLocs.recordcount GTE 1>
        <cfloop query="SuperLocs">
        	#OfficeName# / #SNAPSite#<br />
            <cfif SNAPSite is "Yes">
            	<cfset isSNAPSite = "Yes">
            </cfif>		
        </cfloop>
    </cfif>  
<cfelse>
	#Super.OfficeName# / #Super.SNAPSite#<br />
    <cfif Super.SNAPSite is "Yes">
		<cfset isSNAPSite = "Yes">
    <cfelse>
    	<cfset isSNAPSite = "No">
    </cfif>	
</CFIF>

isSNAPSite = #isSNAPSite#<br />

<cfif isSNAPSite eq "Yes">
	<cfset SNAPSiteCC = "cjnicastro@gmail.com">
<cfelse>
	<cfset SNAPSiteCC = "">
</cfif>

SNAPSiteCC = #SNAPSiteCC#<bR />

</cfoutput>