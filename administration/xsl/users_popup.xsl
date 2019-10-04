<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version='1.0'>
<xsl:output indent='yes'/>

<xsl:template match="APP[action/users]">
    <table height="100%" width="100%" cellSpacing="0" cellPadding="0"  border="0" >
		<tr width="100%" valign="top">
			<td >
				<xsl:choose>
					<xsl:when test="action/users = 'search'">
			    		<xsl:call-template name='users_popup_search'/>
			    		<xsl:call-template name='users_popup_list'/>
					</xsl:when>
					<xsl:when test="action/users = 'search3'">
			    		<xsl:call-template name='users_popup_search'/>
			    		<xsl:call-template name='users_popup_list3'/>
					</xsl:when>
					<xsl:when test="action/users = 'details'">
			    		<xsl:call-template name='users_popup_details'/>
					</xsl:when>					
				</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template name='users_popup_search'>

	<form name='user_popup_search' method='post' >
	<input type='hidden' name='op' value='administration.users_popup.searchuser'/>
	<table cellSpacing='1' cellPadding='1' border='0' width='100%' valign='top'>
		<tr align='left'>
			<td >
				<xsl:value-of select="php:function('lang','Last Name')"/>
			</td>
		</tr>
		<tr align='left'>
			<td >
				<input name='last_name' >
					<xsl:attribute name='value'>				
						<xsl:value-of select='/APPSHORE/APP/recordset/last_name' />
					</xsl:attribute>
				</input>
			</td>
		</tr>
	</table>
	<xsl:call-template name="footerSearchForm">
		<xsl:with-param name="thisForm">user_popup_search</xsl:with-param>
	</xsl:call-template>	
	</form>
</xsl:template>

<xsl:template name='users_popup_list'>

	<form name='user_popup_listing' method='post' >
	<input type='hidden' name='op' value='administration.users_popup.searchuser'/>
	<xsl:for-each select = "recordset/node()">	
		<xsl:if test="name()">	
			<input type="hidden" name="{name()}" value="{node()}" />
		</xsl:if>
	</xsl:for-each>	
			
    <table class='boxtitle' cellSpacing='0' cellPadding='0' width='100%' border='0'>
		<tr>
			<td >
				<xsl:value-of select="php:function('lang','Search Result')"/> 
			</td>
			<td align="right">
				<xsl:choose>
					<xsl:when test="recordset/countMax = 0">
						<xsl:value-of select="php:function('lang','No user')"/>&#160;
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="php:function('lang','Users')"/>&#160;<xsl:value-of select="recordset/currentVal+1" />&#160;<xsl:value-of select="php:function('lang','to')"/>&#160;<xsl:value-of select="recordset/first" />&#160;<xsl:value-of select="php:function('lang','of')"/>&#160;<xsl:value-of select="recordset/countMax" />&#160;				
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
	</table>
	<table border='0' cellpadding='1' cellspacing='1' width='100%' >
		<tr class="label" align='left' >
			<td>
				<a href="javascript: orderby(document.user_popup_listing, 'first_names');">
					<xsl:value-of select="php:function('lang','First name')"/>				
				</a>
			</td>
			<td>
				<a href="javascript: orderby(document.user_popup_listing, 'last_name');">
					<xsl:value-of select="php:function('lang','Last name')"/>				
				</a>
			</td>			
			<td>
				<a href="javascript: orderby(document.user_popup_listing, 'title');">
					<xsl:value-of select="php:function('lang','Title')"/>				
				</a>
			</td>
		</tr>
		<xsl:for-each select = 'users/users_item'>
			<tr  class="unselectedtext" onMouseOver='this.className ="selectedtext"' onMouseOut='this.className = "unselectedtext"'>
				<td width="*">
					<a href='javascript:passBackTuple("{first_names}"+" "+"{last_name}","{user_id}");popupClose();'>
						<xsl:value-of select="first_names"/>
					</a>
				</td>
				<td width="*">
					<a href='javascript:passBackTuple("{first_names}"+" "+"{last_name}","{user_id}");popupClose();'>
						<xsl:value-of select="last_name"/>
					</a>
				</td>				
				<td width="*">
					<xsl:value-of select="title"/>
				</td>
			</tr>	
		</xsl:for-each>
	</table>
	<xsl:call-template name="footerPopupList">
		<xsl:with-param name="thisForm">user_popup_listing</xsl:with-param>
	</xsl:call-template> 					
	&#160;			
	<input type='button' class="formBarButton" onclick='passBackTuple("","0");popupClose();'>                        
		<xsl:attribute name="value">
        	<xsl:value-of select="php:function('lang','Clear')"/>
        </xsl:attribute>
    </input>&#160;						
	<input type='button' class="formBarButton" onclick='popupClose();'>
        <xsl:attribute name="value">
            <xsl:value-of select="php:function('lang','Cancel')"/>
        </xsl:attribute>
    </input>				
	</form>
</xsl:template>


<xsl:template name='users_popup_list3'>

<script LANGUAGE="JavaScript" >
<![CDATA[
function passBackUser( activity_id, attendee_id)
{
	top.document.attendees_list.activity_id.value = activity_id;
	top.document.attendees_list.attendee_id.value = attendee_id;
	top.document.attendees_list.jskey.value = 'SaveUser';
    top.document.attendees_list.submit();
    popupClose();
}
]]>

</script>

	<form name='user_popup_listing3' method='post'>
		<input type='hidden' name='op' value='activities.attendees.searchUser'/>
		<input type="hidden" name="level" >
			<xsl:attribute name="value"><xsl:value-of select="recordset/level" /></xsl:attribute>
		</input>
		<input type="hidden" name="currentVal">
			<xsl:attribute name="value"><xsl:value-of select="recordset/currentVal" /></xsl:attribute>
		</input>
		<input type="hidden" name="countMax">
			<xsl:attribute name="value"><xsl:value-of select="recordset/countMax" /></xsl:attribute>
		</input>
		<input type="hidden" name="first">
			<xsl:attribute name="value"><xsl:value-of select="recordset/first" /></xsl:attribute>
		</input>
		<input type="hidden" name="orderby">
			<xsl:attribute name="value"><xsl:value-of select="recordset/orderby" /></xsl:attribute>
		</input>
		<input type="hidden" name="ascdesc">
			<xsl:attribute name="value"><xsl:value-of select="recordset/ascdesc" /></xsl:attribute>
		</input>
		<input type="hidden" name="last_name">
			<xsl:attribute name="value"><xsl:value-of select="recordset/last_name" /></xsl:attribute>
		</input>
		<input type="hidden" name="title">
			<xsl:attribute name="value"><xsl:value-of select="recordset/title" /></xsl:attribute>
		</input>
		<input type="hidden" name="activity_id">
            <xsl:attribute name="value"><xsl:value-of select="recordset/activity_id" /></xsl:attribute>
        </input>
		<input type="hidden" name="user_id">
            <xsl:attribute name="value"><xsl:value-of select="recordset/user_id" /></xsl:attribute>
        </input>

    <xsl:call-template name="headerListForm">
	    <xsl:with-param name="appLabel"><xsl:value-of select="php:function('lang','Users')"/></xsl:with-param>
    </xsl:call-template>

	<table border='0' cellpadding='1' cellspacing='1' width='100%'>
		<tr class="label" align='left' >
			<td>
				<a href="javascript: orderby(document.user_popup_listing, 'first_names');">
					<xsl:value-of select="php:function('lang','First name')"/>
				</a>
			</td>
			<td>
				<a href="javascript: orderby(document.user_popup_listing, 'last_name');">
					<xsl:value-of select="php:function('lang','Last name')"/>
				</a>
			</td>			
			<td>
				<a href="javascript: orderby(document.user_popup_listing, 'title');">
					<xsl:value-of select="php:function('lang','Title')"/>
				</a>
			</td>
		</tr>
		<xsl:for-each select = 'users/users_item'>
			<tr  class="unselectedtext" onMouseOver='this.className ="selectedtext"' onMouseOut='this.className = "unselectedtext"'>
				<td width="*">
					<a href='javascript:passBackUser("{/APPSHORE/APP/recordset/activity_id}","{user_id}");'>
						<xsl:value-of select="first_names"/>
					</a>
				</td>
				<td width="*">
					<a href='javascript:passBackUser("{/APPSHORE/APP/recordset/activity_id}","{user_id}");'>
						<xsl:value-of select="last_name"/>
					</a>
				</td>				
				<td width="*">
					<xsl:value-of select="title"/>
				</td>
			</tr>
		</xsl:for-each>
	</table>
	<xsl:call-template name="footerPopupList">
		<xsl:with-param name="thisForm">user_popup_listing3</xsl:with-param>
	</xsl:call-template> 					
	&#160;
	<input type='button' class="formBarButton" onclick='popupClose();'>
        <xsl:attribute name="value">
            <xsl:value-of select="php:function('lang','Cancel')"/>
        </xsl:attribute>
    </input>
	</form>
</xsl:template>

<xsl:template name="users_popup_details">
	<table border="0" width="100%" height="80px" cellpadding="1" cellspacing="1">
		<tr>
			<td class="label" align="right"><xsl:value-of select="php:function('lang','Email')"/>:</td>
			<td align="left" class="field">
				<a href="mailto:{user/email}">
					<xsl:value-of select="user/email"/>
				</a>				
			</td>
		</tr>
		<tr>
			<td class="label" align="right" width="30%"><xsl:value-of select="php:function('lang','Mobile')"/>:</td>
			<td align="left" class="field" width="*%"><xsl:value-of select="user/mobile"/></td>
		</tr>			
		<tr>
			<td class="label" align="right" width="30%"><xsl:value-of select="php:function('lang','Fax')"/>:</td>
			<td align="left" class="field" width="*%"><xsl:value-of select="user/fax"/></td>
		</tr>							
		<tr>
			<td class="label" align="right" width="30%"><xsl:value-of select="php:function('lang','Manager')"/>:</td>
			<td align="left" class="field"  >
				<a href="{$baseurl}&amp;op=administration.users_base.view&amp;user_id={user/manager_id}" target="_top">
					<xsl:value-of select="user/manager_first_names"/>&#160;<xsl:value-of select="user/manager_last_name" />
				</a>
			</td>
		</tr>
	</table>
</xsl:template>


</xsl:stylesheet>
