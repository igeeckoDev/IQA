<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href=select_office.cfm>UL Locations</a> - Office Status">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<!--- included for Form Validation and Formatted Form Textarea boxes --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

<cfquery Datasource="Corporate" name="Details"> 
SELECT *
FROM IQAtblOffices
WHERE ID = #URL.ID#
</CFQUERY>

<b>Details</b><br />
<cfoutput query="Details">
<u>Office Name</u>: <a href="Office_Details.cfm?ID=#ID#">#OfficeName#</a><Br>
<u>Region</u>: #Region#<br>
<u>SubRegion</u>: #SubRegion#<br><Br />

<FORM id="myform" name="myform" METHOD="POST" ACTION="Office_Details_Status_Submit.cfm?ID=#ID#">

<Cfset InputName = "Exist">

<u>Office Status</u>: <cfif Exist eq "Yes">Active<cfelse>Inactive</cfif><br />

Active <input type="radio" name="#InputName#" value="Yes" <cfif Exist eq "Yes">CHECKED</cfif>> 
Inactive <input type="radio" name="#InputName#" value="No" <cfif Exist eq "No">CHECKED</cfif> data-bvalidator="required" data-bvalidator-msg="Select Site Status (Active/Inactive)">
<Br><br>

<input type="submit" value="Save and Continue">
<input type="reset" value="Reset Form">
</form>
</cfoutput>

<br>
Note - <font class="warning">DO NOT</font> inactivate a site that is currently on the Audit Schedule. Inactivating is only to be done when the site is not audited, and there are no plans to audit the site.<br><br>

Note - A site can be re-activated in the same manner as it is Inactivated.<br><br>

<!--- required for form validation --->
<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->