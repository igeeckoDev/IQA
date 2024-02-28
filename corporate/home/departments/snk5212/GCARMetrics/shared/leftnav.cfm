<div id="left"> 
	<div class="content-pad">
    <h2>GCAR Metrics Menu</h2>
        <ul class="arrow2">
          <li class="arrow2"><a href="index.cfm" class="arrow">Start New Search</a></li>
          <li class="arrow2"><a href="getEmpNo.cfm?page=ViewQueries" class="arrow">View Your Saved Reports</a></li>
          <li class="arrow2"><a href="ViewQueries.cfm?EmpNo=All" class="arrow">View All Saved Reports</a></li>
          <li class="arrow2"><a href="Glossary.cfm?ID=All" class="arrow">Glossary of Terms</a></li>
          <li class="arrow2"><a href="Overview.cfm" class="arrow">Application Overview</a></li>
        </ul>
        
        <h2>Site Status</h2>
        <cfoutput>
        <ul class="arrow2">
            <cfif Request.Development eq "Yes">
                <li class="arrow2">
                    <p class="warning">
                        Application In Development - This is TEST DATA and is NOT ACCURATE
                    </p>
                </li>
            <cfelse>
                <li class="arrow2">
                    <!---GCAR Metrics Data last updated on <span class="dataDate">#dateformat(Request.DataDate, "mm/dd/yyyy")#</span>--->
                </li>
            </cfif>
        </ul>
        </cfoutput>
	</div>
</div>