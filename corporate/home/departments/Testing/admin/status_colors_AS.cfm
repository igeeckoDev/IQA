<b>Status</b><br>
<cfif Trim(Status) is "Removed">
	<font color="red">Removed from Audit Schedule (Deleted)</font>
<cfelse>
	<cfif trim(year) gt CurYear>
		<cfif Trim(Status) is NOT "deleted">
            <img src="#IQARootDir#images/yellow.jpg" border="0">
        <cfelse>
            <img src="#IQARootDir#images/black.jpg" border="0">
        </cfif>
    <cfelseif trim(year) is CurYear>
        <cfif Trim(Report) is NOT "" and Trim(Status) is NOT "deleted">
            <img src="#IQARootDir#images/green.jpg" border="0">
        <cfelseif Trim(Report) is "" and Trim(Status) is NOT "deleted">
            <cfif Trim(Month) is CurMonth>
                <cfif Trim(EndDate) is "" and Trim(StartDate) is NOT "">
                    <cfif Trim(StartDate) lt CurDate>
                        <img src="#IQARootDir#images/green.jpg" border="0">
                    <cfelse>
                        <img src="#IQARootDir#images/yellow.jpg" border="0">
                    </cfif>
                <cfelseif Trim(EndDate) is "" and Trim(StartDate) is "">
                    <img src="#IQARootDir#images/yellow.jpg" border="0">
                <cfelseif Trim(EndDate) is NOT "" and Trim(StartDate) is NOT "">
                    <cfif Trim(EndDate) lt CurDate or Trim(StartDate) lt CurDate>
                            <img src="#IQARootDir#images/green.jpg" border="0">
                    <cfelseif Trim(EndDate) gte CurDate or Trim(StartDate) gte CurDate>
                        <img src="#IQARootDir#images/yellow.jpg" border="0">
                    </cfif>
                </cfif>
            <cfelseif CurMonth gt Trim(Month)>
                    <img src="#IQARootDir#images/green.jpg" border="0">
            <cfelse>
                <img src="#IQARootDir#images/yellow.jpg" border="0">
            </cfif>
        <cfelse>
	        <img src="#IQARootDir#images/black.jpg" border="0">
        </cfif>
    <cfelse>
	    <cfif Trim(Status) is NOT "deleted">
	        <img src="#IQARootDir#images/green.jpg" border="0">
        <cfelse>
        	<img src="#IQARootDir#images/black.jpg" border="0">
        </cfif>
    </cfif>
</cfif>