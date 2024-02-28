<!--- Start of Page File --->
<cfset subTitle = "CAR Administrator - Confirm Delete">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<CFQUERY BLOCKFACTOR="100" NAME="Details" DataSource="Corporate">
SELECT * FROM CARAdminList
WHERE ID = #URL.ID#
</cfquery>

<cfoutput>					  
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="CARAdminDelete.cfm?ID=#URL.ID#">

Do you wish to delete the CAR Admin Profile of <u>#Details.Name#</u>?<br /><br />

<INPUT TYPE="Submit" name="Delete" Value="Confirm Request">
<INPUT TYPE="Submit" name="Delete" Value="Cancel Request">

</FORM>
</cfoutput>	  

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->