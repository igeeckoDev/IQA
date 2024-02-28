<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "CAR Trend Reports - <a href=Report_Owners.cfm>Functional Group Owners</a> - Select Functions to Email">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfif isDefined("Form.Submit") AND isDefined("Form.Function")>

<cfset checkEmails = 0>

<cfloop index="ListElement" list="#Form.Function#"> 
	<cfquery name="checkEmail" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT Owner, Function, FunctionField, SortField
    FROM GCAR_Metrics_QReports
    WHERE ID = #ListElement#
    AND Owner IS NULL
    </cfquery>
    
	<cfif checkEmail.recordCount gt 0>
    The following report does not have an Owner listed.<br>
	Please add Owners in order to use the 'Send Email' function.<br><Br>
	
    	<cfoutput query="checkEmail">
			<cfinclude template="shared/incVariables_Report.cfm">
			:: #Function# by #sortFieldName# [<a href="Report_ChangeOwner.cfm?ID=#ListElement#">Add Owner</a>]<br>
            <cfset checkEmails = checkEmails + 1>
        </cfoutput><Br>
    <cfelse>
    	<cfset checkEmails = checkEmails>
    </cfif>
</cfloop>

<cfif checkEmails eq 0>
	<cflocation url="Report_EmailOwner_Send.cfm?ID=Select&List=#FORM.Function#" addtoken="no">
</cfif>

<cfelse>

<cfquery name="Owners" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Function, FunctionField, SortField, Owner, CC, ID
FROM GCAR_METRICS_QREPORTS
WHERE ReportType = 'QE'
ORDER BY Function
</cfquery>

<cfform name="SelectContacts" action="#CGI.Script_Name#" method="post">
<table border="1">
<tr align="center">
    <th>Function</th>
    <th>Function Owner</th>
    <th>FYI (cc)</th>
    <th>Select</th>
</tr>
<cfoutput query="Owners">
<tr>
    <cfinclude template="shared/incVariables_Report.cfm">
	<td valign="top">#Function#</td>
    <td valign="top"><cfif len(Owner)>#replace(Owner, ",", "<br />", "All")#<cfelse>--</cfif></td>
    <td valign="top"><cfif len(CC)>#replace(CC, ",", "<br />", "All")#<cfelse>--</cfif></td>
    <td align="center"><cfinput type="checkbox" name="Function" value="#ID#"></td>
</tr>
</cfoutput>
</table>
<br /><br />

<input type="submit" name="Submit" value="Email Selected Functions">
</cfform>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->