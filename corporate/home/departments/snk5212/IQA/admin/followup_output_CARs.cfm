<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT *
 FROM TPREPORT
 WHERE YEAR_='2007' AND  AuditedBy = 'IQA'
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</cfquery>

<cfoutput query="View">
<cfset CARList = CAR1 & ", " & CAR2 & ", " & CAR3 & ", " & CAR4 & ", " & CAR5 & ", " & CAR6 & ", " & CAR7 & ", " & CAR8 & ", " & CAR9 & ", " & CAR10 & ", " & CAR11 & ", " & CAR12 & ", " & CAR13 & ", " & CAR14 & ", " & CAR15 & ", " & CAR16 & ", " & CAR17 & ", " & CAR18 & ", " & CAR19 & ", " & CAR20 & ", " & CAR21 & ", " & CAR22 & ", " & CAR23 & ", " & CAR24 & ", " & CAR25 & ", " & CAROther>

<u>#year#-#id#</u><br>
<cfset dump = #replace(CARList, "N/A, ", "", "All")#>
<cfset dump1 = #replace(dump, ", N/A", "", "All")#>
<cfset dump2 = #replace(dump1, "N/A", "", "All")#>
<cfif dump2 is "">
No CARs Found<br><br>
<cfelse>
#dump2#<br><br>
</cfif>
</cfoutput>