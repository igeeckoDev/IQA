<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="KPI" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT MAX(ID) as MaxID
FROM KPI
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="getYearMonth" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Year_, Month
FROM KPI
WHERE ID = #KPI.MaxID#
</CFQUERY>

<cfif getYearMonth.Month eq 12>
	<cfset varMonth = 1>
	<cfset varYear = getYearMonth.Year_ + 1>
<cfelse>
	<cfset varMonth = getYearMonth.Month + 1>
	<cfset varYear = getYearMonth.Year_>
</cfif>

<cfoutput>
	<b>Year/Month to Add</b><br>
	<u>Year</u>: #varYear#<br>
	<u>Month</u>: #monthAsString(varMonth)#<br><br>
</cfoutput>

<table border=1>
	<tr>
		<td>Effectively Closed CAR %</td>
		<!--- CARs Verified Effective / [Effective + Ineffective], when CAR Open Date is in the last 3 years, i.e., Month Posted/01/curyear minus 3--->
		
		<cfset varThreeYear = curYear - 3>
		<cfset varNextMonth = varMonth + 1>
		
		<CFQUERY BLOCKFACTOR="100" name="EffectiveCARs" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		SELECT DISTINCT CARNumber
		FROM GCAR_Metrics
		WHERE 
			(CARCloseDate >= TO_DATE('#varThreeYear#-#varNextMonth#-01', 'yyyy-mm-dd')
			AND CARCloseDate <= TO_DATE('#curYear#-#varNextMonth#-01', 'yyyy-mm-dd')) 
			
		AND CARState = 'Closed - Verified as Effective'
		AND CARFindOrObservation = 'Finding'
		</cfquery>
		
		<CFQUERY BLOCKFACTOR="100" name="VerifiedCARs" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		SELECT DISTINCT CARNumber
		FROM GCAR_Metrics
		WHERE 
			(CARCloseDate >= TO_DATE('#varThreeYear#-#numberformat(varNextMonth, 00)#-01', 'yyyy-mm-dd') <!--- greater than or equal to 2014-05-01 --->
			AND CARCloseDate <= TO_DATE('#curYear#-#numberformat(varNextMonth, 00)#-01', 'yyyy-mm-dd')) <!--- less than or equal to 2017-05-01 --->
		AND 
			(CARState = 'Closed - Verified as Effective'
			OR CARState = 'Closed - Verified as Ineffective')
		AND CARFindOrObservation = 'Finding'
		</cfquery>
		
		<cfset CARVerifiedEffectiveRate = EffectiveCARs.recordcount / VerifiedCARs.recordcount>
		
		<td align="center">
			<cfoutput>
				#CARVerifiedEffectiveRate#<br>
				#EffectiveCARs.recordcount# / #VerifiedCARs.recordcount#<br>
				From #varThreeYear#-#varNextMonth#-01<br>
				To #curYear#-#varNextMonth#-01
			</cfoutput>
		</td>
	</tr>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->