<div id="left"> 
  <div class="content-pad"> 
    <h2>Calibration Meetings Menu</h2>
    <ul class="arrow2">
 	  <li class="arrow2"><a href="Calibration_Index.cfm" class="arrow">Home</a></li>
      <li class="arrow2"><a href="Calibration_Meeting_Add.cfm" class="arrow">Add Meeting</a></li>
      <li class="arrow2"><a href="Calibration_ActionItems.cfm" class="arrow">All Action Items</a></li>
      <li class="arrow2"><a href="Calibration_ActionItems.cfm?View=Open" class="arrow">Open Action Items</a></li>
      <li class="arrow2"><a href="Calibration_ActionItems.cfm?View=Closed" class="arrow">Closed Action Items</a></li>
	</ul>
	
	<cflock scope="Session" Timeout="5">
		<cfif IsDefined("SESSION.Auth.IsLoggedIn")>
        	<cfoutput>
            <br />
            <h2>Account</h2>
                <ul class="arrow2">
                    <li class="arrow2">#SESSION.Auth.Name#</li>
                    <li class="arrow2">Access Level: #SESSION.Auth.AccessLevel#</li>
                    <li class="arrow2"><a href="../index.cfm" class="arrow">Return to CAR Process Admin Menu</a></li>
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