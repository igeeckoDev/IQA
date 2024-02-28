<cfoutput>
<cfif Trim(RescheduleNextYear) is "Yes">
<!--- added 8/29/2007 --->
<cfelseif Trim(Status) is "Removed">
    <u>Status</u><br>
    <font color="red">Removed from Audit Schedule (Deleted)</font>
    <!--- /// --->
<cfelse>
    <u>Status</u><br>
	<cfif trim(year) gt CurYear>
		<cfif Trim(Status) is NOT "deleted">
            <img src="#IQARootDir#images/yellow.jpg" border="0"> - Audit Scheduled
        <cfelse>
            <img src="#IQARootDir#images/black.jpg" border="0"> - Audit Cancelled
        </cfif>
    <cfelseif trim(year) is CurYear>
		<cfif Trim(Report) is NOT "" and Trim(Status) is NOT "deleted">
        	<img src="#IQARootDir#images/green.jpg" border="0"> - Audit Completed
        <cfelseif Trim(Report) is "" and Trim(Status) is NOT "deleted">
            <cfif Trim(Month) is CurMonth>
                <cfif Trim(EndDate) is "" and Trim(StartDate) is NOT "">
                    <cfif Trim(StartDate) lt CurDate>
                        <img src="#IQARootDir#images/green.jpg" border="0"> - Audit Completed
                    <cfelse>
                        <img src="#IQARootDir#images/yellow.jpg" border="0"> - Audit Scheduled
                    </cfif>
                <cfelseif Trim(EndDate) is "" and Trim(StartDate) is "">
                    <img src="#IQARootDir#images/yellow.jpg" border="0"> - Audit Scheduled
                <cfelseif Trim(EndDate) is NOT "" and Trim(StartDate) is NOT "">
                    <cfif Trim(EndDate) lt CurDate or Trim(StartDate) lt CurDate>
                            <img src="#IQARootDir#images/green.jpg" border="0"> - Audit Completed
                    <cfelseif Trim(EndDate) gte CurDate or Trim(StartDate) gte CurDate>
                        <img src="#IQARootDir#images/yellow.jpg" border="0"> - Audit Scheduled
                    </cfif>
                </cfif>
            <cfelseif CurMonth gt Trim(Month)>
                    <img src="#IQARootDir#images/green.jpg" border="0"> - Audit Completed
            <cfelse>
                <img src="#IQARootDir#images/yellow.jpg" border="0"> - Audit Scheduled
            </cfif>
        <cfelse>
            <img src="#IQARootDir#images/black.jpg" border="0"> - Audit Cancelled
        </cfif>
    <cfelse>
        <cfif Trim(Status) is NOT "deleted">
            <img src="#IQARootDir#images/green.jpg" border="0"> - Audit Completed
        <cfelse>
            <img src="#IQARootDir#images/black.jpg" border="0"> - Audit Cancelled
        </cfif>
    </cfif>
</cfif>
</cfoutput>