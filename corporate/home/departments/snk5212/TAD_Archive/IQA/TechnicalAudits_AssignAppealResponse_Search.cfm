<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Internal Technical Audits - Assign Appeal Response">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<div align="Left" class="blog-time">
<br />
<b>Instructions</b><br />
<CFQUERY BLOCKFACTOR="100" NAME="DocumentLinks" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM TechnicalAudits_Links
WHERE Label = 'Instructions'
</cfquery>
<cfoutput query="DocumentLinks">
See <a href="#HTTPLINK#">#HTTPLINKNAME#</a><br />
Section 9.9 Assign Appeal Response<br /><br />
</cfoutput>
</div>

<cfif isDefined("Form.Submit")>
	<cfoutput>
	    <b>Select Appeal Response Employee - Search Results (#Form.Last_Name#)</b><br />
    </cfoutput>
    
    <CFQUERY NAME="QEmpLookup" datasource="OracleNet">
    SELECT first_n_middle, last_name, employee_email, Person_ID
    FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
    WHERE UPPER(last_name) LIKE UPPER('#form.last_name#%')
    ORDER BY last_name, first_n_middle
    </CFQUERY>
    
    <cfoutput query="QEmpLookup">
    #first_n_middle# #last_name# - #employee_email# <A href="TechnicalAudits_AssignAppealResponse.cfm?ID=#ID#&Year=#Year#&Person_ID=#Person_ID#">[Select]</A><br>
    </cfoutput>
<cfelse>
	<cfoutput>
    <FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Accred" action="#CGI.Script_Name#?#CGI.Query_String#">
    </cfoutput>
    
    <b>Select Appeal Response Employee - Search by Last Name</b><br />
    <input name="Last_Name" type="Text" size="70" value="">
    <br><br>
    
    <input name="Submit" type="Submit" value="Search for Employee"> 
    </form>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->