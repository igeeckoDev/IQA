<cfquery name="Report" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Function, FunctionField
FROM GCAR_METRICS_QREPORTS
WHERE ID = #URL.ID#
</cfquery>

<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "CAR Trend Reports - Change Owner - <a href='Report_Details.cfm?ID=#URL.ID#'>#Report.Function#</a>">

<cfinclude template="shared/incVariables_Report.cfm">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<script language=javascript>
	window.name = "doUpLoadProc";
</script>

<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function popUp(URL) {
day = new Date();
id = day.getTime();
eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width=450,height=350,left = 200,top = 200');");
}
// End -->
</script>

<cfif isDefined("Form.Submit") AND Form.Submit eq "Add Contact to Current List"
	OR isDefined("Form.Submit") AND Form.Submit eq "Save New List">

	<cfif isDefined("Form.ownerList") AND len(Form.ownerList)>
        <cfset newOwner = "#form.ownerList#">
    <cfelseif isDefined("Form.Owner") AND len(Form.Owner)>
        <cfset newOwner = "#form.owner#">
    <cfelse>
        <cflocation url="#cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#" addtoken="no">
    </cfif>

    <cfquery name="Report" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT Function, FunctionField, TopItems, SortField, TopItems_CARSource, Owner
    FROM GCAR_METRICS_QREPORTS
    WHERE ID = #URL.ID#
    </cfquery>

    <cfquery name="Report" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE GCAR_METRICS_QREPORTS
    SET 
    
    <cfif Form.Submit eq "Add Contact to Current List">
    Owner = '#ListAppend(Report.Owner, newOwner)#'
    <cfelseif Form.Submit eq "Save New List">
    Owner = '#newOwner#'
    </cfif>
    
    WHERE ID = #URL.ID#
    </cfquery>

    <cflocation url="#cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#" addtoken="no">

<cfelse>

<cfif isDefined("Form.Submit") AND Form.Submit eq "Add Contact to New List">
	<cfset ownerList = listAppend(url.ownerList, "#form.Owner#")>
<cfelse>
	<cfif isDefined("url.ownerList")>
		<cfset ownerList = "#url.ownerList#">
 	<cfelse>
    	<cfset ownerList = "">
    </cfif>
</cfif>

<cfoutput>
	<cfif len(ownerList)>
        <b>New Owners List</b> <span class="warning">Not Yet Saved!</span><br />
        #replace(ownerList, ",", "<br />", "All")#<br /><br />
    </cfif>
</cfoutput>

<cfquery name="Report" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Function, FunctionField, TopItems, SortField, TopItems_CARSource, Owner, ID
FROM GCAR_METRICS_QREPORTS
WHERE ID = #URL.ID#
</cfquery>

<cfoutput query="Report">
	<cfinclude template="shared/incVariables_Report.cfm">
	<b>Function</b>: #Function# by #FunctionFieldName#<br><br />

    <b>Current Owner(s)</b>:
    <cfif ListLen(Owner) gt 0>
    	[<a href="Report_RemoveOwner.cfm?#cgi.QUERY_STRING#&List=#Owner#&ListItem=All">Remove All Contacts</a>]<br />
        <cfloop from="1" to="#ListLen(Owner)#" index="OwnerListItem">
	        #ListGetAt(Owner, OwnerListItem)# [<a href="Report_RemoveOwner.cfm?#cgi.QUERY_STRING#&List=#Owner#&ListItem=#OwnerListItem#">remove</a>]<Br />
        </cfloop>
    <cfelse>
    	None<br />
    </cfif><br />    

    <cfform action="#cgi.script_name#?#cgi.query_string#" name="form" method="post">
 
    <cfif isDefined("Form.Submit") AND Form.Submit eq "Add Contact to New List">
    	<cfset OwnerValue = "">
    <cfelseif isDefined("Form.Submit") AND Form.Submit NEQ "Add Contact to New List">
        <cfif isDefined("Form.Owner")>
    	    <cfset OwnerValue = "#Form.Owner#">
    	<cfelse>
        	<cfset OwnerValue = "">
    	</cfif>
    <cfelseif NOT isDefined("Form.Submit")>
        <cfif isDefined("Form.Owner")>
    	    <cfset OwnerValue = "#Form.Owner#">
    	<cfelse>
        	<cfset OwnerValue = "">
    	</cfif>
	</cfif>
    
    <span class="warning">Please use the link below to look up UL Email addresses</span><br><br />
    
    <b>Select New Owner</b><br />
    External UL Email Addresses Only<Br>
    :: <a href="javascript:popUp('EmailLookup.cfm?ID=#ID#&ownerList=#ownerList#&pageName=Report_ChangeOwner.cfm')">Lookup UL Email</a><br><br>
   
    <cfinput type="hidden" name="Owner" size="50" value="#OwnerValue#">
    <cfif len(OwnerValue)>
    Selected: #OwnerValue#<br />   
    </cfif><br />
    
    <cfinput type="hidden" name="ownerList" value="#ownerList#">    
    
		<cfif len(OwnerValue)>
        <!--- if there is a new OwnerValue (email address) that has been selected from the popup --->
            <input type="Submit" name="Submit" Value="Add Contact to New List" />
            
            <!--- if there is NOT an ownerList (i.e., no New List created), allow the user to add the ownerValue to the Current List --->
            <cfif NOT len(OwnerList)>
            	<input type="Submit" name="Submit" Value="Add Contact to Current List" />
            </cfif>
        </cfif>
        
        <!--- if there is an OwnerList (i.e, New List created), allow the user to save the list in place of the old one --->
        <cfif len(OwnerList)>
        	<input type="Submit" name="Submit" Value="Save New List" />
        </cfif>
    </cfform>
</cfoutput>

</cfif>

<br /><br />
<b><u>Instructions</u></b><br />
1. <b>Remove Names</b> - You can remove names from the <u>Current Owner(s)</u> list by selecting <u>remove</u> next to the appropriate name. You can also remove all names by selectiong <u>Remove All Contacts</u>.<br /><br />

2. <b>Add Names</b> - You can add a new name to the <u>Current Owner(s)</u> list by selecting <u>Lookup UL Email</u>, selecting a name, then selecting the <u>Add Contact to Current List</u> button. The new names are immediately saved to the <u>Current Owner(s)</u> list.<br /><br />

3. <b>Create New List</b> - You can create a <u>New Owner(s)</u> list by selecting <u>Lookup UL Email</u>, selecting a name, then selecting the <u>Add Contact to New List</u> button. You can continue to add names to the <u>New Owner(s)</u> list in this fashion. <span class="warning">Note - the new list is NOT saved until you complete Step 4</span><br /><br />

4. <b>Save New List</b> - In order to save the <u>New Owner(s)</u> list, you must select the <u>Save New List</u> button.<br /><br />

5. <b>Discarding a New List Without Saving</b> - <span class="warning">Leaving the page will discard a new list that has not been saved.</span>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->