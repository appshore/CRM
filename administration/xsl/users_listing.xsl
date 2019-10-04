<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name="users_listing">

	<form name="users_listing" method="post" >
		<input type="hidden" name="op" value="administration.users_base.search"/>	

	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Users</xsl:with-param>
	</xsl:call-template>

	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr class="label" align="center">
			<td >
				<xsl:value-of select="php:function('lang','Name')"/>
			</td>
			<td>
				<xsl:value-of select="php:function('lang','Title')"/>
			</td>				
			<td>
				<xsl:value-of select="php:function('lang','Email')"/>
			</td>
			<td>
				<xsl:value-of select="php:function('lang','Phone')"/>
			</td>
			<td >
				<xsl:value-of select="php:function('lang','Manager')"/>
			</td>
			<td >
				<xsl:value-of select="php:function('lang','Assistant')"/>
			</td>			
		</tr>
		<xsl:for-each select = "users/users_item">
			<tr class="unselectedtext" onMouseOver="this.className = 'selectedtext'" onMouseOut="this.className = 'unselectedtext'">
			
				<td width="*%">
					<a href="{$baseurl}&amp;op=administration.users_base.view&amp;user_id={user_id}">
						<xsl:value-of select="first_names"/>&#160;<xsl:value-of select="last_name"/>&#160;(<xsl:value-of select="user_name"/>)
					</a>
				</td>				
				<td width="15%" align="center">
					<xsl:value-of select="title"/>
				</td>
				<td width="15%" align="center">
					<xsl:value-of select="email"/>
				</td>
				<td width="15%" align="center">
					<xsl:value-of select="phone"/>
				</td>
				<td width="15%">
					<a href="{$baseurl}&amp;op=administration.users_base.view&amp;user_id={manager_id}">
						<xsl:value-of select="manager_first_names"/>&#160;<xsl:value-of select="manager_last_name"/>
					</a>
				</td>
				<td width="15%">
					<a href="{$baseurl}&amp;op=administration.users_base.view&amp;user_id={assistant_id}">
						<xsl:value-of select="assistant_first_names"/>&#160;<xsl:value-of select="assistant_last_name"/>
					</a>
				</td>					
			</tr>	
		</xsl:for-each>
		</table>

	</form>
</xsl:template>

</xsl:stylesheet>
