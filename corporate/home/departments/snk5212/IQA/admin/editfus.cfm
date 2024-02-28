<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "UL Inspection Center Locations - Edit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfquery Datasource="Corporate" name="FUS"> 
SELECT * from FUSAreas
WHERE ID = #url.id#
</CFQUERY>

<cfquery Datasource="Corporate" name="FUSAll"> 
SELECT * from FUSAreas
ORDER BY Area
</CFQUERY>


<cfoutput>
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddArea" action="EditFus_update.cfm?ID=#URL.ID#">
</cfoutput>
<br>
Edit Field Service Location:<br>
<CFOUTPUT Query="FUS"> 
<input name="Area" type="Text" size="70" value="#Area#">
<br><br>

<cfif NOT len(Status)>
	<a href="delete_fus.cfm?id=#id#&action=remove">remove</a> #Area#
<cfelse>
	<a href="delete_fus.cfm?id=#id#&action=reinstate">reinstate</a> #Area#
</cfif><br><br>
</cfoutput>

<input name="submit" type="submit" value="Submit"> 
</form><br>

<CFOUTPUT Query="FUSAll"> 
 - #Area# <a href="EditFus.cfm?id=#id#">(edit)</a><br>
</CFOUTPUT>
<br><br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->