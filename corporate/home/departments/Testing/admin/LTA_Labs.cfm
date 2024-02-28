<cfquery Datasource="Corporate" name="Labs"> 
SELECT * from IQAOffices_Areas
WHERE ID = #URL.OfficeName#
AND LTA = 1
ORDER BY LAB
</CFQUERY>

<cfquery Datasource="Corporate" name="OfficeName"> 
SELECT * from IQAtblOffices
WHERE ID = #URL.OfficeName#
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Laboratories - <cfoutput>#OfficeName.OfficeName#</cfoutput>">
<cfinclude template="SOP.cfm">

<!--- / --->

<br>
<cfif Labs.recordcount is 0>
There are no Laboratories listed for this office.
</cfif>						  
						  
<cfoutput query="OfficeName">						  
<b>#OfficeName#</b>
</cfoutput>
<br><br>

<cfoutput query="labs">
- #Lab# <a href="LTA_labs_edit.cfm?LabID=#LabID#&ID=#URL.OfficeName#">(edit)</a><br>
</cfoutput>
<br>

<cfoutput>
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddLabs" action="LTA_Labs_Add.cfm?OfficeName=#URL.OfficeName#">

Add Lab:<br>
<input name="Lab" type="Text" value="" size="50">
<br><br>

<input name="submit" type="submit" value="Submit"> 
</form>
</cfoutput>
<br><br>
				
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->