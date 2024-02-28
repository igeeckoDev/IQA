<div id="left">
  <div class="content-pad">
    <h2>Menu</h2>
		<ul class="arrow2">
        	<li class="arrow2"><a href="Distribution_2019.cfm?Type=Program" class="arrow">IQA Audit Planning - 2019<br /></a></li>
			<li class="arrow2"><a href="https://ul.sharepoint.com/sites/quality/539/Shared%20Documents/Forms/AllItems.aspx?RootFolder=%2Fsites%2Fquality%2F539%2FShared%20Documents%2FStaff%20Directories%2FAudit%20Planning%20Survey%20Contact%20Lists&FolderCTID=0x012000F8973DC62364B544A6CE5E28E450DDF6&View=%7B7EF74934%2D7955%2D485F%2DBAAF%2DF6AA5B8B95BB%7D" target="_blank" class="arrow">View / Manage Contact Lists</a></li>
  			<li class="arrow2"><a href="Archive_Menu.cfm" class="arrow">Archive</a></li>
            <li class="arrow2"><a href="../index.cfm" class="arrow">Return to IQA Site</a></li>
		</ul>

	<br />
    <h2>Site Info</h2>
        <ul class="arrow2">
            <li class="arrow2">
				This site is not intended for use with Mobile Devices.
            </li>
        </ul>

<cflock scope="Session" Timeout="5">
    <cfif IsDefined("SESSION.Auth.IsLoggedIn")>
        <cfoutput>
        <br />
        <h2>Account</h2>
            <ul class="arrow2">
                <li class="arrow2">#SESSION.Auth.Name#</li>
                <li class="arrow2">Access Level: #SESSION.Auth.AccessLevel#</li>
 				<li class="arrow2"><a href="../admin/index.cfm" class="arrow">Return to IQA Admin</a></li>
            </ul>
        </cfoutput>
	</cfif>
</cflock>

	<cfoutput>
		<cfif Request.Development eq "Yes">
		<br />
        <h2>Site Status</h2>
			<ul class="arrow2">
				<li class="arrow2">
					<p class="warning">
						Application In Development - This is TEST DATA and is NOT ACCURATE
					</p>
				</li>
			</ul>
		</cfif>
	</cfoutput>
  </div>
</div>