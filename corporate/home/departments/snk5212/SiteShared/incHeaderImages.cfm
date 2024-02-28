<cfoutput>
	<cfset SiteStyle = "/departments/snk5212/SiteShared/cr_style.css">

	<cfset QEHeaderImage = "#SiteDir#SiteImages/hdr_qual_eng.jpg">
    <cfset QEHeaderImageAlt = "Quality Engineering Header Image">

	<cfset CQHeaderImage = "#SiteDir#SiteImages/hdr_corp_qual.jpg">
    <cfset CQHeaderImageAlt = "Corporate Quality Header Image">
    
	<cfset CARMetricsHeaderImage = "#SiteDir#SiteImages/hdr_car_metrics.jpg">
    <cfset CARMetricsHeaderImageAlt = "CAR Metrics Header Image">

    <cfif Path eq "#IQAPath#">
        <cfset HeaderImage = "#QEHeaderImage#">
        <cfset HeaderAlt = "#QEHeaderImageAlt#">
    <cfelseif Path eq "#IQAWebHelpPath#">
        <cfset HeaderImage = "#QEHeaderImage#">
        <cfset HeaderAlt = "#QEHeaderImageAlt#">
    <cfelseif Path eq "#IQAPath_Admin#">
        <cfset HeaderImage = "#QEHeaderImage#">
        <cfset HeaderAlt = "#QEHeaderImageAlt#">
    <cfelseif Path eq "#CARPath#">
        <cfset HeaderImage = "#QEHeaderImage#">
        <cfset HeaderAlt = "#QEHeaderImageAlt#">
    <cfelseif Path eq "#CARPath_Admin#">
        <cfset HeaderImage = "#QEHeaderImage#">
        <cfset HeaderAlt = "#QEHeaderImageAlt#">
    <cfelseif Path eq "#GCARMetricsPath#" OR Path eq "#GCARMetricsAdminPath#">
        <cfset HeaderImage = "#CARMetricsHeaderImage#">
        <cfset HeaderAlt = "#CARMetricsHeaderImageAlt#">
    <cfelseif Path eq "#AccreditationsPath#">
        <cfset HeaderImage = "#QEHeaderImage#">
        <cfset HeaderAlt = "#QEHeaderImageAlt#">
    <cfelseif Path eq "#QEPath#">
        <cfset HeaderImage = "#QEHeaderImage#">
        <cfset HeaderAlt = "#QEHeaderImageAlt#">
    <cfelseif Path eq "#FAQPath#">
        <cfset HeaderImage = "#QEHeaderImage#">
        <cfset HeaderAlt = "#QEHeaderImageAlt#">
    <cfelseif Path eq "#QECMPath#">
        <cfset HeaderImage = "#QEHeaderImage#">
        <cfset HeaderAlt = "#QEHeaderImageAlt#">
    </cfif>
</cfoutput>