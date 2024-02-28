<cfoutput>
<div id="left">
	<div class="content-pad">
    	<!--- IQA Path --->
		 <cfset thisDir = "#IQADir#">
		<cfif Path eq "#IQAPath#">
            <h2>IQA Menu</h2>
                <cfset thisDir = "#IQADir#">
        <!--- IQA Admin Path - Show IQA Admin Path Menu for all pages except global_login.cfm, which uses the IQA Path Menu --->
        <cfelseif Path eq "#DAPPath#">
			<h2>DAP Menu</h2>
				<cfset thisDir = "#DAPDir#">
		<cfelseif Path eq "#IQAPath_Admin#">
        	<cfif cgi.script_name EQ "#IQADir_Admin#global_login.cfm">
                <h2>IQA Menu</h2>
                    <cfset thisDir = "#IQADir#">
			<cfelseif cgi.script_name NEQ "#IQADir_Admin#global_login.cfm">
	            <h2>IQA Admin Menu</h2>
	                <cfset thisDir = "#IQADir_Admin#">
			</cfif>
        <!--- IQA Web Help Path --->
		<cfelseif Path eq "#IQAWebHelpPath#">
            <h2>IQA Web Help Menu</h2>
                <cfset thisDir = "#IQAWebHelpDir#">
        <!--- CAR Path --->
		<cfelseif Path eq "#CARPath#">
            <h2>CAR Process Menu</h2>
                <cfset thisDir = "#CARDir#">
        <!--- CAR Admin Path - Show CAR Admin Path Menu for all pages except global_login.cfm, which uses the CAR Path Menu --->
        <cfelseif Path eq "#CARPath_Admin#">
        	<cfif cgi.script_name EQ "#CARDir_Admin#global_login.cfm">
                <h2>CAR Process Menu</h2>
                    <cfset thisDir = "#CARDir#">
			<cfelseif cgi.script_name NEQ "#CARDir_Admin#global_login.cfm">
	            <h2>CAR Process Admin Menu</h2>
	                <cfset thisDir = "#CARDir_Admin#">
			</cfif>
        <!--- CAR Admin Calibration Path --->
        <cfelseif Path eq "#CAR_CalibrationMeeting_Path#">
			<h2>CAR Admin Calibration Meetings Menu</h2>
            <cfset thisDir = "#CAR_CalibrationMeeting_Dir#">
        <!--- GCAR Metrics Path --->
        <cfelseif Path eq "#GCARMetricsPath#">
            <h2>GCAR Metrics Menu</h2>
                 <cfset thisDir = "#GCARMetricsDir#">
        <!--- GCAR Metrics Admin Path --->
        <cfelseif Path eq "#GCARMetricsAdminPath#">
            <!---
			<h2>GCAR Metrics Admin Menu</h2>
			--->
                 <cfset thisDir = "#GCARMetricsAdminDir#">
		<!--- UL Accreditations Path --->
        <cfelseif Path eq "#AccreditationsPath#">
            <h2>UL Accreditations Menu</h2>
                <cfset thisDir = "#AccreditationsDir#">
       <!--- Quality Engineering Path --->
        <cfelseif Path eq "#QEPath#">
            <h2>Quality Engineering Menu</h2>
                <cfset thisDir = "#QEDir#">
        <!--- FAQ Path --->
        <cfelseif Path eq "#FAQPath#">
        	<h2>FAQ Menu</h2>
            	<cfset thisDir = "#FAQDir#">
        <!--- Audit Planning Path --->
        <cfelseif Path eq "#PlanningPath#">
        	<h2>2011-2012 Audit Planning Menu</h2>
            	<cfset thisDir = "#PlanningDir#">
        </cfif>

		<!--- include the menu for the given path defined above --->
        <cfinclude template="#thisDir#shared/menu.cfm">

		<!--- if we are in the applications named IQA or QE (CAR Process Website), check for logins --->
		<cfif this.name eq "IQA" OR this.name eq "QE">
	        <cfinclude template="incLoggedInStatus.cfm">
        </cfif>

        <!--- include site status (if in development, etc) --->
        <cfinclude template="incSiteStatus.cfm">

         <!--- include Error Reporting Link --->
        <cfinclude template="incErrorReporting.cfm">
	</div>
</div>
</cfoutput>