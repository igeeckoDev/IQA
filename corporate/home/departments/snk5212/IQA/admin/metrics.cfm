<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Schedule Attainment Metrics">
<cfinclude template="SOP.cfm">

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

<cfinclude template="#IQARootDir#qMetrics.cfm">
					  					  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->