<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="GetData">
SELECT *
FROM Corporate.Report
WHERE Year_ = 2008
AND AuditedBy = 'IQA'
</CFQUERY>

<cfset TotalFinding = 0>
<cfset TotalObservation = 0>

<cfoutput query="GetData">
    <cfset AuditFinding = Count1+Count2+Count3+Count4+Count5+Count6+Count7+Count8+Count9+Count10+Count11+Count12+Count13+Count14+Count15+Count16+Count17+Count18+Count19+Count20+Count21+Count22+Count23+Count24+Count25+Count26+Count27+Count28+Count29+Count30+Count31+Count32+Count33+Count34+Count35+Count36+Count37+CountOther>
    
    <cfset TotalFinding = TotalFinding + AuditFinding>

    <cfset AuditObservation = OCount1+OCount2+OCount3+OCount4+OCount5+OCount6+OCount7+OCount8+OCount9+OCount10+OCount11+OCount12+OCount13+OCount14+OCount15+OCount16+OCount17+OCount18+OCount19+OCount20+OCount21+OCount22+OCount23+OCount24+OCount25+OCount26+OCount27+OCount28+OCount29+OCount30+OCount31+OCount32+OCount33+OCount34+OCount35+OCount36+OCount37+OCountOther>
    
    <cfset TotalObservation = TotalObservation + AuditObservation>
</cfoutput>

<cfoutput>
Finding - #TotalFinding#<br>
Observation - #TotalObservation#<br>
Audits - #getData.recordcount#<br>
Average = <cfset Average = (#TotalFinding# + #TotalObservation#) / #getData.recordcount#> #Average#<br><Br>
</cfoutput>