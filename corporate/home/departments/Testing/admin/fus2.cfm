<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "UL Inspection Center Locations">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfquery Datasource="Corporate" name="FUS"> 
SELECT * 
FROM FUSAreas
ORDER BY Area
</CFQUERY>

<cfif isDefined("url.id")>
	<CFQUERY Name="value" Datasource="Corporate">
	SELECT * 
    From FUSAreas
	WHERE ID = #URL.ID#
	</CFQUERY>
    <cfif isDefined("url.msg")>
        <cfif url.msg is "duplicate">
            <cfoutput>
            Attempted to add: <b>#value.Area#</b><br>
            <font color="red"><b>#value.Area#</b> is already listed.</font><br>
            </cfoutput>
        <cfelseif url.msg is "remove">
            <cfoutput>
            <font color="red">#value.Area# had been removed.</font><br>
            </cfoutput>
        <cfelseif url.msg is "reinstate">
            <cfoutput>
            <font color="red">#value.Area# had been reinstated.</font><br>
            </cfoutput>
        <cfelseif url.msg is "added">
            <cfoutput>
            <font color="red">#value.Area# has been added.</font><br>
            </cfoutput>
        <cfelseif url.msg is "edited">
            <cfoutput>
            <font color="red">#value.Area# has been edited.</font><br>
            </cfoutput>
        </cfif>
        <br>
    </cfif>
</cfif>

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddArea" action="AddFus_update.cfm">
<br>
Add Field Service Location:<br>
<input name="Area" type="Text" size="70" value="">
<br><br>

<input name="submit" type="submit" value="Submit"> 
</form><br>

<CFOUTPUT Query="FUS"> 
 - #Area# <a href="EditFus.cfm?id=#id#">(edit)</a> <cfif Status eq "removed"><font class="warning"><b>Removed</b></font></cfif><br>
</CFOUTPUT>
<br><br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->