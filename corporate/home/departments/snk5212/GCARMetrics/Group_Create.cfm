<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "GCAR Metrics - Grouping Search Items - Confirm Group">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfinclude template="shared/incVariables_Report.cfm">

<cfif isDefined("url.dup") AND url.dup eq "Yes">
	<cfoutput>
    	<span class=warning>
        	The Group Name <b>#url.GroupName#</b> has already been created for a grouping of <b>#functionFieldName#</b> items.<Br />
            Please enter a new Group name.
        </span><br /><br />
        <cfset Form.GroupItems = url.GroupItems>
    </cfoutput>
</cfif>

<cfform action="Group_GroupName_Check.cfm">
<b>Category</b><br>
<cfoutput>#FunctionFieldName#</cfoutput><br><br>
<cfinput type="hidden" name="GroupType" value="#url.FunctionField#">

<b>Items to Group</b><br>
<cfloop from="1" to="#ListLen(Form.GroupItems)#" index="ItemName">
    <cfoutput>
	    <cfset ListItems = #replace(ListGetAt(Form.GroupItems, ItemName), "!!", ",", "All")#>
        #ListItems#<br>
    </cfoutput>
</cfloop><br>
<cfinput type="hidden" name="ItemName" value="#Form.GroupItems#">

<b>Group Name</b><br>
<cfinput type="text" name="groupName" required="yes" message="Group Name is Required" size="50"><br><br>

<input type="Submit" name="Submit" Value="Save Group" />
</cfform>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->