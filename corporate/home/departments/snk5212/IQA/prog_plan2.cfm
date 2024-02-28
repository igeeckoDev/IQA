<cfsetting requestTimeOut="300">

<cfif isDefined("URL.View")>
	<cfif URL.View is "NACPO">
    	<cfset subTitle = "IQA Activity - Audit Coverage - North American Certifications Program Office (NA CPO) Programs Coverage">
    </cfif>
<cfelse>
	<cfset subTitle = "IQA Activity - Audit Coverage - Programs Coverage">
</cfif>

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfinclude template="qProg_Plan2.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->