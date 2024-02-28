<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Schedule - Confirm Audit Cancellation">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif isDefined("url.msg")>
	<cfoutput>
    <br />
    <font color="red"><b>#url.msg#</b></font><br /><br />
    
    <a href="auditdetails.cfm?id=#url.id#&year=#url.year#">Return to Audit Details</a><Br /><Br />
    </cfoutput>
<cfelseif Form.Cancel is "Cancel Request">
	<cflocation url="auditdetails.cfm?id=#url.id#&year=#url.year#" addtoken="no">
<cfelseif form.Cancel is "Confirm Request">

<!---
    <cfparam name="link" default="">
    <cfset link="#HTTP_Referer#">

    <CFIF Form.File is "">
        <cflocation url="#link#" addtoken="no">
    </CFIF>

    <CFFILE ACTION="UPLOAD" 
        FILEFIELD="Form.File" 
        DESTINATION="#IQAPath#CancelRequestFiles\" 
        NAMECONFLICT="OVERWRITE"
        accept="application/pdf, application/msword">

	<cfset FileName="#Form.File#">

	<cfset NewFileName="#URL.Year#-#URL.ID#-CancelFile.#cffile.ClientFileExt#">
 
    <cffile
        action="rename"
        source="#FileName#"
        destination="#IQAPath#CancelRequestFiles\#NewFileName#">
--->
      
        <CFQUERY BLOCKFACTOR="100" NAME="AddID" Datasource="Corporate">
		Update AuditSchedule 
		SET
		<!---
        CancelRequestFile = '#NewFileName#',
        --->
		CancelRequest = 'Yes',
        CancelRequestDate = #createodbcdate(curdate)#,
        CancelNotes = '#Form.Notes#<br>Requestor:<cflock scope="session" timeout="5">#SESSION.Auth.Username#</cflock><br>Date: #dateformat(curdate, "mm/dd/yyyy")#'
        
		WHERE ID = #URL.ID# AND Year_ = #URL.Year#
        </CFQUERY>
        
        <!--- request email to DE --->
        <cfmail 
        	to="Kai.Huang@ul.com"
            subject="Audit Cancellation Request - #URL.Year#-#URL.ID#-IQA"
            from="Internal.Quality_Audits@ul.com"
            type="html">
            An Audit Cancellation Request is awaiting your approval. Please log in to IQA and view "Audit Cancellations - View Requests"<br><br>
            
            <a href="http://usnbkiqas100p/departments/snk5212/IQA/admin/global_login.cfm">IQA Login Page</a>
        </cfmail>
      
      <cfset message = "Cancellation Request has been sent. Please contact Denise for more information.">
   
   <cflocation url="cancel_fileupload.cfm?ID=#URL.ID#&Year=#URL.Year#&msg=#variables.message#" addtoken="no">
<cfelse>

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

Audit Cancel Help - <A HREF="javascript:popUp('../webhelp/webhelp_cancel.cfm')">[?]</A><br><br />

<cfoutput>	
<!---
	<script language="JavaScript">		
    function check() {
      var ext = document.Audit.File.value;
      ext = ext.substring(ext.length-3,ext.length);
      ext = ext.toLowerCase();
        if ((document.Audit.File.value.length!=0) || (document.Audit.File.value!=null)) {
         if(ext != 'pdf') {
        alert('You selected a .'+ext+' file; Only PDF files are accepted.');
        return false; 
         }
        }	
    else
    return true;
    document.Audit.submit();
    }
    </script>
--->

<b>Audit Number</b><br />
#URL.Year#-#URL.ID#-IQA<br /><br />
 
<form name="Audit" action="cancel_fileupload.cfm?ID=#URL.ID#&Year=#URL.Year#" enctype="multipart/form-data" method="post">
<u>Cancellation Notes</u>:<br>
#form.e_Notes#<br><br>
<input type="hidden" value="#form.e_notes#" name="notes">

<!---
Audit Cancellation File to Upload:<br />
<input type="File" size="50" name="File"><br><br />

<INPUT TYPE="button" value="Confirm Request" name="Cancel" onClick=" javascript:check(document.Audit.File);">
--->

<INPUT TYPE="Submit" name="Cancel" Value="Confirm Request">
<INPUT TYPE="Submit" name="Cancel" Value="Cancel Request">

</form>
</cfoutput>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->