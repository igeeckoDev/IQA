<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "UL Locations - Office Details (Edit)">
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

<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfif curyear gte 2006 AND curyear lte 2008>
	<cfset StartYear = 2006>
<cfelseif curyear gte 2009 AND curyear lte 2011>
	<cfset StartYear = 2009>
<cfelseif curyear gte 2012 AND curyear lte 2014>
	<cfset StartYear = 2012>	
</cfif>

<cfoutput>
    <cflock scope="SESSION" timeout="60">
        <CFIF SESSION.Auth.AccessLevel is "SU" 
            OR SESSION.Auth.AccessLevel is "Admin" 
            OR SESSION.Auth.AccessLevel is "IQAAuditor">
            <cfset AuditedBy = "IQA">
        <cfelse>
            <cfset AuditedBy = #SESSION.Auth.SubRegion#>
        </cfif>
    </cflock>
</cfoutput>

<b>Details</b><br />
<cfoutput query="Details">
<u>Office Name</u>: <a href="Office_Details.cfm?ID=#ID#">#OfficeName#</a><Br>
<u>Region</u>: #Region#<br>
<u>SubRegion</u>: #SubRegion#<br><Br />

<FORM id="myform" name="myform" METHOD="POST" ACTION="Office_Details_Edit_Submit.cfm?ID=#ID#">

<Cfset InputName = "VS">
<u>Verification Services (VS) Internal Audit Site</u>: <cfif VS eq "Yes">#VS#<cfelse>No</cfif><br />
Yes <input type="radio" name="#InputName#" value="Yes" <cfif VS eq "Yes">CHECKED</cfif>> 
No <input type="radio" name="#InputName#" value="No" <cfif VS neq "Yes">CHECKED</cfif> data-bvalidator="required" data-bvalidator-msg="Select #InputName# Internal Audit Site Yes/No">
<Br><br>

<Cfset InputName = "ULE">
<u>UL Environment (ULE) Internal Audit Site</u>: <cfif ULE eq "Yes">#ULE#<cfelse>No</cfif><br />
Yes <input type="radio" name="#InputName#" value="Yes" <cfif ULE eq "Yes">CHECKED</cfif>> 
No <input type="radio" name="#InputName#" value="No" <cfif ULE neq "Yes">CHECKED</cfif> data-bvalidator="required" data-bvalidator-msg="Select #InputName# Internal Audit Site Yes/No">
<Br><br>

<Cfset InputName = "WiSE">
<u>WiSE Internal Audit Site</u>: <cfif WiSE eq "Yes">#WiSE#<cfelse>No</cfif><br />
Yes <input type="radio" name="#InputName#" value="Yes" <cfif WiSE eq "Yes">CHECKED</cfif>> 
No <input type="radio" name="#InputName#" value="No" <cfif WiSe neq "Yes">CHECKED</cfif> data-bvalidator="required" data-bvalidator-msg="Select #InputName# Internal Audit Site Yes/No">
<Br><br>

<cfset InputName = "LHS">
<u>Life and Health Sciences Internal Audit Site</u>: <cfif LHS eq "Yes">#LHS#<cfelse>No</cfif><br />
Yes <input type="radio" name="#InputName#" value="Yes" <cfif LHS eq "Yes">CHECKED</cfif>> 
No <input type="radio" name="#InputName#" value="No" <cfif LHS neq "Yes">CHECKED</cfif> data-bvalidator="required" data-bvalidator-msg="Select #InputName# Internal Audit Site Yes/No">
<Br><br>

<cfset InputName = "LabScope">
<u>Lab Scope Review Required</u>: <cfif LabScope eq "Yes">#LabScope#<cfelse>No</cfif><br />
Yes <input type="radio" name="#InputName#" value="Yes" <cfif LabScope eq "Yes">CHECKED</cfif>> 
No <input type="radio" name="#InputName#" value="No" <cfif LabScope neq "Yes">CHECKED</cfif> data-bvalidator="required" data-bvalidator-msg="Select Lab Scope Review Required Yes/No">
<Br><br>

<input type="submit" value="Save and Continue">
<input type="reset" value="Reset Form">
</form>
</cfoutput>

<!--- required for form validation --->
<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->