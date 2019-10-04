<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>


<xsl:template name="webmail_popup_view2">
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>	
	<xsl:param name="nodeName"/>	
	<xsl:param name="recordId"/>	
	<xsl:param name="recordName"/>	
			
	<xsl:variable name="recordIdValue"><xsl:value-of select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $recordId]"/></xsl:variable>		
	<xsl:variable name="recordNameValue"><xsl:value-of select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $recordName]"/></xsl:variable>		
	
	<form name="webmail_popup_view" method="post" >
		<input type="hidden" name="op" value="webmail.popup.view"/>
		<input type="hidden" name="key" id="key"/>	
		<input type="hidden" name="isreload" id="isreload" value="false"/>	
		<input type="hidden" name="mail_id" id="mail_id">
			<xsl:attribute name="value"><xsl:value-of select="mail/mail_id" /></xsl:attribute>
		</input>
		
	    <div class="boxtitle">
            <xsl:value-of select="php:functionString('lang',$appLabel)"/>:&#160;
			<xsl:value-of select="$recordNameValue"/>
		</div>		

		<div style="clear:both">
			<xsl:call-template name="webmailPopupViewButtons">
				<xsl:with-param name="thisForm">webmail_popup_view</xsl:with-param>
				<xsl:with-param name="isTop">true</xsl:with-param>
				<xsl:with-param name="nodeName" select="$nodeName"/>
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="recordId" select="$recordId"/>
				<xsl:with-param name="recordIdValue" select="$recordIdValue"/>
				<xsl:with-param name="delete">true</xsl:with-param>
			</xsl:call-template> 				
		</div>	

		<div style="clear:both">
			<table border="0" width="100%" cellpadding="1" cellspacing="1" style="line-height:2em">
				<tr>
					<td align="right" class="label" width="10%" ><xsl:value-of select="php:function('lang','From')"/>:</td>
					<td align="left" class="field" width="40%">
		                <xsl:value-of select="mail/mail_from"/>
		            </td>
					<td align="right" class="label" width="10%" ><xsl:value-of select="php:function('lang','Date')"/>:</td>
					<td align="left" class="field" width="40%">
		                <xsl:value-of select="mail/mail_date"/>
		            </td>            
				</tr>
				<tr>
					<td align="right" class="label"><xsl:value-of select="php:function('lang','To')"/>:</td>
					<td align="left" class="field">
		                <xsl:value-of select="mail/mail_to"/>
		            </td>
					<td align="right" class="label"><xsl:value-of select="php:function('lang','Priority')"/>:</td>
					<td align="left" class="field">
		                <xsl:value-of select="mail/priority_name"/>
		            </td>            
				</tr>	
				<tr>
					<td align="right" class="label"><xsl:value-of select="php:function('lang','Cc')"/>:</td>
					<td align="left" class="field">
		                <xsl:value-of select="mail/mail_cc"/>
		            </td>
					<td align="right" class="label"><xsl:value-of select="php:function('lang','Bcc')"/>:</td>
					<td align="left" class="field">
		                <xsl:value-of select="mail/mail_bcc"/>
		            </td>
				</tr>					
				<tr>
					<td align="right" class="label"><xsl:value-of select="php:function('lang','Subject')"/>:</td>
					<td align="left" class="field">
		                <xsl:value-of select="mail/subject"/>
		            </td>
					<td align="right" class="label"><xsl:value-of select="php:function('lang','Folder')"/>:</td>
				    <td align="left" class="field">
				    	<xsl:value-of select="mail/folder_name"/>
		            </td>          
				</tr>			
				<tr >
					<td align="right" class="label"><xsl:value-of select="php:function('lang','Message')"/>:</td>		
					<td align="left" class="field" colspan="3">
						<xsl:choose>
							<xsl:when test = "mail/body_html">
								<iframe id="body_html" name="body_html" scroll="auto" style="border:0;background-color:white;width:100%;height:15em"/>
								<input id="body_html_hidden" name="body_html_hidden" type="hidden" value="{mail/body_html}"/>
								<script language="Javascript" type="text/javascript">
									var bodyframe = window.frames['body_html'].document;
									bodyframe.open();
									bodyframe.write($('body_html_hidden').value);
									bodyframe.close();
								</script>						
							</xsl:when>
							<xsl:otherwise>
								<input type="hidden" name="body" value='{mail/body_text}'/>				
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
				<tr>
					<td class="label" align="right"><xsl:value-of select="php:function('lang','Attachments')"/>:</td>			
					<td  class="field" align="left" colspan="3">		
						<xsl:for-each select = "/APPSHORE/APP/files/files_item">
							<a href="{$baseurl}&amp;op=webmail.download.attachment&amp;attachment_id={attachment_id}">
								<xsl:value-of select="filename"/>
							</a>&#160;	
						</xsl:for-each>									
						<xsl:for-each select = "/APPSHORE/APP/documents/documents_item">
							<a href="{$baseurl}&amp;op=webmail.download.document&amp;document_id={document_id}">
								<xsl:value-of select="document_name"/>
							</a>&#160;	
						</xsl:for-each>						
		    		</td>	    		
				</tr>			
			</table>
		</div>

		<div style="clear:both">
			<xsl:call-template name="webmailPopupViewButtons">
				<xsl:with-param name="thisForm">webmail_popup_view</xsl:with-param>
				<xsl:with-param name="isTop">false</xsl:with-param>
				<xsl:with-param name="nodeName" select="$nodeName"/>
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="recordId" select="$recordId"/>
				<xsl:with-param name="recordIdValue" select="$recordIdValue"/>
				<xsl:with-param name="delete">true</xsl:with-param>
			</xsl:call-template> 				
		</div>	
	</form>
	
</xsl:template>

<xsl:template name="webmail_popup_view">
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
		<input type="hidden" name="op" value="webmail.popup.view"/>
		<input type="hidden" name="key" id="key"/>	
		<input type="hidden" name="mail_id" id="mail_id" value="{mail/mail_id}" />
			
		<div class="clearboth formBar">
			<xsl:call-template name="webmailPopupViewButtons">
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
			<xsl:call-template name="custom_popup_view">
				<xsl:with-param name="thisForm" select="'webmail_view'"/>
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="appLabel" select="$appLabel"/>
				<xsl:with-param name="nodeName" select="$nodeName"/>
				<xsl:with-param name="recordId" select="$recordId"/>
				<xsl:with-param name="recordName" select="$recordName"/>
			</xsl:call-template> 				
		</div>	

		<div class="clearboth formBar">
			<xsl:call-template name="webmailPopupViewButtons">
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

</xsl:template>


<xsl:template name="webmailPopupViewButtons">
	<xsl:param name="appName"/>
	<xsl:param name="thisForm"/>	
	<xsl:param name="isTop"/>	
    <table cellSpacing="1" cellPadding="1" width="100%" border="0">
		<tr>
			<td align="left">
				<input type="button" class="formBarButton" name="Cancel" onclick="popupClose();">
		            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Cancel')"/></xsl:attribute>
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


<xsl:template name='webmail_popup_edit'>
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

	<xsl:variable name="recordIdValue"><xsl:value-of select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $recordId]"/></xsl:variable>		
	<xsl:variable name="recordNameValue"><xsl:value-of select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $recordName]"/></xsl:variable>		
		
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
		<input type="hidden" name="op" id="op" value="webmail.popup.edit"/>
		<input type="hidden" name="key" id="key"/>	
		<input type="hidden" name="isreload" id="isreload" value="false"/>	
		<input type="hidden" name="mail_id" id="mail_id" value="{mail/mail_id}" />
		<input type="hidden" name="user_id" id="user_id" value="{mail/user_id}" />
		<input type="hidden" name="related_record_id" id="related_record_id" value="{mail/related_record_id}"/>
		<input type="hidden" name="selectedFiles" id="selectedFiles"/>					
		<input type="hidden" name="selectedDocuments" id="selectedDocuments"/>					
	
		<div class="clearboth formBar">
			<xsl:call-template name="webmailPopupEditButtons">
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="thisForm">webmail_edit</xsl:with-param>		
				<xsl:with-param name="isTop">true</xsl:with-param>		
			</xsl:call-template>			
		</div>	

		<div class="clearboth">
			<xsl:call-template name="customEditBody">
				<xsl:with-param name="thisForm">webmail_edit</xsl:with-param>
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="appLabel" select="$appLabel"/>
				<xsl:with-param name="nodeName" select="$nodeName"/>
				<xsl:with-param name="recordId" select="$recordId"/>
				<xsl:with-param name="recordName" select="$recordName"/>
			</xsl:call-template> 				
		</div>			
	    
		<div class="clearboth formBar">
			<xsl:call-template name="webmailPopupEditButtons">
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="thisForm">webmail_edit</xsl:with-param>		
			</xsl:call-template>			
		</div>	
				
	</form>
	
	<div class="clearboth">
	<br/>
		<xsl:call-template name="customLinked">
			<xsl:with-param name="masterForm">webmail_edit</xsl:with-param>
			<xsl:with-param name="masterTableName" select="$appName"/>
			<xsl:with-param name="masterRecordId" select="$recordId"/>
			<xsl:with-param name="masterRecordIdValue" select="$recordIdValue"/>
			<xsl:with-param name="masterRecordNameValue" select="$recordNameValue"/>
		</xsl:call-template>
	</div> 	
	
</xsl:template>


<xsl:template name="webmailPopupEditButtons">
	<xsl:param name="appName"/>
	<xsl:param name="thisForm"/>	
	<xsl:param name="isTop"/>	
    <table cellSpacing="1" cellPadding="1" width="100%" border="0">
		<tr>
			<td align="left">
				<input type="submit" class="formBarButton" name="Send" onclick="top.window.winReload=true;document.{$thisForm}.key.value=this.name;">
		            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Send')"/></xsl:attribute>
		        </input>&#160;        	
				<input type="submit" class="formBarButton" name="Save" onclick="top.window.winReload=true;document.{$thisForm}.key.value=this.name;">
		            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Save as a draft')"/></xsl:attribute>
		        </input>&#160;        	
				<input type="button" class="formBarButton" name="Cancel" onclick="popupClose2('webmail_edit');">
		            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Cancel')"/></xsl:attribute>
		        </input>
			</td> 
		</tr>
	</table>				        
</xsl:template>


</xsl:stylesheet>
