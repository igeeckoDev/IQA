<!--- Start of Page File --->
<cfset subTitle = "Quality Alerts - Metrics">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
			
<cfif isDefined("URL.Type")>
	<cfif URL.Type is "SC">
	 <cfinclude template="qMetricsSC.cfm">
	<cfelseif URL.Type is "KP">
	 <cfinclude template="qMetricsKP.cfm"> 
	<cfelseif URL.Type is "Office">
	 <cfinclude template="qMetricsOffice.cfm">
	<cfelseif URL.Type is "Sector">
	 <cfinclude template="qMetricsSector.cfm">
	<cfelseif URL.Type is "">
	 <cflocation url="viewMetrics.cfm" addtoken="No">
	</cfif><br>
	 Return to <a href="viewMetrics.cfm">Quality Alerts Metrics</a>
<cfelse>
	<cflocation url="viewMetrics.cfm" addtoken="No">
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->