<cfoutput>
<cfif isDefined("url.View") AND isDefined("url.Manager") AND isDefined("url.Type")>
	
	<cfif url.Type eq "All">
		<cfset Type = "CARs">
	<cfelseif url.Type eq "Finding">
		<cfset Type = "Findings">
	<cfelseif url.Type eq "Observation">
		<cfset Type = "Observations">
	</cfif>

	<cfif url.View eq "All">
		<cfset subTitle = "View All #Type#">
	<cfelseif url.View eq "Open">
		<cfset subTitle = "View Open #Type#">
	<cfelseif url.View eq "Closed">
		<cfset subTitle = "View Closed #Type#">
	</cfif>
	
	<cfif url.Manager neq "None" AND url.Program neq "Null">
		<cfset subTitle = "#subtitle# by<br> <img src=../SiteImages/arrow2_bullet.gif> Manager (#url.Manager#)<br> <img src=../SiteImages/arrow2_bullet.gif> Program (#url.Program#)">
	<cfelseif url.Manager neq "None" AND url.Program eq "Null">
		<cfset subTitle = "#subTitle# by<br> <img src=../SiteImages/arrow2_bullet.gif> Manager (#url.Manager#)">
	<cfelseif url.Manager eq "None" AND url.Program neq "Null">
		<cfset subTitle = "#subTitle# by<br> <img src=../SiteImages/arrow2_bullet.gif> Program (#url.Program#)">
	</cfif>
</cfif>

<cfif isDefined("url.showPerf")>
	<cfif url.showPerf eq "Yes">
		<cfset subTitle2 = "CAR Performance">
	</cfif>
</cfif>
</cfoutput>