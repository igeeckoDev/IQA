<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "#Request.SiteTitle# - Send Email - Email Verification">
<cfinclude template="SOP.cfm">

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

<cfquery name="Email" datasource="Corporate" blockfactor="100"> 
SELECT MAX(ID)+1 as maxId FROM IQADB_SendEmail
</cfquery>
	
<cfquery name="addEmail" datasource="Corporate" blockfactor="100"> 
INSERT INTO IQADB_SendEmail(ID)
VALUES(#Email.maxId#)
</cfquery>	

<cfquery name="UpdateEmail" datasource="Corporate" blockfactor="100"> 
UPDATE IQADB_SendEmail
	SET

	REFERENCE='#Form.REFERENCE#',
	Subject='#form.Subject#',
	EmailBody='#form.EmailBody#',
	<cflock scope="Session" timeout="5">
	Author='#SESSION.Auth.Email#',
	</cflock>
	<cfif form.sendCC is NOT "">
	SendCC='#Form.SendCC#',
	</cfif>	
	SendTo='#Form.SendTo#',
	SendDate=#CreateODBCDate(curdate)#
	
	WHERE ID = #Email.maxId#
</cfquery>
	
<cfquery name="Email" datasource="Corporate" blockfactor="100"> 
SELECT * FROM IQADB_SendEmail
WHERE ID = #Email.maxID#
</cfquery>
	
<!--- check SendTo Address --->	
	<cfset Emails = #valueList(Email.SendTo, ',')#>
	<cfset myArrayList = ListToArray(Emails)>
	
	<cfloop from="1" to="#arraylen(myArrayList)#" index="i">
	<CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
	SELECT first_n_middle, last_name, preferred_name, employee_email 
	FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
	WHERE employee_email = '#myArrayList[i]#'
	</CFQUERY>
	
	<u>'Send To' Address Check</u>:<br>
	<cfoutput>
	#myArrayList[i]# - 
	<cfif NameLookup.RecordCount eq 1>
		Ok
	<cfelseif NameLookup.RecordCount gt 1>
		Ok (#namelookup.recordcount#)
	<cfelse>
		<b>Not Found</b>
	</cfif>
	</cfoutput><br>
	</cfloop><br>
	
<cfif Email.SendCC is NOT "">	
<!--- Check SendCC Addresses --->

	<cfset Emails = #valueList(Email.SendCC, ',')#>
	<cfset myArrayList = ListToArray(Emails)>
	
	<cfloop from="1" to="#arraylen(myArrayList)#" index="i">
	<CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
	SELECT first_n_middle, last_name, preferred_name, employee_email 
	FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
	WHERE employee_email = '#myArrayList[i]#'
	</CFQUERY>

	<u>CC Address Check</u>:<br>
	<cfoutput>
	#myArrayList[i]# - 
	<cfif NameLookup.RecordCount eq 1>
		Ok
	<cfelseif NameLookup.RecordCount gt 1>
		Ok (#namelookup.recordcount#)
	<cfelse>
		<b>Not Found</b>
	</cfif>
	</cfoutput><br>
	</cfloop><br>
</cfif>
	
<!--- Email Form --->
	
<cfform name="Email" action="SendEmail3.cfm?ID=#Email.ID#" method="post">

<b>Date Sent</b>:<br />
<cfinput type="datefield" name="SendDate" value="#dateformat(Email.SendDate, "mm/dd/yyyy")#" required="yes" size="25">
<br /><br />

<B>Author</B>:<br />
<cfinput type="text" name="Author" value="#Email.Author#" required="Yes" size="75"><Br /><br />

<B>Send Email To</B>:<br>
<cfinput type="text" name="SendTo" value="#Email.SendTo#" message="Please Enter the Recipient's Email Address, UL External Email Address Only" required="Yes" size="75"><br>

External UL Email Addresses Only. <a href="">Look Up</a> Email Addresses Here<br><br>

<B>Send Email CC</B>:<br>
<cfinput type="text" name="SendCC" value="#Email.SendCC#" message="Please Enter the CC Email Addresses if applicable, UL External Email Address Only" required="no" size="75"><br>
	
External UL Email Addresses Only. <a href="">Look Up</a> Email Addresses Here<br><br>	
	
<B>Subject</B><br>
<cfinput type="text" name="Subject" value="#Email.Subject#" message="Please Enter the Email Subject" required="Yes" size="75"><br><br>

<b>Reference</b>:<br />
<cfinput type="text" name="Reference" value="#Email.Reference#" message="Please Enter a Reference for grouping/sorting purposes" required="yes" size="75"><br /><br />
	
<b>Email Text</B><br>
<cfoutput>
<textarea WRAP="PHYSICAL" ROWS="20" COLS="60" NAME="EmailBody">#Email.EmailBody#</textarea><br><br>
</cfoutput>
	
<input type="submit" value="Send Email" name="Save">
</cfform>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->