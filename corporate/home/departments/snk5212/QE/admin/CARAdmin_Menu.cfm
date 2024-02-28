<!--- Start of Page File --->
<cfset subTitle = "CAR Administrator Related Pages - Menu">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfoutput>
Please select a page below:<br><br />
<ul class="arrow2">
  <li class="arrow2"><a href="CM/Calibration_Index.cfm">Calibration Meetings</a></li>
  <li class="arrow2"><a href="carAdminList.cfm">CAR Admin List and Profiles - View</a></li>
  <li class="arrow2"><a href="carAdminAdd.cfm">Add New CAR Admin</a></li>
  <li class="arrow2"><a href="CARFiles.cfm">CAR Training Attendance, CAR Admin Performance</a></li>
  <li class="arrow2">CAR Administrator Responsibility Matrix <a href="#CARDir#carMatrix/CARAdministratorResponsibilityList.xls">[View]</a> <a href="CARResponsibility.cfm">[Upload]</a></li>
  <li class="arrow2">Requests <a href="#CARDir#getEmpNo.cfm?page=request">[Request Form]</a> <a href="Request.cfm">[View Requests]</a></li>
</ul>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->