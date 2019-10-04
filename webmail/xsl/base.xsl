<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>
			
<xsl:template match="APP[action/node()[name() = /APPSHORE/APP/recordset/appName]]">
    <table width="100%" cellSpacing="0" cellPadding="0"  border="0" >
		<tr width="100%" valign="top">
			<xsl:call-template name="webmail_leftPanel"/>
			<td class="right_panel" id="right_panel" >
				<xsl:choose>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'search'">
						<xsl:call-template name="custom_search">
							<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
							<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabel"/>
						</xsl:call-template>	
						<xsl:call-template name="webmail_grid">
							<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
							<xsl:with-param name="appLabel" select="folder/folder_name"/>
							<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appName"/>
							<xsl:with-param name="recordId" select="/APPSHORE/APP/recordset/appRecordId"/>
						</xsl:call-template>
						<xsl:call-template name="custom_bulk">
							<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
							<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appName"/>
							<xsl:with-param name="selectedForm" select="'webmail_grid'"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'view'">
						<xsl:call-template name="webmail_view">
							<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
							<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabelSingular"/>
							<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appNameSingular"/>
							<xsl:with-param name="recordId" select="/APPSHORE/APP/recordset/appRecordId"/>
							<xsl:with-param name="recordName" select="/APPSHORE/APP/recordset/appRecordName"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'edit'">
						<xsl:call-template name="webmail_edit">
							<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
							<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabelSingular"/>
							<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appNameSingular"/>
							<xsl:with-param name="recordId" select="/APPSHORE/APP/recordset/appRecordId"/>
							<xsl:with-param name="recordName" select="/APPSHORE/APP/recordset/appRecordName"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'popup_view'">
						<xsl:call-template name="webmail_popup_view">
							<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
							<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabelSingular"/>
							<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appNameSingular"/>
							<xsl:with-param name="recordId" select="/APPSHORE/APP/recordset/appRecordId"/>
							<xsl:with-param name="recordName" select="/APPSHORE/APP/recordset/appRecordName"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'popup_view2'">
						<xsl:call-template name="webmail_popup_view2">
							<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
							<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabelSingular"/>
							<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appNameSingular"/>
							<xsl:with-param name="recordId" select="/APPSHORE/APP/recordset/appRecordId"/>
							<xsl:with-param name="recordName" select="/APPSHORE/APP/recordset/appRecordName"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'popup_edit'">
						<xsl:call-template name="webmail_popup_edit">
							<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
							<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabelSingular"/>
							<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appNameSingular"/>
							<xsl:with-param name="recordId" select="/APPSHORE/APP/recordset/appRecordId"/>
							<xsl:with-param name="recordName" select="/APPSHORE/APP/recordset/appRecordName"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'setup_accounts'">
						<xsl:call-template name="setup_tabs"/>
						<xsl:call-template name="setup_accounts"/>
					</xsl:when>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'setup_folders'">
						<xsl:call-template name="setup_tabs"/>
						<xsl:call-template name="setup_folders"/>
					</xsl:when>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'setup_signatures'">
						<xsl:call-template name="setup_tabs"/>
						<xsl:call-template name="setup_signatures"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="custom_actions"/>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template name="webmail_leftPanel">
	<xsl:if test="not(/APPSHORE/API/popup)">
		<td class="left_panel" id="left_panel" style="display:{/APPSHORE/API/cookie/left_panel}">
 
 			<xsl:if test="/APPSHORE/APP/action/webmail">
				<xsl:call-template name="webmail_folders"/>	
			</xsl:if>	

		    <xsl:call-template name="panelets"/>
		</td>
	</xsl:if>	
</xsl:template>

<xsl:template name="webmail_folders">

	<div class="verticalMenusBoxContainer">
		<div class="verticalMenusBoxBody" id="folders">
			<xsl:for-each select = "/APPSHORE/APP/folders/folders_item">
				<div class="verticalMenusBoxBodyLine">
					<img  class="image" style="padding-right:5px" width="16" src="{$api_image_path}/{folder_type}.png" />				
					<a href="{$baseurl}&amp;op=webmail.base.search&amp;folder_id={folder_id}">
						<xsl:choose>
							<xsl:when test="nbr_unread > 0">
								<xsl:attribute name="style">font-weight:bold</xsl:attribute>
								<xsl:attribute name="title"><xsl:value-of select="php:functionString('lang','%s unread emails of %s',nbr_unread, nbr_webmail)"/></xsl:attribute>
								<xsl:value-of select="folder_name"/><xsl:if test="nbr_unread > 0">&#160;(<xsl:value-of select="nbr_unread"/>)</xsl:if>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="title"><xsl:value-of select="php:functionString('lang','%s emails', nbr_webmail)"/></xsl:attribute>
								<xsl:value-of select="folder_name"/>
							</xsl:otherwise>
						</xsl:choose>
					</a>
				</div>
			</xsl:for-each>	
		</div>		
	</div>
	
</xsl:template>

<xsl:template name="webmail_grid">
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>
	<xsl:param name="nodeName"/>		
	<xsl:param name="recordId"/>	

	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel" select="$appLabel"/>
	</xsl:call-template>

	<form name="webmail_grid" method="post" >
		<input type="hidden" name="op" id="op" value="{$appName}.base.search"/>
		<input type="hidden" name="orderby" id="orberby" value="{/APPSHORE/APP/recordset/orderby}"/>
		<input type="hidden" name="ascdesc" id="ascdesc" value="{/APPSHORE/APP/recordset/ascdesc}"/>
		<input type="hidden" name="key" id="key" />	
		<input type="hidden" name="selected" id="selected" />
		<input type="hidden" name="nbrecords" id="nbrecords" />
	
		<table class="formBar" border="0" cellspacing="0" cellpadding="0">
			<tr class="formBarContent">
				<xsl:if test="/APPSHORE/APP/scope > 0"> 								
					<td class="formBarContent start_direction">
					    <xsl:call-template name="webmail_gridCheckAllListForm">
							<xsl:with-param name="thisForm" select="'webmail_grid'"/>
						</xsl:call-template>				
					</td>
				</xsl:if>
				<td class="formBarContent end_direction">
				    <xsl:call-template name="gridButtons">
						<xsl:with-param name="thisForm" select="'webmail_grid'"/>
					</xsl:call-template>        
				</td>
			</tr>					
		</table>						

		<xsl:variable name="fieldsCount" select="count(/APPSHORE/APP/result_fields/result_fields_item)+5" />
		
		<table class="resizable searchResultsTable" border="0" cellspacing="0" cellpadding="0">
			<tr class="searchResultsHeader">
				<td class="searchResultsHeaderIcons"/>
<!--				<td class="searchResultsHeaderIcons"/>-->
<!--				<td class="searchResultsHeaderIcons"/>-->
				<td class="searchResultsHeaderIcons">
					<a href="javascript:gridOrderBy(document.webmail_grid,'bound');">
						<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Bound')"/></xsl:attribute>
						<xsl:value-of select="php:function('lang','B')"/>
					</a>
				</td>
				<td class="searchResultsHeaderIcons">
					<a href="javascript:void(0);">
						<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Attachment')"/></xsl:attribute>
						<xsl:value-of select="php:function('lang','A')"/>
					</a>
				</td>
				<xsl:for-each select = "/APPSHORE/APP/result_fields/result_fields_item" >
					<th>
						<xsl:choose>
							<xsl:when test = "field_name = 'subject'">
								<xsl:attribute name="style">min-width:50%</xsl:attribute>
							</xsl:when>
						</xsl:choose>
						<xsl:call-template name="gridFieldsHeader">
							<xsl:with-param name="thisForm" select="'webmail_grid'"/>
						</xsl:call-template>
					</th>
				</xsl:for-each>
			</tr>

			<xsl:variable name="items"><xsl:value-of select="$nodeName"/>_item</xsl:variable>
			<xsl:for-each select = "/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $items]">
				<xsl:variable name="currentRecord" select="current()"/>
				<xsl:variable name="recordId_value" select="*[name() = $recordId]"/>
<!--				<xsl:variable name="unselectedtext">-->
<!--					<xsl:choose>-->
<!--						<xsl:when test ="record_date = 'new'">new</xsl:when>-->
<!--						<xsl:when test ="record_date = 'expired'">expired</xsl:when>-->
<!--					</xsl:choose>-->
<!--				</xsl:variable>											-->
				<xsl:variable name="isRead">
					<xsl:choose>
						<xsl:when test ="is_read = 'N' and bound = 'I'">N</xsl:when>
						<xsl:otherwise>Y</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>											
				<tr class="{record_class}" onMouseOver="this.className ='searchResultsSelected'" onMouseOut="this.className ='{record_class}'">
					<xsl:if test="/APPSHORE/APP/scope > 0">
						<td class="searchResultsIcons {_result_class}" >
							<xsl:call-template name="gridCheckListForm">
								<xsl:with-param name="thisForm" select="'webmail_grid'"/>
								<xsl:with-param name="thisId" select="$recordId_value"/>
								<xsl:with-param name="scope" select="scope"/>
							</xsl:call-template>
						</td>
<!--						<td class="searchResultsIcons {_result_class}" >-->
<!--							<xsl:if test="bound = 'D'">-->
<!--								<a href="{$baseurl}&amp;op={$appName}.base.edit&amp;{$recordId}={$recordId_value}&amp;offset={offset}">-->
<!--							 	   <img class="image" src="{$api_image_path}/edit.png"/>-->
<!--				 				</a>-->
<!--				 			</xsl:if>-->
<!--						</td>-->
				 	</xsl:if>
<!--					<td class="searchResultsIcons {_result_class}" >-->
<!--						<a href="{$baseurl}&amp;op={$appName}.base.view&amp;{$recordId}={$recordId_value}&amp;offset={offset}" onMouseOver="popupDetails( '{$baseurl}&amp;op={$appName}.popup.view&amp;{$recordId}={$recordId_value}','view','{$api_image_path}','{$appName}');" onMouseOut="return nd();"  >-->
<!--							<img class="image" src="{$api_image_path}/view.png"/>-->
<!--				 		</a>-->
<!--					</td>-->
					<td class="searchResultsIcons {_result_class}" >
						<xsl:choose>
							<xsl:when test = "bound = 'D'">
								<a href="{$baseurl}&amp;op={$appName}.base.edit&amp;{$recordId}={$recordId_value}&amp;offset={offset}" onMouseOver="popupDetails( '{$baseurl}&amp;op={$appName}.popup.view&amp;{$recordId}={$recordId_value}','view','{$api_image_path}','{$appName}');" onMouseOut="return nd();"  >
									<img border="0" src="{$api_image_path}/draft.png">
										<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Draft message')"/></xsl:attribute>
									</img>
				 				</a>
							</xsl:when>
							<xsl:when test = "bound = 'O'">
								<a href="{$baseurl}&amp;op={$appName}.base.view&amp;{$recordId}={$recordId_value}&amp;offset={offset}" onMouseOver="popupDetails( '{$baseurl}&amp;op={$appName}.popup.view&amp;{$recordId}={$recordId_value}','view','{$api_image_path}','{$appName}');" onMouseOut="return nd();"  >
									<img border="0" src="{$api_image_path}/sent.png">
										<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Outbound message')"/></xsl:attribute>
									</img>
								</a>
							</xsl:when>
							<xsl:when test = "bound = 'I'">
								<a href="{$baseurl}&amp;op={$appName}.base.view&amp;{$recordId}={$recordId_value}&amp;offset={offset}" onMouseOver="popupDetails( '{$baseurl}&amp;op={$appName}.popup.view&amp;{$recordId}={$recordId_value}','view','{$api_image_path}','{$appName}');" onMouseOut="return nd();"  >
									<img border="0" src="{$api_image_path}/inbox.png">
										<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Inbound message')"/></xsl:attribute>
									</img>
								</a>
							</xsl:when>
						</xsl:choose>
					</td>
					<td class="searchResultsIcons {_result_class}" >
						<xsl:if test = "attachments > 0">
							<img border="0" src="{$api_image_path}/attachment.png">
								<xsl:attribute name="title"><xsl:value-of select="php:functionString('lang','%s attachment(s)',attachments)"/></xsl:attribute>
							</img>
						</xsl:if>
					</td>
					<xsl:for-each select = "/APPSHORE/APP/result_fields/result_fields_item" >
						<td class="searchResultsCells">
							<xsl:if test = "$isRead = 'N'">
								<xsl:attribute name="style">font-weight: bold;</xsl:attribute>
							</xsl:if>														
							<xsl:call-template name="gridFields">
								<xsl:with-param name="appName" select="$appName"/>
								<xsl:with-param name="recordId" select="$recordId"/>
								<xsl:with-param name="recordId_value" select="$recordId_value"/>
								<xsl:with-param name="currentRecord" select="$currentRecord"/>
								<xsl:with-param name="currentField" select="current()"/>
<!--								<xsl:with-param name="unselectedtext" select="$unselectedtext"/>-->
							</xsl:call-template>
						</td>
					</xsl:for-each>
				</tr>
			</xsl:for-each>
			<xsl:variable name="recordsCount" select="count(/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $items])"/>
			<xsl:choose>
			    <xsl:when test="$recordsCount = 0">
			    	<tr style="text-align:center;vertical-align:middle">
			    		<td colspan="{$fieldsCount}">
       					 	<H2 style="color:lightgrey;line-height:4em"><xsl:value-of select="php:function('lang','No entries')"/></H2>
						</td>
					</tr>
			    </xsl:when>	
			    <xsl:when test="(5-$recordsCount) > 0">
			    	<tr>
			    		<td colspan="{$fieldsCount}" style="line-height:{8-$recordsCount}em">&#160;</td>
 					</tr>
			    </xsl:when>	
			</xsl:choose>					
		</table>
	
		<table class="formBar" border="0" cellspacing="0" cellpadding="0">
			<tr class="formBarContent">
				<xsl:if test="/APPSHORE/APP/scope > 0"> 								
					<td class="formBarContent start_direction">
					    <xsl:call-template name="webmail_gridCheckAllListForm">
							<xsl:with-param name="thisForm" select="'webmail_grid'"/>
						</xsl:call-template>				
					</td>
				</xsl:if>
				<td class="formBarContent end_direction">
				    <xsl:call-template name="gridButtons">
						<xsl:with-param name="thisForm" select="'webmail_grid'"/>
					</xsl:call-template>        
				</td>
			</tr>					
		</table>						

	</form>

</xsl:template>

<xsl:template name="webmail_gridCheckAllListForm">
	<xsl:param name="thisForm"/>
	<xsl:value-of select="php:function('lang','Select')"/>:&#160;
	<a href="javascript:void(0)" onclick="gridAllCheckbox(document.{$thisForm},'all');">
		<xsl:value-of select="php:function('lang','All')"/>
	</a>&#160;
	<a href="javascript:void(0)" onclick="gridAllCheckbox(document.{$thisForm},'none');">
		<xsl:value-of select="php:function('lang','None')"/>
	</a>&#160;
<!--	<a href="javascript:void(0)" onclick="gridAllCheckbox(document.{$thisForm},'read');">-->
<!--		<xsl:value-of select="php:function('lang','Read')"/>-->
<!--	</a>&#160;-->
<!--	<a href="javascript:void(0)" onclick="gridAllCheckbox(document.{$thisForm},'unread');">-->
<!--		<xsl:value-of select="php:function('lang','Unread')"/>-->
<!--	</a>-->
</xsl:template>


<xsl:template name="webmail_view">
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>
	<xsl:param name="nodeName"/>
	<xsl:param name="recordId"/>
	<xsl:param name="recordName"/>
			
	<xsl:variable name="recordIdValue" select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $recordId]"/>
	<xsl:variable name="recordNameValue" select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $recordName]"/>

	<div class="clearboth">
		<div class="formTitleTags start_float">
			<xsl:value-of select="php:functionString('lang',$appLabel)"/>:&#160;<xsl:value-of select="$recordNameValue"/>
		</div>
		<div class="end_float">
			<xsl:call-template name="displayTags">
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="nodeName" select="$nodeName"/>
				<xsl:with-param name="recordIdValue" select="$recordIdValue"/>
			</xsl:call-template>
		</div>
	</div>	
	
	<form name="webmail_view" method="post" >
		<input type="hidden" name="op" value="webmail.base.view"/>
		<input type="hidden" name="key" id="key"/>	
		<input name="{$recordId}" id="{$recordId}" type="hidden" value="{$recordIdValue}" />				
			
		<div class="clearboth formBar">
			<xsl:call-template name="webmailViewButtons">
				<xsl:with-param name="thisForm" select="'webmail_view'"/>
				<xsl:with-param name="isTop">true</xsl:with-param>
				<xsl:with-param name="nodeName" select="$nodeName"/>
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="recordId" select="$recordId"/>
				<xsl:with-param name="recordIdValue" select="$recordIdValue"/>
				<xsl:with-param name="delete">true</xsl:with-param>
			</xsl:call-template>
		</div>	

		
		<div class="clearboth">
			<xsl:call-template name="viewBody">
				<xsl:with-param name="thisForm" select="'webmail_view'"/>
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="appLabel" select="$appLabel"/>
				<xsl:with-param name="nodeName" select="$nodeName"/>
				<xsl:with-param name="recordId" select="$recordId"/>
				<xsl:with-param name="recordName" select="$recordName"/>
			</xsl:call-template> 				
		</div>	

		<div class="clearboth formBar">
			<xsl:call-template name="webmailViewButtons">
				<xsl:with-param name="thisForm" select="'webmail_view'"/>
				<xsl:with-param name="isTop">false</xsl:with-param>
				<xsl:with-param name="nodeName" select="$nodeName"/>
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="recordId" select="$recordId"/>
				<xsl:with-param name="recordIdValue" select="$recordIdValue"/>
				<xsl:with-param name="delete">true</xsl:with-param>
			</xsl:call-template>
		</div>	
	</form>


	<div class="clearboth">
		<br/>
		<xsl:call-template name="customLinked">
			<xsl:with-param name="masterForm" select="'webmail_view'"/>
			<xsl:with-param name="masterTableName" select="$appName"/>
			<xsl:with-param name="masterRecordId" select="$recordId"/>
			<xsl:with-param name="masterRecordIdValue" select="$recordIdValue"/>
			<xsl:with-param name="masterRecordNameValue" select="$recordNameValue"/>
		</xsl:call-template>
	</div>
	
</xsl:template>

<xsl:template name="webmailViewButtons">
	<xsl:param name="thisForm"/>
	<xsl:param name="isTop"/>
	<xsl:param name="nodeName"/>
	<xsl:param name="appName"/>
	<xsl:param name="recordId"/>
	<xsl:param name="recordIdValue"/>
	<xsl:param name="delete"/>
	<table cellSpacing="1" cellPadding="1" width="100%" border="0">
		<tr>
			<td align="left">
				<input type="submit" class="formBarButton" name="Reply" onclick="document.{$thisForm}.key.value=this.name">
					<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Reply')"/></xsl:attribute>
				</input>&#160;
				<input type="submit" class="formBarButton" name="ReplyAll" onclick="document.{$thisForm}.key.value=this.name">
					<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Reply to all')"/></xsl:attribute>
				</input>&#160;
				<input type="submit" class="formBarButton" name="Forward" onclick="document.{$thisForm}.key.value=this.name">
					<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Forward')"/></xsl:attribute>
				</input>&#160;
				<xsl:if test="$delete">
					<input type="submit" class="formBarButton" name="Delete" onclick="document.{$thisForm}.key.value=this.name">
						<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Delete')"/></xsl:attribute>
					</input>&#160;
				</xsl:if>
				<input type="submit" class="formBarButton" name="Cancel" onclick="document.{$thisForm}.key.value=this.name">
					<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Cancel')"/></xsl:attribute>
				</input>&#160;
				<xsl:variable name="title"><xsl:value-of select="php:function('lang','Print record')"/></xsl:variable>
				<input type="button" class="formBarButton" name="print" onclick="popupIntra('{$baseurl}&amp;op={$appName}.base.view&amp;key=Print&amp;{$recordId}={$recordIdValue}','{$title}');" >
					<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Print')"/></xsl:attribute>
				</input>
			</td> 
			<td align="right">
				<xsl:call-template name="buttonsNavigation">
					<xsl:with-param name="thisForm" select="$thisForm"/>
				</xsl:call-template>
			</td>
		</tr>
	</table>
</xsl:template>


<xsl:template name='webmail_edit'>
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>
	<xsl:param name="nodeName"/>
	<xsl:param name="recordId"/>
	<xsl:param name="recordName"/>

	<script language="JavaScript" type="text/javascript" src="{$lib_js_path}/multifile.js"/>
	<script language="JavaScript" type="text/javascript" src="{$lib_js_path}/form.js"/>
	<script language="JavaScript" type="text/javascript" src="webmail/js/webmail.js"/>		
	<script LANGUAGE="JavaScript" >
		var fieldRequired = new Array();
		var fieldDescription = new Array();
		var	fieldInc = 0;
	</script>

	<xsl:variable name="recordIdValue" select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $recordId]"/>
	<xsl:variable name="recordNameValue" select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $recordName]"/>
		
	<div class="clearboth">
		<div class="formTitleTags start_float">
            <xsl:value-of select="php:functionString('lang',$appLabel)"/>:&#160;
			<xsl:choose>
				<xsl:when test="string-length($recordIdValue)">
					<xsl:value-of select="$recordNameValue"/>
				</xsl:when>
				<xsl:otherwise>
					<span style="color:black;font-weight:normal;font-style:italic"><xsl:value-of select="php:function('lang','New')"/></span>
				</xsl:otherwise>
			</xsl:choose>
		</div>
		<div class="end_float">
			<xsl:call-template name="displayTags">
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="nodeName" select="$nodeName"/>
				<xsl:with-param name="recordIdValue" select="$recordIdValue"/>
			</xsl:call-template>
		</div>
	</div>	
				
	<form name='webmail_edit'  enctype="multipart/form-data" method='post' onsubmit='return webmail_submit(this);'>
		<input type="hidden" name="op" id="op" value="{$appName}.base.edit"/>
		<input type="hidden" name="key" id="key"/>	
		<input type="hidden" name="mail_id" id="mail_id" value="{mail/mail_id}" />
		<input type="hidden" name="user_id" id="user_id" value="{mail/user_id}" />
		<input type="hidden" name="related_record_id" id="related_record_id" value="{mail/related_record_id}"/>
		<input type="hidden" name="selectedFiles" id="selectedFiles"/>
		<input type="hidden" name="selectedDocuments" id="selectedDocuments"/>
	
		<div class="clearboth formBar">
			<xsl:call-template name="webmailEditButtons">
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="thisForm" select="'webmail_edit'"/>
				<xsl:with-param name="recordIdValue" select="$recordIdValue"/>
				<xsl:with-param name="isTop" select="'true'"/>
			</xsl:call-template>
		</div>	

		<div class="clearboth">
			<xsl:call-template name="customEditBody">
				<xsl:with-param name="thisForm" select="'webmail_edit'"/>
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="appLabel" select="$appLabel"/>
				<xsl:with-param name="nodeName" select="$nodeName"/>
				<xsl:with-param name="recordId" select="$recordId"/>
				<xsl:with-param name="recordName" select="$recordName"/>
			</xsl:call-template>
		</div>
		
		<div class="clearboth formBar">
			<xsl:call-template name="webmailEditButtons">
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="thisForm" select="'webmail_edit'"/>
				<xsl:with-param name="recordIdValue" select="$recordIdValue"/>
			</xsl:call-template>
		</div>

	</form>
	
	<div class="clearboth">
	<br/>
		<xsl:call-template name="customLinked">
			<xsl:with-param name="masterForm" select="'webmail_edit'"/>
			<xsl:with-param name="masterTableName" select="$appName"/>
			<xsl:with-param name="masterRecordId" select="$recordId"/>
			<xsl:with-param name="masterRecordIdValue" select="$recordIdValue"/>
			<xsl:with-param name="masterRecordNameValue" select="$recordNameValue"/>
		</xsl:call-template>
	</div> 	
	
</xsl:template>

<xsl:template name="webmailEditButtons">
	<xsl:param name="appName"/>
	<xsl:param name="thisForm"/>	
	<xsl:param name="recordIdValue"/>
	<xsl:param name="isTop"/>	

	<table cellSpacing="1" cellPadding="1" width="100%" border="0">
		<tr>
			<td align="left">
				<input type="submit" class="formBarButton" name="Send" onclick="document.{$thisForm}.key.value=this.name">
					<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Send')"/></xsl:attribute>
				</input>&#160;
				<input type="submit" class="formBarButton" name="Save" onclick="document.{$thisForm}.key.value=this.name">
					<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Save as a draft')"/></xsl:attribute>
				</input>&#160;
				<input type="submit" class="formBarButton" name="Cancel" onclick="document.{$thisForm}.key.value=this.name">
					<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Cancel')"/></xsl:attribute>
				</input>
			</td> 
        	<xsl:if test="string-length($recordIdValue)">
				<td align="right">
					<xsl:call-template name="buttonsNavigation">
						<xsl:with-param name="thisForm" select="$thisForm"/>
					</xsl:call-template>
				</td>
			</xsl:if>
		</tr>
	</table>
</xsl:template>

</xsl:stylesheet>
