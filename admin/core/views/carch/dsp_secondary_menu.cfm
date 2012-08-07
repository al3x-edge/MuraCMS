<!--- This file is part of Mura CMS.

Mura CMS is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, Version 2 of the License.

Mura CMS is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Mura CMS. If not, see <http://www.gnu.org/licenses/>.

Linking Mura CMS statically or dynamically with other modules constitutes the preparation of a derivative work based on 
Mura CMS. Thus, the terms and conditions of the GNU General Public License version 2 ("GPL") cover the entire combined work.

However, as a special exception, the copyright holders of Mura CMS grant you permission to combine Mura CMS with programs
or libraries that are released under the GNU Lesser General Public License version 2.1.

In addition, as a special exception, the copyright holders of Mura CMS grant you permission to combine Mura CMS with 
independent software modules (plugins, themes and bundles), and to distribute these plugins, themes and bundles without 
Mura CMS under the license of your choice, provided that you follow these specific guidelines: 

Your custom code 

• Must not alter any default objects in the Mura CMS database and
• May not alter the default display of the Mura CMS logo within Mura CMS and
• Must not alter any files in the following directories.

 /admin/
 /tasks/
 /config/
 /requirements/mura/
 /Application.cfc
 /index.cfm
 /MuraProxy.cfc

You may copy and distribute Mura CMS with a plug-in, theme or bundle that meets the above guidelines as a combined work 
under the terms of GPL for Mura CMS, provided that you include the source code of that other code when and as the GNU GPL 
requires distribution of source code.

For clarity, if you create a modified version of Mura CMS, you are not obligated to grant this special exception for your 
modified version; it is your choice whether to do so, or to make such modified version available under the GNU General Public License 
version 2 without this exception.  You may, if you choose, apply this exception to your own modified versions of Mura CMS.
--->

<cfoutput>
<cfset rc.originalfuseaction=listLast(request.action,".")>
<cfset rc.originalcircuit=listFirst(listLast(request.action,":"),".")>
<div id="nav-module-specific" class="btn-group">
	<cfswitch expression="#rc.moduleid#">
		<cfcase value="00000000000000000000000000000000003,00000000000000000000000000000000004">
			<cfswitch expression="#rc.originalfuseaction#">
				<cfcase value="list">
					<cfif rc.originalcircuit eq 'cPerm' or rc.perm neq 'none'>
					<cfif listFind(session.mura.memberships,'Admin;#application.settingsManager.getSite(rc.siteid).getPrivateUserPoolID()#;0') or listFind(session.mura.memberships,'S2')>
						<a class="btn <cfif rc.originalfuseaction eq "main"> active</cfif>" href="index.cfm?muraAction=cPerm.main&contentid=#rc.moduleID#&topid=#URLEncodedFormat(rc.topid)#&siteid=#URLEncodedFormat(rc.siteid)#&moduleid=#rc.moduleid#&startrow=#rc.startrow#">Permissions</a>
					</cfif>
					<cfif rc.moduleid eq "00000000000000000000000000000000003">
						<a class="btn" href="index.cfm?muraAction=cArch.edit&type=Component&contentid=&topid=#URLEncodedFormat(rc.topid)#&parentid=#rc.topid#&siteid=#URLEncodedFormat(rc.siteid)#&moduleid=#rc.moduleid#">#application.rbFactory.getKeyValue(session.rb,'sitemanager.addcomponent')#</a>
					<cfelse>
						<a class="btn" href="index.cfm?muraAction=cArch.edit&type=Form&contentid=&topid=#URLEncodedFormat(rc.topid)#&parentid=#rc.topid#&siteid=#URLEncodedFormat(rc.siteid)#&moduleid=#rc.moduleid#&formType=editor">#application.rbFactory.getKeyValue(session.rb,'sitemanager.addformwitheditor')#</a>
						<a class="btn" href="index.cfm?muraAction=cArch.edit&type=Form&contentid=&topid=#URLEncodedFormat(rc.topid)#&parentid=#rc.topid#&siteid=#URLEncodedFormat(rc.siteid)#&moduleid=#rc.moduleid#&formType=builder">#application.rbFactory.getKeyValue(session.rb,'sitemanager.addformwithbuilder')#</a>
					</cfif>
					</cfif>
				</cfcase>
				<cfcase value="edit">
					<a class="btn" href="index.cfm?muraAction=cArch.list&siteid=#URLEncodedFormat(rc.siteid)#&topid=#rc.moduleID#&parentid=#rc.moduleID#&moduleid=#rc.moduleID#"><i class="icon-share-alt"></i> 
					<cfif rc.moduleid eq "00000000000000000000000000000000003">
						#application.rbFactory.getKeyValue(session.rb,'sitemanager.backtocomponents')#
					<cfelse>
						#application.rbFactory.getKeyValue(session.rb,'sitemanager.backtoforms')#
					</cfif>
					</a>
					<cfif len(rc.contentID)>
					<cfswitch expression="#rc.type#">		
						<cfcase value="Form">
							<cfif listFind(session.mura.memberships,'S2IsPrivate')>
							<a class="btn" href="index.cfm?muraAction=cArch.datamanager&contentid=#URLEncodedFormat(rc.contentid)#&siteid=#URLEncodedFormat(rc.siteid)#&topid=#URLEncodedFormat(rc.topid)#&moduleid=#rc.moduleid#&type=Form&parentid=#rc.moduleid#">#application.rbFactory.getKeyValue(session.rb,"sitemanager.content.managedata")#</a></li>
							</cfif>
						</cfcase>
						</cfswitch>
						<a class="btn" href="index.cfm?muraAction=cArch.hist&contentid=#URLEncodedFormat(rc.contentid)#&type=#rc.type#&parentid=#URLEncodedFormat(rc.parentid)#&topid=#URLEncodedFormat(rc.topid)#&siteid=#URLEncodedFormat(rc.siteid)#&startrow=#rc.startrow#&moduleid=#rc.moduleid#&compactDisplay=#rc.compactDisplay#">#application.rbFactory.getKeyValue(session.rb,"sitemanager.content.versionhistory")#</a>
						<cfif rc.compactDisplay neq 'true' and rc.contentBean.getactive()lt 1 and (rc.perm neq 'none')>
							<a class="btn" href="index.cfm?muraAction=cArch.update&contenthistid=#URLEncodedFormat(rc.contenthistid)#&action=delete&contentid=#URLEncodedFormat(rc.contentid)#&type=#rc.type#&parentid=#URLEncodedFormat(rc.parentid)#&topid=#URLEncodedFormat(rc.topid)#&siteid=#URLEncodedFormat(rc.siteid)#&startrow=#rc.startrow#&moduleid=#rc.moduleid#&return=#rc.return#" onclick="return confirmDialog('#jsStringFormat(application.rbFactory.getKeyValue(session.rb,"sitemanager.content.deleteversionconfirm"))#',this.href)">#application.rbFactory.getKeyValue(session.rb,"sitemanager.content.deleteversion")#</a>
						</cfif>
						<cfif rc.deletable>
							<a class="btn" href="index.cfm?muraAction=cArch.update&action=deleteall&contentid=#URLEncodedFormat(rc.contentid)#&type=#rc.type#&parentid=#URLEncodedFormat(rc.parentid)#&topid=#URLEncodedFormat(rc.topid)#&siteid=#URLEncodedFormat(rc.siteid)#&startrow=#rc.startrow#&moduleid=#rc.moduleid#" 
							<cfif listFindNoCase(nodeLevelList,rc.contentBean.getType())>onclick="return confirmDialog('#jsStringFormat(application.rbFactory.getResourceBundle(session.rb).messageFormat(application.rbFactory.getKeyValue(session.rb,'sitemanager.content.deletecontentrecursiveconfirm'),rc.contentBean.getMenutitle()))#',this.href)"<cfelse>onclick="return confirmDialog('#jsStringFormat(application.rbFactory.getKeyValue(session.rb,"sitemanager.content.deletecontentconfirm"))#',this.href)"</cfif>>#application.rbFactory.getKeyValue(session.rb,"sitemanager.content.deletecontent")#</a>
						</cfif>
						<cfif (listFind(session.mura.memberships,'Admin;#application.settingsManager.getSite(rc.siteid).getPrivateUserPoolID()#;0') or listFind(session.mura.memberships,'S2'))>
							<a class="btn" href="index.cfm?muraAction=cPerm.main&contentid=#URLEncodedFormat(rc.contentid)#&type=#rc.contentBean.gettype()#&parentid=#rc.contentBean.getparentID()#&topid=#URLEncodedFormat(rc.topid)#&siteid=#URLEncodedFormat(rc.siteid)#&moduleid=#rc.moduleid#&startrow=#rc.startrow#">#application.rbFactory.getKeyValue(session.rb,"sitemanager.content.permissions")#</a>
						</cfif>
					</cfif>
				</cfcase>
				<cfcase value="hist">
					<a class="btn" href="index.cfm?muraAction=cArch.list&siteid=#URLEncodedFormat(rc.siteid)#&topid=#rc.moduleID#&parentid=#rc.moduleID#&moduleid=#rc.moduleID#"><i class="icon-share-alt"></i> 
						<cfif rc.moduleid eq "00000000000000000000000000000000003">
							#application.rbFactory.getKeyValue(session.rb,'sitemanager.backtocomponents')#
						<cfelse>
							#application.rbFactory.getKeyValue(session.rb,'sitemanager.backtoforms')#
						</cfif>
					</a>
					<cfif len(rc.contentID)>
					<cfswitch expression="#rc.type#">
					<cfcase value="Form">
						<cfif listFind(session.mura.memberships,'S2IsPrivate')>
						<a class="btn" href="index.cfm?muraAction=cArch.datamanager&contentid=#URLEncodedFormat(rc.contentid)#&siteid=#URLEncodedFormat(rc.siteid)#&topid=#URLEncodedFormat(rc.topid)#&moduleid=#rc.moduleid#&type=Form&parentid=#rc.moduleid#">#application.rbFactory.getKeyValue(session.rb,"sitemanager.content.managedata")#</a></li>
						</cfif>
					</cfcase>
					</cfswitch>
					<cfif rc.perm neq 'none'>
						<a class="btn" href="index.cfm?muraAction=cArch.update&action=deletehistall&contentid=#URLEncodedFormat(rc.contentid)#&type=#rc.type#&parentid=#URLEncodedFormat(rc.parentid)#&topid=#URLEncodedFormat(rc.topid)#&siteid=#URLEncodedFormat(rc.siteid)#&startrow=#rc.startrow#&moduleid=#rc.moduleid#&compactDisplay=#rc.compactDisplay#" onclick="return confirmDialog('#jsStringFormat(application.rbFactory.getKeyValue(session.rb,'sitemanager.content.clearversionhistoryconfirm'))#',this.href)">#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.clearversionhistory')#</a>
					</cfif>
					<cfif rc.compactDisplay neq 'true' and rc.contentBean.getactive()lt 1 and (rc.perm neq 'none')>
						<a class="btn" href="index.cfm?muraAction=cArch.update&contenthistid=#URLEncodedFormat(rc.contenthistid)#&action=delete&contentid=#URLEncodedFormat(rc.contentid)#&type=#rc.type#&parentid=#URLEncodedFormat(rc.parentid)#&topid=#URLEncodedFormat(rc.topid)#&siteid=#URLEncodedFormat(rc.siteid)#&startrow=#rc.startrow#&moduleid=#rc.moduleid#&return=#rc.return#" onclick="return confirmDialog('#jsStringFormat(application.rbFactory.getKeyValue(session.rb,"sitemanager.content.deleteversionconfirm"))#',this.href)">#application.rbFactory.getKeyValue(session.rb,"sitemanager.content.deleteversion")#</a>
					</cfif>
					<cfif rc.deletable>
						<a class="btn" href="index.cfm?muraAction=cArch.update&action=deleteall&contentid=#URLEncodedFormat(rc.contentid)#&type=#rc.type#&parentid=#URLEncodedFormat(rc.parentid)#&topid=#URLEncodedFormat(rc.topid)#&siteid=#URLEncodedFormat(rc.siteid)#&startrow=#rc.startrow#&moduleid=#rc.moduleid#" 
						<cfif listFindNoCase(nodeLevelList,rc.contentBean.getType())>onclick="return confirmDialog('#jsStringFormat(application.rbFactory.getResourceBundle(session.rb).messageFormat(application.rbFactory.getKeyValue(session.rb,'sitemanager.content.deletecontentrecursiveconfirm'),rc.contentBean.getMenutitle()))#',this.href)"<cfelse>onclick="return confirmDialog('#jsStringFormat(application.rbFactory.getKeyValue(session.rb,"sitemanager.content.deletecontentconfirm"))#',this.href)"</cfif>>#application.rbFactory.getKeyValue(session.rb,"sitemanager.content.deletecontent")#</a>
					</cfif>
					<cfif (listFind(session.mura.memberships,'Admin;#application.settingsManager.getSite(rc.siteid).getPrivateUserPoolID()#;0') or listFind(session.mura.memberships,'S2'))>
						<a class="btn" href="index.cfm?muraAction=cPerm.main&contentid=#URLEncodedFormat(rc.contentid)#&type=#rc.contentBean.gettype()#&parentid=#rc.contentBean.getparentID()#&topid=#URLEncodedFormat(rc.topid)#&siteid=#URLEncodedFormat(rc.siteid)#&moduleid=#rc.moduleid#&startrow=#rc.startrow#">#application.rbFactory.getKeyValue(session.rb,"sitemanager.content.permissions")#</a>
					</cfif>
					</cfif>
				</cfcase>
			</cfswitch>
		</cfcase>
	<cfdefaultcase>
		<cfswitch expression="#rc.originalfuseaction#">
			<cfcase value="edit">
				<a class="btn" href="index.cfm?muraAction=cArch.list&siteid=#rc.siteid#&moduleid=00000000000000000000000000000000000"><i class="icon-share-alt"></i> #application.rbFactory.getKeyValue(session.rb,'sitemanager.backtositemanager')#</a>
				<cfif rc.contentid neq "">
				<cfif (rc.contentBean.getfilename() neq '' or rc.contentid eq '00000000000000000000000000000000001')>
					<cfswitch expression="#rc.type#">
					<cfcase value="Page,Portal,Calendar,Gallery,Link">
						<cfif not rc.contentBean.getIsNew()>
							<cfset currentBean=application.contentManager.getActiveContent(rc.contentID,rc.siteid) />
							<a class="btn" href="##" onclick="return openPreviewDialog('http://#application.settingsManager.getSite(rc.siteid).getDomain()##application.configBean.getServerPort()##application.configBean.getContext()##application.contentRenderer.getURLStem(rc.siteid,currentBean.getfilename())#','#currentBean.getTargetParams()#');">#application.rbFactory.getKeyValue(session.rb,"sitemanager.content.viewactive")#</a></li>
						</cfif>
						<a class="btn" href="##" onclick="return openPreviewDialog('http://#application.settingsManager.getSite(rc.siteid).getDomain()##application.configBean.getServerPort()##application.configBean.getContext()##application.contentRenderer.getURLStem(rc.siteid,"")#?previewid=#rc.contentBean.getcontenthistid()#&contentid=#rc.contentBean.getcontentid()#','#rc.contentBean.getTargetParams()#');">#application.rbFactory.getKeyValue(session.rb,"sitemanager.content.viewversion")#</a>
					</cfcase>
					<cfcase value="File">	
						<a class="btn" href="##" href="##" onclick="return openPreviewDialog('http://#application.settingsManager.getSite(rc.siteid).getDomain()##application.configBean.getServerPort()##application.configBean.getContext()##application.contentRenderer.getURLStem(rc.siteid,"")#?LinkServID=#rc.contentid#');">#application.rbFactory.getKeyValue(session.rb,"sitemanager.content.viewactive")#</a></li>
						<li><a href="##" href="##" onclick="return openPreviewDialog('http://#application.settingsManager.getSite(rc.siteid).getDomain()##application.configBean.getServerPort()##application.configBean.getContext()#/tasks/render/file/?fileID=#rc.contentBean.getFileID()#');">#application.rbFactory.getKeyValue(session.rb,"sitemanager.content.viewversion")#</a>
					</cfcase>
					</cfswitch>
				</cfif>
				
				<a class="btn" href="index.cfm?muraAction=cArch.hist&contentid=#URLEncodedFormat(rc.contentid)#&type=#rc.type#&parentid=#URLEncodedFormat(rc.parentid)#&topid=#URLEncodedFormat(rc.topid)#&siteid=#URLEncodedFormat(rc.siteid)#&startrow=#rc.startrow#&moduleid=#rc.moduleid#&compactDisplay=#rc.compactDisplay#">#application.rbFactory.getKeyValue(session.rb,"sitemanager.content.versionhistory")#</a>
				<cfif rc.compactDisplay neq 'true' and rc.contentBean.getactive()lt 1 and (rc.perm neq 'none')>
					<a class="btn" href="index.cfm?muraAction=cArch.update&contenthistid=#URLEncodedFormat(rc.contenthistid)#&action=delete&contentid=#URLEncodedFormat(rc.contentid)#&type=#rc.type#&parentid=#URLEncodedFormat(rc.parentid)#&topid=#URLEncodedFormat(rc.topid)#&siteid=#URLEncodedFormat(rc.siteid)#&startrow=#rc.startrow#&moduleid=#rc.moduleid#&return=#rc.return#" onclick="return confirmDialog('#jsStringFormat(application.rbFactory.getKeyValue(session.rb,"sitemanager.content.deleteversionconfirm"))#',this.href)">#application.rbFactory.getKeyValue(session.rb,"sitemanager.content.deleteversion")#</a>
				</cfif>
				<cfif rc.deletable>
					<a class="btn" href="index.cfm?muraAction=cArch.update&action=deleteall&contentid=#URLEncodedFormat(rc.contentid)#&type=#rc.type#&parentid=#URLEncodedFormat(rc.parentid)#&topid=#URLEncodedFormat(rc.topid)#&siteid=#URLEncodedFormat(rc.siteid)#&startrow=#rc.startrow#&moduleid=#rc.moduleid#" 
					<cfif listFindNoCase(nodeLevelList,rc.contentBean.getType())>onclick="return confirmDialog('#jsStringFormat(application.rbFactory.getResourceBundle(session.rb).messageFormat(application.rbFactory.getKeyValue(session.rb,'sitemanager.content.deletecontentrecursiveconfirm'),rc.contentBean.getMenutitle()))#',this.href)"<cfelse>onclick="return confirmDialog('#jsStringFormat(application.rbFactory.getKeyValue(session.rb,"sitemanager.content.deletecontentconfirm"))#',this.href)"</cfif>>#application.rbFactory.getKeyValue(session.rb,"sitemanager.content.deletecontent")#</a>
				</cfif>
				<cfif (listFind(session.mura.memberships,'Admin;#application.settingsManager.getSite(rc.siteid).getPrivateUserPoolID()#;0') or listFind(session.mura.memberships,'S2'))>
					<a class="btn" href="index.cfm?muraAction=cPerm.main&contentid=#URLEncodedFormat(rc.contentid)#&type=#rc.contentBean.gettype()#&parentid=#rc.contentBean.getparentID()#&topid=#URLEncodedFormat(rc.topid)#&siteid=#URLEncodedFormat(rc.siteid)#&moduleid=#rc.moduleid#&startrow=#rc.startrow#">#application.rbFactory.getKeyValue(session.rb,"sitemanager.content.permissions")#</a>
				</cfif>
			</cfif>
			</cfcase>
			<cfcase value="hist">
				<a class="btn" href="index.cfm?muraAction=cArch.list&siteid=#rc.siteid#&moduleid=00000000000000000000000000000000000"><i class="icon-share-alt"></i> #application.rbFactory.getKeyValue(session.rb,'sitemanager.backtositemanager')#</a>
				<cfif rc.perm neq 'none'>
					<a class="btn" href="index.cfm?muraAction=cArch.update&action=deletehistall&contentid=#URLEncodedFormat(rc.contentid)#&type=#rc.type#&parentid=#URLEncodedFormat(rc.parentid)#&topid=#URLEncodedFormat(rc.topid)#&siteid=#URLEncodedFormat(rc.siteid)#&startrow=#rc.startrow#&moduleid=#rc.moduleid#&compactDisplay=#rc.compactDisplay#" onclick="return confirmDialog('#jsStringFormat(application.rbFactory.getKeyValue(session.rb,'sitemanager.content.clearversionhistoryconfirm'))#',this.href)">#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.clearversionhistory')#</a>
				</cfif>
				<cfif rc.deletable and rc.compactDisplay neq 'true'>
					<a class="btn" href="index.cfm?muraAction=cArch.update&action=deleteall&contentid=#URLEncodedFormat(rc.contentid)#&type=#rc.type#&parentid=#URLEncodedFormat(rc.parentid)#&topid=#URLEncodedFormat(rc.topid)#&siteid=#URLEncodedFormat(rc.siteid)#&startrow=#rc.startrow#&moduleid=#rc.moduleid#&compactDisplay=#rc.compactDisplay#" 
					<cfif listFindNoCase(nodeLevelList,rc.contentBean.getType())>onclick="return confirmDialog('#jsStringFormat(application.rbFactory.getResourceBundle(session.rb).messageFormat(application.rbFactory.getKeyValue(session.rb,'sitemanager.content.deletecontentrecursiveconfirm'),rc.contentBean.getMenutitle()))#',this.href)"<cfelse>onclick="return confirmDialog('#jsStringFormat(application.rbFactory.getKeyValue(session.rb,'sitemanager.content.deletecontentconfirm'))#',this.href)"</cfif> >#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.deletecontent')#</a>
				</cfif>
				<cfif listFind(session.mura.memberships,'Admin;#application.settingsManager.getSite(rc.siteid).getPrivateUserPoolID()#;0') or listFind(session.mura.memberships,'S2')>
					<a class="btn" href="index.cfm?muraAction=cPerm.main&contentid=#URLEncodedFormat(rc.contentid)#&type=#rc.type#&parentid=#URLEncodedFormat(rc.parentid)#&topid=#URLEncodedFormat(rc.topid)#&siteid=#URLEncodedFormat(rc.siteid)#&moduleid=#rc.moduleid#&startrow=#rc.startrow#">#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.permissions')#</a>
				</cfif>
			</cfcase>
			<cfcase value="imagedetails">
				<cfif isdefined('rc.contentBean')>
					<a clas="btn" href="#rc.contentBean.getEditURL(compactDisplay=rc.compactDisplay)#">
						<i class="icon-share-alt"></i> 
						#application.rbFactory.getKeyValue(session.rb,'sitemanager.backtocontent')#
					</a>
					<a class="btn" href="index.cfm?&muraAction=cArch.list&siteid=#rc.siteid#&moduleid=00000000000000000000000000000000000">
						<i class="icon-share-alt"></i>
						#application.rbFactory.getKeyValue(session.rb,'sitemanager.backtositemanager')#
					</a>
				</cfif>
			</cfcase>
			<cfcase value="datamanager">
				<a class="btn" href="index.cfm?muraAction=cArch.hist&contentid=#URLEncodedFormat(rc.contentid)#&type=Form&parentid=00000000000000000000000000000000004&topid=00000000000000000000000000000000004&siteid=#URLEncodedFormat(rc.siteid)#&startrow=#rc.startrow#&moduleid=00000000000000000000000000000000004">#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.versionhistory')#</a>
				<cfif rc.action neq ''>
				<a class="btn" title="#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.managedate')#" href="index.cfm?muraAction=cArch.datamanager&contentid=#URLEncodedFormat(rc.contentid)#&type=Form&topid=00000000000000000000000000000000004&siteid=#URLEncodedFormat(rc.siteid)#&moduleid=00000000000000000000000000000000004&parentid=00000000000000000000000000000000004">#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.managedata')#</a>
				</cfif>
				<cfif rc.perm eq 'editor'>
				<a class="btn" title="#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.editdisplay')#" href="index.cfm?muraAction=cArch.datamanager&contentid=#URLEncodedFormat(rc.contentid)#&type=Form&action=display&topid=00000000000000000000000000000000004&siteid=#URLEncodedFormat(rc.siteid)#&moduleid=00000000000000000000000000000000004&parentid=00000000000000000000000000000000004">#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.editdisplay')#</a>
				<a class="btn" title="#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.delete')#" href="index.cfm?muraAction=cArch.update&contentid=#URLEncodedFormat(rc.contentid)#&type=Form&action=deleteall&topid=00000000000000000000000000000000004&siteid=#URLEncodedFormat(rc.siteid)#&moduleid=00000000000000000000000000000000004&parentid=00000000000000000000000000000000004" onClick="return confirmDialog('#jsStringFormat(application.rbFactory.getKeyValue(session.rb,'sitemanager.content.deleteformconfirm'))#',this.href)">#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.deleteform')#</a>
				</cfif>
				<cfif listFind(session.mura.memberships,'Admin;#application.settingsManager.getSite(rc.siteid).getPrivateUserPoolID()#;0') or listFind(session.mura.memberships,'S2')>
					<a class="btn" href="index.cfm?muraAction=cPerm.main&contentid=#URLEncodedFormat(rc.contentid)#&type=Form&parentid=00000000000000000000000000000000004&topid=00000000000000000000000000000000004&siteid=#URLEncodedFormat(rc.siteid)#&moduleid=00000000000000000000000000000000004&startrow=#rc.startrow#">#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.permissions')#</a>
				</cfif>
			</cfcase>
		</cfswitch>
	</cfdefaultcase>
	</cfswitch>
</div>
</cfoutput>