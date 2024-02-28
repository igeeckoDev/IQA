<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Corporate IQA Auditor Qualifications - Update">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif isDefined("Form.Submit")>

<cfoutput>
<!---
<cfloop item="fname" collection="#form#">
	<cfif fname neq "FieldNames"
		AND fname neq "Submit"
		AND listfirst(fname, "z") NEQ "POPBOXINPUT"
		AND listfirst(fname, "z") NEQ "POPBOXINPUTNOTES">
		<cfif len(form[fname])>
            <cfif form[fname] neq "No Changes">
                AuditorID = #listLast(fname, "z")#<br>
                #fname# = #form[fname]#<br><br>
            </cfif>
        </cfif>
    </cfif>
</cfloop><Br>
--->

<cfif URL.Action is "Qualification">
	<CFQUERY Name="qCount" Datasource="Corporate">
	SELECT ID, Auditor
	From AuditorList
	WHERE IQA = 'Yes'
	AND (Status = 'Active' OR Status = 'In Training')
	AND Auditor <> 'James Kurtz'
	AND Auditor <> 'John Carlin'
	ORDER BY Status, LastName
	</CFQUERY>

   	<CFQUERY Name="qName" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT ID, QualificationName as qName
	From Qualification
    WHERE ID = #URL.ID#
	</CFQUERY>
<cfelseif URL.Action is "Auditor">
	<CFQUERY Name="qCount" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT ID, QualificationName
	From Qualification
	WHERE STATUS IS NULL
	ORDER BY ID
	</CFQUERY>

	<CFQUERY Name="qName" Datasource="Corporate">
	SELECT ID, Auditor as qName
	From AuditorList
	WHERE ID = #URL.ID#
	</CFQUERY>
</cfif>

<b>Qualification Changes</b><br /><br />

<!--- Update Qualifications --->
<cfsavecontent variable="outputUpdateText">
<cfloop query="qCount">
	<cfif evaluate("form.qValuez#ID#") eq 1 OR evaluate("form.qValuez#ID#") eq 0>
    	<CFQUERY Name="Current" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    	SELECT qHistory, ID
        FROM AuditorQualification
        WHERE
			<cfif URL.Action is "Qualification">
                aID = #ID#
                AND qID = #URL.ID#
            <cfelseif URL.Action is "Auditor">
                aID = #URL.ID#
                AND qID = #ID#
            </cfif>
    	</CFQUERY>

        <cfif Current.RecordCount eq 0>
			<cfif URL.Action is "Qualification">
                <Cfset qIDNew = #URL.ID#>
                <cfset aIDNew = #ID#>
            <cfelseif URL.Action is "Auditor">
                <cfset qIDNew = #ID#>
                <cfset aIDNew = #URL.ID#>
            </cfif>

            <CFQUERY Name="MaxID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
            SELECT MAX(ID) + 1 as newID
            FROM AuditorQualification
            </CFQUERY>

            <CFQUERY Name="MaxID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
            INSERT INTO AuditorQualification(ID, qID, aID, qValue, qDate, qHistory, Notes)
            VALUES(#MaxID.newID#, #qIDNew#, #aIDNew#, #evaluate("form.qValuez#ID#")#, '#evaluate("form.qDatez#ID#")#', 'Current changes were added on #curdate# #curtime# by #SESSION.Auth.Name#<br />Qualification=#evaluate("form.qValuez#ID#")#<br />Date=#evaluate("form.qDatez#ID#")#<br />Notes=#evaluate("form.Notesz#ID#")#', '#evaluate("form.Notesz#ID#")#')
            </CFQUERY>
            Row Added<br />
        <cfelse>
    	<CFQUERY Name="UpdateTable" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        UPDATE AuditorQualification
		SET

        qValue = #evaluate("form.qValuez#ID#")#,
			<cfif evaluate("form.qValuez#ID#") eq 1>
            	<cfif len(evaluate("form.qDatez#ID#"))>
	            	qDate = '#evaluate("form.qDatez#ID#")#',
                <cfelse>
                	qDate = '#dateformat(curdate, "mm/dd/yyyy")#',
                </cfif>
            <cfelseif evaluate("form.qValuez#ID#") eq 0>
            	qDate = null,
            </cfif>
        Notes = '#evaluate("form.Notesz#ID#")#',
        qHistory = 'Current changes were added on #curdate# #curtime# by #SESSION.Auth.Name#<br />
            Qualification=<cfif evaluate("form.qValuez#ID#") eq 1>Yes<cfelseif evaluate("form.qValuez#ID#") eq 0>No</cfif><br />
            Date=#evaluate("form.qDatez#ID#")#<br />
            Notes=#evaluate("form.Notesz#ID#")#<br /><br />
            #Current.qHistory#'

        WHERE
			<cfif URL.Action is "Qualification">
                aID = #ID#
                AND qID = #URL.ID#
            <cfelseif URL.Action is "Auditor">
                aID = #URL.ID#
                AND qID = #ID#
            </cfif>
        </CFQUERY>

        <u>Updated</u><br />
		<cfif URL.Action is "Qualification">
            Auditor = #Auditor#<Br />
            Qualification = #qName.qName#
        <cfelseif URL.Action is "Auditor">
            Auditor = #qName.qName#<br />
            Qualification = #QualificationName#
        </cfif><br />
        Qualification Y/N = <cfif evaluate("form.qValuez#ID#") eq 1>Yes<cfelseif evaluate("form.qValuez#ID#") eq 0>No</cfif><Br />
        Qualification Date =
		<cfif len(evaluate("form.qDatez#ID#"))>
        	#evaluate("form.qDatez#ID#")#
		<cfelse>
        	<cfif evaluate("form.qValuez#ID#") eq 1>
	        	No date was entered - #dateformat(curdate, "mm/dd/yyyy")# was assumed and entered.
			<cfelseif evaluate("form.qValuez#ID#") eq 0>
            	N/A
            </cfif>
		</cfif><Br />
        Notes = <cfif len(evaluate("form.Notesz#ID#"))>#evaluate("form.Notesz#ID#")#<cfelse>No Notes Added</cfif><Br />
        Rev History = <A href="_Quals_ViewItemHistory.cfm?ID=#Current.ID#">View History</A><br /><br />
        </cfif>
    <cfelseif evaluate("form.qValuez#ID#") eq "No Changes">
        No Changes were made for
        <cfif URL.Action is "Qualification">
            #Auditor# / #qName.qName#
        <cfelseif URL.Action is "Auditor">
            #qName.qName# / #QualificationName#
        </cfif>
        <br /><br />
    </cfif>
</cfloop>
</cfsavecontent>
</cfoutput>

<!--- Output Quals Table to show new Values --->
<cfif URL.Action is "Qualification">
    <CFQUERY Name="qEdit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ID, QualificationName as EditItem
    From Qualification
    WHERE ID = #URL.ID#
    </CFQUERY>

	<CFQUERY Name="qList" Datasource="Corporate">
	SELECT ID, Auditor as qListItem
	From AuditorList
	WHERE IQA = 'Yes'
	AND (Status = 'Active' OR Status = 'In Training')
	AND Auditor <> 'James Kurtz'
	AND Auditor <> 'John Carlin'
	ORDER BY Status, LastName
	</CFQUERY>

    <cfset heading = "Auditor Name">
    <cfset field = "Auditor">
<cfelseif URL.Action is "Auditor">
    <CFQUERY Name="qEdit" Datasource="Corporate">
    SELECT ID, Auditor as EditItem
    From AuditorList
    WHERE ID = #URL.ID#
    </CFQUERY>

    <CFQUERY Name="qList" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ID, QualificationName as qListItem
    From Qualification
	WHERE STATUS IS NULL
    ORDER BY ID
    </CFQUERY>

    <cfset heading = "Qualification Name">
    <cfset field = "Qualification">
</cfif>

<cfoutput>
<u>Options</u><br />
:: View <a href="_Quals.cfm">Auditor Qualifications Table</a><br />
:: Edit <a href="_Quals_Edit.cfm?#CGI.QUERY_STRING#">#qEdit.EditItem#</a><br /><br />

<Table border="1">
<tr>
	<th align="center" colspan="4">#qEdit.EditItem#</th>
</tr>
<tr>
	<th>#heading#</th>
    <th>Yes/No (Date)</th>
	<th>Notes</th>
	<th>View Rev History</th>
</tr>
</cfoutput>

<cfoutput query="qList">
<tr>
	<td>#qListItem#</td>
    <td align="center">
    	<CFQUERY Name="Quals" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT AuditorQualification.ID, AuditorQualification.aID, AuditorQualification.qID,
        AuditorQualification.qValue, AuditorQualification.qDate, Qualification.QualificationName,
        AuditorQualification.Notes, AuditorQualification.qHistory

        FROM AuditorQualification, Qualification
        WHERE
        <cfif URL.Action is "Auditor">
            AuditorQualification.aID = #qEdit.ID#
            AND Qualification.ID = #ID#
            <cfset value = "#ID#">
        <cfelseif URL.Action is "Qualification">
            AuditorQualification.aID = #ID#
            AND Qualification.ID = #qEdit.ID#
            <cfset value = "#ID#">
        </cfif>
        AND AuditorQualification.qID = Qualification.ID
        ORDER BY AuditorQualification.qID
        </CFQUERY>

        <cfif Quals.qValue eq 1>
        	Yes
        <cfelse>
        	No
        </cfif>
        <cfif len(Quals.qDate)>
        	<br>#Quals.qDate#
        </cfif>
    </td>
	<td>
    	<cfif len(Quals.Notes)>#Quals.Notes#<cfelse>No Notes Added</cfif>
    </Td>
    <td align="center">
    	<cfif len(Quals.ID)>
        	<a href="_Quals_ViewItemHistory.cfm?ID=#Quals.ID#">View</a>
        <cfelse>
        	--
        </cfif>
    </td>
</tr>
</cfoutput>
</Table>
<Br /><br />
<!--- /// --->

<!--- output update text to show changes from update/insert queries --->
<b>Current Change History</b><br />
<cfoutput>
#outputUpdateText#
</cfoutput>
<!--- /// --->

<cfelse>

<cfif isDefined("URL.Action")>
	<cfif URL.Action is "Qualification">
        <CFQUERY Name="qEdit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT ID, QualificationName as EditItem
        From Qualification
        WHERE ID = #URL.ID#
		</CFQUERY>

		<CFQUERY Name="qList" Datasource="Corporate">
		SELECT ID, Auditor as qListItem
		From AuditorList
		WHERE IQA = 'Yes'
		AND (Status = 'Active' OR Status = 'In Training')
		AND Auditor <> 'James Kurtz'
		AND Auditor <> 'John Carlin'
		ORDER BY Status, LastName
		</CFQUERY>

        <cfset heading = "Auditor Name">
        <cfset field = "Auditor">
	<cfelseif URL.Action is "Auditor">
        <CFQUERY Name="qEdit" Datasource="Corporate">
        SELECT ID, Auditor as EditItem
        From AuditorList
        WHERE ID = #URL.ID#
        </CFQUERY>

        <CFQUERY Name="qList" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT ID, QualificationName as qListItem
        From Qualification
		WHERE STATUS IS NULL
        ORDER BY ID
        </CFQUERY>

        <cfset heading = "Qualification Name">
        <cfset field = "Qualification">
	</cfif>
<cfelse>
	<cflocation url="_Quals.cfm" addtoken="no">
</cfif>

<cfform action="_Quals_Edit.cfm?ID=#URL.ID#&Action=#URL.Action#">
<cfoutput>

:: View <a href="_Quals.cfm">Auditor Qualifications table</a><br /><br />

<b>Notes</b><br />
<u>Qualification Date</u> will only be saved if you select Yes.<br />
<u>Qualification Notes</u> will only be saved if you select Yes or No.<br /><br />

<Table border="1" width="650"
<tr>
	<th align="center">&nbsp;</th>
    <th align="center" colspan="2">Current: #qEdit.EditItem#</th>
    <th align="center" colspan="3">New Values: #qEdit.EditItem#</th>
</tr>
<tr>
	<th>#heading#</th>
    <th>Yes/No (Date)</th>
    <th width="200">Notes</th>
    <th>Yes / No</th>
    <th>Qualification<br>Date</th>
    <th>Qualification<br>Notes</th>
</tr>
</cfoutput>

<cfoutput query="qList">
<tr>
	<td>#qListItem#</td>
    <td align="center">
    	<CFQUERY Name="Quals" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT AuditorQualification.ID, AuditorQualification.aID, AuditorQualification.qID,
        AuditorQualification.qValue, AuditorQualification.qDate, Qualification.QualificationName,
        AuditorQualification.Notes, AuditorQualification.qHistory

        FROM AuditorQualification, Qualification
        WHERE
        <cfif URL.Action is "Auditor">
            AuditorQualification.aID = #qEdit.ID#
            AND Qualification.ID = #ID#
            <cfset value = "#ID#">
        <cfelseif URL.Action is "Qualification">
            AuditorQualification.aID = #ID#
            AND Qualification.ID = #qEdit.ID#
            <cfset value = "#ID#">
        </cfif>
        AND AuditorQualification.qID = Qualification.ID
        ORDER BY AuditorQualification.qID
        </CFQUERY>

        <cfif Quals.qValue eq 1>
        	Yes
        <cfelse>
        	No
        </cfif>
        <cfif len(Quals.qDate)>
        	<br>#Quals.qDate#
        </cfif>
    </td>
    <td>
	    <cfif len(Quals.Notes)>#Quals.Notes#<cfelse>No Notes Added</cfif>
    </td>
    <td align="center">
    <cfselect name="qValuez#value#">
      	<option value="1">Yes</option>
        <option value="0">No</option>
        <option value="No Changes" selected>No Changes</option>
    </cfselect>
    </td>
    <td align="center">

		<!---
		<script>
		$(function() {
			$( "##date#value#" ).datepicker({
			changeMonth: true,
			changeYear: true
			});
		});
		</script>
		--->

	    <!---
	    <div id="datepicker">
        --->
		    <cfinput size="10"
                id="date#value#"
                type="text"
                name="qDatez#value#"
                value=""
                maxlength="10"
                validate="date">
		<!---
		</div>
		--->
    </td>
    <Td>
	<!---
    <script>
    $(function () {
    	$( ".input-boxes" ).popBox();
    });
	</script>
	--->

    <cfinput class="input-boxes" name="Notesz#value#" type="text" />
    </Td>
</tr>
</cfoutput>
<tr>
	<td colspan="6" align="center">
    	<cfinput type="Submit" name="Submit" value="Save Changes">
    </td>
</tr>
</Table>
<br /><br />
</cfform>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->