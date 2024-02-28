<cfoutput>
	<!--- future year audit --->
    <cfif trim(year) gt CurYear>
    
		<cfif Trim(Status) is NOT "deleted">
            <!--- audit not cancelled --->
            <img src="#IQARootDir#images/yellow.jpg" border="0">
        <cfelse>
            <!--- audit cancelled --->
            <img src="#IQARootDir#images/black.jpg" border="0">
        </cfif>

	<!--- current year audit --->
    <cfelseif trim(year) is CurYear>

		<!--- Audit Cancelled --->
        <cfif Trim(Status) is "deleted">
            <img src="#IQARootDir#images/black.jpg" border="0">
        <!--- Audit Report(s) are attached --->
        <cfelseif AttachCheck.RecordCount gt 0>
            <img src="#IQARootDir#images/green.jpg" border="0">
        <!--- no Audit Report(s) attached --->
        <cfelseif AttachCheck.RecordCount eq 0>
            <!--- audit is in current month --->
            <cfif Trim(Month) is CurMonth>
                <!--- Start Date, no End Date --->
                <cfif NOT len(EndDate) AND Len(StartDate)>
                    <!--- Audit is in process or is in the past --->
                    <cfif Trim(StartDate) lt CurDate>
                        <img src="#IQARootDir#images/blue.jpg" border="0">
                    <!--- Audit has not started yet --->
                    <cfelseif Trim(StartDate) gte CurDate>
                        <img src="#IQARootDir#images/yellow.jpg" border="0">
                    </cfif>
                <!--- no dates listed --->
                <cfelseif NOT Len(EndDate) AND NOT Len(StartDate)>
                    <img src="#IQARootDir#images/yellow.jpg" border="0">
                <!--- Start Date and End Date present --->
                <cfelseif Len(EndDate) AND Len(StartDate)>
                    <!--- Audit has started --->
                    <cfif Trim(StartDate) lte CurDate>
                        <!--- Is audit in process or is it over? --->
                        <cfif Trim(EndDate) gte CurDate>
                            <img src="#IQARootDir#images/blue.jpg" border="0">
                        <cfelseif Trim(EndDate) lt CurDate>
                            <img src="#IQARootDir#images/blue.jpg" border="0">
                        </cfif>
                    </cfif>
                </cfif>	
            <cfelseif CurMonth gt Trim(Month)>
                    <img src="#IQARootDir#images/blue.jpg" border="0">
            <cfelseif CurMonth lt Trim(Month)>
                <img src="#IQARootDir#images/yellow.jpg" border="0">
            </cfif>
        </cfif>

	<cfelseif trim(year) lt CurYear>

		<cfif Trim(Status) is NOT "deleted">
	        <cfif AttachCheck.RecordCount gt 0>
            	<img src="#IQARootDir#images/green.jpg" border="0">
        	<cfelse>
            	<img src="#IQARootDir#images/blue.jpg" border="0">
            </cfif>
		<cfelse>
            <img src="#IQARootDir#images/black.jpg" border="0">
        </cfif>
	</cfif>
</cfoutput>