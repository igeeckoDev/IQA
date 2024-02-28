<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Internal Technical Audits - Add/Edit #url.label#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	*
FROM 
	TechnicalAudits_AuditSchedule
WHERE
	ID = #URL.ID#
    AND Year_ = #URL.Year#
</cfquery>

<Cfoutput>
    <cfif len(Audit.Auditor) AND len(Audit.AuditorManager)>
        <cfinclude template="TechnicalAudit_incAuditIdentifier.cfm">
    <cfelse>
        <b>Audit Number</b><br />
        #URL.Year#-#URl.ID#-Technical Audit<br /><br />
        
        <b>Technical Audit Identifier</b><br>
        Not Available - Auditor must be assigned<br><br>
    </cfif>
    
    <!---
    <script 
        language="javascript" 
        type="text/javascript" 
        src="#IQADir#/tinymce/jscripts/tiny_mce/tiny_mce.js">
    </script>
    
    <script language="javascript" type="text/javascript">
    tinyMCE.init({
        mode : "textareas",
        content_css : "#SiteDir#SiteShared/cr_style.css"
    });
    </script>
    --->
</Cfoutput>

<!--- build form --->
<cfform action="TechnicalAudits_AuditDetails_Edit_Action.cfm?#CGI.Query_String#">

<cfoutput>
Set #url.label#:<br />
</cfoutput>

<div style="position:relative; z-index:3">
<cfif url.var eq "RequestType">
	Test <cfinput type="Radio" name="RequestType" value="Test" required="yes" message="Enter the Project Request Type">
    No Test <cfinput type="Radio" name="RequestType" value="No Test" required="yes" message="Enter the Project Request Type">
<cfelseif url.var eq "Program">
	<CFQUERY BLOCKFACTOR="100" NAME="Program" Datasource="Corporate">
    SELECT Program, ID, Type
    FROM ProgDev
    WHERE (Status IS NULL OR Status = 'Under Review')
    ORDER BY Program
    </CFQUERY>
    
    <CFSELECT NAME="Program" required="yes" message="Please select the Program">
    	<OPTION>Select a Program</OPTION>
        <CFOUTPUT QUERY="Program">
            <OPTION VALUE="#Program#">#Program# (#Type#)</OPTION>
        </CFOUTPUT>
    </CFSELECT>
<cfelseif url.var eq "Notes">
	<cfoutput query="Audit">
    	<textarea WRAP="PHYSICAL" ROWS="10" COLS="60" NAME="Notes">#replace(Notes, "!", "'", "All")#</textarea>
    </cfoutput>
<cfelseif url.var eq "Standard" OR url.var eq "Standard2">
    <CFQUERY Name="Standard" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT * 
    From TechnicalAudits_Standard
    WHERE Status IS NULL
    Order BY StandardName, RevisionNumber DESC
    </CFQUERY>

	<cfif url.var eq "Standard">
		<cfset varMultiple = "No">
    <cfelse>
    	<cfset varMultiple = "Yes">
	</cfif>
    
    <CFSelect Name="#url.var#" required="yes" message="Please select the #url.label#" multiple="#varMultiple#">
        <OPTION>Select Standard</OPTION>
        <cfoutput query="Standard">
            <cfset standardValue = "#StandardName# (#RevisionNumber# - #dateformat(RevisionDate, "mm/dd/yyyy")#)">
            <OPTION VALUE="#standardValue#">#standardValue#</OPTION>
        </cfoutput>
    </CFSelect>
<cfelseif url.var eq "Month">
	<cfif audit.audittype2 eq "Full">
        <cfset maxMonthNumber = 4>
        <cfset MonthLabel = "Quarter">
    <cfelseif audit.audittype2 eq "In-Process">
        <cfset maxMonthNumber = 12>
        <cfset MonthLabel = "Month">
    </cfif>

    <SELECT NAME="Month" displayname="#MonthLabel#">
		<cfoutput>
            <option value="">Select #MonthLabel# Below
        </cfoutput>
            <option value="">---
        <cfloop index="i" to="#maxMonthNumber#" from="1">
            <cfoutput>
                <OPTION VALUE="#i#"><cfif audit.audittype2 eq "In-Process">#MonthAsString(i)#<cfelse>Quarter #i#</cfif>
            </cfoutput>
        </cfloop>
    </SELECT>
<cfelse>
	<cfif url.var eq "CCN">
		<cfset varMaxLength = 5>
    <cfelse>
    	<cfset varMaxLength = 125>
	</cfif>
    
   	<cfif url.var eq "CCN">
		<cfset varInputSize = 25>
    <cfelse>
    	<cfset varInputSize = 75>
	</cfif> 
    
    <cfif url.var eq "CCN2">
    <font class="warning">Please separate each CCN with a comma</font><br>
    </cfif>
	<cfinput type="text" 
    	name="#url.var#" 
        required="yes" 
        value="#evaluate("Audit.#url.var#")#" 
        message="Please include the #url.label#"
        maxlength="#varMaxLength#"
        size="#varInputSize#">
</cfif>
</div>
<br /><br />

<cfoutput>
	<cfinput type="Submit" name="Submit" value="Save #url.label#">
</cfoutput>
</cfform>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->