<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name="forecastsResultsChart">

	<xsl:if test = "count(forecasts/forecasts_item) > 0">
    	<xsl:call-template name="forecastsResultsChartOpportunity"/>					    						
	</xsl:if>

	<xsl:if test = "count(perstage/perstage_item) > 0">
    	<xsl:call-template name="forecastsResultsChartStage"/>					    						
	</xsl:if>

	<xsl:if test = "count(peruser/peruser_item) > 1">
    	<xsl:call-template name="forecastsResultsChartUser"/>					    						
	</xsl:if>

</xsl:template>


<xsl:template name="forecastsResultsChartOpportunity">

	<script type="text/javascript">
		function chartPerOpportunity()
		{
			// collect raw data
			var peropportunity = new Array();
			<xsl:for-each select = "forecasts/forecasts_item">
				peropportunity[<xsl:value-of select="position()-1"/>] = new Array();
				peropportunity[<xsl:value-of select="position()-1"/>][0] = '<xsl:value-of select="opportunity_name"/> - <xsl:value-of select="account_name"/>';    
				peropportunity[<xsl:value-of select="position()-1"/>][1] = parseInt('<xsl:value-of select="expected_amount_int"/>');    
				peropportunity[<xsl:value-of select="position()-1"/>][2] = parseInt('<xsl:value-of select="forecasted_amount_int"/>');    
			</xsl:for-each>

			var data1 = new google.visualization.DataTable();	
		    data1.addColumn('string', '<xsl:value-of select="php:functionString('lang','Opportunities')"/>');
		    data1.addColumn('number', ''<xsl:value-of select="php:functionString('lang','%')"/>'');
		    data1.addRows(peropportunity.length);
		    
			var data2 = new google.visualization.DataTable();
		    data2.addColumn('string', '<xsl:value-of select="php:functionString('lang','Opportunities')"/>');
		    data2.addColumn('number', ''<xsl:value-of select="php:functionString('lang','%')"/>'');
		    data2.addRows(peropportunity.length);

		    for (var i = 0; i  &lt; peropportunity.length; i++) 
		    {
			    data1.setValue(i, 0, peropportunity[i][0]);
			    data1.setValue(i, 1, peropportunity[i][1]); //expected
			    
			    data2.setValue(i, 0, peropportunity[i][0]);
			    data2.setValue(i, 1, peropportunity[i][2]); //forecasted
		    }
		    
		     new google.visualization.PieChart(document.getElementById('per_opportunity_expected')).
		        draw(data1,{title:"<xsl:value-of select="php:functionString('lang','Opportunities')"/> - <xsl:value-of select="php:functionString('lang','Expected amount')"/>"});

		     new google.visualization.PieChart(document.getElementById('per_opportunity_forecasted')).
		        draw(data2,{title:"<xsl:value-of select="php:functionString('lang','Opportunities')"/> - <xsl:value-of select="php:functionString('lang','Forecasted amount')"/>"});
		  }    
		  
		google.setOnLoadCallback(chartPerOpportunity);
	</script>
	
	<div class="clearboth">
		<div class="start_float" id="per_opportunity_expected" style="width:49%;height:300px"/>
		<div class="end_float" id="per_opportunity_forecasted" style="width:49%;height:300px"/>
	</div>
</xsl:template>


<xsl:template name="forecastsResultsChartStage">

	<script type="text/javascript">
		  
		function chartPerStage()
		{
			var perstage = new Array();
			<xsl:for-each select = "perstage/perstage_item">
				perstage[<xsl:value-of select="position()-1"/>] = new Array();
				perstage[<xsl:value-of select="position()-1"/>][0] = '<xsl:value-of select="stage_name"/>';    
				perstage[<xsl:value-of select="position()-1"/>][1] = parseInt('<xsl:value-of select="sum_expected_amount_int"/>');    
				perstage[<xsl:value-of select="position()-1"/>][2] = parseInt('<xsl:value-of select="sum_forecasted_amount_int"/>');    
			</xsl:for-each>

			var data1 = new google.visualization.DataTable();
		    data1.addColumn('string', '<xsl:value-of select="php:functionString('lang','Stages')"/>');
		    data1.addColumn('number', ''<xsl:value-of select="php:functionString('lang','%')"/>'');
		    data1.addRows(perstage.length);

			var data2 = new google.visualization.DataTable();
		    data2.addColumn('string', '<xsl:value-of select="php:functionString('lang','Stages')"/>');
		    data2.addColumn('number', ''<xsl:value-of select="php:functionString('lang','%')"/>'');
		    data2.addRows(perstage.length);
		    
		    for (var i = 0; i  &lt; perstage.length; i++) 
		    {
			    data1.setValue(i, 0, perstage[i][0]);
			    data1.setValue(i, 1, perstage[i][1]);

			    data2.setValue(i, 0, perstage[i][0]);
			    data2.setValue(i, 1, perstage[i][2]);
		    }
		    
		     new google.visualization.PieChart(document.getElementById('perstage_expected')).
		        draw(data1,{title:"<xsl:value-of select="php:functionString('lang','Stages')"/> - <xsl:value-of select="php:functionString('lang','Expected amount')"/>"});
		    
		     new google.visualization.PieChart(document.getElementById('perstage_forecasted')).
		        draw(data2,{title:"<xsl:value-of select="php:functionString('lang','Stages')"/> - <xsl:value-of select="php:functionString('lang','Forecasted amount')"/>"});
		  }    		  
		google.setOnLoadCallback(chartPerStage);
	</script>
	
	<div class="clearboth">
		<div class="start_float" id="perstage_expected" style="width:49%;height:300px"/>
		<div class="end_float" id="perstage_forecasted" style="width:49%;height:300px"/>
	</div>
</xsl:template>

<xsl:template name="forecastsResultsChartUser">

	<script type="text/javascript">
		function chartPerUser()
		{
			var peruser = new Array();
			<xsl:for-each select = "peruser/peruser_item">
				peruser[<xsl:value-of select="position()-1"/>] = new Array();
				peruser[<xsl:value-of select="position()-1"/>][0] = '<xsl:value-of select="full_name"/>';    
				peruser[<xsl:value-of select="position()-1"/>][1] = parseInt('<xsl:value-of select="sum_expected_amount_int"/>');    
				peruser[<xsl:value-of select="position()-1"/>][2] = parseInt('<xsl:value-of select="sum_forecasted_amount_int"/>');    
			</xsl:for-each>


			var data1 = new google.visualization.DataTable();
		    data1.addColumn('string', '<xsl:value-of select="php:functionString('lang','Sales people')"/>');
		    data1.addColumn('number', ''<xsl:value-of select="php:functionString('lang','%')"/>'');
		    data1.addRows(peruser.length);

			var data2 = new google.visualization.DataTable();
		    data2.addColumn('string', '<xsl:value-of select="php:functionString('lang','Sales people')"/>');
		    data2.addColumn('number', ''<xsl:value-of select="php:functionString('lang','%')"/>'');
		    data2.addRows(peruser.length);
		    
		    for (var i = 0; i  &lt; peruser.length; i++) 
		    {
			    data1.setValue(i, 0, peruser[i][0]);
			    data1.setValue(i, 1, peruser[i][1]);

			    data2.setValue(i, 0, peruser[i][0]);
			    data2.setValue(i, 1, peruser[i][2]);
		    }
		    
		     new google.visualization.PieChart(document.getElementById('peruser_expected')).
		        draw(data1,{title:"<xsl:value-of select="php:functionString('lang','Sales people')"/> - <xsl:value-of select="php:functionString('lang','Expected amount')"/>"});
		    
		     new google.visualization.PieChart(document.getElementById('peruser_forecasted')).
		        draw(data2,{title:"<xsl:value-of select="php:functionString('lang','Sales people')"/> - <xsl:value-of select="php:functionString('lang','Forecasted amount')"/>"});
		  }    		  

		google.setOnLoadCallback(chartPerUser);

	</script>
	
	<div class="clearboth">
		<div class="start_float" id="peruser_expected" style="width:49%;height:300px"/>
		<div class="end_float" id="peruser_forecasted" style="width:49%;height:300px"/>
	</div>
</xsl:template>

<xsl:template name="performancesChart">

	<xsl:if test = "count(performances/performances_item) > 0">
    	<xsl:call-template name="performancesChartColumns"/>					    						
	</xsl:if>

</xsl:template>

<xsl:template name="performancesChartColumns">

	<script type="text/javascript">
		function performancesChart()
		{
			var data = new google.visualization.DataTable();
			var persons = new Array();
			var raw_data = new Array();
			<xsl:for-each select = "performances/performances_item">
				persons[<xsl:value-of select="position()-1"/>] = '<xsl:value-of select="full_name"/>';
				raw_data[<xsl:value-of select="position()-1"/>] = new Array();
				raw_data[<xsl:value-of select="position()-1"/>][0] = parseInt('<xsl:value-of select="quota_int"/>');    
				raw_data[<xsl:value-of select="position()-1"/>][1] = parseInt('<xsl:value-of select="sum_expected_amount_int"/>');    
				raw_data[<xsl:value-of select="position()-1"/>][2] = parseInt('<xsl:value-of select="sum_forecasted_amount_int"/>');    
				raw_data[<xsl:value-of select="position()-1"/>][3] = parseInt('<xsl:value-of select="sum_won_amount_int"/>');    
			</xsl:for-each>

		    data.addColumn('string', '<xsl:value-of select="php:functionString('lang','Sales people')"/>');       
			data.addColumn('number', '<xsl:value-of select="php:function('lang','Quota')"/>');    
			data.addColumn('number', '<xsl:value-of select="php:function('lang','Expected amount')"/>');    
			data.addColumn('number', '<xsl:value-of select="php:function('lang','Forecasted amount')"/>');    
			data.addColumn('number', '<xsl:value-of select="php:function('lang','Won amount')"/>');  
		
			data.addRows(persons.length);
		    
		    for (var i = 0; i  &lt; persons.length; i++) 
		    {
				data.setValue(i, 0, persons[i].toString());    
	 			for (var j = 0; j  &lt; 4; j++) 
				{
					data.setValue(i, j+1, raw_data[i][j]);    
				}
		    }

		     new google.visualization.ColumnChart(document.getElementById('performancesChart')).
		        draw(data,{
		        	//title:"<xsl:value-of select="php:functionString('lang','Performance')"/>", 
		        	//hAxis: {title: "<xsl:value-of select="php:functionString('lang','Sales people')"/>"}
		        	}
		        );
		  }    

		  google.setOnLoadCallback(performancesChart);
	</script>
	<div id="performancesChart" style="width:100%;height:400px"/>
</xsl:template>

</xsl:stylesheet>
