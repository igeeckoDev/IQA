<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
CARSurvey_Distribution.Year_, CARSurvey_Distribution.Quarter

FROM
CARSurvey_Distribution

WHERE
CARSurvey_Distribution.ID = #URL.dID#
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="<a href='CARSurvey_Distribution.cfm'>CAR Survey</a> - Add Survey Participant for #Distribution.year_# Quarter #Distribution.Quarter# Survey Distribution">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif isDefined("Form.Submit")>
	<cfoutput>
	    <b>Search Results (#Form.Last_Name#)</b><br /><br />

    </cfoutput>

    <CFQUERY NAME="QEmpLookup" datasource="OracleNet">
    SELECT first_n_middle, last_name, employee_email, Person_ID
    FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW
    WHERE UPPER(last_name) LIKE UPPER('#form.last_name#%')
    ORDER BY last_name, first_n_middle
    </CFQUERY>

    <cfoutput query="QEmpLookup">
    #first_n_middle# #last_name# - #employee_email# <A href="CARSurvey_addSurveyParticipant_Action.cfm?dID=#URL.dID#&Person_ID=#Person_ID#">[Select]</A><br>
    </cfoutput>
<cfelse>
	<cfoutput>
    <FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Accred" action="#CGI.Script_Name#?#CGI.Query_String#">
    </cfoutput>

    <b>Search by Last Name</b><br /><br />

    <input name="Last_Name" type="Text" size="70" value="">
    <br><br>

    <input name="Submit" type="Submit" value="Search for Employee">
    </form>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->