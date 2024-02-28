<CFQUERY BLOCKFACTOR="100" NAME="RootCause" DataSource="Corporate"> 
SELECT * FROM CAR_RootCause
WHERE ID = #URL.ID#
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "CAR Root Cause  - #URL.Action#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="RootCause_Remove.cfm?ID=#RootCause.ID#&Action=#URL.Action#">

<cfoutput query="RootCause">
Do you wish to #URL.Action# Root Cause Category <b>#Category#</b>?<br><br>

<u>Note</u> - You can change the status of this Root Cause from the Edit page in the future<br><br>
</cfoutput>

<INPUT TYPE="Submit" name="Remove" Value="Confirm Request">
<INPUT TYPE="Submit" name="Remove" Value="Cancel Request">

</cfFORM>
						  
<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->