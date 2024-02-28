<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "GCAR Metrics - Grouping Search Items - Confirm Group">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfinclude template="shared/incVariables_Report.cfm">

<!--- check for name conflict --->
<cfquery name="checkGroups" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT GroupName, GroupType
FROM GCAR_Metrics_Function_Grouping
WHERE GroupName = '#Form.GroupName#'
AND GroupType = '#Form.GroupType#'
</cfquery>

<cfdump var="#form#">

<cfif checkGroups.recordCount gt 0>
	<!--- go back to Group.Create.cfm --->
    <cflocation url="Group_Create.cfm?dup=Yes&GroupName=#Form.GroupName#&FunctionField=#Form.GroupType#&GroupItems=#Form.ItemName#"
	    addtoken="no">
<cfelse>
	<!--- continue to Group_Submit.cfm --->
    <cflocation url="Group_Submit.cfm?GroupName=#Form.GroupName#&GroupType=#Form.GroupType#&ItemName=#Form.ItemName#"
    	addtoken="no">
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->