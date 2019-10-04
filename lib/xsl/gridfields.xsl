<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name="gridFields">
	<xsl:param name="appName"/>
	<xsl:param name="recordId"/>	
	<xsl:param name="recordId_value"/>	
	<xsl:param name="currentRecord"/>		
	<xsl:param name="currentField"/>	
	<xsl:param name="unselectedtext"/>	

	<xsl:choose>
	
	    <xsl:when test="field_type = 'CH'">
			<xsl:choose>
			    <xsl:when test="$currentRecord/*[name() = $currentField/field_name] = 'Y' or $currentRecord/*[name() = $currentField/field_name] = '1'">
					<img class="image" src="{$api_image_path}/checked.gif"/>
			    </xsl:when>	
			    <xsl:otherwise>
					<img class="image" src="{$api_image_path}/unchecked.gif"/>
		   	   </xsl:otherwise>			    		    
			</xsl:choose>					
	    </xsl:when>		
	    						    					    
	    <xsl:when test="field_type = 'CU'">
			<xsl:value-of select="/APPSHORE/API/current_user/currency_id"/>&#160;<xsl:value-of select="format-number($currentRecord/*[name() = $currentField/field_name], '###,###,###')"/>
	    </xsl:when>		
	    						    					    
	    <xsl:when test="field_type = 'CD'">
			<xsl:value-of select="/APPSHORE/API/current_user/currency_id"/>&#160;<xsl:value-of select="format-number($currentRecord/*[name() = $currentField/field_name], '###,###,###.00')"/>
	    </xsl:when>		

	    <xsl:when test="field_type = 'DD'">
			<xsl:choose>
			    <xsl:when test="string-length(related_id) > 0">
					<xsl:variable name="related_field_name_value">related_<xsl:value-of select="field_name"/></xsl:variable>
					<xsl:value-of select="php:functionString('lang',$currentRecord/*[name() = $related_field_name_value])"/>										
			    </xsl:when>	
			    <xsl:otherwise>
			    	<xsl:value-of select="php:functionString('lang',$currentRecord/*[name() = $currentField/field_name])"/>
		   	   </xsl:otherwise>			    		    
			</xsl:choose>																												
   	   </xsl:when>				    
	    
	    <xsl:when test="field_type = 'DO'">
			<xsl:choose>
			    <xsl:when test="/APPSHORE/API/popup = 'true'">
					<xsl:choose>
					    <xsl:when test="$currentRecord/is_folder = 'Y'">
							<img class="image" src="{$api_image_path}/mime_folder.png"/>&#160;						
					        <a href="{$baseurl}&amp;op=documents.popup.search&amp;document_id={$recordId_value}&amp;is_attachment={/APPSHORE/APP/recordset/is_attachment}&amp;is_multiple={/APPSHORE/APP/recordset/is_multiple}">
								<xsl:value-of select="$currentRecord/*[name() = $currentField/field_name]"/>	
					        </a>							
					    </xsl:when>
					    <xsl:otherwise>
							<xsl:value-of select="$currentRecord/*[name() = $currentField/field_name]"/>	
					    </xsl:otherwise>
					</xsl:choose>
				</xsl:when>
			    <xsl:otherwise>
					<xsl:choose>
					    <xsl:when test="$currentRecord/is_folder = 'Y'">
							<img class="image" src="{$api_image_path}/mime_folder.png"/>&#160;						
					        <a href="{$baseurl}&amp;op=documents.base.search&amp;document_id={$recordId_value}&amp;offset={$currentRecord/offset}" onMouseOver="popupDetails( '{$baseurl}&amp;op=documents.popup.view&amp;document_id={$recordId_value}');" onMouseOut="return nd(1000);"  >
								<xsl:value-of select="$currentRecord/*[name() = $currentField/field_name]"/>	
					        </a>							
					    </xsl:when>
					    <xsl:otherwise>
					        <a href="{$baseurl}&amp;op=documents.download.start&amp;document_id={$recordId_value}&amp;offset={$currentRecord/offset}" onMouseOver="popupDetails( '{$baseurl}&amp;op=documents.popup.view&amp;document_id={$recordId_value}');" onMouseOut="return nd(1000);"  >
								<xsl:value-of select="$currentRecord/*[name() = $currentField/field_name]"/>	
					        </a>							
					    </xsl:otherwise>
					</xsl:choose>
			    </xsl:otherwise>
			</xsl:choose>
	    </xsl:when>			
<!--					    					    							    						    					    
	    <xsl:when test="field_type = 'ML'">
			<textarea readonly="true" class="textarea {$unselectedtext}" onMouseOver="this.className='textarea selectedtext'" onMouseOut="this.className='textarea {$unselectedtext}'" wrap="off" style="height:2em;width:100%;overflow:hidden" onblur="style.height='2em';style.overflow='hidden'" onfocus="style.height='10em';style.overflow='auto'">
				<xsl:value-of select="$currentRecord/*[name() = $currentField/field_name]"/>
			</textarea>
	    </xsl:when>		
-->						    	
	
		<xsl:when test="field_type = 'IM'">
			<xsl:if test="string-length($currentRecord/*[name() = $currentField/field_name])">
				<img class="image fieldAssociatedLink" src="{$basepath}/lib/image.php?image_id={$currentRecord/*[name() = $currentField/field_name]}_48" style="margin:2px;height:48px;width:48px" onclick="popupInter('{$basepath}/lib/image.php?image_id={$currentRecord/*[name() = $currentField/field_name]}','{field_label}');">
			   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Full size')"/></xsl:attribute>                    
				</img>
			</xsl:if>
		</xsl:when>			

	    <xsl:when test="field_type = 'MV'">
	    	<xsl:value-of select="php:functionString('lang',$currentRecord/*[name() = $currentField/field_name])"/>
   	   </xsl:when>				    

	    <xsl:when test="field_type = 'NU'">
			<xsl:value-of select="format-number($currentRecord/*[name() = $currentField/field_name], '###,###,###')"/>
	    </xsl:when>		

	    <xsl:when test="field_type = 'ND'">
			<xsl:value-of select="format-number($currentRecord/*[name() = $currentField/field_name], '###,###,###.00')"/>
	    </xsl:when>		
	    					    	
	    <xsl:when test="field_type = 'PE'">
			<xsl:value-of select="format-number($currentRecord/*[name() = $currentField/field_name], '#')"/>%
	    </xsl:when>		
	    					    	
	    <xsl:when test="field_type = 'PD'">
			<xsl:value-of select="format-number($currentRecord/*[name() = $currentField/field_name], '#.00')"/>%
	    </xsl:when>		
	    					    	
	    <xsl:when test="field_type = 'PH'">
			<xsl:call-template name="callto">
				<xsl:with-param name="phone"><xsl:value-of select="$currentRecord/*[name() = $currentField/field_name]"/></xsl:with-param>
			</xsl:call-template>
	    </xsl:when>
    						    	
	    <xsl:when test="(field_type = 'RR' or field_type = 'DF') and not(/APPSHORE/API/popup = 'true')">
			<xsl:variable name="related_field_name_value">related_<xsl:value-of select="field_name"/></xsl:variable>
            <a href="{$baseurl}&amp;op={related_app_name}.base.view&amp;{related_id}={$currentRecord/*[name() = $currentField/field_name]}" onMouseOver="popupDetails('{$baseurl}&amp;op={related_app_name}.popup.view&amp;{related_id}={$currentRecord/*[name() = $currentField/field_name]}');" onMouseOut="return nd(1000);"  >
				<xsl:value-of select="$currentRecord/*[name() = $related_field_name_value]"/>										
			</a>
	    </xsl:when>	
	    
	    <xsl:when test="field_type = 'VF' and not(/APPSHORE/API/popup = 'true')">
            <a href="{$baseurl}&amp;op={$appName}.base.view&amp;{$recordId}={$recordId_value}&amp;offset={$currentRecord/offset}" onMouseOver="popupDetails('{$baseurl}&amp;op={$appName}.popup.view&amp;{$recordId}={$recordId_value}');" onMouseOut="return nd(1000);"  >
				<xsl:value-of select="$currentRecord/*[name() = $currentField/field_name]"/>	
			</a>
	    </xsl:when>	
	    	
	    <xsl:when test="field_type = 'WM' or field_type = 'EM'">
			<xsl:call-template name="mailto">
				<xsl:with-param name="email"><xsl:value-of select="$currentRecord/*[name() = $currentField/field_name]"/></xsl:with-param>
				<xsl:with-param name="name">
					<xsl:choose>
						<xsl:when test = "$currentRecord/record_name"> 
							<xsl:value-of select="$currentRecord/record_name"/>
						</xsl:when>
						<xsl:when test = "$currentRecord/full_name"> 
							<xsl:value-of select="$currentRecord/full_name"/>
						</xsl:when>
						<xsl:when test = "$currentRecord/last_name"> 
							<xsl:value-of select="$currentRecord/first_names"/>&#160;<xsl:value-of select="$currentRecord/last_name"/>
						</xsl:when>
						<xsl:otherwise> 
							<xsl:value-of select="$currentRecord/account_name"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="subject" select="$currentRecord/*[name() = subject]"/>
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="recordIdValue" select="$recordId_value"/>
			</xsl:call-template>
	    </xsl:when>	
	    
	    <xsl:when test="field_type = 'WS' and not(/APPSHORE/API/popup = 'true') and string-length($currentRecord/*[name() = $currentField/field_name])">
			<a href="javascript:;" onclick="popupInter('{$currentRecord/*[name() = $currentField/field_name]}','{$currentRecord/*[name() = $currentField/field_name]}');">
             	<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Open a popup window')"/></xsl:attribute>                    
				<xsl:value-of select="$currentRecord/*[name() = $currentField/field_name]"/>
			</a>
			<a href="{$currentRecord/*[name() = $currentField/field_name]}" target="_new">
           		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Open a new window')"/></xsl:attribute>                    
				<img class="image" src="{$api_image_path}/openwindow_16.png"/>
			</a>
	    </xsl:when>	
	    
	    <xsl:otherwise>
			<xsl:choose>
			    <xsl:when test="string-length(related_id) > 0">
					<xsl:variable name="related_field_name_value">related_<xsl:value-of select="field_name"/></xsl:variable>
					<xsl:value-of select="$currentRecord/*[name() = $related_field_name_value]"/>										
			    </xsl:when>	
			    <xsl:otherwise>
					<xsl:value-of select="$currentRecord/*[name() = $currentField/field_name]"/>	
		   	   </xsl:otherwise>			    		    
			</xsl:choose>																												
   	   </xsl:otherwise>		
   	   	    		    
	</xsl:choose>							

</xsl:template>

</xsl:stylesheet>
