<cfset subTitle = "Administration Actions">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<b>Available Actions</b><br />
<Cfoutput>
<cflock scope="Session" timeout="5">
<cfif isDefined("SESSION.Auth.IsLoggedInApp") AND SESSION.Auth.IsLoggedInApp eq "#this.name#"
	AND isDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.IsLoggedIn eq "Yes">
        <cfif SESSION.Auth.AccessLevel eq "QReports">
         :: <a href="#GCARMetricsDir#Report.cfm?ReportType=QE">CAR Trend Reports</a><br />
		<cfelseif SESSION.Auth.AccessLevel eq "SU">
			<cfif SESSION.Auth.EMPNO eq "06046" or SESSION.Auth.EMPNO eq "16963">
				 :: <a href="AdminMenu_DataUpdate.cfm?complete=0">Weekly Data Refresh</a><br>
			</cfif>
		 :: <a href="#GCARMetricsDir#Report.cfm?ReportType=QE">CAR Trend Reports</a><br />
		 <!---:: <a href="GroupingField_addToCAR.cfm">Add CAR Grouping</a><br>--->
		 :: CAR Management Chain List - FAQ 36 - <a href="#GCARMetricsDir#qManagementChain.cfm">View Report</a> :: <a href="#GCARMetricsDir#qManagementChain_Modify.cfm">Modify</a><br>
		 :: Observations - Root Cause Category - <a href="#GCARMetricsDir#qObservations_RootCauseCategory.cfm">View Report</a><br>
        </cfif>
<cfelse>
	<cflocation url="#GCARMetricsDir#index.cfm" addtoken="no">
</cfif>
</cflock>
</Cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->