<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href='CARSurvey_Distribution.cfm'>CAR Survey</a> - <a href='CARSurvey_viewDistributions.cfm'>View Distributions</a> - Send Distribution List">
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
CARSurvey_distributionDetails.Email, CARSurvey_distributionDetails.Focus, CARSurvey_distributionDetails.ID

FROM
CARSurvey_Distribution, CARSurvey_distributionDetails

WHERE
CARSurvey_Distribution.ID = CARSurvey_distributionDetails.dID
AND CARSurvey_Distribution.ID = #URL.ID#
AND CARSurvey_distributionDetails.status IS NULL

Order By
Email
</CFQUERY>

<cfoutput query="Distribution">
<b>Survey Distribution List</b> for <b>#Year_# Quarter #Quarter#</b><br><br>
</cfoutput>

<cfif isdefined("URL.msg")>
	<font class="warning">
		<b>Input Error</b>:
		<cfoutput>
			#URL.msg#<br><br>
		</cfoutput>
	</font>
</cfif>

<cfmail
	to="#Email#"
	from="CAR.Corporate.Admin@ul.com"
	subject="CAR Survey - 1st Half of #Year_#"
	failto="CAR.Corporate.Admin@ul.com"
	replyto="CAR.Corporate.Admin@ul.com"
	type="html"
	bcc="Kai.Huang@ul.com"
	query="DistributionDetails">
Dear CAR Owner / Owner’s Assistant:<br>
We would like to know how helpful we were with your CAR experience(s) so far in #Year_#.<br><br>

Please take a few moments to share with us things that we did well in addition to opportunities we have to improve. The below link will take you to a brief CAR survey. If any of your comments are specific to a certain CAR Administrator/Champion, please include their name in your comments.<Br><br>

Thanks in advance for your feedback.<br><br>

<a href="http://usnbkiqas100p/departments/snk5212/QE/getEmpNo.cfm?page=CARSurvey&dID=#URL.ID#">Open Survey</a><br><br>
</cfmail>

<cfoutput>
	<cfset postDate = #now()#>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" name="SurveySent" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE CARSurvey_Distribution
SET
SentDate = #postDate#,
Status = 'Sent'
WHERE ID = #URL.ID#
</cfquery>

<cflocation url="CARSurvey_manageDistribution.cfm?ID=#URL.ID#" addtoken="no">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->