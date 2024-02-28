<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Superuser - Change Access Level">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<u>Note</u> - In order to regain your SU access rights, you must <b>Log Out</b>, then <b>Log back in to IQA</b>.<br><br>

This is used to test views and forms without having to manage multiple test accounts.<br><br>

<b>Select Access Level</b>:<br>
<a href="superuser_AccessLevel_Change_Process_Action.cfm?AccessLevel=Admin">Admin</a> (IQA)<br>
<a href="superuser_AccessLevel_Change_Process_Action.cfm?AccessLevel=AS">AS</a><br>
<a href="superuser_AccessLevel_Change_Process_Action.cfm?AccessLevel=Auditor">Auditor</a> (no longer used)<br>
<a href="superuser_AccessLevel_Change_Process_Action.cfm?AccessLevel=CPO">CPO</a> (Program Master List)<br>
<a href="superuser_AccessLevel_Change_Process_Action.cfm?AccessLevel=DAP Qualifier">DAP Qualifier</a><br>
<a href="superuser_AccessLevel_Change_Process_Action.cfm?AccessLevel=Field Services">Field Services</a><br>
<a href="superuser_AccessLevel_Change_Process_Action.cfm?AccessLevel=Finance">Finance</a> (no longer used)<br>
<a href="superuser_AccessLevel_Change_Process_Action.cfm?AccessLevel=IQAAuditor">IQAAuditor</a> (IQA)<br>
<a href="superuser_AccessLevel_Change_Process_Action.cfm?AccessLevel=Laboratory Technical Audit">Laboratory Technical Audit</a> (no longer used)<br>
<a href="superuser_AccessLevel_Change_Process_Action.cfm?AccessLevel=Technical Audit">Technical Audit</a> (not used)<br>
<a href="superuser_AccessLevel_Change_Process_Action.cfm?AccessLevel=UL Environment">UL Environment</a><br>
<a href="superuser_AccessLevel_Change_Process_Action.cfm?AccessLevel=Verification Services">Verification Services</a> (no longer used)<br>
<a href="superuser_AccessLevel_Change_Process_Action.cfm?AccessLevel=WiSE">WiSE</a><br><br>

<b>For RQM Access Level - Select Region/Sub Region</b>:<br>
<u>Asia Pacific</u><br>
<a href="superuser_AccessLevel_Change_Process_Action.cfm?AccessLevel=RQM&Region=Asia Pacific&SubRegion=Australasia">Australasia</a> ::
<a href="superuser_AccessLevel_Change_Process_Action.cfm?AccessLevel=RQM&Region=Asia Pacific&SubRegion=Greater China">Greater China</a> ::
<a href="superuser_AccessLevel_Change_Process_Action.cfm?AccessLevel=RQM&Region=Asia Pacific&SubRegion=India">India</a> ::
<a href="superuser_AccessLevel_Change_Process_Action.cfm?AccessLevel=RQM&Region=Asia Pacific&SubRegion=Japan">Japan</a> ::
<a href="superuser_AccessLevel_Change_Process_Action.cfm?AccessLevel=RQM&Region=Asia Pacific&SubRegion=Korea">Korea</a><br><br>

<u>Europe</u><br>
<a href="superuser_AccessLevel_Change_Process_Action.cfm?AccessLevel=RQM&Region=Europe&SubRegion=Europe">Europe</a><br><br>

<u>Latin America</u><br>
<a href="superuser_AccessLevel_Change_Process_Action.cfm?AccessLevel=RQM&Region=Latin America&SubRegion=Latin America">Latin America</a><br><br>

<u>North America</u><br>
<a href="superuser_AccessLevel_Change_Process_Action.cfm?AccessLevel=RQM&Region=North America&SubRegion=Canada">Canada</a> ::
<a href="superuser_AccessLevel_Change_Process_Action.cfm?AccessLevel=RQM&Region=North America&SubRegion=US Central">US Central</a> ::
<a href="superuser_AccessLevel_Change_Process_Action.cfm?AccessLevel=RQM&Region=North America&SubRegion=US East Coast">US East Coast</a> ::
<a href="superuser_AccessLevel_Change_Process_Action.cfm?AccessLevel=RQM&Region=North America&SubRegion=US West Coast">US West Coast</a><br><br>

<u>Medical</u><br>
<a href="superuser_AccessLevel_Change_Process_Action.cfm?AccessLevel=RQM&Region=Medical&SubRegion=Medical">Medical</a>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->