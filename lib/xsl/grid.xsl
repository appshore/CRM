<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name="custom_grid">
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>
	<xsl:param name="nodeName"/>		
	<xsl:param name="recordId"/>	
	<xsl:param name="select" select="'true'"/>	
	<xsl:param name="edit" select="'true'"/>	
	<xsl:param name="view" select="'true'"/>	

	<xsl:if test="$appLabel"> 								
	    <div class="clearboth formTitle">
			<xsl:value-of select="php:functionString('lang',$appLabel)"/>
		</div>
	</xsl:if>
	
	<xsl:variable name="formName" select="'custom_grid'"/>							
	<form id="{$formName}" name="{$formName}" method="post">
		<input type="hidden" name="op" id="op" value="{$appName}.base.search"/>
		<input type="hidden" name="orderby" id="orberby" value="{/APPSHORE/APP/recordset/orderby}"/>		
		<input type="hidden" name="ascdesc" id="ascdesc" value="{/APPSHORE/APP/recordset/ascdesc}"/>	
		<input type="hidden" name="key" id="key"/>	
		<input type="hidden" name="selected" id="selected"/>	
		<input type="hidden" name="nbrecords" id="nbrecords"/>			

		<table class="formBar" border="0" cellspacing="0" cellpadding="0">
			<tr class="formBarContent">
				<xsl:if test="/APPSHORE/APP/scope > 0"> 								
					<td class="formBarContent start_direction">
					    <xsl:call-template name="gridCheckAllListForm">
							<xsl:with-param name="thisForm" select="$formName"/>				
						</xsl:call-template>				
					</td>
				</xsl:if>
				<td class="formBarContent end_direction">
				    <xsl:call-template name="gridButtons">
						<xsl:with-param name="thisForm" select="$formName"/>				
					</xsl:call-template>        
				</td>
			</tr>					
		</table>						

		<xsl:variable name="fieldsCount" select="count(/APPSHORE/APP/result_fields/result_fields_item)+3"/>	
		
		<table class="resizable searchResultsTable" border="0" cellspacing="0" cellpadding="0">
			<tr class="searchResultsHeader">
				<xsl:if test="/APPSHORE/APP/scope > 0"> 								
					<xsl:if test="$select = 'true'">                    
					    <td class="searchResultsHeaderIcons"/>				
	         		</xsl:if>
					<xsl:if test="$edit = 'true'">                    
						<td class="searchResultsHeaderIcons">
							<xsl:if test="scope > 0"> 								
								<a href="javascript:gridOrderBy(document.{$formName},'created');">
							        <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Sort by date of creation')"/></xsl:attribute>
					                <xsl:value-of select="php:function('lang','C')"/>
					            </a>
							</xsl:if>
						</td>
	         		</xsl:if>
				</xsl:if>
				<xsl:if test="$view = 'true'">                    
					<td class="searchResultsHeaderIcons">
						<a href="javascript:gridOrderBy(document.{$formName},'updated');">
					        <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Sort by date of last update')"/></xsl:attribute>
			                <xsl:value-of select="php:function('lang','U')"/>
			            </a>
					</td>
				</xsl:if>
				<xsl:for-each select = "/APPSHORE/APP/result_fields/result_fields_item" >
					<th class="searchResultsHeaderCells">
						<xsl:call-template name="gridFieldsHeader">
							<xsl:with-param name="thisForm" select="$formName"/>
						</xsl:call-template>
					</th>					
				</xsl:for-each>									
			</tr>

			<xsl:variable name="items"><xsl:value-of select="$nodeName"/>_item</xsl:variable>					
			<xsl:for-each select = "/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $items]">
				<xsl:variable name="currentRecord" select="current()"/>					
				<xsl:variable name="recordId_value" select="*[name() = $recordId]"/>					
				<xsl:variable name="unselectedtext" select="record_class"/>
				<tr class="{record_class}" onMouseOver="this.className ='searchResultsSelected'" onMouseOut="this.className ='{record_class}'">
					<xsl:if test="not(record_class = 'unselectedtext')"> 								
			            <xsl:attribute name="title"><xsl:value-of select="php:functionString('lang', concat('record.class.',record_class))"/></xsl:attribute>
			        </xsl:if>
					<xsl:if test="/APPSHORE/APP/scope > 0"> 								
						<xsl:if test="$select = 'true'">                    
							<td class="searchResultsIcons" >		
								<xsl:call-template name="gridCheckListForm">
									<xsl:with-param name="thisForm" select="$formName"/>				
									<xsl:with-param name="thisId" select="$recordId_value"/>
									<xsl:with-param name="scope" select="scope"/>					
								</xsl:call-template>
							</td>
		         		</xsl:if>
						<xsl:if test="$edit = 'true'">                    
							<td class="searchResultsIcons" >		
								<xsl:if test="scope > 0"> 	
									<a>							
							        	<xsl:attribute name="href"><xsl:value-of select="$baseurl"/>&amp;op=<xsl:value-of select="$appName"/>.base.edit&amp;<xsl:value-of select="$recordId"/>=<xsl:value-of select="$recordId_value"/>&amp;offset=<xsl:value-of select="offset"/></xsl:attribute>
							        	<xsl:attribute name="onmouseover">popupDetails('<xsl:value-of select="$baseurl"/>&amp;op=<xsl:value-of select="$appName"/>.popup.view&amp;<xsl:value-of select="$recordId"/>=<xsl:value-of select="$recordId_value"/>');</xsl:attribute>
							        	<xsl:attribute name="onmouseout">return nd(1000);</xsl:attribute>
							        	<img class="image" src="{$api_image_path}/edit.png"/>
							        </a>
				         		</xsl:if>
							</td>									
		         		</xsl:if>
	         		</xsl:if>
					<xsl:if test="$view = 'true'">                    
						<td class="searchResultsIcons" >		
							<a>							
					        	<xsl:attribute name="href"><xsl:value-of select="$baseurl"/>&amp;op=<xsl:value-of select="$appName"/>.base.view&amp;<xsl:value-of select="$recordId"/>=<xsl:value-of select="$recordId_value"/>&amp;offset=<xsl:value-of select="offset"/></xsl:attribute>
					        	<xsl:attribute name="onmouseover">popupDetails('<xsl:value-of select="$baseurl"/>&amp;op=<xsl:value-of select="$appName"/>.popup.view&amp;<xsl:value-of select="$recordId"/>=<xsl:value-of select="$recordId_value"/>');</xsl:attribute>
					        	<xsl:attribute name="onmouseout">return nd(1000);</xsl:attribute>
					        	<img class="image" src="{$api_image_path}/view.png"/>
					        </a>
						</td>				
	         		</xsl:if>
					<xsl:for-each select = "/APPSHORE/APP/result_fields/result_fields_item" >
						<td class="searchResultsCells {result_class}">
							<xsl:call-template name="gridFields">
								<xsl:with-param name="appName" select="$appName"/>
								<xsl:with-param name="recordId" select="$recordId"/>
								<xsl:with-param name="recordId_value" select="$recordId_value"/>
								<xsl:with-param name="currentRecord" select="$currentRecord"/>
								<xsl:with-param name="currentField" select="current()"/>
								<xsl:with-param name="unselectedtext" select="$unselectedtext"/>
							</xsl:call-template>&#160;
						</td>	
					</xsl:for-each>																					
				</tr>
			</xsl:for-each>
			<xsl:variable name="recordsCount" select="count(/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $items])"/>	
			<xsl:choose>
			    <xsl:when test="$recordsCount = 0">
			    	<tr style="text-align:center;vertical-align:middle"><td colspan="{$fieldsCount}">
       				 	<H2 style="color:lightgrey;line-height:4em"><xsl:value-of select="php:function('lang','No entries')"/></H2>
					</td></tr>
			    </xsl:when>	
			    <xsl:when test="(4-$recordsCount) > 0">
			    	<tr>
			    		<td colspan="{$fieldsCount}" style="line-height:{8-$recordsCount}em">&#160;</td>
 					</tr>
			    </xsl:when>	
			</xsl:choose>					

			<xsl:if test="/APPSHORE/APP/computed">
				<tr class="searchResultsHeader">
					<xsl:if test="/APPSHORE/APP/scope > 0"> 								
						<xsl:if test="$select = 'true'">                    
							<td class="searchResultsHeaderIcons"/>				
			     		</xsl:if>
						<xsl:if test="$edit = 'true'">                    
							<td class="searchResultsHeaderIcons">
							</td>
			     		</xsl:if>
					</xsl:if>
					<xsl:if test="$view = 'true'">                    
						<td class="searchResultsHeaderIcons">
						</td>
					</xsl:if>
					<xsl:for-each select = "/APPSHORE/APP/result_fields/result_fields_item" >
						<th class="searchResultsHeaderCells {result_class}">
							<xsl:call-template name="gridComputedTotal">
								<xsl:with-param name="currentField" select="current()"/>
							</xsl:call-template>&#160;
						</th>					
					</xsl:for-each>									
				</tr>
			</xsl:if>
		</table>
	
		<table class="formBar" border="0" cellspacing="0" cellpadding="0">
			<tr class="formBarContent">
				<xsl:if test="/APPSHORE/APP/scope > 0"> 								
					<td class="formBarContent start_direction">
					    <xsl:call-template name="gridCheckAllListForm">
							<xsl:with-param name="thisForm" select="$formName"/>				
						</xsl:call-template>				
					</td>
				</xsl:if>
				<td class="formBarContent end_direction">
				    <xsl:call-template name="gridButtons">
						<xsl:with-param name="thisForm" select="$formName"/>				
					</xsl:call-template>        
				</td>
			</tr>					
		</table>						

	</form>

</xsl:template>


<xsl:template name="custom_popup_grid">
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>
	<xsl:param name="nodeName"/>		
	<xsl:param name="recordId"/>	
	<xsl:param name="recordName"/>	
	<xsl:param name="is_multiple"/>	

	<xsl:if test="$appLabel"> 								
	    <div class="clearboth formTitle">
			<xsl:value-of select="php:functionString('lang',$appLabel)"/>
		</div>
	</xsl:if>

	<xsl:variable name="formName">custom_popup_grid</xsl:variable>	
	<form name="{$formName}" method="post" >
		<input type="hidden" name="op" id="op" value="{$appName}.popup.search"/>
		<input type="hidden" name="orderby" id="orderby" value="{/APPSHORE/APP/recordset/orderby}"/>		
		<input type="hidden" name="ascdesc" id="ascdesc" value="{/APPSHORE/APP/recordset/ascdesc}"/>	
		<input type="hidden" name="readonly" id="readonly" value="{/APPSHORE/APP/recordset/readonly}"/>	
		<input type="hidden" name="is_multiple" id="is_multiple" value="{$is_multiple}"/>	
		<input type="hidden" name="key" id="key"/>	
		<input type="hidden" name="selected" id="selected"/>	
	
		<table class="formBar" border="0" cellspacing="0" cellpadding="0">
			<tr class="formBarContent">
				<xsl:if test="(/APPSHORE/APP/scope > 0) and ($is_multiple = 'true')"> 								
					<td class="formBarContent start_direction">
					    <xsl:call-template name="gridCheckAllListForm">
							<xsl:with-param name="thisForm" select="$formName"/>				
						</xsl:call-template>				
					</td>
				</xsl:if>
				<td class="formBarContent end_direction">
				    <xsl:call-template name="gridButtons">
						<xsl:with-param name="thisForm" select="$formName"/>				
					</xsl:call-template>        
				</td>
			</tr>					
		</table>						
										

		<xsl:variable name="fieldsCount" select="count(/APPSHORE/APP/popup_result_fields/popup_result_fields_item)"/>	
		
		<table class="resizable searchResultsTable" border="0" cellspacing="0" cellpadding="0">
			<tr class="searchResultsHeader">
			    <td class="searchResultsHeaderCells"/>				
				<xsl:for-each select = "/APPSHORE/APP/popup_result_fields/popup_result_fields_item" >
					<th class="searchResultsHeaderCells">
						<xsl:call-template name="gridFieldsHeader">
							<xsl:with-param name="thisForm" select="$formName"/>
						</xsl:call-template>	
					</th>					
				</xsl:for-each>									
			</tr>
			
			<xsl:variable name="items"><xsl:value-of select="$nodeName"/>_item</xsl:variable>					
			<xsl:for-each select = "/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $items]">
				<xsl:variable name="currentRecord" select="current()"/>					
				<xsl:variable name="recordId_value" select="*[name() = $recordId]"/>
				<xsl:variable name="unselectedtext">
					<xsl:choose>
						<xsl:when test ="record_date = 'new'">new</xsl:when>
						<xsl:when test ="record_date = 'expired'">expired</xsl:when>
						<xsl:when test ="record_date = 'inprogress'">inprogress</xsl:when>
					</xsl:choose>
				</xsl:variable>											
				<tr class="{record_class}" onMouseOver="this.className ='searchResultsSelected'" onMouseOut="this.className ='{record_class}'">
					<xsl:choose>
					    <xsl:when test="$is_multiple = 'true'">
							<td class="searchResultsIcons" >		
							    <xsl:call-template name="gridCheckListForm">
									<xsl:with-param name="thisForm" select="$formName"/>				
									<xsl:with-param name="thisId" select="$recordId_value"/>
									<xsl:with-param name="scope" select="scope"/>					
								</xsl:call-template>
							</td>
						</xsl:when>	
						<xsl:otherwise>
							<td class="searchResultsIcons">
								<xsl:variable name="recordName_slash">					
									<xsl:choose>
									    <xsl:when test="*[name() = concat(/APPSHORE/APP/recordset/related_name,'_slash')]">
											<xsl:value-of select="*[name() = concat(/APPSHORE/APP/recordset/related_name,'_slash')]"/>
									    </xsl:when>	
									    <xsl:when test="*[name() = concat($recordName,'_slash')]">
											<xsl:value-of select="*[name() = concat($recordName,'_slash')]"/>
									    </xsl:when>	
									    <xsl:when test="$currentRecord/last_name">
											<xsl:value-of select="$currentRecord/first_names_slash"/>&#160;<xsl:value-of select="$currentRecord/last_name_slash"/>
									    </xsl:when>	
									    <xsl:otherwise>
											<xsl:value-of select="*[name() = /APPSHORE/APP/recordset/related_name]"/>
								   	   </xsl:otherwise>			    		    
									</xsl:choose>
								</xsl:variable>					
								<input type="radio">
									<xsl:attribute name="onClick">if(passBackTuple("<xsl:value-of select="$recordName_slash"/>","<xsl:value-of select="$recordId_value"/>"))popupClose();</xsl:attribute>
								</input>
							</td>		
						</xsl:otherwise>			    		    
					</xsl:choose>					
					<xsl:for-each select = "/APPSHORE/APP/popup_result_fields/popup_result_fields_item" >
						<td class="searchResultsCells {result_class}">
							<xsl:call-template name="gridFields">
								<xsl:with-param name="appName" select="$appName"/>
								<xsl:with-param name="recordId" select="$recordId"/>
								<xsl:with-param name="recordId_value" select="$recordId_value"/>
								<xsl:with-param name="currentRecord" select="$currentRecord"/>
								<xsl:with-param name="currentField" select="current()"/>
								<xsl:with-param name="unselectedtext" select="$unselectedtext"/>
							</xsl:call-template>	
						</td>	
					</xsl:for-each>																					
				</tr>
			</xsl:for-each>
		</table>					
		
		<table class="formBar" border="0" cellspacing="0" cellpadding="0">
			<tr class="formBarContent">
				<xsl:if test="(/APPSHORE/APP/scope > 0) and ($is_multiple = 'true')"> 								
					<td class="formBarContent start_direction">
					    <xsl:call-template name="gridCheckAllListForm">
							<xsl:with-param name="thisForm" select="$formName"/>				
						</xsl:call-template>				
					</td>
				</xsl:if>
				<td class="formBarContent end_direction">
				    <xsl:call-template name="gridButtons">
						<xsl:with-param name="thisForm" select="$formName"/>				
					</xsl:call-template>        
				</td>
			</tr>					
		</table>						

	    <div class="boxtitle buttonbar clearboth">
			<xsl:choose>
			    <xsl:when test="$is_multiple = 'true'">
					<xsl:value-of select="php:function('lang','Apply On')"/>&#160;
					<select class="fieldInputSelect" name="bulk_id" id="bulk_id">
						<xsl:for-each select = "bulk/bulk_item" >
							<option value="{bulk_id}">
								<xsl:if test="bulk_id = /APPSHORE/APP/recordset/bulk_id">
									<xsl:attribute name="selected" value="true"/>
								</xsl:if>
								<xsl:value-of select="bulk_name"/>
							</option>
						</xsl:for-each>
					</select>&#160;
					<input type="submit" class="formBarButton" name="Link" onclick="top.window.winReload=true;return gridBulkKey(document.{$formName},document.{$formName},this.name);">
				        <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Link selection')"/></xsl:attribute>
						<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Link')"/></xsl:attribute>
				    </input>        
			    </xsl:when>	
			    <xsl:otherwise>
					<input type='button' class="formBarButton" onclick="passBackTuple('',0);popupClose();">
				   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Clear and close')"/></xsl:attribute>                    
			        	<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Clear')"/></xsl:attribute>
			    	</input>
		   	   </xsl:otherwise>			    		    
			</xsl:choose>					
			&#160;<input type='button' class="formBarButton" onclick="popupClose2('custom_edit');">
			   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Cancel and close')"/></xsl:attribute>                    
		        	<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Cancel')"/></xsl:attribute>
	    	</input>
		</div>


	</form>
	  

</xsl:template>

<xsl:template name="gridButtons">
	<xsl:param name="thisForm"/>								
	<xsl:param name="isTop"/>								
	<xsl:param name="appLabel"/>	
	
    <xsl:call-template name="buttonsNavigation">
		<xsl:with-param name="thisForm" select="$thisForm"/>
		<xsl:with-param name="isGrid">true</xsl:with-param>
	</xsl:call-template>
	<xsl:if test="/APPSHORE/APP/nbrecords">  
		&#160;			
	    <xsl:call-template name="gridNbRecords">
			<xsl:with-param name="thisForm" select="$thisForm"/>
		</xsl:call-template> 
	</xsl:if>
</xsl:template>


<xsl:template name="gridNbRecords">
	<xsl:param name="thisForm"/>
	<select class="formBarSelect" onchange="document.{$thisForm}.key.value='NbRecords';document.{$thisForm}.nbrecords.value=this.value;document.{$thisForm}.submit();">
		<xsl:for-each select = "nbrecords/nbrecords_item" >
			<option value="{nbrecords}">
				<xsl:if test="nbrecords = /APPSHORE/API/current_user/nbrecords">
					<xsl:attribute name="selected" value="true"/>
				</xsl:if>
				<xsl:value-of select="nbrecords"/>
			</option>
		</xsl:for-each>
	</select>&#160;<xsl:value-of select="php:function('lang','Lines')"/>	 
</xsl:template>

<xsl:template name="gridCheckAllListForm">
	<xsl:param name="thisForm"/>
	<xsl:value-of select="php:function('lang','Select')"/>:&#160;
	<a href="javascript:void(0)" onclick="gridAllCheckbox(document.{$thisForm},'all');">
		<xsl:value-of select="php:function('lang','All')"/>
	</a>&#160;
	<a href="javascript:void(0)" onclick="gridAllCheckbox(document.{$thisForm},'none');">
		<xsl:value-of select="php:function('lang','None')"/>
	</a>&#160;
	<a href="javascript:void(0)" onclick="gridAllCheckbox(document.{$thisForm},'new');">
		<xsl:value-of select="php:function('lang','New')"/>
	</a>&#160;
<!--	<a href="javascript:void(0)" onclick="gridAllCheckbox(document.{$thisForm},'old');">-->
<!--		<xsl:value-of select="php:function('lang','Old')"/>-->
<!--	</a>&#160;-->
<!--	<a href="javascript:void(0)" onclick="gridAllCheckbox(document.{$thisForm},'inprogress');">-->
<!--		<xsl:value-of select="php:function('lang','In progress')"/>-->
<!--	</a>&#160;-->
<!--	<a href="javascript:void(0)" onclick="gridAllCheckbox(document.{$thisForm},'expired');">-->
<!--		<xsl:value-of select="php:function('lang','Expired')"/>-->
<!--	</a>-->
</xsl:template>

<xsl:template name="gridCheckListForm">
	<xsl:param name="thisForm"/>
	<xsl:param name="thisId"/>
	<xsl:param name="scope"/>	
	<xsl:if test="$scope > 0 "> 		
		<input class="searchResultsCheckbox" id="{$thisId}" name="{$thisId}" onclick="checkTheBox(this);" type="checkbox" value="0"/>
	</xsl:if>
</xsl:template>


<xsl:template name="gridFieldsHeader">
	<xsl:param name="thisForm"/>			    
	<xsl:variable name="orderby"><xsl:if test="string-length(related_name) > 0">related_</xsl:if><xsl:value-of select="field_name"/></xsl:variable>							
	<xsl:choose>
		<xsl:when test="(/APPSHORE/APP/recordset/orderby = $orderby) and (/APPSHORE/APP/recordset/ascdesc = 'ASC')"> 								
            <xsl:attribute name="class">searchResultsHeaderCells sortasc</xsl:attribute>
		</xsl:when>						
		<xsl:when test="(/APPSHORE/APP/recordset/orderby = $orderby) and (/APPSHORE/APP/recordset/ascdesc = 'DESC')"> 								
            <xsl:attribute name="class">searchResultsHeaderCells sortdesc</xsl:attribute>
		</xsl:when>						
		<xsl:otherwise test="/APPSHORE/APP/recordset/orderby = $orderby"> 								
            <xsl:attribute name="class">searchResultsHeaderCells</xsl:attribute>
		</xsl:otherwise>
	</xsl:choose>						
	<a href="javascript:gridOrderBy(document.{$thisForm},'{$orderby}');">
        <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Sort by')"/>&#160;<xsl:value-of select="php:functionString('lang',field_label)"/></xsl:attribute>
        <xsl:value-of select="php:functionString('lang',field_label)"/>
    </a>
</xsl:template>


<xsl:template name="gridComputedTotal">
	<xsl:param name="currentField"/>	
	<xsl:if test="/APPSHORE/APP/computed/node()[name() = $currentField/field_name]">
		<xsl:for-each select = "/APPSHORE/APP/computed/node()[name() = $currentField/field_name]/node()/node()" >
			<xsl:choose>
				<xsl:when test= "string(number(.))='NaN'"> 
					<xsl:value-of select="name()"/>:&#160;<xsl:value-of select="."/>
				</xsl:when>
				<xsl:otherwise> 
					<xsl:value-of select="name()"/>:&#160;<xsl:value-of select="format-number(.,'###,###,###')"/>
				</xsl:otherwise>
			</xsl:choose><xsl:if test="not(position() = last())"><br/></xsl:if>
		</xsl:for-each>									
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
