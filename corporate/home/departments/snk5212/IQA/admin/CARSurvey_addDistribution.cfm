<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href='CARSurvey_Distribution.cfm'>CAR Survey</a> - Add Distribution">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif isDefined("Form.Submit")>
	<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT
	ID, Quarter, Year_

	FROM
	CARSurvey_Distribution

	WHERE
	Year_ = #Form.Year#
	AND Quarter = #Form.Quarter#
	</CFQUERY>

	<cfif Distribution.recordcount eq 1>
	A survey distribution has already been created for <cfoutput><b>#Form.Year# Quarter #Form.Quarter#</b>.
	You can view and edit this distribution <a href="CARSurvey_manageDistribution.cfm?ID=#Distribution.ID#">here</a></cfoutput>.
	<cfelse>
	    <CFQUERY BLOCKFACTOR="100" name="NewUserID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	    SELECT MAX(ID)+1 as NewID
	    FROM CARSurvey_Distribution
	    </CFQUERY>

		<!--- insert name in to CARSurvey_Users Table --->
	    <CFQUERY NAME="AddAuditor" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	    INSERT INTO CARSurvey_Distribution(ID, Year_, Quarter)
		VALUES(#NewUserID.NewID#, #Form.Year#, #Form.Quarter#)
	    </cfquery>

		<cflocation url="CARSurvey_viewDistributions.cfm" addtoken="no">
	</cfif>

<cfelse>
	<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT
	ID, Quarter, Year_

	FROM
	CARSurvey_Distribution

	ORDER BY
	Year_, Quarter
	</CFQUERY>

	<cfif Distribution.recordcount GT 0>
	<b>Current Distributions:</b><br>
		<cfoutput query="Distribution">
			:: <a href="CARSurvey_manageDistribution.cfm?ID=#ID#">#Year_# Quarter #Quarter#</a><br>
		</cfoutput>
	<cfelse>
	No Survey Distributions have been created.<br>
	</cfif><br>

	<!--- included for Form Validation and Formatted Form Textarea boxes --->
	<!--- form name and id must be "myform" --->
	<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

	<cfform method ="post" id="myform" name="myform" action="CARSurvey_addDistribution.cfm" enctype="multipart/form-data">

	<b>Create a Survey Distribution:</b><br><br>

	<u>Select Year</u>:<Br>
	<cfselect
	    queryposition="below"
	    name="Year"
	    data-bvalidator="required"
	    data-bvalidator-msg="Select a Year">
		<option value="">Select Year Below
		<cfloop index="i" to="#nextyear#" from="2014">
			<cfoutput><OPTION VALUE="#i#">#i#</cfoutput>
		</cfloop>
	</cfSELECT>
	<br><br>

	<u>Select Quarter</u>:<Br>
	<cfselect
	    queryposition="below"
	    name="Quarter"
	    data-bvalidator="required"
	    data-bvalidator-msg="Select a Quarter">
		<option value="">Select Year Below
		<cfloop index="i" to="4" from="1">
				<cfoutput><OPTION VALUE="#i#">#i#</cfoutput>
		</cfloop>
	</cfSELECT>
	<br><Br>

	<cfinput name="submit" type="submit" value="Add Distribution">
	<cfinput name="submit" type="reset" value="Reset Form"><br /><br />
	</cfform>

	<!--- required for form validation --->
	<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->