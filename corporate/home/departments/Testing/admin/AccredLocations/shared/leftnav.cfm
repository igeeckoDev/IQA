<div id="left"> 
  <div class="content-pad"> 
    <h2>UL Accreditations Menu</h2>
    <ul class="arrow2">
 	  <li class="arrow2"><a href="index.cfm" class="arrow">Home</a></li>
 	  <li class="arrow2"><a href="viewAll.cfm" class="arrow">View All Accreditations</a></li>
      <li class="arrow2"><a href="SelectSite.cfm" class="arrow">View by UL Site</a></li>
	  <li class="arrow2"><a href="SelectAccreditor.cfm" class="arrow">View by Accreditor</a></li>
	  <li class="arrow2"><a href="AddAccred.cfm" class="arrow">View/Add UL Accreditors</a></li>
	  	<cfoutput>
        <cflock scope="Session" Timeout="5">
			<cfif IsDefined("SESSION.Auth.IsLoggedIn")>
				<cfif SESSION.Auth.AccessLevel eq "RQM">
                	<cfif SESSION.Auth.Region eq SESSION.Auth.Subregion>
                    	<li class="arrow2">
                        	<a href="addAccred_Site.cfm?Region=#SESSION.Auth.Region#&Subregion=#SESSION.Auth.SubRegion#" class="arrow">Add Accreditation</a>
                        </li>
                    <cfelse>
	                	<li class="arrow2">
                        	<a href="addAccred_Site.cfm?Region=#SESSION.Auth.Region#&SubRegion=#SESSION.Auth.SubRegion#" class="arrow">Add Accreditation</a>
                        </li>
					</cfif>
                <cfelse>
					<li class="arrow2">
                    	<a href="addAccred_Site.cfm" class="arrow">Add Accreditation</a>
                    </li>
				</cfif>
            </cfif>
        </cflock>
        </cfoutput>
      <li class="arrow2"><a href="Glossary.cfm" class="arrow">Glossary</a></li>
	  <li class="arrow2"><a href="QueryToExcel.cfm" class="arrow">Export to Excel</a></li>
      <li class="arrow2"><a href="helpFile/HelpFile.pptx" class="arrow">How To Use This Module (pptx)</a></li>
	</ul>
	
	<cflock scope="Session" Timeout="5">
		<cfif IsDefined("SESSION.Auth.IsLoggedIn")>
        	<cfoutput>
            <br />
            <h2>Account</h2>
                <ul class="arrow2">
                    <li class="arrow2">#SESSION.Auth.Name#</li>
                    <li class="arrow2">Access Level: #SESSION.Auth.AccessLevel#</li>
					<cfif SESSION.Auth.AccessLevel eq "RQM">
                    	<li class="arrow2">
							Region: 
							<cfif SESSION.Auth.Region eq SESSION.Auth.Subregion>
                            	#SESSION.Auth.Region#
							<cfelse>
                            	#SESSION.Auth.Region# / #SESSION.Auth.SubRegion#
							</cfif>
                        </li>
					</cfif>
                    <li class="arrow2"><a href="../index.cfm" class="arrow">Return to IQA Admin</a></li>
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