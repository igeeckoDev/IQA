<cfif NOT isDefined("URL.Year")>
	<cfset url.year = #curyear#>
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitleHeading = "Audit Calendar List View - <cfoutput>#url.year#</cfoutput>">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY DataSource="Corporate" Name="BaseLine">
SELECT * FROM Baseline
WHERE Year_ = #URL.Year#
</cfquery>

<cfif BaseLine.BaseLine eq 0>
	<cfoutput>
	<font color="red"><b>#URL.Year# IQA Audit Schedule is tentative.</b></font><br><Br>
	</cfoutput>
</cfif>

<cfinclude template="qAudit_List2.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->