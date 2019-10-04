<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="APP[action/reports]">
    <table width="100%" cellSpacing="0" cellPadding="0"  border="0">
		<tr width="100%" valign="top">
		    <xsl:call-template name="leftPanel"/>
            <td id="right_panel" class="right_panel">
				<xsl:choose>
					<xsl:when test="action/reports  = 'page'">
						<xsl:call-template name="report_edit"/>
					</xsl:when>
					<xsl:when test="action/reports  = 'edit'">
						<xsl:call-template name="report_edit">
							<xsl:with-param name="appName" select="'reports'"/>
							<xsl:with-param name="appLabel" select="'Report'"/>
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template name="report_edit">
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>	
	<xsl:param name="nodeName"/>	
	<xsl:param name="recordId"/>
	<xsl:param name="recordName"/>			

	<script language="JavaScript" type="text/javascript" src="{$lib_js_path}/form.js"/>
	<script language="JavaScript" type="text/javascript" src="reports/js/builder.js"/>

	<form name="report_edit" method="post" onchange="notsaved=true;" onsubmit="return builder_submit(this);">
		<input type="hidden" name="op" id="op" value="reports.builder.edit"/>
		<input type="hidden" name="key" id="key"/>	
		<input type="hidden" name="report_id" id="report_id" value="{report/report_id}"/>
		<input type="hidden" name="groupbylines" id="groupbylines" value="{report/groupbylines}"/>
		<input type="hidden" name="groupbyfields" id="groupbyfields" value="{report/groupbyfields}"/>
		<input type="hidden" name="filterlines" id="filterlines" value="{report/filterlines}"/>
		<input type="hidden" name="filtercriterias" id="filtercriterias" value="{report/filtercriterias}"/>
		<input type="hidden" name="allgroupbys" id="allgroupbys" value="{allgroupbysStr}"/>
		<input type="hidden" name="allfilters" id="allfilters" value="{allfiltersStr}"/>
		<input type="hidden" name="rank" id="rank"/>
		<input type="hidden" name="updown" id="updown"/>
		<input type="hidden" name="subst_key" id="subst_key"/>

		
		<div class="clearboth">
			<div class="formTitleTags start_float">
				<xsl:choose>
					<xsl:when test="string-length(report/report_name)">
						<xsl:value-of select="php:functionString('lang',$appLabel)"/>:&#160;<xsl:value-of select="report/report_name"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="php:functionString('lang',$appLabel)"/>:&#160;<span style="color:black;font-weight:normal;font-style:italic"><xsl:value-of select="php:function('lang','New')"/></span>
					</xsl:otherwise>
				</xsl:choose>
			</div>
<!--			<div class="end_float">-->
<!--				<xsl:call-template name="displayTags">-->
<!--					<xsl:with-param name="appName" select="$appName"/>-->
<!--					<xsl:with-param name="nodeName" select="$nodeName"/>-->
<!--					<xsl:with-param name="recordIdValue" select="$recordIdValue"/>-->
<!--				</xsl:call-template>-->
<!--			</div>-->
		</div>	
		<xsl:if test="string-length(report/report_name) = '0'">
			<div class="helpmsg">
				<xsl:value-of disable-output-escaping="yes" select="php:function('lang','reports.builder.help.new')"/>
			</div>
		</xsl:if>

		<div class="clearboth formBar">
			<xsl:call-template name="builderEditButtons">
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="thisForm">report_edit</xsl:with-param>		
				<xsl:with-param name="isTop">true</xsl:with-param>		
			</xsl:call-template>			
		</div>	

		
		<table class="clearboth formTable">
		<tr><td>
			<div class="clearboth fieldLabelContainer" style="padding-top: 10px;">
				<div class="fieldLabel fieldLabelMandatory">
					<xsl:value-of select="php:function('lang','Report name')"/>
				</div>
				<div class="fieldText">
					<input class="fieldInputText" type="text" id="report_name" name="report_name" value="{report/report_name}"/>
				</div>
			</div>
			<div class="clearboth fieldLabelContainer" style="padding-top: 10px;">
				<div class="start_float" style="width:50%">
					<div class="fieldLabel fieldLabelMandatory">
						<xsl:value-of select="php:function('lang','Application')"/>
					</div>
					<div class="fieldText">
						<xsl:choose>
							<xsl:when test = "string(/APPSHORE/APP/report/report_id)">
								<input type="hidden" id="table_name" name="table_name" value="{report/table_name}"/>
								<xsl:value-of select="php:functionString('lang',report/app_label)"/>
							</xsl:when>
							<xsl:otherwise >
								<select  class="fieldInputSelect" id="table_name" name="table_name" onchange ="changeTable();">
									<option/>
									<xsl:for-each select = "tables/tables_item">
										<option value="{table_name}">
											<xsl:value-of select="php:functionString('lang',app_label)"/>
										</option>
									</xsl:for-each>
								</select>
							</xsl:otherwise>
						</xsl:choose>	
					</div>
				</div>
				<div class="end_float" style="width:50%">
					<div class="fieldLabel">
						<xsl:value-of select="php:function('lang','Private')"/>
					</div>
					<div class="fieldText">
						<input id="is_private" name="is_private" type="hidden" value="{report/is_private}"/>
						<input class="fieldInputCheckbox" type="checkbox" name="checkbox_is_private" id="checkbox_is_private" onclick="boxchecked(document.report_edit.checkbox_is_private, document.report_edit.is_private);" value="{report/is_private}">
							<xsl:if test="report/is_private = 'Y'">
								<xsl:attribute name="checked"/>
							</xsl:if>
						</input>		
					</div>
				</div>
			</div>			
			<div class="clearboth fieldLabelContainer" style="padding-top: 10px;">
				<div class="fieldLabel">
					<xsl:value-of select="php:function('lang','Fields')"/>
				</div>
				<div class="fieldText">
					<table border="0" width="100%" cellpadding="1" cellspacing="1">
						<tr class="label" align="center">
							<td >
								<xsl:value-of select="php:function('lang','Available fields')"/>
							</td>
							<td >
								<xsl:value-of select="php:function('lang','Select')"/>
							</td>
							<td >
								<xsl:value-of select="php:function('lang','Selected fields')"/>
							</td>
							<td >
								<xsl:value-of select="php:function('lang','Fields order')"/>
							</td>
						</tr>
						<tr class="field" align="center">
							<td style="width:35%">
								<select style='width:100%' size="20" id="fields_available" name="fields_available" multiple="true" >
									<xsl:for-each select = "/APPSHORE/APP/fields_available/fields_available_item" >
										<option value="{field_name}">
											<xsl:value-of select="php:functionString('lang',field_label)"/>
										</option>
									</xsl:for-each>
								</select>
							</td>
							<td style="width:15%" >
								<input type="button" class="formBarButton" style='width:50px' onclick='moveAll(document.report_edit.fields_available, document.report_edit.fields_selected);' value='&#62;&#62;' /><br/><br/><br/> 
								<input type="button" class="formBarButton" style='width:50px' onclick='moveSelected(document.report_edit.fields_available, document.report_edit.fields_selected);' value='&#62;' /><br/><br/><br/> 
								<input type="button" class="formBarButton" style='width:50px' onclick='removeSelected(document.report_edit.fields_selected);' value='&#60;' /><br/><br/><br/>
								<input type="button" class="formBarButton" style='width:50px' onclick='removeAll(document.report_edit.fields_selected);' value='&#60;&#60;' />								
							</td>
							<td style="width:35%" >
								<input name="selectedfields" id="selectedfields" type="hidden" value="{report/selectedfields}"/>
								<select style='width:100%' size="20" id="fields_selected" name="fields_selected" multiple="true" >
									<xsl:for-each select = "report/fields_selected/fields_selected_item" >
										<option value="{field_name}">
											<xsl:value-of select="php:functionString('lang',field_label)"/>
										</option>
									</xsl:for-each>
								</select>
							</td>
							<td style="width:15%" >
								<input type="button" class="formBarButton" style='width:8em' onclick='moveTop(document.report_edit.fields_selected);'>
									<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Top')"/></xsl:attribute>
						   		 </input><br/><br/><br/>
								<input type="button" class="formBarButton" style='width:8em' onclick='moveUp(document.report_edit.fields_selected);'>
									<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Up')"/></xsl:attribute>
						   		 </input><br/><br/><br/>
								<input type="button" class="formBarButton" style='width:8em' onclick='moveDown(document.report_edit.fields_selected);'>
									<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Down')"/></xsl:attribute>
						   		 </input><br/><br/><br/>
								<input type="button" class="formBarButton" style='width:8em' onclick='moveBottom(document.report_edit.fields_selected);'>								
									<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Bottom')"/></xsl:attribute>
				 	       		 </input>
							</td>			
						</tr>
					</table>
				</div>
			</div>
			<div class="clearboth fieldLabelContainer" style="padding-top: 10px;">
				<div class="fieldLabel">
					<xsl:value-of select="php:function('lang','Groups')"/>
				</div>
				<div class="fieldText">
					<table border="0" width="100%" cellpadding="1" cellspacing="1">
						<tr align="center">	
							<td class="label" width="28%">
								<xsl:value-of select="php:function('lang','field')"/>
							</td>
							<td class="label" width="12%">
								<xsl:value-of select="php:function('lang','Group by')"/>
							</td>
							<td class="label" width="12%">
								<xsl:value-of select="php:function('lang','Count')"/>
							</td>
							<td class="label" width="12%">
								<xsl:value-of select="php:function('lang','Sum')"/>
							</td>
							<td class="label" width="12%">
								<xsl:value-of select="php:function('lang','Average')"/>
							</td>
							<td class="label" width="12%">
								<xsl:value-of select="php:function('lang','Minimum')"/>
							</td>
							<td class="label" width="12%">
								<xsl:value-of select="php:function('lang','Maximum')"/>
							</td>
						</tr>															
						<xsl:call-template name="loop_groupby">
							<xsl:with-param name="i">1</xsl:with-param>
							<xsl:with-param name="count">5</xsl:with-param>
						</xsl:call-template>
					</table>
				</div>
			</div>
			<div class="clearboth fieldLabelContainer" style="padding-top: 10px;">
				<div class="fieldLabel">
					<xsl:value-of select="php:function('lang','Static filters')"/>
				</div>
				<div class="fieldText">
					<table border="0" width="100%" cellpadding="1" cellspacing="1">
						<tr align="center">	
							<td class="label" width="30%">
								<xsl:value-of select="php:function('lang','field')"/>
							</td>
							<td class="label" width="30%">
								<xsl:value-of select="php:function('lang','Operation')"/>
							</td>
							<td class="label" width="40%">
								<xsl:value-of select="php:function('lang','Criteria')"/>
							</td>
						</tr>	
						<xsl:call-template name="loop_filter">
							<xsl:with-param name="i">1</xsl:with-param>
							<xsl:with-param name="count">5</xsl:with-param>
							<xsl:with-param name="thisForm">report_edit</xsl:with-param>		
						</xsl:call-template>														
					</table>
				</div>
			</div>
<!--			<div class="fieldContainer">-->
<!--				<div class="fieldLabelMandatory">-->
<!--					<xsl:value-of select="php:function('lang','Dynamic filters')"/>-->
<!--				</div>-->
<!--				<div class="fieldText">-->
<!--					<table border="0" width="100%" cellpadding="1" cellspacing="1">-->
<!--						<tr align="center">	-->
<!--							<td class="label" width="30%"><xsl:value-of select="php:function('lang','field')"/></td>-->
<!--							<td class="label" width="30%"><xsl:value-of select="php:function('lang','Operation')"/></td>-->
<!--							<td class="label" width="40%"><xsl:value-of select="php:function('lang','Criteria')"/></td>-->
<!--						</tr>	-->
<!--						<xsl:call-template name="loop_filter">-->
<!--							<xsl:with-param name="i">1</xsl:with-param>-->
<!--							<xsl:with-param name="count">5</xsl:with-param>-->
<!--							<xsl:with-param name="thisForm">report_edit</xsl:with-param>		-->
<!--						</xsl:call-template>														-->
<!--					</table>-->
<!--				</div>-->
<!--			</div>-->
			<div class="clearboth fieldLabelContainer" style="padding-top: 10px;">
				<div class="fieldLabel">				
					<span class="start_float">			
						<xsl:value-of select="php:function('lang','Note')"/>
					</span>
					<span class="end_float">			
						<a class="fieldAssociatedLink" onclick="insertTimeStamp( document.report_edit.note,'{/APPSHORE/API/current_user/full_name}', true);">
							<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Insert a time stamp in the field')"/></xsl:attribute>
							<img border="0" src="{$api_image_path}/clock_16.png"/>
			   			</a>&#160;
						<a class="fieldAssociatedLink" onclick="if($('note').getHeight()&#60;1000)$('note').style.height = ($('note').getHeight()+200)+'px';">
							<xsl:attribute name="title"><xsl:value-of select="php:function('lang','More lines')"/></xsl:attribute>
							<img border="0" src="{$api_image_path}/plus_16.png"/>
			   			</a>&#160;
						<a class="fieldAssociatedLink" onclick="if($('note').getHeight()&#62;250)$('note').style.height = ($('note').getHeight()-200)+'px';">
							<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Less lines')"/></xsl:attribute>
							<img border="0" src="{$api_image_path}/minus_16.png"/>
			   			</a>
			   		</span>
				</div>
				<div class="fieldText">
					<textarea class="formtextarea" name="note" id="note" style="width:100%;height:10em">
						<xsl:value-of select="report/note"/>
					</textarea>	
				</div>
			</div>
			<div class="clearboth fieldLabelContainer" style="padding-top: 10px;">
				<div class="start_float" style="width:50%">
					<div class="fieldLabel">
						<xsl:value-of select="php:function('lang','Created')"/>
					</div>
					<div class="fieldText">
						<xsl:value-of select="report/created"/>&#160;<xsl:value-of select="php:function('lang','by')"/>&#160;<xsl:value-of select="report/created_by"/>
					</div>
				</div>
				<div class="end_float" style="width:50%">
					<div class="fieldLabel">
						<xsl:value-of select="php:function('lang','Updated')"/>
					</div>
					<div class="fieldText">
						<xsl:value-of select="report/updated"/>&#160;<xsl:value-of select="php:function('lang','by')"/>&#160;<xsl:value-of select="report/updated_by"/>
					</div>
				</div>
			</div>
		</td></tr>
		</table>

	
		<div class="clearboth formBar">
			<xsl:call-template name="builderEditButtons">
				<xsl:with-param name="appName"><xsl:value-of select="$appName"/></xsl:with-param>
				<xsl:with-param name="thisForm">report_edit</xsl:with-param>		
			</xsl:call-template>			
		</div>	
	
	</form>		
</xsl:template>

<xsl:template name="builderEditButtons">
	<xsl:param name="appName"/>
	<xsl:param name="thisForm"/>	
	<xsl:param name="isTop"/>	
    <table cellSpacing="1" cellPadding="1" width="100%" border="0">
		<tr>
			<td class="start_direction">
				<input type="submit" class="formBarButton" name="Save" onclick="report_edit.key.value=this.name">
		            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Save')"/></xsl:attribute>
		        </input>&#160;        	
				<xsl:if test="string(/APPSHORE/APP/report/report_id)">
					<input type="submit" class="formBarButton" name="Duplicate" onclick="report_edit.key.value=this.name">
	                    <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Duplicate')"/></xsl:attribute>
	                </input>&#160;
					<input type="button" class="formBarButton" name="Delete">
	                    <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Delete')"/></xsl:attribute>
			            <xsl:attribute name="onclick">
			            	document.report_edit.key.value=this.name;
			            	confirmAction(document.report_edit,"<xsl:value-of select="/APPSHORE/API/current_user/confirm_delete"/>");
			            </xsl:attribute>
	                </input>&#160;
					<input type="button" class="formBarButton" name="Run">
			            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Run Report')"/></xsl:attribute>
			            <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Run report and display on screen for printing')"/></xsl:attribute>
			            <xsl:attribute name="onclick">
			            	if( notsaved )
			            		popupAlert('Save updates first!');
			            	else 
			            		popupIntra("<xsl:value-of select="$baseurl"/>&amp;preop=builder&amp;op=reports.listing.predefined&amp;out=default&amp;report_id="+document.report_edit.report_id.value+"&amp;_rd="+Math.random(),"<xsl:value-of select="report/report_name"/>");
			            </xsl:attribute>
			        </input>&#160;        	
					<input type="button" class="formBarButton" name="Export" onclick="">
			            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Run Export')"/></xsl:attribute>
			            <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Run report and export as a CSV file')"/></xsl:attribute>
			            <xsl:attribute name="onclick">
			            	if( notsaved )
			            		popupAlert('Save updates first!');
			            	else 
			            		location.href="<xsl:value-of select="$baseurl"/>&amp;preop=builder&amp;op=reports.listing.predefined&amp;out=csv&amp;report_id="+document.report_edit.report_id.value+"&amp;_rd="+Math.random();
			            </xsl:attribute>
			        </input>&#160;        	
				</xsl:if>				
				<input type="submit" class="formBarButton" name="Cancel" onclick="report_edit.key.value=this.name">
		            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Cancel')"/></xsl:attribute>
		        </input>
			</td> 
			<td class="end_direction">					
				<xsl:if test = "users/users_item and $isTop">
	            	<xsl:value-of select="php:function('lang','Assigned to')"/>&#160;
	        		<select name="user_id">
	        			<xsl:for-each select = "/APPSHORE/APP/users/users_item">
       						<option>
	        					<xsl:if test="user_id = /APPSHORE/APP/node()[$appName]/user_id">
        							<xsl:attribute name="selected"/>
	        					</xsl:if>
    							<xsl:attribute name="value"><xsl:value-of select="user_id"/></xsl:attribute>
    							<xsl:value-of select="full_name"/> - <xsl:value-of select="user_name"/>
    						</option>
	        			</xsl:for-each>
	        		</select>
	        	</xsl:if>
			</td>
		</tr>
	</table>				        
</xsl:template>

<xsl:template name="loop_groupby">
	<xsl:param name="i"/>
	<xsl:param name="count"/>
	<xsl:if test="$i &lt;= $count">
		<tr>	
			<td align="left">
				<select class="fieldSelectGroupby" style="width:100%" name="field{$i}" id="field{$i}">
					<xsl:attribute name="onchange">setGroupby('<xsl:value-of select="$i"/>');</xsl:attribute>
						<option/>
					<xsl:for-each select = "report/fields_selected/fields_selected_item">								
						<option value="{field_name}">
							<xsl:if test="field_name = /APPSHORE/APP/report/groupbys/groupbys_item[position()=$i]/field_name">
								<xsl:attribute name="selected" value="'true'"/>
							</xsl:if>
							<xsl:value-of select="php:functionString('lang',field_label)"/>
						</option>
					</xsl:for-each>	
				</select>	
			</td>
			<td align="center" width="12%">
				<xsl:call-template name="groupby_operator">
					<xsl:with-param name="operator">groupby<xsl:value-of select="$i"/></xsl:with-param>
					<xsl:with-param name="operatorValue"><xsl:value-of select="report/groupbys/groupbys_item[position()=$i]/grp"/></xsl:with-param>
				</xsl:call-template>			
			</td>
			<td align="center" width="12%">
				<xsl:call-template name="groupby_operator">
					<xsl:with-param name="operator">count<xsl:value-of select="$i"/></xsl:with-param>
					<xsl:with-param name="operatorValue"><xsl:value-of select="report/groupbys/groupbys_item[position()=$i]/cnt"/></xsl:with-param>
				</xsl:call-template>			
			</td>
			<td align="center" width="12%">
				<xsl:call-template name="groupby_operator">
					<xsl:with-param name="operator">sum<xsl:value-of select="$i"/></xsl:with-param>
					<xsl:with-param name="operatorValue"><xsl:value-of select="report/groupbys/groupbys_item[position()=$i]/sum"/></xsl:with-param>
				</xsl:call-template>			
			</td>
			<td align="center" width="12%">
				<xsl:call-template name="groupby_operator">
					<xsl:with-param name="operator">average<xsl:value-of select="$i"/></xsl:with-param>
					<xsl:with-param name="operatorValue"><xsl:value-of select="report/groupbys/groupbys_item[position()=$i]/avg"/></xsl:with-param>
				</xsl:call-template>			
			</td>
			<td align="center" width="12%">
				<xsl:call-template name="groupby_operator">
					<xsl:with-param name="operator">minimum<xsl:value-of select="$i"/></xsl:with-param>
					<xsl:with-param name="operatorValue"><xsl:value-of select="report/groupbys/groupbys_item[position()=$i]/min"/></xsl:with-param>
				</xsl:call-template>			
			</td>
			<td align="center" width="12%">
				<xsl:call-template name="groupby_operator">
					<xsl:with-param name="operator">maximum<xsl:value-of select="$i"/></xsl:with-param>
					<xsl:with-param name="operatorValue"><xsl:value-of select="report/groupbys/groupbys_item[position()=$i]/max"/></xsl:with-param>
				</xsl:call-template>			
			</td>
		</tr>
	</xsl:if>
	<xsl:if test="$i &lt;= $count">
		<xsl:call-template name="loop_groupby">
			<xsl:with-param name="i"><xsl:value-of select="$i + 1"/></xsl:with-param>
			<xsl:with-param name="count"><xsl:value-of select="$count"/></xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template name="groupby_operator">
	<xsl:param name="operator"/>
	<xsl:param name="operatorValue"/>
	<input type="checkbox" name="{$operator}" id="{$operator}">
		<xsl:attribute name="onclick">checkTheBox(this);</xsl:attribute>
		<xsl:attribute name="value"><xsl:value-of select="$operatorValue"/></xsl:attribute>
		<xsl:if test="$operatorValue = '1' or $operatorValue = 'Y'">					
			<xsl:attribute name="checked"/>
		</xsl:if>
	</input>
</xsl:template>

<xsl:template name="loop_filter">
	<xsl:param name="i"/>
	<xsl:param name="count"/>
	<xsl:param name="thisForm"/>
	<xsl:if test="$i &lt;= $count">
		<tr >	
			<td >		
				<select style="width:100%" id="filter{$i}" name="filter{$i}" onchange="getFilterOperators('{$i}');setFilter('{$i}');">
						<option/>
					<xsl:for-each select = "/APPSHORE/APP/fields_available/fields_available_item">								
						<option value="{field_name}">
							<xsl:if test="field_name = /APPSHORE/APP/report/filters/filters_item[position()=$i]/field_name">
								<xsl:attribute name="selected" value="'true'"/>
							</xsl:if>
							<xsl:value-of select="php:functionString('lang',field_label)"/>
						</option>
					</xsl:for-each>	
				</select>	
			</td>
			<td >
				<select style="width:100%" name="operator{$i}" id="operator{$i}" onchange="showopdiv('{$i}');">
					<xsl:for-each select="/APPSHORE/APP/report/filters/filters_item[position()=$i]/operators/operators_item">								
						<option value="{operator_id}">
							<xsl:if test="operator_id = /APPSHORE/APP/report/filters/filters_item[position()=$i]/operator_id">
								<xsl:attribute name="selected" value="'true'"/>
							</xsl:if>
							<xsl:value-of select="php:functionString('lang',operator_label)"/>
						</option>
					</xsl:for-each>	
				</select>							
			</td>
			<td >
				<input type="hidden" name="field_type{$i}" id="field_type{$i}" value="{/APPSHORE/APP/report/filters/filters_item[position()=$i]/field_type}"/>
				<div style="display:none;" name="divc{$i}" id="divc{$i}">
					<input style="width:80%" autocomplete="off" id="criteria{$i}" name="criteria{$i}" type="text" value="{/APPSHORE/APP/report/filters/filters_item[position()=$i]/criteria}"/>
				</div>	
				<div style="display:none;" name="divl{$i}" id="divl{$i}">
					<div class="auto_complete" id="criteria{$i}_auto_complete" name="criteria{$i}_auto_complete"/>	
				</div>	
				<div style="display:none;" name="divd{$i}" id="divd{$i}">
					<xsl:call-template name="calendar">
						<xsl:with-param name="field">criteria<xsl:value-of select="$i"/></xsl:with-param>
						<xsl:with-param name="label">Date</xsl:with-param>
						<xsl:with-param name="local">false</xsl:with-param>
					</xsl:call-template>
				</div>
				<div style="display:none;" name="divp{$i}" id="divp{$i}">
					<select id="period{$i}" name="period{$i}" onsubmit="$('criteria{$i}').value=this.options[this.selectedIndex].value;">
						<xsl:for-each select="/APPSHORE/APP/periods/periods_item">
							<option value="{period_id}">
								<xsl:if test="period_id = /APPSHORE/APP/report/filters/filters_item[position()=$i]/period_id">
									<xsl:attribute name="selected" value="'true'"/>
								</xsl:if>
								<xsl:value-of select="php:functionString('lang',period_name)"/>
							</option>
						</xsl:for-each>
					</select>
				</div>
				<img class="image" height="1" width="1" onload="setFilter('{$i}');showopdiv('{$i}');" src="{$api_image_path}/spacer.gif"/>
				<xsl:if test="$i &lt; $count">
					<xsl:value-of select="php:function('lang','and')"/>
				</xsl:if>
			</td>
		</tr>
	</xsl:if>
	<xsl:if test="$i &lt;= $count">
		<xsl:call-template name="loop_filter">
			<xsl:with-param name="i"><xsl:value-of select="$i + 1"/></xsl:with-param>
			<xsl:with-param name="count"><xsl:value-of select="$count"/></xsl:with-param>
			<xsl:with-param name="thisForm"><xsl:value-of select="$thisForm"/></xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
