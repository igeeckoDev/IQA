<CFQUERY Name="GF" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * From TechnicalAudits_CCN
WHERE ID = #URL.ID#
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Internal Technical Audits - CCN List Control - Edit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<br>
<CFOUTPUT query="GF">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="CCN_edit_update.cfm?ID=#URL.ID#">

CCN Name: <b>#CCN#</b><Br>
<input name="CCN" type="text" value="#CCN#" size="70" maxlength="5">
<br><br>

Change Status: (Current Status: <cfif len(Status)>#Status#<cfelse>Active</cfif>)<Br>
<cfif NOT len(status)>
	:: <a href="CCN_Status.cfm?ID=#URL.ID#&Action=Remove">Remove</a> CCN #CCN#<br><br>
<cfelseif status eq "Removed">
	:: <a href="CCN_Status.cfm?ID=#URL.ID#&Action=Reinstate">Reinstate</a> CCN #CCN# (currently Removed)<br><br>
</cfif>

<input name="submit" type="submit" value="Submit"> 
</form>
</CFOUTPUT>
				  
<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->