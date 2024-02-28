<cfif NOT isDefined("URL.ShowAll")>
	<cfset URL.ShowAll = "No">
</cfif>

<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - View Audit Non-Conformances">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfinclude template="#IQADir#TechnicalAudits_qReporting_Output.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->