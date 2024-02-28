<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Upload Scope Letter - Notification">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
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
</cfoutput>

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

<script language="JavaScript">
function check() {
  var ext = document.Audit.e_AttachA.value;
  ext = ext.substring(ext.length-3,ext.length);
  ext = ext.toLowerCase();
    if ((document.Audit.e_AttachA.value.length!=0) || (document.Audit.e_AttachA.value!=null)) {
	 if(ext != 'pdf') {
    alert('You selected a .'+ext+' file; please select a pdf file.');
    return false;
	 }
	}
else
return true;
document.Audit.submit();
}
</script>

<CFQUERY BLOCKFACTOR="100" name="AddReport" Datasource="Corporate">
SELECT * FROM AuditSchedule
WHERE ID = #URL.ID#
and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfif isDefined("Form.e_AttachA")>

<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<CFIF Form.e_AttachA is "">
	<cflocation url="#link#" addtoken="no">
</CFIF>

<CFFILE ACTION="UPLOAD"
FILEFIELD="e_AttachA"
DESTINATION="#IQARootPath#ScopeLetters\"
NAMECONFLICT="OVERWRITE"
accept="application/pdf">

<cfset FileName="#Form.e_AttachA#">

<cfset NewFileName="#URL.Year#-#URL.ID#-Attach.#cffile.ClientFileExt#">

<cffile
    action="rename"
    source="#FileName#"
    destination="#IQARootPath#ScopeLetters\#NewFileName#">

<CFQUERY Datasource="Corporate" Name="EnterScope">
UPDATE AuditSchedule
SET

ScopeLetter='#NewFileName#',
ScopeLetterDate=#CreateODBCDate(curdate)#

WHERE ID = #URL.ID#
AND YEAR_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<cfset Dump1 = #replace(Form.RecipientsTo, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump1, "</p>", "", "All")#>

<cfset Dump3 = #replace(Form.RecipientsCC, "<p>", "", "All")#>
<cfset Dump4 = #replace(Dump3, "</p>", "", "All")#>

<cfif isDefined("Form.Message")>
	<cfset Dump5 = #replace(Form.Message, "<p>", "", "All")#>
    <cfset Dump6 = #replace(Dump5, "</p>", "<br><br>", "All")#>
</cfif>

<cfif AddReport.Approved eq "Yes">
	<cfoutput query="AddReport">
        <cfif AuditType2 eq "Program">
            <cfset incSubject = "Scope Letter - Quality System Audit of #Trim(Area)#">
        <cfelseif AuditType2 eq "Field Services">
            <cfset incSubject = "Scope Letter - Quality System Audit of Field Services - #trim(Area)#">
        <cfelseif AuditType2 is "Corporate" or AuditType2 is "Local Function" or AuditType2 is "Local Function FS" or audittype2 is "Local Function CBTL" or audittype2 is "Global Function/Process">
            <cfif isDefined("Area")>
                <cfset incSubject = "Scope Letter - Quality System Audit of #Trim(OfficeName)# - #Trim(Area)#">
            <cfelse>
                <cfset incSubject = "Scope Letter - Quality System Audit of #Trim(OfficeName)# - #Trim(AuditArea)#">
            </cfif>
        <cfelseif AuditType2 is "MMS - Medical Management Systems">
            <cfset incSubject = "Scope Letter - Quality System Audit of #Trim(Area)#">
        <cfelseif AuditType2 is "WiSE Technical Audit">
            <cfset incSubject = "WiSE Technical Audit of #OfficeName#">
		<cfelseif AuditedBy is "ULE">
	    	<cfset incSubject = "ULE Audit - #Trim(AuditArea)#">
        </cfif>
    </cfoutput>

    <cflock Scope="SESSION" Timeout="5">
        <cfmail
            to="#Dump2#"
            From="#SESSION.AUTH.Email#"
            cc="#Dump4#"
            bcc="#SESSION.AUTH.Email#"
            Subject=" #incSubject#"
            query="AddReport"
            type="html">
        <b>Audit</b>: #Year#-#ID#-#AuditedBy#<br>
        <b>Audit Type</b>: #AuditType2#<br />
        <b>Audit Area</b>: <cfif len(Area)>#Trim(Area)#<cfelse>#Trim(AuditArea)#</cfif><br>
        <b>Location</b>: #Trim(Officename)#<br>
        <cfif AuditType2 is "WiSE Technical Audit">
            <b>Auditor</b>: #Auditor#<br>
        <cfelse>
            <b>Lead Auditor</b>: #LeadAuditor#<br>
        </cfif>

        <u>Audit Details</u>:<Br />
        http://usnbkiqas100p/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#<br><br>

        The Scope Letter for this audit has been submitted to the Audit Database. You can view the scope by following the link above to the Audit Details page on the IQA website.<Br /><br />

        <cfif isDefined("Form.Message")>
        <u>Comments</u>: #Dump6#
        </cfif>

        Please contact <cfif AuditType2 is "WiSE Technical Audit">#Auditor#<cfelse>#LeadAuditor#</cfif> with any questions or issues.
        </cfmail>
    </cflock>
</cfif>

<cflocation url="AuditDetails.cfm?ID=#URL.ID#&Year=#URL.Year#" addtoken="no">

<cfelse>

<cfoutput query="AddReport">
	<cfif AuditType2 eq "Program">
        <cfset incSubject = "Scope Letter - Quality System Audit of #Trim(Area)#">
    <cfelseif AuditType2 eq "Field Services">
        <cfset incSubject = "Scope Letter - Quality System Audit of Field Services - #trim(Area)#">
    <cfelseif AuditType2 is "Corporate"
	  or AuditType2 is "Local Function"
	  or AuditType2 is "Local Function FS"
	  or audittype2 is "Local Function CBTL"
	  or audittype2 is "Global Function/Process">
        <cfif isDefined("Area")>
            <cfset incSubject = "Scope Letter - Quality System Audit of #Trim(OfficeName)# - #Trim(Area)#">
        <cfelse>
            <cfset incSubject = "Scope Letter - Quality System Audit of #Trim(OfficeName)# - #Trim(AuditArea)#">
        </cfif>
    <cfelseif AuditType2 is "MMS - Medical Management Systems">
        <cfset incSubject = "Scope Letter - Quality System Audit of #Trim(Area)#">
    <cfelseif AuditType2 is "WiSE Technical Audit">
        <cfset incSubject = "WiSE Technical Audit of #OfficeName#">
    <cfelseif AuditedBy is "ULE">
    	<cfset incSubject = "ULE Audit - #Trim(AuditArea)#">
    </cfif>

<CFFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="#CGI.Script_Name#?#CGI.QUERY_STRING#">

Upload Scope Letter for <b>#year#-#id#</b>:<br>
File must be PDF or DOC Format<br>
<INPUT NAME="e_AttachA" SIZE=50 Type="File"><br><Br>

<input name="RecipientsTo" Type="Hidden" value="#Email#">
<input name="RecipientsCC" Type="Hidden" value="#Email2#">

<cfif Approved eq "Yes">
<b>To</b>: #email#<br>
<b>CC</b>: #email2#<br>
<cflock scope="Session" timeout="6">
	<cfoutput>
		<b>BCC</b>: #SESSION.Auth.Name# will be sent a copy of this email<br>
	</cfoutput>
</cflock>
<b>Subject</b>: #incSubject#<br /><Br />

Note - You can edit the contacts above on the Audit Details page.<br><Br>

Message: (Required)<br>
<textarea WRAP="PHYSICAL" ROWS="10" COLS="60" NAME="Message">Please enter a message here.<br><br>
This will be the body of the email text to notify of a new Scope Letter attachment.</textarea><br><br>
<cfelse>
<u>NOTE</u> - This audit is not approved to the Audit Schedule. No notifications will be sent<br><br>
</cfif>

<INPUT TYPE="button" value="Send Scope Letter Email" onClick=" javascript:check(document.Audit.e_AttachA);">
</cfFORM>
</cfoutput>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->