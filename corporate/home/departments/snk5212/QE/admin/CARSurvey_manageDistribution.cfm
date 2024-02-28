<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href='CARSurvey_Distribution.cfm'>CAR Survey</a> - <a href='CARSurvey_viewDistributions.cfm'>View Distributions</a> - Manage Distribution List">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
*

FROM
CARSurvey_Distribution

WHERE
CARSurvey_Distribution.ID = #URL.ID#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="DistributionDetails" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
CARSurvey_Distribution.Year_, CARSurvey_Distribution.Quarter, CARSurvey_Distribution.SentDate,
CARSurvey_distributionDetails.Email, CARSurvey_distributionDetails.Focus, CARSurvey_distributionDetails.ID,
CARSurvey_distributionDetails.Status

FROM
CARSurvey_Distribution, CARSurvey_distributionDetails

WHERE
CARSurvey_Distribution.ID = CARSurvey_distributionDetails.dID
AND CARSurvey_Distribution.ID = #URL.ID#

Order By
Status DESC, Email
</CFQUERY>

<cfoutput query="Distribution">
<b>Survey Distribution List</b> for <b>#Year_# Quarter #Quarter#</b><br><br>
<cfif Status neq "Sent">
	:: <a href="CARSurvey_addSurveyParticipant.cfm?dID=#URL.ID#">Add Recipient</a><br>
</cfif>
<cfif DistributionDetails.recordCount GT 0>
	<cfif Status eq "Sent">
		:: Distribution Sent on #dateformat(sentDate, "mm/dd/yyyy")#
	<cfelse>
		:: <a href="CARSurvey_sendDistribution.cfm?ID=#URL.ID#">Send Distribution</a>
	</cfif>
<cfelse>
 :: Send Distribution - There must be at least one recipient in order to send the survey email</a>
</cfif><br><br>
</cfoutput>

<cfif isdefined("URL.msg")>
	<font class="warning">
		<b>Input Error</b>:
		<cfoutput>
			#URL.msg#<br><br>
		</cfoutput>
	</font>
</cfif>

<cfset YearHolder = "">

<cfif DistributionDetails.RecordCount GT 0>
    <table border="1" width="650">
    	<tr>
	        <th>Email</th>
	        <th>Status</th>
	        <th><cfif Distribution.Status eq "Sent">View<cfelse>Edit</cfif></th>
        </tr>
		<cfoutput query="DistributionDetails">
			<tr>
	            <td valign="top">
					<div align="left">
			            #Email#

						<cfif Distribution.Status NEQ "Sent">
				            <cfif len(Status) AND Status eq "removed">
					            [<a href="CARSurvey_reinstateDistributionItem.cfm?ID=#ID#&dID=#URL.ID#">Reinstate</a>]
							</cfif>
						</cfif>
		            </div>
	            </td>
	            <td valign="top" align="center">
					<CFQUERY BLOCKFACTOR="100" name="Response" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
					SELECT * FROM CARSurvey_Users WHERE Distribution_UserID = #ID#
					</CFQUERY>

					<cfif Distribution.Status eq "Sent">
						<cfif Response.Responded eq "Yes">
							Responded #dateformat(Response.Posted, "mm/dd/yyyy")# <cfif Response.RecordCount GT 1>(#Response.Recordcount# Responses)</cfif>
						<cfelse>
							<cfif len(Status) AND status eq "removed">
								--
							<Cfelse>
								No Response
							</cfif>
						</cfif>
					<cfelse>
						N/A
					</cfif>
				</td>
				<td valign="top" align="center">
		            <cfif Distribution.Status eq "Sent">
						<cfif Response.Responded eq "Yes">
				            <a href="CARSurvey_Details.cfm?UserID=#ID#">View Survey</a>
						<cfelse>
							<cfif len(Status) AND status eq "removed">
				        		<font class=warning>Removed</font>
				        	<cfelse>
				        		--
				        	</cfif>
						</cfif>
					<cfelse>
			        	<cfif len(Status) AND status eq "removed">
			        		<font class=warning>Removed</font>
			        	<cfelse>
			        		<a href="CARSurvey_removeDistributionItem.cfm?ID=#ID#&dID=#URL.ID#">Remove</a>
			        	</cfif>
			        </cfif>
	            </td>
	        </tr>
	    </cfoutput>
    </table>
<cfelse>
	No names have been added to the distribution<br><br>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->