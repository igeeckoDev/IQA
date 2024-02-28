<cfoutput>
<cfif Trim(RescheduleNextYear) is "Yes">
<!--- do nothing --->
<cfelseif Trim(Status) is "Removed">
	<!--- added 8/29/2007 --->
    <b>Status</b><br>
    <font color="red">Removed from Audit Schedule (Deleted)</font>
    <!--- /// --->
<cfelse>
	<b>Status</b><br>
	<cfif Trim(FollowUp) is "Notes">
        <!--- This condition is for TPTDP audits only --->
        <img src="#IQADir#images/orange.jpg" border="0">
    <cfelse>
        <cfif trim(year) gt CurYear>
		<!--- audit is in future year --->
            <cfif Trim(Status) is NOT "deleted">
		        <!--- if not deleted, yellow --->
	            <img src="#IQADir#images/yellow.jpg" border="0"> - Audit Scheduled
            <cfelseif Trim(Status) is "deleted">
            	<!--- cancelled audit in the future --->
                <img src="#IQADir#images/black.jpg" border="0"> - Audit Cancelled
            </cfif>
        <cfelseif trim(year) is CurYear>
        <!--- audit is in current year --->
			<cfif Trim(Report) is NOT "" and Trim(Status) is NOT "deleted">
                <!--- NOT deleted and report field not blank --->
                <cfif auditedby is "Field Services">
                    <!--- FS uploads report files --->
                    <img src="#IQADir#images/green.jpg" border="0"> - Audit Completed
                <cfelse>
                <!--- for IQA and internal audits that use the audit report form, if report is anything other than "Completed" and not null --->
                    <cfif Trim(Report) is "Entered"
                            or Trim(Report) is "1"
                            or Trim(Report) is "2"
                            or Trim(Report) is "3"
                            or Trim(Report) is "4"
                            or Trim(Report) is "5">
                        <img src="#IQADir#images/blue.jpg" border="0"> - Audit Completed, Awaiting Report
                    <cfelseif Trim(Report) is "Completed"
                                or Trim(Report) is "#year#-#id#.pdf"
                                or Trim(Report) CONTAINS "#year#-#id#.">
                        <!--- report completed --->
                        <img src="#IQADir#images/green.jpg" border="0"> - Audit Completed, Report Published
                    </cfif>
                </cfif>
        	<cfelseif Trim(Report) is "" and Trim(Status) is NOT "deleted">
        	<!--- NOT deleted and report field blank --->
            	<cfif Trim(Month) is CurMonth>
                <!--- current month --->
					<cfif Trim(EndDate) is "" and Trim(StartDate) is NOT "">
                    <!--- only start date listed ---->
                        <cfif Trim(StartDate) lt CurDate>
                        <!--- startdate less than current date - audit already began --->
                        <!--- currently there are no reports for TA, so it is considered done after the audit is finished--->
                            <img src="#IQADir#images/blue.jpg" border="0"> - Audit Completed, Awaiting Report
                        <cfelse>
                            <!--- no report and the start date is gte current date --->
                            <img src="#IQADir#images/yellow.jpg" border="0"> - Audit Scheduled
                        </cfif>
                    <!--- dates are blank --->
                    <cfelseif Trim(EndDate) is "" and Trim(StartDate) is "">
                        <img src="#IQADir#images/yellow.jpg" border="0"> - Audit Scheduled
                    <!--- both dates entered --->
					<cfelseif Trim(EndDate) is NOT "" and Trim(StartDate) is NOT "">
                    <!--- audit is in process --->
						<cfif Trim(StartDate) lt CurDate AND Trim(EndDate) gte CurDate>
                        	<img src="#IQADir#images/blue.jpg" border="0"> - Audit In Process
                        <!--- audit is over, awaiting report --->
                        <cfelseif Trim(EndDate) lt CurDate>
                        	<img src="#IQADir#images/blue.jpg" border="0"> - Audit Completed, Awaiting Report
                        <cfelseif Trim(StartDate) gte CurDate>
                        <!--- audit has not happened yet --->
                            <img src="#IQADir#images/yellow.jpg" border="0"> - Audit Scheduled
                        </cfif>
                    </cfif>
				<cfelseif CurMonth gt Trim(Month)>
                <!---  audit in a past month --->
	                <img src="#IQADir#images/blue.jpg" border="0"> - Audit Completed, Awaiting Report
                <cfelse>
                <!--- audit is in the future, in this year --->
                    <img src="#IQADir#images/yellow.jpg" border="0"> - Audit Scheduled
                </cfif>
            <cfelse>
            <!--- is status is deleted --->
 	           <img src="#IQADir#images/black.jpg" border="0"> - Audit Cancelled
            </cfif>

        <cfelseif year is "2004" or year is "2005">
		<!--- audit from 2004 and 2005 - there were only PDF reports --->
		    <cfif Trim(Status) is "Deleted">
    			<img src="#IQADir#images/black.jpg" border="0"> - Audit Cancelled
    		<cfelseif Trim(Report) is NOT "">
    			<img src="#IQADir#images/green.jpg" border="0"> - Audit Completed
    		<cfelseif Trim(Report) is "">
        		<cfif Trim(AuditType) is "Technical Assessment">
        			<img src="#IQADir#images/green.jpg" border="0"> - Audit Completed
        		<cfelse>
        			<img src="#IQADir#images/blue.jpg" border="0"> - Audit Completed, Awaiting Report
        		</cfif>
    		</cfif>
		<cfelseif year gt 2005 AND year lt curyear>
 <!--- years 2006 through the previous year --->
			<cfif Trim(Status) is "Deleted">
            	<img src="#IQADir#images/black.jpg" border="0"> - Audit Cancelled
            <cfelseif Trim(Report) is "Completed">
            	<img src="#IQADir#images/green.jpg" border="0"> - Audit Completed, Report Completed
            <cfelseif AuditedBy is "Field Services" AND Report is NOT "">
            	<img src="#IQADir#images/green.jpg" border="0"> - Audit Completed, Report Completed
            <cfelseif Trim(Report) is NOT "Completed">
                <cfif Trim(AuditType2) is "Technical Assessment" AND Trim(Report) is NOT "">
                	<img src="#IQADir#images/green.jpg" border="0"> - Audit Completed
                <cfelseif Trim(AuditType2) is "Technical Assessment" AND Trim(Report) is "">
                	<img src="#IQADir#images/blue.jpg" border="0"> - Audit Completed, Awaiting Report
                <cfelseif Trim(Report) CONTAINS "#year#-#id#.">
                	<img src="#IQADir#images/green.jpg" border="0"> - Audit Completed
                <cfelse>
                	<img src="#IQADir#images/blue.jpg" border="0">
                </cfif>
            </cfif>
		</cfif>
	</cfif>
</cfif>
</cfoutput>