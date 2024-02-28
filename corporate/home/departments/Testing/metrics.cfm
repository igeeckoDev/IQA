<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subtitle = "Schedule Attainment Metrics - #URL.Year# #URL.AuditedBy#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif URL.AuditedBy eq "IQA">
    <CFQUERY Datasource="Corporate" Name="baseline">
    SELECT *
    FROM Baseline
    WHERE Year_ = #url.Year#
    </cfquery>

    <cfoutput query="baseline">
        <cfif baseline is 0>
            <font color="red"><b>#url.year# IQA Audit Schedule is tentative</b></font><br><br />
        </cfif>
    </cfoutput>
</cfif>


<cfinclude template="qMetrics.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->