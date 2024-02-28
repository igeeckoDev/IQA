<CFQUERY Name="Standard" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * 
From TechnicalAudits_Standard
WHERE ID = #URL.ID#
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Internal Technical Audits - Standard List Control - Edit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<br>
<CFOUTPUT query="Standard">
<CFFORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="Standard_edit_update.cfm?ID=#URL.ID#">

Standard Name: <b>#StandardName# (#RevisionNumber#, #dateformat(RevisionDate, "mm/dd/yyyy")#)</b><Br>
<input name="StandardName" type="text" value="#StandardName#" size="70">
<br><br>

Revision/Edition Number:<br>
<input name="RevisionNumber" type="Text" size="70" value="#RevisionNumber#">
<br><br>

Revision/Edition Date: (mm/dd/yyyy)<br>
<div style="position:relative; z-index:3">
<cfinput type="datefield" name="RevisionDate" value="#dateformat(RevisionDate, "mm/dd/yyyy")#" validate="date" maxlength="10">
</div>
<br><br><br />

Change Status: (Current Status: <cfif len(Status)>#Status#<cfelse>Active</cfif>)<Br>
<cfif NOT len(status)>
	:: <a href="Standard_Status.cfm?ID=#URL.ID#&Action=Remove">Remove</a> Standard #StandardName# (#RevisionNumber#, #dateformat(RevisionDate, "mm/dd/yyyy")#)<br><br>
<cfelseif status eq "Removed">
	:: <a href="Standard_Status.cfm?ID=#URL.ID#&Action=Reinstate">Reinstate</a> Standard #StandardName# (#RevisionNumber#, #dateformat(RevisionDate, "mm/dd/yyyy")#) (currently Removed)<br><br>
</cfif>

<input name="submit" type="submit" value="Submit"> 
</CFform>
</CFOUTPUT>
				  
<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->