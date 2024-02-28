<!---
    <CFQUERY NAME="QEmpLookup" datasource="OracleNet">
    SELECT first_n_middle, last_name, preferred_name, employee_email 
    FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
    WHERE employee_number='#form.EmpNo#' 
    </CFQUERY>
    
    <cfif QEmpLookup.recordcount gt 0> 
    <cfset EmpFieldType="Hidden">
       <cfif len(QEmpLookup.preferred_name)>
       <cfset v_name = #QEmpLookup.preferred_name# & " " & #QEmpLookup.last_name# >
       <cfelse>
       <cfset v_name = #QEmpLookup.first_n_middle# & " " & #QEmpLookup.last_name# >
       </cfif>
      <cfset v_email = #QEmpLookup.employee_email#>
      <cfset qresult = 0>
    <cfelse>
    <cfset EmpFieldType="Text">
      <cfset v_name = ''>
      <cfset v_email = ''>
      <cfset qresult = 1>
    </cfif>
--->

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitleHeading = "Quality Engineering Web Site - Error Reporting">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfparam name="form.link" default="No HTTP Referer">
<cfparam name="form.empNo" default="">

<cfoutput>
    <script 
        language="javascript" 
        type="text/javascript" 
        src="#CARDir#tinymce/jscripts/tiny_mce/tiny_mce.js">
    </script>
    
    <script language="javascript" type="text/javascript">
    tinyMCE.init({
        mode : "textareas",
        content_css : "#SiteDir#SiteShared/cr_style.css"
    });
    </script>
</cfoutput>

<cfif isDefined("Form.EmpNo")>
	<cfset EmpFieldType="Text">
	<cfset v_name = ''>
    <cfset v_email = ''>
    <cfset qresult = 1>
</cfif>
						  
<br><p>Please complete the form below with any errors found on the <cfoutput>#Request.SiteTitle#</cfoutput>.<br></p>

<cfoutput>
<cfform ACTION="email_submit.cfm" METHOD="POST" name="Audit">
    
    <cfinput type="hidden" name="emaillink" value="#form.link#">
    <cfinput type="hidden" name="EmpNo" value="#form.EmpNo#">	
						  
<table width="650" border="0" cellpadding="1" cellspacing="1" valign="top">
    <tr>
        <TD class="blog-title">
        	<P>Your Name:</P>
        </TD>
        <TD class="blog-content">
        	#v_name#<cfinput size="50" type="#EmpFieldType#" name="name" value="#v_name#">
        </TD>
    </TR>
    <TR>
        <TD class="blog-title">
        	<P>Your Email:</P>
        </TD>
        <TD class="blog-content">
        	#v_email#<cfinput size="50" type="#EmpFieldType#" name="email" value="#v_email#">
        </TD>
    </TR>
    <TR>
        <TD class="blog-title" valign="top">
        	<P>Issue:</P>
        </TD>
        <TD>
        	<textarea WRAP="PHYSICAL" ROWS="5" COLS="60" NAME="e_input"></textarea>
        </TD>
    </TR>
</table><br>

<cfinput type="Submit" name="Submit" value="Submit Error Report">
</cfform>

<br>
<b>Referring URL:</b><br>
<cfif form.link is "No HTTP Referer">
	#form.link#
<cfelse>
	<a href="#urlDecode(form.link)#">#urlDecode(form.link)#</a>
</cfif>
<br>						  					  
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->