<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>


<xsl:template name="capture">
	<div class="formTitleTags start_float">
		<xsl:value-of select="php:function('lang','Capture Leads')"/>
	</div>
	
	<div class="helpmsg">
		<xsl:value-of disable-output-escaping="yes" select="php:function('lang','leads.capture.help')"/>
	</div>

	<div style="width:99%;clear:both;padding-top:10px">		
<textarea style="height:40em;width:100%;line-height:1em" wrap="off" readonly="true">
&lt;HTML&gt;
&lt;HEAD&gt;
&lt;TITLE&gt;AppShore Lead Capture&lt;/TITLE&gt;
&lt;BODY&gt;

&lt;!-- Some fields can be suppressed but the field names and field types must remain intact to match AppShore fields --&gt;
&lt;!-- Lead will be created under your AppShore Main Contact profile --&gt;

&lt;!-- DO NOT MODIFY: this line is linked to your dedicated AppShore environment --&gt;
&lt;form name="appshore_leads" method="post" action="<xsl:value-of select="/APPSHORE/API/basepath"/>/leads/capture.php"&gt;

&lt;!-- Set value (yes or no) to receive an email alert for each new lead --&gt;
&lt;!-- Email will be sent to user defined as AppShore Main Contact --&gt;
&lt;!-- Example: &lt;input name="emailAlert" type="hidden" value="yes"/&gt; --&gt;
&lt;input name="emailAlert" type="hidden" value=""/&gt;		

&lt;!-- Set value to indicate the email address of the recipient--&gt;
&lt;!-- Default email address is AppShore Main Contact if undefined--&gt;
&lt;!-- Example: &lt;input name="emailTo" type="hidden" value="valid@email_address"/&gt; --&gt;
&lt;input name="emailTo" type="hidden" value=""/&gt;			

&lt;!-- Set value to indicate the origin of the lead --&gt;
&lt;!-- This value will appear in the email subject --&gt;
&lt;!-- Example: &lt;input name="leadFrom" type="hidden" value="a_short_text"/&gt; --&gt;
&lt;input name="leadFrom" type="hidden" value=""/&gt;	

&lt;!-- MANDATORY: Set value with the complete returning url of your web site when the form is successfully submitted --&gt;
&lt;!-- Example: &lt;input name="urlSuccess" type="hidden" value="http://www.my_company.com/capture_leads/success.html"/&gt; --&gt;
&lt;input name="urlSuccess" type="hidden" value=""/&gt;

&lt;!-- MANDATORY: Set value with the complete returning url of your web site when the form is unsuccessfully submitted  --&gt;
&lt;!-- Example: &lt;input name="urlError" type="hidden" value="http://www.my_company.com/capture_leads/error.html"/&gt; --&gt;
&lt;input name="urlError" type="hidden" value=""/&gt;

&lt;table&gt;	
	&lt;tr&gt;		
		&lt;td width="30%" align="right"&gt;Salutation:&lt;/td&gt;
		&lt;td align="left"&gt;&lt;input size="10" name="salutation" type="text"/&gt;&lt;/td&gt;
	&lt;/tr&gt;
	&lt;tr&gt;
		&lt;td width="30%" align="right"&gt;First Name:&lt;/td&gt;
		&lt;td align="left"&gt;&lt;input size="25" name="first_names" type="text"/&gt;&lt;/td&gt;
	&lt;/tr&gt;
	&lt;tr&gt;
		&lt;td width="30%" align="right"&gt;Last Name:&lt;/td&gt;
		&lt;td align="left"&gt;&lt;input size="30" name="last_name" type="text"/&gt;&lt;/td&gt;
	&lt;/tr&gt;
	&lt;tr&gt;		
		&lt;td width="30%" align="right"&gt;Title:&lt;/td&gt;
		&lt;td align="left"&gt;&lt;input size="30" name="title" type="text"/&gt;&lt;/td&gt;
	&lt;/tr&gt;
	&lt;tr&gt;
		&lt;td width="30%" align="right"&gt;Company:&lt;/td&gt;
		&lt;td align="left"&gt;&lt;input size="35" name="account_name" type="text"/&gt;&lt;/td&gt;
	&lt;/tr&gt;
	&lt;tr&gt;
		&lt;td width="30%" align="right"&gt;Phone:&lt;/td&gt;
		&lt;td align="left"&gt;&lt;input size="20" name="phone" type="text"/&gt;&lt;/td&gt;
	&lt;/tr&gt;
	&lt;tr&gt;
		&lt;td width="30%" align="right"&gt;Do Not Call:&lt;/td&gt;
		&lt;td align="left"&gt;&lt;input name="do_not_call" type="checkbox"/&gt;&lt;/td&gt;
	&lt;/tr&gt;
	&lt;tr&gt;
		&lt;td width="30%" align="right"&gt;Email:&lt;/td&gt;
		&lt;td align="left"&gt;&lt;input size="30" name="email" type="text"/&gt;&lt;/td&gt;
	&lt;/tr&gt;
	&lt;tr&gt;
		&lt;td width="30%" align="right"&gt;Email Opt Out:&lt;/td&gt;
		&lt;td align="left"&gt;&lt;input name="email_opt_out" type="checkbox"/&gt;&lt;/td&gt;
	&lt;/tr&gt;
	&lt;tr&gt;
		&lt;td width="30%" align="right"&gt;Mobile:&lt;/td&gt;
		&lt;td align="left"&gt;&lt;input size="20" name="mobile" type="text"/&gt;&lt;/td&gt;
	&lt;/tr&gt;
	&lt;tr&gt;
		&lt;td width="30%" align="right"&gt;Fax:&lt;/td&gt;
		&lt;td align="left"&gt;&lt;input size="20" name="fax" type="text"/&gt;&lt;/td&gt;
	&lt;/tr&gt;
	&lt;tr&gt;
		&lt;td width="30%" align="right"&gt;Source:&lt;/td&gt;
		&lt;td align="left"&gt;
			&lt;!-- You can change the text or suppress some lines of this popdown list --&gt;		
			&lt;!-- but it will remain unchanged on the AppShore environment  --&gt;		
			&lt;select name="source_id"&gt;
				&lt;option&gt;&lt;/option&gt;
				&lt;option value="2"&gt;Advertisement&lt;/option&gt;
				&lt;option value="11"&gt;Cold calling&lt;/option&gt;
				&lt;option value="3"&gt;Direct Mail&lt;/option&gt;
				&lt;option value="1"&gt;Other&lt;/option&gt;
				&lt;option value="4"&gt;Radio&lt;/option&gt;
				&lt;option value="5"&gt;Search Engine&lt;/option&gt;
				&lt;option value="6"&gt;Seminar&lt;/option&gt;
				&lt;option value="7"&gt;Telemarketing&lt;/option&gt;
				&lt;option value="8"&gt;Trade Show&lt;/option&gt;
				&lt;option value="9"&gt;Web Site&lt;/option&gt;
				&lt;option value="10"&gt;Word of Mouth&lt;/option&gt;
			&lt;/select&gt;
		&lt;/td&gt;
	&lt;/tr&gt;
	&lt;tr&gt;
		&lt;td width="30%" align="right"&gt;Web Site:&lt;/td&gt;
		&lt;td align="left"&gt;http://&lt;input size="25" name="url" type="text"/&gt;&lt;/td&gt;
	&lt;/tr&gt;
	&lt;tr&gt;
		&lt;td width="30%" align="right"&gt;Rating:&lt;/td&gt;
		&lt;td align="left"&gt;
			&lt;!-- You can change the text or suppress some lines of this popdown list --&gt;		
			&lt;!-- but it will remain unchanged on the AppShore environment  --&gt;		
			&lt;select name="rating_id"&gt;
				&lt;option&gt;&lt;/option&gt;
				&lt;option value="1"&gt;Unknown&lt;/option&gt;
				&lt;option value="2"&gt;Avoid&lt;/option&gt;
				&lt;option value="3"&gt;Poor&lt;/option&gt;
				&lt;option value="4"&gt;Fair&lt;/option&gt;
				&lt;option value="5"&gt;Good&lt;/option&gt;
				&lt;option value="6"&gt;Excellent&lt;/option&gt;
			&lt;/select&gt;
		&lt;/td&gt;
	&lt;/tr&gt;
	&lt;tr&gt;
		&lt;td width="30%" align="right"&gt;Industry:&lt;/td&gt;
		&lt;td align="left"&gt;
			&lt;!-- You can change the text or suppress some lines of this popdown list --&gt;		
			&lt;!-- but it will remain unchanged on the AppShore environment  --&gt;		
			&lt;select name="industry_id"&gt;
				&lt;option&gt;&lt;/option&gt;
				&lt;option value="2"&gt;Advertising&lt;/option&gt;
				&lt;option value="3"&gt;Architecture&lt;/option&gt;
				&lt;option value="4"&gt;Chemicals&lt;/option&gt;
				&lt;option value="5"&gt;Communications&lt;/option&gt;
				&lt;option value="6"&gt;Computers&lt;/option&gt;
				&lt;option value="7"&gt;Construction&lt;/option&gt;
				&lt;option value="8"&gt;Consulting&lt;/option&gt;
				&lt;option value="9"&gt;Distribution&lt;/option&gt;
				&lt;option value="10"&gt;Education&lt;/option&gt;
				&lt;option value="11"&gt;Finance&lt;/option&gt;
				&lt;option value="12"&gt;Government&lt;/option&gt;
				&lt;option value="13"&gt;Healthcare&lt;/option&gt;
				&lt;option value="14"&gt;Insurance&lt;/option&gt;
				&lt;option value="15"&gt;Legal&lt;/option&gt;
				&lt;option value="16"&gt;Manufacturing&lt;/option&gt;
				&lt;option value="17"&gt;Non-Profit&lt;/option&gt;
				&lt;option value="1"&gt;Other&lt;/option&gt;
				&lt;option value="18"&gt;Real Estate&lt;/option&gt;
				&lt;option value="19"&gt;Restaurant&lt;/option&gt;
				&lt;option value="20"&gt;Retail&lt;/option&gt;
			&lt;/select&gt;
		&lt;/td&gt;
	&lt;/tr&gt;
	&lt;tr&gt;
		&lt;td width="30%" align="right"&gt;Type:&lt;/td&gt;
		&lt;td align="left"&gt;
			&lt;!-- You can change the text or suppress some lines of this popdown list --&gt;		
			&lt;!-- but it will remain unchanged on the AppShore environment  --&gt;		
			&lt;select name="status_id"&gt;
				&lt;option&gt;&lt;/option&gt;
				&lt;option value="1"&gt;Lead&lt;/option&gt;
				&lt;option value="2"&gt;Prospect&lt;/option&gt;
				&lt;option value="3"&gt;Customer&lt;/option&gt;
				&lt;option value="4"&gt;Closed&lt;/option&gt;
				&lt;option value="5"&gt;Partner&lt;/option&gt;
				&lt;option value="6"&gt;Supplier&lt;/option&gt;
				&lt;option value="7"&gt;Competitor&lt;/option&gt;
			&lt;/select&gt;
		&lt;/td&gt;
	&lt;/tr&gt;
	&lt;tr&gt;
		&lt;td width="30%" align="right"&gt;Employees:&lt;/td&gt;
		&lt;td align="left"&gt;&lt;input size="7" name="employees" type="text"/&gt;&lt;/td&gt;
	&lt;/tr&gt;
	&lt;tr&gt;
		&lt;td width="30%" align="right"&gt;Revenue:&lt;/td&gt;
		&lt;td align="left"&gt;&lt;input size="15" name="revenue" type="text"/&gt;&lt;/td&gt;
	&lt;/tr&gt;
	&lt;tr&gt;
		&lt;td width="30%" align="right"&gt;Primary address:&lt;/td&gt;
		&lt;td align="left"&gt;&lt;textarea class="formtextarea" rows="2" cols="25" name="address_1"&gt;&lt;/textarea&gt;&lt;/td&gt;
	&lt;/tr&gt;
	&lt;tr&gt;
		&lt;td width="30%" align="right"&gt;City:&lt;/td&gt;
		&lt;td align="left"&gt;&lt;input size="25" name="city_1" type="text"/&gt;&lt;/td&gt;
	&lt;/tr&gt;
	&lt;tr&gt;
		&lt;td width="30%" align="right"&gt;State:&lt;/td&gt;
		&lt;td align="left"&gt;&lt;input size="25" name="state_1" type="text"/&gt;&lt;/td&gt;
	&lt;/tr&gt;
	&lt;tr&gt;
		&lt;td width="30%" align="right"&gt;Zip code:&lt;/td&gt;
		&lt;td align="left"&gt;&lt;input size="10" name="zipcode_1" type="text"/&gt;&lt;/td&gt;
	&lt;/tr&gt;
	&lt;tr&gt;
		&lt;td width="30%" align="right"&gt;Country:&lt;/td&gt;
		&lt;td align="left"&gt;&lt;input size="25" name="country_1" type="text"/&gt;&lt;/td&gt;
	&lt;/tr&gt;
	&lt;tr&gt;
		&lt;td width="30%" align="right"&gt;Note:&lt;/td&gt;
		&lt;td align="left"&gt;&lt;textarea class="formtextarea" cols="75" rows="3" name="note"&gt;&lt;/textarea&gt;&lt;/td&gt;
	&lt;/tr&gt;
	&lt;tr&gt;
		&lt;td width="30%" align="right"&gt;&lt;/td&gt;
		&lt;!-- MANDATORY: used to validate the form --&gt;		
		&lt;td align="left"&gt;&lt;input name="submit" value="Submit" type="submit"/&gt;&lt;/td&gt;
	&lt;/tr&gt;
&lt;/table&gt;
&lt;/form&gt;	
&lt;/BODY&gt;
&lt;/HTML&gt;
</textarea>		
</div>
</xsl:template>


</xsl:stylesheet>
