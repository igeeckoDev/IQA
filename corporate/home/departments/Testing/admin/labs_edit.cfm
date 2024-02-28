<cfquery Datasource="Corporate" name="Labs"> 
SELECT * from IQAOffices_Areas
WHERE ID = #URL.ID#
AND LabID = #URL.LabID#
</CFQUERY>

<cfquery Datasource="Corporate" name="OfficeName"> 
SELECT * from IQAtblOffices
WHERE ID = #URL.ID#
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Laboratories (Edit) - <cfoutput>#OfficeName.OfficeName#</cfoutput>">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<br>
<cfoutput query="Labs">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddLabs" action="labs_edit_update.cfm?ID=#URL.ID#&LabID=#LabID#">

Edit Lab:<br>
<input name="Lab" type="Text" value="#Lab#" size="50">
<br><br>

<a href="labs_delete.cfm?ID=#URL.ID#&LabID=#URL.LabID#">delete lab</a><br><br>

<input name="submit" type="submit" value="Submit"> 
</form>
</cfoutput>				  
						  				  
<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->