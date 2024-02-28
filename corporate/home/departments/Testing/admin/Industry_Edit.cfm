<CFQUERY Name="GF" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * From TechnicalAudits_Industry
WHERE ID = #URL.ID#
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Internal Technical Audits - Industry List Control - Edit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<br>
<CFOUTPUT query="GF">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="Industry_edit_update.cfm?ID=#URL.ID#">

Industry Name: <b>#Industry#</b><Br>
<input name="Industry" type="text" value="#Industry#" size="70">
<br><br>

Change Status: (Current Status: <cfif len(Status)>#Status#<cfelse>Active</cfif>)<Br>
<cfif NOT len(status)>
	:: <a href="Industry_Status.cfm?ID=#URL.ID#&Action=Remove">Remove</a> #Industry#<br><br>
<cfelseif status eq "Removed">
	:: <a href="Industry_Status.cfm?ID=#URL.ID#&Action=Reinstate">Reinstate</a> #Industry# (currently Removed)<br><br>
</cfif>

<input name="submit" type="submit" value="Submit"> 
</form>
</CFOUTPUT>
				  
<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->