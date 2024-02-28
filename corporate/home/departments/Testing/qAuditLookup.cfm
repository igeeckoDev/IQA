<cfif isDefined("Form.Year") AND isDefined("Form.ID")>
    <CFQUERY BLOCKFACTOR="100" name="Audit" Datasource="Corporate">
    SELECT * FROM AuditSchedule
    WHERE ID = <cfqueryparam value="#Form.ID#" CFSQLTYPE="CF_SQL_INTEGER" maxLength="3" null="No"> 
    AND Year_ = <cfqueryparam value="#Form.Year#" CFSQLTYPE="CF_SQL_INTEGER" maxLength="4" null="No">
    </CFQUERY>
    
    <cfif audit.recordcount is 0>
        <cflocation url="auditnumber.cfm?count=0&ID=#FORM.ID#&Year=#FORM.Year#" ADDTOKEN="No">
    <cfelse>
        <cflocation url="auditdetails.cfm?ID=#FORM.ID#&Year=#FORM.Year#" ADDTOKEN="No">
    </cfif>
<cfelse>						  

Please enter the year and the ID of the audit.<br><br>

<cfoutput>
If you cannot find the audit or do not know the audit number, you can use the <a href="#IQADir#ViewAudits.cfm">View Audits</a> page to search.<br /><br />
</cfoutput>

<cfif isDefined("URL.count")>
	<cfoutput>
		<font color="red">
		Audit <b>#url.year#-#url.id#</b> not found in the Audit Database.
		</font>
		<br><br>
	</cfoutput>
</cfif>

<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" Action="#CGI.SCRIPT_NAME#"> 

Year:<br>
<cfinput required="yes" validate="integer" maxlength="4" message="Year is a required field: numbers only" type="text" name="Year" value="">
<br><br>
ID:<br>
<cfinput required="yes" validate="integer" maxlength="3" message="ID is arequired field: numbers only" type="text" name="ID" value="">
<br><br>
<INPUT TYPE="Submit" value="Submit">
</cfFORM>

</cfif>