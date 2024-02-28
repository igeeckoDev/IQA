<cfif isDefined("url.var") AND isDefined("url.varValue")>
<cfoutput>
#url.var# = #url.varValue#<br><Br>
</cfoutput>
</cfif>

<cfquery name="AllCARs" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
select Count(*) as CARTotal
FROM GCAR_Metrics
WHERE CARYear >= 2008
<cfif isDefined("url.var") AND isDefined("url.varValue")>
AND #url.var# = '#url.varValue#'
</cfif>
</cfquery>

<cfquery name="ExceptionGeography" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
select Count(*) as CARTotal, CARYear
FROM GCAR_Metrics
WHERE CARGeography = 'None Listed'
AND CARYear >= 2008
<cfif isDefined("url.var") AND isDefined("url.varValue")>
AND #url.var# = '#url.varValue#'
</cfif>
GROUP BY CARYear
</cfquery>

<cfoutput>
Total CARs: #AllCARs.CARTotal#<Br><Br>
</cfoutput>

CAR Geography "None Listed". If not in current year, these are errors/issues.<br>
<cfoutput query="ExceptionGeography">
#CARYear#: #CARTotal#<br>
</cfoutput><br>

<cfquery name="total" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
select Count(*) as CARYearTotal, CARYear
FROM GCAR_Metrics
WHERE CARYear >= 2008
<cfif isDefined("url.var") AND isDefined("url.varValue")>
AND #url.var# = '#url.varValue#'
</cfif>
GROUP BY CARYear
ORDER BY CARYear
</cfquery>

<Table border="1">
<tr>
    <th>CAR Year</th>
    <th>Total CARs</th>
    <th colspan="2">Findings</th>
    <th colspan="2">Observations</th>
    <th colspan="2">Local</th>
    <th colspan="2">Global</th>
    <th colspan="2">Regional</th>
</tr>
<cfoutput query="total">
<tr>
	<td>#CARYear#</td>
	<td>#CARYearTotal#</td>

    <cfquery name="classification" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    select Count(CARFindOrObservation) as CARYearClassificationTotal, CARYear, CARFindOrObservation
    FROM GCAR_Metrics
    WHERE CARYear = #CARYear#
    <cfif isDefined("url.var") AND isDefined("url.varValue")>
    AND #url.var# = '#url.varValue#'
    </cfif>
    GROUP BY CARYear, CARFindOrObservation
    ORDER BY CARYear, CARFindOrObservation
    </cfquery>
    
    <cfloop query="classification">
    <cfset pct = (100*(CARYearClassificationTotal / total.CARYearTotal))>
    <td>#CARYearClassificationTotal#</td>
    <td>#numberformat(pct, "99.99")#%</td>
    </cfloop>
    
    <cfquery name="geography" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    select Count(CARGeography) as CARYearGeographyTotal, CARYear, CARGeography
    FROM GCAR_Metrics
    WHERE CARYear = #CARYear#
    AND CARGeography <> 'None Listed'
    <cfif isDefined("url.var") AND isDefined("url.varValue")>
    AND #url.var# = '#url.varValue#'
    </cfif>
    GROUP BY CARYear, CARGeography
    ORDER BY CARYear, CARGeography
    </cfquery>
    
    <cfloop query="geography">
    <cfset pct = (100*(CARYearGeographyTotal / total.CARYearTotal))>
    <td>#CARYearGeographyTotal#</td>
    <td>#numberformat(pct, "99.99")#%</td>
    </cfloop>
</tr>
</cfoutput>

<cfquery name="total2" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
select Count(*) as CARYearTotal
FROM GCAR_Metrics
WHERE CARYear >= 2008
<cfif isDefined("url.var") AND isDefined("url.varValue")>
AND #url.var# = '#url.varValue#'
</cfif>
ORDER BY CARYear
</cfquery>

<cfoutput query="total2">
<tr>
	<th align="left">Total</th>
	<th align="left">#CARYearTotal#</th>
    
    <cfquery name="classification2" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    select Count(CARFindOrObservation) as CARYearClassificationTotal, CARFindOrObservation
    FROM GCAR_Metrics
    WHERE CARYear >= 2008
    <cfif isDefined("url.var") AND isDefined("url.varValue")>
    AND #url.var# = '#url.varValue#'
    </cfif>
    GROUP BY CARFindOrObservation
    ORDER BY CARFindOrObservation
    </cfquery>
    
    <cfloop query="classification2">
    <cfset pct = (100*(CARYearClassificationTotal / total2.CARYearTotal))>
    <th>#CARYearClassificationTotal#</th>
    <th>#numberformat(pct, "99.99")#%</th>
    </cfloop>
    
    <cfquery name="geography2" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    select Count(CARGeography) as CARYearGeographyTotal, CARGeography
    FROM GCAR_Metrics
    WHERE CARYear >= 2008
    AND CARGeography <> 'None Listed'
    <cfif isDefined("url.var") AND isDefined("url.varValue")>
    AND #url.var# = '#url.varValue#'
    </cfif>
    GROUP BY CARGeography
    ORDER BY CARGeography
    </cfquery>
    
    <cfloop query="geography2">
    <cfset pct = (100*(CARYearGeographyTotal / total2.CARYearTotal))>
    <th>#CARYearGeographyTotal#</th>
    <th>#numberformat(pct, "99.99")#%</th>
    </cfloop>   
</tr>
</cfoutput>
</Table>