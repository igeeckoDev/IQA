						</td>
                          <td width="4%"></td>
                        </tr>
						<tr> 
                          <td class="article-end" colspan="3" align="right"><a href="#"><img src="images/top.gif" alt="" height="7" width="5" border="0"></a></td>
                        </tr>					
                        
						<tr> 
                         <td width="3%">&nbsp;</td>
<td class="sched-content">
<cfset Self = GetFileFromPath(cgi.CF_TEMPLATE_PATH)>
<cfset DirToList = GetDirectoryFromPath(ExpandPath("./" & Self))>
<cfdirectory action="list" directory="#DirToList#" name="DirListing">

<CFQUERY Name="Files" DataSource="Corporate">
SELECT * From RH
WHERE FileName = '#CGI.SCRIPT_NAME#'
</CFQUERY>

<cfoutput query="DirListing">
<cfif Name is #Self#>
<br>
<b>Page Details</b><br>
<u>filename</u> :: #UCase(Left(Name, 1))##Right(Name, Len(Name) - 1)#<br>
<u>size</u> :: #Size# bytes<br>
<u>last modified</u> :: #DateFormat(datelastmodified, "mm/dd/yyyy")# #TimeFormat(datelastmodified, "hh:mm:ss TT")#<br>
<u>datasource</u> :: Corporate<br>
#curdir#<br><br>
</cfif>
</cfoutput>

<script language="JavaScript" src="popup.js"></script>

<cflock scope="SESSION" timeout="5">
	<cfif isdefined("SESSION.Auth.Username")>
		<cfif SESSION.Auth.Username is "Chris">
			<cfif Files.recordcount eq 1>
				<cfoutput query="Files">
					<a href="javascript:popUp('RH.cfm?filename=#filename#')">View</a> Revision History
				</cfoutput>
			<cfelse>
				<cfoutput>
					Unregistered - <A href="admin/page_reg.cfm?filename=#CGI.SCRIPT_NAME#">register page</A>
				</cfoutput>
			</cfif>
		</cfif>
	</cfif>
</cflock>

<br><br>
<b>Error Reporting</b><br>
In case of errors/questions, please proceed to the <a href="#IQADir#getEmpNo.cfm?page=email">Error Reporting Form</a>.
</td>
                          <td></td>
                        </tr>
                        
						<tr> 
                          <td class="article-end" colspan="3" align="right"><a href="#"><img src="../IQA/images/top.gif" alt="" height="7" width="5" border="0"></a></td>
                        </tr>
                      </table>
                      <br> 
                  
					  <table width="100%">
                        <tr><td width="70%">&nbsp;</td>
					  <td width="30%" align="left">

						</td>
						</tr></table>
                      
                    </td>
                    <td class="horizontalbar">&nbsp;</td>
                    <td class="content-column-right" valign="top">&nbsp;</td>
                  </tr>
                </table></td>
				</tr>
				<tr>
				  <td class="table-bookend-bottom-footer" valign="top">
				  <div class="box-header">&nbsp;</div>
				</td>
				  </tr>
				  <tr>				  
<td class="table-bookend-bottom-footer">
<cfinclude template="footer.cfm">

<!---
<cfif cgi.remote_addr is NOT "10.40.118.45" AND cgi.remote_addr is NOT "10.40.118.53" AND cgi.remote_addr is NOT "10.40.106.138" AND cgi.remote_addr is NOT "10.40.118.42">
	<cfinclude template="incViews.cfm">
</cfif>
--->
</td>
			  </tr>
				<tr>
				  <td class="table-bookend-bottom">&nbsp;</td>
			  </tr>
				<tr>
					<td></td>

				</tr>
			</table>
			</div>
			</td></tr></table>
		<!---
		<!--- google analytics added 4/16/2009 --->
		<script type="text/javascript"> 
			var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www."); 
			document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E")); 
			</script> 
			<script type="text/javascript"> 
			var pageTracker = _gat._getTracker("UA-5818863-1"); 
			pageTracker._trackPageview(); 
		</script>
		--->		
</div>
	</body>
</html>