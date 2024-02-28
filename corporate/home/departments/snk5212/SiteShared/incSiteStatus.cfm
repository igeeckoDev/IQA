<cfoutput>
	<cfif Request.Development eq "Yes">
	<br />
	<h2>Site Status</h2>
        <p class="warning">
            <img align="absmiddle" src="#SiteDir#SiteImages/database_stop.png" border="0" alt="In Development" /> Application In Development - This is TEST DATA and is NOT ACCURATE
        </p>
	</cfif>
</cfoutput>