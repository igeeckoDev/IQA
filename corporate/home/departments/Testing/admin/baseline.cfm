<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Schedule Baseline">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Datasource="Corporate" Name="baseline">
SELECT Baseline.*, Baseline.Year_ AS "Year" 
FROM Baseline
ORDER BY Year_
</cfquery>

<CFQUERY Datasource="Corporate" Name="baseline2"> 
SELECT Baseline.*, Baseline.Year_ AS "Year" 
FROM Baseline
WHERE YEAR_ = #url.year#
</cfquery>

<br><u>Current status</u>:<br>
<cfoutput query="baseline">
	<cfif year lt curyear>
	#Year#
	<cfelse>
	<a href="baseline.cfm?year=#year#">#Year#</a>
	</cfif>
: <cfif baseline is 1>Yes<cfelseif baseline is 0>No<cfelse>No Data</cfif><br>
</cfoutput>
<br>

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="SQL" ACTION="Baseline_Submit.cfm">

Year:<br>
<cfoutput query="baseline2"><b>#url.year#</b>
<input type="hidden" name="year" value="#url.year#"></cfoutput>
<br><br>

Schedule Baselined?<br>
<cfif isdefined("url.year")>
	<cfswitch expression="#baseline2.Baseline#">
		<cfcase value="1">
		Yes <INPUT TYPE="Radio" name="Baseline" value="1" checked> No <INPUT TYPE="Radio" name="Baseline" value="0">
		</cfcase>
		<cfcase value="0">
		Yes <INPUT TYPE="Radio" name="Baseline" value="1"> No <INPUT TYPE="Radio" name="Baseline" value="0" checked>
		</cfcase>
		<cfcase value="">
		Yes <INPUT TYPE="Radio" name="Baseline" value="1"> No <INPUT TYPE="Radio" name="Baseline" value="0">
		</cfcase>
	</cfswitch>
<cfelse>
Yes <INPUT TYPE="Radio" name="Baseline" value="1"> No <INPUT TYPE="Radio" name="Baseline" value="0" checked>
</cfif>

<br><br>

<INPUT TYPE="Submit" value="Submit">
</form>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->