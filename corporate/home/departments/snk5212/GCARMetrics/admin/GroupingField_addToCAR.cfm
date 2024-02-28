<cfset subTitle = "Administration Actions - Add Grouping Information to CARs">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<!--- included for Form Validation and Formatted Form Textarea boxes --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

<CFQUERY BLOCKFACTOR="100" name="ViewGroupings" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM GCAR_Metrics_GroupingField
ORDER BY GroupingName
</cfquery>

<b>Group Names</b> [<a href="GroupingField_Manage.cfm">Manage</a>]<br>
<cfoutput query="ViewGroupings">
#GroupingName#<br>
</cfoutput><br>

<cfform action="GroupingField_addToCAR_Submit.cfm" method ="post" id="myform" name="myform">
<u>CAR Number</u><br>
<cfinput type="text" name="CARNumber" data-bvalidator="required" data-bvalidator-msg="CAR Number">
<br><Br>

<u>Grouping</u><br>
<cfselect
    queryposition="below"
    name="GroupingName"
    data-bvalidator="required"
    data-bvalidator-msg="Grouping"
	query="ViewGroupings"
	Display="GroupingName"
	Value="ID">

    <option></option>
</cfselect><br><Br>

<input type="submit" value="Save and Continue">
<input type="reset" value="Reset Form">
</cfform>

<!--- required for form validation --->
<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->