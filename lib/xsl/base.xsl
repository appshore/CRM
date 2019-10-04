<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name="calendar">
	<xsl:param name="field"/>
	<xsl:param name="label"/>
	<xsl:param name="time" select="false"/>
	<xsl:param name="local" select="true"/>
	<script src="includes/calendar_date_select/javascript/calendar_date_select.js" type="text/javascript"/>		
	<!-- Language handling -->
	<xsl:if test = "not(/APPSHORE/API/current_user/language_id = 'en-us')">
		<script src="includes/calendar_date_select/javascript/language_{/APPSHORE/API/current_user/language_id}.js" type="text/javascript"/>
	</xsl:if>
	<!-- Time handling -->
	<xsl:choose>
		<xsl:when test = "/APPSHORE/API/current_user/locale_time_id = '%H:%M' or $local = 'false'">
			<script src="includes/calendar_date_select/javascript/format_time_24hr.js" type="text/javascript"/>
		</xsl:when>
		<xsl:otherwise>
			<script src="includes/calendar_date_select/javascript/format_time_12hr.js" type="text/javascript"/>
		</xsl:otherwise>
	</xsl:choose>
	<!-- Date handling -->
	<xsl:choose>
		<xsl:when test = "$local = 'false'">
			<script src="includes/calendar_date_select/javascript/format_ymd_hyphen.js" type="text/javascript"/>
		</xsl:when>
		<xsl:when test = "/APPSHORE/API/current_user/locale_date_id = '%B %e, %Y'">
			<script src="includes/calendar_date_select/javascript/format_BeY_comma.js" type="text/javascript"/>
		</xsl:when>
		<xsl:when test = "/APPSHORE/API/current_user/locale_date_id = '%h %e, %Y'">
			<script src="includes/calendar_date_select/javascript/format_heY_comma.js" type="text/javascript"/>
		</xsl:when>
		<xsl:when test = "/APPSHORE/API/current_user/locale_date_id = '%e %B %Y'">
			<script src="includes/calendar_date_select/javascript/format_eBY_space.js" type="text/javascript"/>
		</xsl:when>
		<xsl:when test = "/APPSHORE/API/current_user/locale_date_id = '%e %h %Y'">
			<script src="includes/calendar_date_select/javascript/format_ehY_space.js" type="text/javascript"/>
		</xsl:when>
		<xsl:when test = "/APPSHORE/API/current_user/locale_date_id = '%d.%m.%Y'">
			<script src="includes/calendar_date_select/javascript/format_dmy_dot.js" type="text/javascript"/>
		</xsl:when>
		<xsl:when test = "/APPSHORE/API/current_user/locale_date_id = '%d/%m/%Y'">
			<script src="includes/calendar_date_select/javascript/format_dmy_slash.js" type="text/javascript"/>
		</xsl:when>
		<xsl:when test = "/APPSHORE/API/current_user/locale_date_id = '%m/%d/%Y'">
			<script src="includes/calendar_date_select/javascript/format_mdy_slash.js" type="text/javascript"/>
		</xsl:when>
		<xsl:otherwise>
			<script src="includes/calendar_date_select/javascript/format_ymd_hyphen.js" type="text/javascript"/>
		</xsl:otherwise>		
	</xsl:choose>			
  	<link rel="stylesheet" href="includes/calendar_date_select/stylesheet/appshore.css" type="text/css" />
    <img class="icon" src="{$api_image_path}/cal.gif">
		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Open a calendar')"/></xsl:attribute>
		<xsl:attribute name="onClick">
			new CalendarDateSelect('<xsl:value-of select="$field" />', {time: '<xsl:value-of select="$time" />'});
		</xsl:attribute>
	</img>
</xsl:template>

<xsl:template name="headerSearchForm">
	<xsl:param name="appLabel"/>
	<div class="clearboth formTitleTags">
		<xsl:value-of select="php:function('lang','Search')"/>&#160;<xsl:value-of select="php:functionString('lang',$appLabel)"/>
	</div>	
</xsl:template>

<xsl:template name="footerSearchForm">
	<xsl:param name="thisForm"/>
		<input type="hidden" name="key" />				
		<input type="submit" class="formBarButton" name="search" onclick="document.{$thisForm}.key.value='Search'">
            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Search')"/></xsl:attribute>
        </input>&#160;
		<input type="submit" class="formBarButton" name="clear" onclick="document.{$thisForm}.key.value='Clear'">
            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Clear')"/></xsl:attribute>
        </input>
</xsl:template>


<xsl:template name="headerListForm">
	<xsl:param name="appLabel"/>
	<xsl:param name="appName"/>	
	<div class="clearboth formTitleTags">
       	<xsl:value-of select="php:functionString('lang',$appLabel)"/>
	</div>	
</xsl:template>


<xsl:template name="checkAllListForm">
	<xsl:param name="thisForm"/>
	<xsl:if test="/APPSHORE/APP/scope > 0 ">   					 		                
		<td style="width:1em" class="label">
			<input type="checkbox" id="select" name="check_all" value="0" onclick="checkTheBox( this, document.{$thisForm});checkAll( this, document.{$thisForm});"/>
		</td>
	</xsl:if>  	
</xsl:template>

<xsl:template name="checkListForm">
	<xsl:param name="thisForm"/>
	<xsl:param name="thisId"/>
	<xsl:param name="scope"/>	
	<xsl:if test="/APPSHORE/APP/scope > 0 "> 	
		<td style="width:1em" class="field">
			<xsl:if test="$scope > 0 "> 		
				<input type="checkbox" id="select" name="{$thisId}" value="0" onclick="checkTheBox(this,document.{$thisForm});isAllChecked(document.{$thisForm}.check_all,document.{$thisForm});" />
			</xsl:if>
		</td>		
	</xsl:if>  		
</xsl:template>


<xsl:template name="callto">
	<xsl:param name="phone"/>
	<a href="callto:{$phone}">
    	<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Click to call this number')"/></xsl:attribute>                    
		<xsl:value-of select="$phone"/>
	</a>
</xsl:template>

<xsl:template name="mailto">
	<xsl:param name="email"/>
	<xsl:param name="name"/>
	<xsl:param name="subject"/>
	<xsl:param name="src"/>
	<xsl:param name="appName"/>
	<xsl:param name="recordIdValue"/>
	<xsl:choose>
		<xsl:when test = "/APPSHORE/API/apps/apps_item[name='webmail']">
	        <xsl:variable name="quote">'</xsl:variable>
			<xsl:variable name="label"><xsl:value-of select="php:function('lang','Webmail')"/></xsl:variable>
			<a href="javascript:void(0);" >
           		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Click to send a webmail')"/></xsl:attribute>                    
           		<xsl:attribute name="onclick">top.popupIntra( '<xsl:value-of select="$baseurl"/>&amp;op=webmail.popup.edit'
           		    <xsl:if test="string-length($appName)">
               			+'&amp;linked_appName=<xsl:value-of select="$appName"/>&amp;linked_recordIdValue=<xsl:value-of select="$recordIdValue"/>'
               		</xsl:if>
           			+'&amp;mail_to='+encodeURIComponent('<xsl:value-of select="translate($name,$quote,'')"/>')
           			+'%20%3C<xsl:value-of select="$email"/>%3E'
           			+'&amp;subject='+encodeURIComponent('<xsl:value-of select="translate($subject,$quote,'')"/>')
           			,'<xsl:value-of select="translate($label,$quote,'')"/>'
           			);
           		</xsl:attribute>                    
				<xsl:choose>
					<xsl:when test = "$src != ''">
						<img class="image" src="{$src}"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$email"/>
					</xsl:otherwise>
				</xsl:choose>			
			</a>		
		</xsl:when>
		<xsl:otherwise>
			<a href="mailto:{$email}">
           		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Click to send an email')"/></xsl:attribute>                    
				<xsl:choose>
					<xsl:when test = "$src != ''">
						<img  class="image" src="{$src}"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$email"/>
					</xsl:otherwise>
				</xsl:choose>			
			</a>
		</xsl:otherwise>
	</xsl:choose>			
</xsl:template>

<xsl:template name="folderLoop">
    <xsl:param name="i"/>
    <xsl:param name="count"/>
    <xsl:if test="$i &lt; $count">
<!--    body of the loop goes here    -->
        &#160;&#160;&#160;&#160;
<!--    end of body of the loop   -->
        <xsl:call-template name="folderLoop">
            <xsl:with-param name="i" select="$i + 1"/>
            <xsl:with-param name="count" select="$count"/>
        </xsl:call-template>
    </xsl:if>
</xsl:template>

<xsl:template name="geoLocation">
	<xsl:param name="full_address"/>
	<xsl:param name="origin_address"/>
	<a class="fieldAssociatedLink" style="line-height:1.5em" onclick="popupInter('http://maps.google.com/maps?q={$full_address}&amp;hl={/APPSHORE/API/current_user/language_id}&amp;output=embed','Google Maps');">
   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Location with Google Maps')"/></xsl:attribute>                    
        <xsl:value-of select="php:function('lang','Location')"/>
    </a>&#160; 						
	<a class="fieldAssociatedLink" style="line-height:1.5em" onclick="popupInter('http://maps.google.com/maps?saddr={$origin_address}&amp;daddr={$full_address}&amp;hl={/APPSHORE/API/current_user/language_id}&amp;output=embed','Google Maps');">
   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Direction from your location to this one with Google Maps')"/></xsl:attribute>                    
        <xsl:value-of select="php:function('lang','Direction from my location')"/>
    </a> 						
</xsl:template>


<xsl:template name="customHeight">
	<xsl:param name="field_height"/>
	<xsl:choose>
	    <xsl:when test="$field_height = '1'">2</xsl:when>			
	    <xsl:when test="$field_height = '2'">4.03</xsl:when>			
	    <xsl:when test="$field_height = '3'">6.1</xsl:when>			
	    <xsl:when test="$field_height = '4'">8.23</xsl:when>			
	    <xsl:when test="$field_height = '5'">10.3</xsl:when>			
	    <xsl:otherwise><xsl:value-of select="$field_height*2"/>.<xsl:value-of select="format-number(-1*(3-$field_height),'0')"/></xsl:otherwise>
	</xsl:choose>		
</xsl:template>

<xsl:template name="buttonsNavigation">
	<xsl:param name="thisForm"/>
	<xsl:param name="isGrid"/>
	<xsl:if test = "recordset/countMax > 1">
		<xsl:if test="not(recordset/currentVal = '0')">
			<input type="submit" class="formBarButtonNav" name="First" onclick="document.{$thisForm}.key.value=this.name;">
		   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','First')"/></xsl:attribute>                    
			    <xsl:attribute name="value">&#171;</xsl:attribute>
			</input>&#160;
			<input type="submit" class="formBarButtonNav" name="Previous" onclick="document.{$thisForm}.key.value=this.name;">
		   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Previous')"/></xsl:attribute>                    
			    <xsl:attribute name="value">&#8249;</xsl:attribute>
			</input>&#160;
		</xsl:if>			
		<xsl:choose>
			<xsl:when test="$isGrid = 'true'">
				<xsl:value-of select="recordset/currentVal+1" />&#160;-&#160;<xsl:value-of select="recordset/first" />&#160;<xsl:value-of select="php:function('lang','of')"/>&#160;<xsl:value-of select="recordset/countMax" />&#160;
				<xsl:if test="not(recordset/first = recordset/countMax)">
					<input type="submit" class="formBarButtonNav" name="Next" onclick="document.{$thisForm}.key.value=this.name;">
				   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Next')"/></xsl:attribute>                    
						<xsl:attribute name="value">&#8250;</xsl:attribute>
					</input>&#160;
					<input type="submit" class="formBarButtonNav" name="Last" onclick="document.{$thisForm}.key.value=this.name;">
				   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Last')"/></xsl:attribute>                    
						<xsl:attribute name="value">&#187;</xsl:attribute>
					</input>
				</xsl:if>
			</xsl:when>			
			<xsl:otherwise>
				<xsl:value-of select="recordset/currentVal+1" />&#160;<xsl:value-of select="php:function('lang','of')"/>&#160;<xsl:value-of select="recordset/countMax" />&#160;
				<xsl:if test="not(recordset/currentVal+1 = recordset/countMax)">
					<input type="submit" class="formBarButtonNav" name="Next" onclick="document.{$thisForm}.key.value=this.name;">
				   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Next')"/></xsl:attribute>                    
						<xsl:attribute name="value">&#8250;</xsl:attribute>
					</input>&#160;
					<input type="submit" class="formBarButtonNav" name="Last" onclick="document.{$thisForm}.key.value=this.name;">
				   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Last')"/></xsl:attribute>                    
						<xsl:attribute name="value">&#187;</xsl:attribute>
					</input>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>		
	</xsl:if> 
</xsl:template>

<xsl:template name="displayTags">
	<xsl:param name="appName"/>
	<xsl:param name="nodeName"/>	
	<xsl:param name="recordIdValue"/>
		
	<xsl:if test = "/APPSHORE/APP/tags/tags_item">
		<script language="JavaScript" type="text/javascript" src="{$lib_js_path}/tags.js"/>		
		<script language='javascript' >
			var tag = new Tags();
		</script>	    
		<div  id="recordTags" style="line-height:2em;vertical-align:middle">
			<xsl:for-each select = "/APPSHORE/APP/tags/tags_item">
				<span class="tagContainer" id="record_tag_{tag_id}">
					<a href="{$baseurl}&amp;op=tags.base.getRecords&amp;tag_id={tag_id}">
				        <xsl:attribute name="title"><xsl:value-of select="php:function('lang','List all records with this tag')"/></xsl:attribute>	            
						<xsl:value-of select="substring(tag_name,1,16)"/>
					</a>&#160;
					<a href="javascript:void(null);" onclick="tag.removeSelected(null,'{tag_id}','{$recordIdValue}');">
				        <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Remove this tag from the record')"/></xsl:attribute>	            
				        <sup style="color:grey">x</sup>
				    </a> 			
		   		</span>&#160;
			</xsl:for-each>		
		</div>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
