<CFQUERY Name="SME" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM SME
WHERE ID = #URL.ID#
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Subject Matter Expert - Edit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<br>
<CFOUTPUT query="SME">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="SME_edit_update.cfm?ID=#URL.ID#">

Subject Matter Expert (external email address):<br>
<input name="SME" type="text" value="#SME#" size="60">
<br><br>

<cfif NOT len(status)>
	:: <a href="SME_delete.cfm?ID=#URL.ID#">Remove</a> #SME#<br><br>
<cfelseif status eq "Removed">
	:: <a href="SME_Reinstate.cfm?ID=#URL.ID#">Reinstate</a> #SME# (currently Removed)<br><br>
</cfif>

<input name="submit" type="submit" value="Submit">
</form>
</CFOUTPUT>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->