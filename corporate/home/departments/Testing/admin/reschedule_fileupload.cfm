<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Reschedule- Confirm">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfif Form.Resched is "Cancel Request">
	<cflocation url="auditdetails.cfm?id=#url.id#&year=#url.year#" addtoken="no">
<cfelseif form.resched is "Confirm Request">

<!---
    <cfparam name="link" default="">
    <cfset link="#HTTP_Referer#">

    <CFIF Form.File is "">
        <cflocation url="#link#" addtoken="no">
    </CFIF>

    <CFFILE ACTION="UPLOAD" 
        FILEFIELD="Form.File" 
        DESTINATION="#IQAPath#RescheduleRequestFiles\" 
        NAMECONFLICT="OVERWRITE"
        accept="application/pdf, application/msword">

	<cfset FileName="#Form.File#">

	<cfset NewFileName="#URL.Year#-#URL.ID#-RescheduleFile.#cffile.ClientFileExt#">

    <cffile
        action="rename"
        source="#FileName#"
        destination="#IQAPath#RescheduleRequestFiles\#NewFileName#">
--->

        <CFQUERY BLOCKFACTOR="100" NAME="Notes" Datasource="Corporate">
		Select RescheduleNotes FROM AuditSchedule 
		WHERE ID = #URL.ID# AND Year_ = #URL.Year#
        </CFQUERY>

        <CFQUERY BLOCKFACTOR="100" NAME="AddID" Datasource="Corporate">
		Update AuditSchedule 
		SET
        RescheduleRequest = 'Yes',
		<!---
		RescheduleRequestFile = '#NewFileName#',
		--->
		RescheduleRequestDate = #createodbcdate(curdate)#,
        RescheduleRequestStartDate = #createodbcdate(form.StartDate)#,
        RescheduleRequestEndDate = #createodbcdate(Form.EndDate)#,
        RescheduleRequestMonth = #form.month#,
        RescheduleRequestNextYear = '#form.reschedulenextyear#',
        RescheduleNotes = '#Form.e_Notes#<br>Requestor:<cflock scope="session" timeout="5">#SESSION.Auth.Username#</cflock><br>Date: #dateformat(curdate, "mm/dd/yyyy")#<br /><br />#Notes.RescheduleNotes#'
		
		WHERE ID = #URL.ID# AND Year_ = #URL.Year#
        </CFQUERY>
        
        <!--- request email to DE --->
        <cfmail 
        	to="kai.huang@ul.com"
            bcc="Internal.Quality_Audits@ul.com"
            subject="Audit Reschedule Request - #URL.Year#-#URL.ID#-IQA"
            from="Internal.Quality_Audits@ul.com"
            type="html">
            An Audit Reschedule Request is awaiting your approval. Please log in to IQA and view "Audit Reschedules - View Requests"<br><br>
            
            <a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/admin/global_login.cfm">IQA Login Page</a>
        </cfmail>
      
      <cfset message = "Reschedule Request has been completed. Please contact Denise for more information.">

   <cflocation url="Reschedule_Request.cfm?ID=#URL.ID#&Year=#URL.Year#&msg=#variables.message#" addtoken="no">
<cfelse>

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

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

Audit Reschedule Help - <A HREF="javascript:popUp('../webhelp/webhelp_reschedule.cfm')">[?]</A><br><br />

<CFQUERY BLOCKFACTOR="100" name="Reschedule" Datasource="Corporate">
SELECT AuditSchedule.*, AuditSchedule.Year_ as Year 
FROM AuditSchedule
WHERE ID = #URL.ID#
and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>
			  
<cfoutput query="Reschedule">
<!--- change to approval by DE page --->
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="reschedule_fileupload.cfm?ID=#ID#&Year=#Year#">

<cfset CompareDate = Compare(FORM.StartDate, FORM.EndDate)>

<cfset y = #url.year#>
<cfset y2 = #y# + 1>
<cfset d = #DateFormat(Form.startdate, 'dd')#>
<cfset m = #DateFormat(Form.startdate, 'mm')#>
<cfset d2 = #DateFormat(Form.Enddate, 'dd')#>
<cfset m2 = #DateFormat(Form.Enddate, 'mm')#>

<cfif form.reschedulenextyear is "yes">
<cfif Form.StartDate is "" AND Form.EndDate is "">
	<input type="hidden" value="" name="startdate">
	<input type="hidden" value="" name="enddate">
	<input type="hidden" value="#form.e_month#" name="month">
<cfelseif Form.StartDate is NOT "" AND Form.EndDate is "">
	<input type="hidden" value="#m#/#d#/#y2#" name="startdate">
	<input type="hidden" value="" name="enddate">
	<cfset m = #DateFormat(Form.StartDate, 'mm')#>
	<input type="hidden" value="#m#" name="month">
<cfelseif Form.Startdate is NOT "" AND Form.EndDate is NOT "">
	<cfif CompareDate eq -1>
		<input type="hidden" value="#m#/#d#/#y2#" name="startdate">
		<input type="hidden" value="#m2#/#d2#/#y2#" name="enddate">
		<cfset m = #DateFormat(Form.StartDate, 'mm')#>
		<input type="hidden" value="#m#" name="month">
	<cfelseif CompareDate eq 0>
		<input type="hidden" value="#m#/#d#/#y2#" name="startdate">
		<input type="hidden" value="#m#/#d#/#y2#" name="enddate">
		<cfset m = #DateFormat(Form.StartDate, 'mm')#>
		<input type="hidden" value="#m#" name="month">
	<cfelseif CompareDate eq 1>
		<input type="hidden" value="#m2#/#d2#/#y2#" name="startdate">
		<input type="hidden" value="#m#/#d#/#y2#" name="enddate">
		<cfset m = #DateFormat(Form.EndDate, 'mm')#>
		<input type="hidden" value="#m#" name="month">
	</cfif>
<cfelseif Form.Startdate is "" AND Form.EndDate is NOT "">
		<input type="hidden" value="#m2#/#d2#/#y2#" name="startdate">
		<input type="hidden" value="#m2#/#d2#/#y2#" name="enddate">
		<cfset m = #DateFormat(Form.EndDate, 'mm')#>
		<input type="hidden" value="#m#" name="month">
</cfif>
<cfelse>
<cfif Form.StartDate is "" AND Form.EndDate is "">
	<input type="hidden" value="" name="startdate">
	<input type="hidden" value="" name="enddate">
	<input type="hidden" value="#form.e_month#" name="month">
<cfelseif Form.StartDate is NOT "" AND Form.EndDate is "">
	<input type="hidden" value="#m#/#d#/#y#" name="startdate">
	<input type="hidden" value="" name="enddate">
	<cfset m = #DateFormat(Form.StartDate, 'mm')#>
	<input type="hidden" value="#m#" name="month">
<cfelseif Form.Startdate is NOT "" AND Form.EndDate is NOT "">
	<cfif CompareDate eq -1>
		<input type="hidden" value="#m#/#d#/#y#" name="startdate">
		<input type="hidden" value="#m2#/#d2#/#y#" name="enddate">
		<cfset m = #DateFormat(Form.StartDate, 'mm')#>
		<input type="hidden" value="#m#" name="month">
	<cfelseif CompareDate eq 0>
		<input type="hidden" value="#m#/#d#/#y#" name="startdate">
		<input type="hidden" value="#m#/#d#/#y#" name="enddate">
		<cfset m = #DateFormat(Form.StartDate, 'mm')#>
		<input type="hidden" value="#m#" name="month">
	<cfelseif CompareDate eq 1>
		<input type="hidden" value="#m2#/#d2#/#y#" name="startdate">
		<input type="hidden" value="#m#/#d#/#y#" name="enddate">
		<cfset m = #DateFormat(Form.EndDate, 'mm')#>
		<input type="hidden" value="#m#" name="month">
	</cfif>
<cfelseif Form.Startdate is "" AND Form.EndDate is NOT "">
		<input type="hidden" value="#m2#/#d2#/#y#" name="startdate">
		<input type="hidden" value="#m2#/#d2#/#y#" name="enddate">
		<cfset m = #DateFormat(Form.EndDate, 'mm')#>
		<input type="hidden" value="#m#" name="month">
</cfif>
</cfif>

Do you wish to reschedule Audit #year#-#id#-#auditedby#?<br><br>

<u>Original Month:</u> #monthasstring(Month)#, #Year#<br>

<cfif form.startdate is "" AND Form.EndDate is "">
	<u>Rescheduled Month:</u> #monthasstring(Form.e_Month)#, <cfif Form.RescheduleNextYear is "Yes"><cfset next = #Year# + 1>#Next#<cfelse>#Year#</cfif><br><br>
<cfelseif form.startdate is NOT "" AND Form.EndDate is "">
	<cfset m = #DateFormat(Form.StartDate, 'mm')#>
	<u>Rescheduled Month:</u> #monthasstring(m)#, <cfif Form.RescheduleNextYear is "Yes"><cfset next = #Year# + 1>#Next#<cfelse>#Year#</cfif><br><br>
<cfelseif form.startdate is "" AND Form.EndDate is NOT "">
	<cfset m = #DateFormat(Form.EndDate, 'mm')#>
	<u>Rescheduled Month:</u> #monthasstring(m)#, <cfif Form.RescheduleNextYear is "Yes"><cfset next = #Year# + 1>#Next#<cfelse>#Year#</cfif><br><br>
<cfelseif form.startdate is NOT "" AND Form.EndDate is NOT "">
	<cfset m = #DateFormat(Form.startdate, 'mm')#>
	<u>Rescheduled Month:</u> #monthasstring(m)#, <cfif Form.RescheduleNextYear is "Yes"><cfset next = #Year# +
1>#Next#<cfelse>#Year#</cfif><br><br>
</cfif>

<u>Reschedule Dates:</u><br>
<cfif form.reschedulenextyear is "yes">
	<cfif Form.StartDate is "" AND Form.EndDate is "">
		No Dates
	<cfelseif Form.StartDate is NOT "" AND Form.EndDate is "">
		#m#/#d#/#y2#
	<cfelseif Form.Startdate is NOT "" AND Form.EndDate is NOT "">
		<cfif CompareDate eq -1>
			#m#/#d#/#y2# - #m2#/#d2#/#y2#
		<cfelseif CompareDate eq 0>
			#m#/#d#/#y2# - #m#/#d#/#y2#
		<cfelseif CompareDate eq 1>
			#m2#/#d2#/#y2# - #m#/#d#/#y2#
		</cfif>
	<cfelseif Form.Startdate is "" AND Form.EndDate is NOT "">
		#m2#/#d2#/#y2#
	</cfif>
<cfelse>
	<cfif Form.StartDate is "" AND Form.EndDate is "">
		No Dates
	<cfelseif Form.StartDate is NOT "" AND Form.EndDate is "">
		#m#/#d#/#y#
	<cfelseif Form.Startdate is NOT "" AND Form.EndDate is NOT "">
		<cfif CompareDate eq -1>
			#m#/#d#/#y# - #m2#/#d2#/#y#
		<cfelseif CompareDate eq 0>
			#m#/#d#/#y# - #m#/#d#/#y#
		<cfelseif CompareDate eq 1>
			#m2#/#d2#/#y# - #m#/#d#/#y#
		</cfif>
	<cfelseif Form.Startdate is "" AND Form.EndDate is NOT "">
		#m2#/#d2#/#y#
	</cfif>
</cfif><br><br>

<u>Reschedule Notes</u>:<br>
#Form.e_Notes#<br><br>
<input type="hidden" value="#form.e_notes#" name="e_Notes">
<input type="hidden" value="#form.reschedulenextyear#" name="reschedulenextyear">

<!---
Audit Reschedule File to Upload:<br />
<input type="File" size="50" name="File"><br><br />

<INPUT TYPE="button" value="Confirm Request" name="Cancel" onClick=" javascript:check(document.Audit.File);">
--->

<INPUT TYPE="Submit" name="Resched" Value="Confirm Request">
<INPUT TYPE="Submit" name="Resched" Value="Cancel Request">

</form>
</cfoutput>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->