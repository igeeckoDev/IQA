						</td>
                          <td width="4%"></td>
                        </tr>
<cfif #myurl# is #schedurl#>
<tr>
	<td width="4%" height="20" align="right"> <p>&nbsp;</p></td>
	<td colspan="2" align="left" class="sched-content">
		<p>
<cfinclude template="color_status.cfm">
		</p>
	</td>
</tr>
</cfif>
						<tr>
                          <td class="article-end" colspan="3" align="right"><a href="#"><img src="images/top.gif" alt="" height="7" width="5" border="0"></a></td>
                        </tr>

						<tr>
                          <td width="3%">&nbsp;</td>
<td class="sched-content">
<cfset Self = GetFileFromPath(cgi.CF_TEMPLATE_PATH)>
<cfset DirToList = GetDirectoryFromPath(ExpandPath("./" & Self))>
<cfdirectory action="list" directory="#DirToList#" name="DirListing">

<cfoutput query="DirListing">
<cfif Name is #Self#>
<br>
<b>Page Details</b><br>
<u>filename</u> :: #UCase(Left(Name, 1))##Right(Name, Len(Name) - 1)#<br>
<u>size</u> :: #Size# bytes<br>
<u>last modified</u> :: #DateFormat(datelastmodified, "mm/dd/yyyy")# #TimeFormat(datelastmodified, "hh:mm:ss TT")#<br>
<u>datasource</u> :: Corporate<br>
#curdir#
</cfif>
</cfoutput>
<br><br>
<b>Error Reporting</b><br>
In case of errors/questions, please proceed to the <a href="getEmpNo.cfm?page=email">Error Reporting Form</a>.
</td>
                          <td></td>
                        </tr>
						<tr>
                          <td class="article-end" colspan="3" align="right"><a href="#"><img src="images/top.gif" alt="" height="7" width="5" border="0"></a></td>
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
	</body>
</html>