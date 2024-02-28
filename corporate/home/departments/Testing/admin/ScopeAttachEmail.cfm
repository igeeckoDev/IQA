<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Upload New Scope Letter Attachment - Notification">
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

<script language="JavaScript">		
function check() {
  var ext = document.Audit.e_AttachA.value;
  ext = ext.substring(ext.length-3,ext.length);
  ext = ext.toLowerCase();
    if ((document.Audit.e_AttachA.value.length!=0) || (document.Audit.e_AttachA.value!=null)) {
	 if(ext != 'pdf') {
      if(ext != 'doc') {
	   if(ext != 'zip') {
    alert('You selected a .'+ext+' file; please select a doc, pdf, or zip file!');
    return false; 
	  }
	  }
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

<cfif isDefined("Form.Submit")>

<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<CFIF Form.e_AttachA is "">
	<cflocation url="#link#" addtoken="no">
</CFIF>

<CFFILE ACTION="UPLOAD" 
FILEFIELD="e_AttachA" 
DESTINATION="#IQARootPath#ScopeLetters\" 
NAMECONFLICT="OVERWRITE">

<cfset FileName="#Form.e_AttachA#">

<cfset NewFileName="#URL.Year#-#URL.ID#-Attach.#cffile.ClientFileExt#">
 
<cffile
    action="rename"
    source="#FileName#"
    destination="#IQARootPath#ScopeLetters\#NewFileName#">

<CFQUERY Datasource="Corporate" Name="EnterScope">
UPDATE Scope
SET

AttachA='#NewFileName#'

WHERE ID = #URL.ID# 
AND YEAR_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<!---
<cfset Dump1 = #replace(Form.Recipients, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump1, "</p>", "", "All")#>

<cfset Dump3 = #replace(Form.cc, "<p>", "", "All")#>
<cfset Dump4 = #replace(Dump3, "</p>", "", "All")#>
--->

<cfset Dump5 = #replace(Form.Message, "<p>", "", "All")#>
<cfset Dump6 = #replace(Dump5, "</p>", "<br><br>", "All")#>

<cfoutput query="AddReport">
	<cfif AuditType2 eq "Program">
    	<cfset incSubject = "#Trim(Area)#">
	<cfelseif AuditType2 eq "Field Services">
    	<cfset incSubject = "Field Services - #trim(Area)#">
	<cfelseif AuditType2 is "Corporate" or AuditType2 is "Local Function" or AuditType2 is "Local Function FS" or audittype2 is "Local Function CBTL" or audittype2 is "Global Function/Process">
    	<cfif isDefined("Area")>
    		<cfset incSubject = "#Trim(OfficeName)# - #Trim(Area)#">
		<cfelse>
        	<cfset incSubject = "#Trim(OfficeName)# - #Trim(AuditArea)#">
        </cfif>
	<cfelseif AuditType2 is "MMS - Medical Management Systems">
    	<cfset incSubject = "#Trim(Area)#">
    </cfif>
</cfoutput>

<cflock Scope="SESSION" Timeout="5">
<cfmail 
	to="#Form.To#" 
	cc="Internal.Quality_Audits@ul.com, #Form.CC#" 
	From="#Form.From#" 
	Subject="Scope Attachment Update - Quality System Audit of #incSubject#" 
	type="HTML"
    query="AddReport">
Attachment A of the scope letter for the quality system audit of #incSubject# (#Year#-#ID#-#AuditedBy#) has been updated. Please follow the link below to access the new Attachment A file:<br><br>

<a href="http://#CGI.Server_Name#/departments/snk5212/IQA/ScopeLetter_View.cfm?ID=#URL.ID#&Year=#URL.Year#">View Scope Letter</a><br><br>

Notes:<br>
#Dump6#

<u>Audit</u>: #Year#-#ID#-#AuditedBy#<br>
<u>Audit Type</u>: #AuditType2#<br />
<u>Audit Area</u>: #Trim(Area)#<br>
<u>Location</u>: #Trim(Officename)#<br>
<u>Lead Auditor</u>: #LeadAuditor#<br>
<u>Audit Details</u>: http://usnbkiqas100p/departments/snk5212/IQA/auditdetails.cfm?ID=#URL.ID#&Year=#URL.Year#<br><br>

Please contact #LeadAuditor# with any questions or issues.
</cfmail>
</cflock>

<cflocation url="AuditDetails.cfm?ID=#URL.ID#&Year=#URL.Year#&msg=Updated Attachment A sent to Audit Team and Auditees&var=AttachA" addtoken="no">

<cfelse>

<cfoutput query="AddReport">

	<Cfset AuditorCCEmails = "">
    
	<!--- add lead auditor field email --->
    <cfif len(LeadAuditor)>
        <cfloop index = "ListElement" list = "#LeadAuditor#"> 
            <Cfoutput>
                <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
                SELECT Email 
                FROM AuditorList
                WHERE Auditor = '#trim(ListElement)#'
                </CFQUERY>
                
                <cfset LeadEmail = "#AuditorEmail.Email#">
                <cfset AuditorCCEmails = listAppend(AuditorCCEmails, "#AuditorEmail.Email#")>
            </cfoutput>
        </cfloop>
    </cfif>

    <!--- add auditor field emails --->
    <cfif len(Auditor)>
        <cfloop index = "ListElement" list = "#Auditor#"> 
            <Cfoutput>
                <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
                SELECT Email 
                FROM AuditorList
                WHERE Auditor = '#trim(ListElement)#'
                </CFQUERY>
                
                <cfset AuditorCCEmails = listAppend(AuditorCCEmails, "#AuditorEmail.Email#")>
            </cfoutput>
        </cfloop>
    </cfif>
    
    <!--- add auditor in training field emails --->
    <cfif len(AuditorInTraining)>
        <cfloop index = "ListElement" list = "#AuditorInTraining#"> 
            <Cfoutput>
                <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
                SELECT Email 
                FROM AuditorList
                WHERE Auditor = '#trim(ListElement)#'
                </CFQUERY>
                
                <cfset AuditorCCEmails = listAppend(AuditorCCEmails, "#AuditorEmail.Email#")>
            </cfoutput>
        </cfloop>
    </cfif>
    <!--- /// --->

<CFFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="#CGI.Script_Name#?#CGI.QUERY_STRING#">
<br>
Upload New Scope Letter Attachment for <b>#year#-#id#</b>:<br>
File must be PDF Format<br>
<INPUT NAME="e_AttachA" SIZE=50 Type="File"><br><Br>

<u>To</u>:<br />
Primary Contact: #Email#<br><br />
<input name="To" Type="hidden" value="#email#">

<u>CC</u>:<br />
Other Contact(s): #Email2#<br>
Audit Team: #AuditorCCEmails#<br /><br />
<input name="cc" Type="hidden" value="#email2#, #AuditorCCEmails#">

<u>From</u>:<br />
Lead Auditor: #LeadEmail#<br /><br />
<input name="from" type="hidden" Value="#LeadEmail#" />

Message: (Required)<br>
<textarea WRAP="PHYSICAL" ROWS="20" COLS="60" NAME="Message">Please enter a message here.<br><br>
This will be the body of the email text to notify of a new Scope Letter attachment.</textarea><br><br>

<INPUT Name="Submit" TYPE="Submit" value="Send Email and Upload New Scope Attachment">

</cfFORM>
</cfoutput>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->