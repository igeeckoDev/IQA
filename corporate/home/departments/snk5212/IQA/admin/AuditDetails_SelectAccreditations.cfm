<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Details - #URL.Year#-#URL.ID# - Add Accreditations">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" name="OfficeName" Datasource="Corporate">
SELECT OfficeName FROM AuditSchedule
WHERE ID = #URL.ID# AND Year_ = #URL.Year#
</CFQUERY>

<cfset Loc = "#OfficeName.OfficeName#">

<cfif isDefined("Form.Submit") AND isDefined("Form.Accred")>

<cfset OfficeHolder = "">
<cfloop index = "ListElement" list = "#Form.Accred#"> 
    <CFQUERY BLOCKFACTOR="100" name="Accreds" Datasource="Corporate">
    SELECT 
        IQAtblOffices.OfficeName, IQAtblOffices.Region, IQAtblOffices.SubRegion, Accreditors.Accreditor, Accreditors.ID, AccredLocations.*
    FROM 
        IQAtblOffices, Accreditors, AccredLocations
    WHERE
        AccredLocations.ID = #ListElement#
        AND IQAtblOffices.ID = AccredLocations.OfficeID
        AND Accreditors.ID = AccredLocations.AccredID
    ORDER BY
        OfficeName, Accreditor, AccredType
    </cfquery>
    
    <cfoutput query="Accreds">
        <cfif OfficeHolder IS NOT OfficeName> 
            <cfif len(OfficeName)>
                <br>
            </cfif>
        <b>#OfficeName#</b><br>
        </cfif>
     :: #Accreditor# - #AccredType# (#AccredType2#) - #OfficeName#<Br>
    <cfset OfficeHolder = OfficeName>
    </cfoutput>
</cfloop><br>

<cfFORM METHOD="POST" name="sAccredAction" ACTION="AuditDetails_SelectAccreditations_AccredAction.cfm?Accred=#Form.Accred#&ID=#URL.ID#&Year=#URL.Year#">

<INPUT TYPE="Submit" name="Accred" Value="Confirm">
<INPUT TYPE="Submit" name="Accred" Value="Cancel">

<br /><br />
Please confirm that the accreditations listed above should be associated with this audit by seleting Confirm above.<Br>
If you wish to edit your selections, please go back to the previous page.<br>
If you wish to cancel and assign accredtiations later, select Cancel.<Br><br>

</cfFORM>

<cfelse>
<cfform 
	method="post" 
    name="Form" 
    format="html" 
    width="700" 
    preservedata="yes"  
    Action="AuditDetails_SelectAccreditations.cfm?ID=#URL.ID#&Year=#URL.Year#">

<!-- check UL Office - Superlocation or not --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Super">
SELECT SuperLocation, ID, OfficeName
FROM IQAtblOffices
WHERE OfficeName = '#Loc#'
</cfquery>

Please select Accreditations below:<Br><Br />

<CFIF Super.SuperLocation eq "Yes">
    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="SuperLocs">
    SELECT SuperLocationID, ID, OfficeName
    FROM IQAtblOffices
    WHERE SuperLocationID = #Super.ID#
    ORDER BY OfficeName
    </cfquery>
    
    <!--- display locations within superlocation --->
    <cfif SuperLocs.recordcount GTE 1>
        <cfoutput>
            <cfloop query="SuperLocs">
                <b>#OfficeName#</b><br>
                <cfquery name="sAccred" datasource="Corporate">
                SELECT 
                    IQAtblOffices.OfficeName, Accreditors.Accreditor, AccredLocations.AccredType, AccredLocations.AccredType2, AccredLocations.ID
                FROM 
                    IQAtblOffices, Accreditors, AccredLocations
                WHERE 
                    IQAtblOffices.ID = AccredLocations.OfficeID
                    AND Accreditors.ID = AccredLocations.AccredID
                    AND IQAtblOffices.OfficeName = '#SuperLocs.OfficeName#'
                ORDER BY
                    Accreditors.Accreditor, AccredLocations.AccredType
                </cfquery>
                
                <cfif sAccred.RecordCount GT 0>
                    <cfloop query="sAccred">
                        <cfinput type="checkbox" name="Accred" value="#ID#">
                        <u>#Accreditor#</u> - #AccredType# (#AccredType2#)<br>
                    </cfloop><br>
				<cfelse>
                	No Accreditations Listed for #OfficeName#<Br><Br>
                </cfif>
			</cfloop>
        </cfoutput>
    </cfif>
	<cfelse>
    <!--- display officename since it is not a superlocation --->
    <cfoutput>
    	<cfloop index="ListElement" delimiters="!" list="#Loc#"> 
            <b>#ListElement#</b><Br>
            <cfquery name="sAccred" datasource="Corporate">
            SELECT 
                IQAtblOffices.OfficeName, Accreditors.Accreditor, AccredLocations.AccredType, AccredLocations.AccredType2, AccredLocations.ID
            FROM 
                IQAtblOffices, Accreditors, AccredLocations
            WHERE 
                IQAtblOffices.ID = AccredLocations.OfficeID
                AND Accreditors.ID = AccredLocations.AccredID
                AND IQAtblOffices.OfficeName = '#ListElement#'
            ORDER BY
                Accreditors.Accreditor, AccredLocations.AccredType
            </cfquery>
            
            <cfif sAccred.RecordCount GT 0>
                <cfloop query="sAccred">
                    <cfinput type="checkbox" name="Accred" value="#ID#">
                    <u>#Accreditor#</u> - #AccredType# (#AccredType2#)<br>
                </cfloop><br>
            <cfelse>
                No Accreditations Listed for #ListElement#<Br><br>
            </cfif>
    	</cfloop>
    </cfoutput>
</CFIF>
<!--- /// --->

<INPUT TYPE="Submit" value="Submit" name="Submit">
</cfform>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->