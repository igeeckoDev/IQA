<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Status"> 
SELECT Status, ID 
FROM IQADB_LOGIN
WHERE ID = #URL.ID#
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "IQA Audit Database Users - Change Account Status">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfFORM METHOD="POST" name="sAccredAction" ACTION="ViewUsers_ChangeStatus_Action.cfm?ID=#URL.ID#">

<b>Current Account Status</b>: 
<cfoutput query="Status">
    <cfif len(Status)>
        #Status#
        <cfset curStatus = Status>
    <cfelse>
        Active
        <cfset curStatus = "Active">
    </cfif><br><br>
</cfoutput>

<b>Change Account Status</b> <Cfoutput>(Current: #CurStatus#)</Cfoutput><br>
<SELECT NAME="Status">
	<OPTION VALUE="">Select New Status</OPTION>
    <OPTION VALUE="">---</OPTION>
	<OPTION VALUE="Active">Active</OPTION>
    <OPTION VALUE="removed">Inactive</OPTION>
	<OPTION VALUE="Test">Test Account</OPTION>
</SELECT><br><br>

<INPUT TYPE="Submit" name="ChangeStatus" Value="Change Status">
</cfform>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->