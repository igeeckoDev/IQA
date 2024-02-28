<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "2016 Audit Planning Survey - Upoad File">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" name="SurveyType" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM AuditPlanning2016_Users
WHERE ID = #URL.UserID#
</CFQUERY>

<cfif SurveyType.Type eq "Program">
    <CFQUERY BLOCKFACTOR="100" name="qData" Datasource="Corporate">
    SELECT ID, Program as pName
    FROM ProgDev
    WHERE ID = #SurveyType.pID#
    </cfquery>
<cfelseif SurveyType.Type eq "Process">
	<cfif SurveyType.pID eq 0>
		<CFQUERY BLOCKFACTOR="100" name="qData" Datasource="UL06046">
        SELECT Type as pName
        FROM AuditPlanning2016_Users
        WHERE ID = #URL.UserID#
        </cfquery>
	<cfelse>
        <CFQUERY BLOCKFACTOR="100" name="qData" Datasource="Corporate">
        SELECT ID, Function as pName
        FROM GlobalFunctions
        WHERE ID = #SurveyType.pID#
        </cfquery>
	</cfif>
<cfelseif SurveyType.Type eq "Site">
	<CFQUERY BLOCKFACTOR="100" Name="qData" datasource="Corporate">
    SELECT OfficeName as pName
    From IQAtblOffices
	WHERE ID = #SurveyType.pID#
    </CFQUERY>
</cfif>

<CFQUERY Name="Output" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
	AuditPlanning2016_Answers.ID as aID,
	AuditPlanning2016_Answers.qID,
    AuditPlanning2016_Answers.Answer,
    AuditPlanning2016_Answers.Notes,
    AuditPlanning2016_Answers.ExtraField_Text as ExtraField_Text_Answer,
    AuditPlanning2016_Answers.ExtraField_FileName as ExtraField_FileName_Answer,
    AuditPlanning2016_Answers.ExtraField_CLOB as ExtraField_CLOB_Answer,

    AuditPlanning2016_Questions.Question,
    AuditPlanning2016_Questions.ID,
    AuditPlanning2016_Questions.ExtraField_Text,
    AuditPlanning2016_Questions.ExtraField_FileName,
    AuditPlanning2016_Questions.ExtraField_CLOB,

    AuditPlanning2016_Users.Type,
    AuditPlanning2016_Users.pID,
    AuditPlanning2016_Users.Posted,
    AuditPlanning2016_Users.PostedBy,
    AuditPlanning2016_Users.LaboratoryNames,
    AuditPlanning2016_Users.SurveyArea_Description

FROM AuditPlanning2016_Answers, AuditPlanning2016_Questions, AuditPlanning2016_Users

WHERE
AuditPlanning2016_Users.ID = #URL.UserID#
AND AuditPlanning2016_Answers.qID = AuditPlanning2016_Questions.ID
AND AuditPlanning2016_Answers.UserID = AuditPlanning2016_Users.ID
ORDER BY qID, aID
</CFQUERY>

<cfif SurveyType.SurveyType eq "New">
	<cfoutput>
    	<u>New Item</u> - <b>#Output.ExtraField_Text_Answer#</b>
    </cfoutput>
<cfelseif SurveyType.Type eq "Program" OR SurveyType.Type eq "Process" OR SurveyType.Type eq "Site">
	<!--- Program or Process or Site --->
	<cfoutput query="qData">
       	<u>#SurveyType.SurveyType# Name</u> - #qData.pName#
    </cfoutput>
<cfelseif SurveyType.SurveyType eq "Lab">
	<b>Laboratory Operations</b>
<cfelseif SurveyType.SurveyType eq "Operations">
	<b>Operations</b>
<cfelse>
	<cfoutput>
    	<u><cfif SurveyType.SurveyType eq "Quality2">Quality Related<cfelse>#SurveyType.SurveyType#</cfif></u> - <b>#SurveyType.Type#</b>
        <cfif SurveyType.SurveyType eq "Quality2">
        	<cfif len(Output.SurveyArea_Description) AND Output.SurveyArea_Description NEQ "No Comments Added">
        	<br /><br />Description: #Output.SurveyArea_Description#
        	</cfif>
        </cfif>
    </cfoutput>
</cfif><br /><br>

<cfset numberoffields = 1>

<cfif isdefined("form.upload")>
    <CFFILE ACTION="UPLOAD"
        DESTINATION="#IQARootPath#Planning\Temp"
        NAMECONFLICT="OVERWRITE"
        filefield="form.File">

    <cfset FileName="#form.file#">

    <cfset NewFileName="#URL.UserID#.#cffile.ClientFileExt#">

    <cffile
        action="rename"
        source="#FileName#"
        destination="#IQARootPath#Planning\Temp\#NewFileName#">

    <cffile
    	action="move"
        source="#IQARootPath#Planning\Temp\#NewFileName#"
        destination="#IQARootPath#Planning\SurveyFiles\">

	<CFQUERY BLOCKFACTOR="100" NAME="AddID" Datasource="UL06046">
    Update AuditPlanning2016_Users
    SET
    SurveyFile = '#NewFileName#'

    WHERE ID = #URL.USERID#
    </CFQUERY>

	<cfset message = "#NewFileName# was uploaded">

	<cflocation url="2016_Details.cfm?USERID=#URL.USERID#&msg=#message#" addtoken="no">

<cfelse>

  <cfif isdefined("url.msg")>
  <br>
      <cfloop list="#url.msg#" index="i">
        <cfoutput>#i#</cfoutput><br>
      </cfloop>
   </cfif>

<cfoutput><Br>

Audit Planning Survey - Upload File<Br><Br>

<a href="2016_Details.cfm?UserID=#URL.USERID#">Return to Survey Results</a><br>

<form action="2016_UploadFile.cfm?#CGI.Query_String#" enctype="multipart/form-data" method="post">
</cfoutput>
<br />

    <b>File to Upload</b>:<br />
    <input type="File" size="50" name="File"><br><br />

    <input type="Submit" name="Upload" value="Upload">

    </form>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->