<cfquery Datasource="Corporate" name="Labs">
SELECT * from IQAOffices_Areas
WHERE ID = #URL.OfficeName#
AND IQA = 1
ORDER BY LAB
</CFQUERY>

<cfquery Datasource="Corporate" name="OfficeName">
SELECT * from IQAtblOffices
WHERE ID = #URL.OfficeName#
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Laboratories - <cfoutput>#OfficeName.OfficeName#</cfoutput>">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<br>
<cfoutput query="OfficeName">
<b>#OfficeName#</b><br>
</cfoutput>

<cfif Labs.recordcount is 0>
There are no Laboratories listed for this office.<br>
</cfif>

<cfoutput query="labs">
- #Lab#
	<cflock scope="Session" timeout="5">
		<cfif Session.Auth.AccessLevel eq "SU" OR Session.Auth.AccessLevel eq "Admin">
			<a href="labs_edit.cfm?LabID=#LabID#&ID=#URL.OfficeName#">(edit)</a><br>
		</cfif>
	</cflock>
</cfoutput>

<cflock scope="Session" timeout="5">
	<cfif Session.Auth.AccessLevel eq "SU" OR Session.Auth.AccessLevel eq "Admin">
<cfoutput>
<br>
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddLabs" action="Add_Labs.cfm?OfficeName=#URL.OfficeName#">

Add Lab:<br>
<input name="Lab" type="Text" value="" size="50">
<br><br>

<input name="submit" type="submit" value="Submit">
</form>
</cfoutput>
<br><br>
	</cfif>
</cflock>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->