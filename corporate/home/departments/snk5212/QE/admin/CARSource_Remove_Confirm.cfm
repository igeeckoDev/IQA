<CFQUERY BLOCKFACTOR="100" NAME="CARSource" DataSource="Corporate"> 
SELECT * FROM CARSource
WHERE ID = #URL.ID#
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "CAR Source - #URL.Action#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="CARSource_Remove.cfm?ID=#CARSource.ID#&Action=#URL.Action#">

<cfoutput query="CARSource">
Do you wish to #URL.Action# CAR Source <b>#CARSource#</b>?<br><br>

<u>Note</u> - You can change the status of this CAR Source from the Edit page in the future<br><br>
</cfoutput>

<INPUT TYPE="Submit" name="Remove" Value="Confirm Request">
<INPUT TYPE="Submit" name="Remove" Value="Cancel Request">

</cfFORM>
						  
<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->