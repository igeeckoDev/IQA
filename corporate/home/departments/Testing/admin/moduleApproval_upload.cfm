<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ViewModules" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ModuleName
FROM ApplicationModules, ApplicationNames
WHERE ApplicationModules.aID = ApplicationNames.aID
AND ApplicationModules.mID = #URL.mID#
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "View Application Module - Upload Approval - #ViewModules.ModuleName#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif isdefined("url.msg")>
	<cfoutput>
        <font color="red"><b>Validation Error</b>: #url.msg#</font>
    </cfoutput><br><br />
</cfif>

<cfoutput>
<b>Module Name</b>:<br />
#ViewModules.ModuleName#<br /><br />
</cfoutput>

<b>Previous Approvals</b><br />
<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ViewApprovals" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM ApplicationApprovals
WHERE mID = #mID#
</CFQUERY>

<cfif ViewApprovals.recordCount GT 0>
	<cfoutput query="ViewApprovals">
    #ApprovalNumber#: #ApprovalName# (#dateformat(ApprovalDate, "mm/dd/yyyy")#) #ApprovalPerson# [<a href="#SiteDir#SiteShared/ApprovalFiles/#ApprovalFile#">View</a>]<br />
    </cfoutput>
<cfelse>
	None Listed
</cfif><br /><br />

<!--- included for Form Validation and Formatted Form Textarea boxes --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">
		
<!--- formatted textarea boxes --->
<cfinclude template="#SiteDir#SiteShared/incTextarea.cfm">

<div>
<cfoutput>
<cfform id="myform" name="myform" action="moduleApproval_Submit.cfm?mID=#URL.mID#" method="post" enctype="multipart/form-data">
 
<u>Approval File to Upload</u>: (PDF Only)<br />
<input type="File" size="50" name="File" data-bvalidator="extension[pdf],required" data-bvalidator-msg="Please select file of type .pdf"><br><br />

<u>Approval Date</u>:<br />
    <div style="position:relative; z-index:3">
	    <cfinput type="datefield" name="ApprovalDate" data-bvalidator="date[mm/dd/yyyy],required">
    </div>
<br /><Br /><Br />

<u>Name of Approval</u> (name of the specific element of the module, or "overall module approval":<br />
<input type="text" size="50" name="ApprovalName" data-bvalidator="minlength[3],required" data-bvalidator-msg="Name of Approval is Required - Minimum 3 Characters">
<bR /><br />

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="getMaxApprovalNumber" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT MAX(ApprovalNumber) as MaxID
FROM ApplicationApprovals
WHERE mID = #mID#
</CFQUERY>

<cfif len(getMaxApprovalNumber.MaxID)>
	<cfset vApprovalNumber = getMaxApprovalNumber.MaxID + 1>
<cfelse>
	<cfset vApprovalNumber = 1>
</cfif>

<u>Approval Number</u>: <Cfoutput>#vApprovalNumber#</Cfoutput>
<input type="hidden" value="#vApprovalNumber#" name="ApprovalNumber">
<br /><br />

<u>Approver Name</u>: Kai Huang
<input type="hidden" value="Kai Huang" name="ApprovalPerson">
<br /><br />

<u>Notes</u>:<Br />
<textarea name="Notes" WRAP="PHYSICAL" ROWS="4" COLS="80"></textarea>
<bR /><br />

<input type="submit" value="Upload Approval File and Save Details">
<input type="reset" value="Reset Form">
</cfform>
</cfoutput>
</div>

<!--- required for form validation --->
<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->