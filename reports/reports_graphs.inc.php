<?php
/**
 * *************************************************************************\
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by MF MICHEL <bmichel@appshore.com>                 *
 * Copyright (C) 2004 Brice MICHEL                                          *
 * -------------------------------------------------------------------------*
 * This program is free software; you can redistribute it and/or modify it  *
 * under the terms of the GNU General Public License as published by the    *
 * Free Software Foundation; either version 2 of the License, or (at your   *
 * option) any later version.                                               *
 * \*************************************************************************
 */
function quickGraphs($report,$request,$args)
{
	require_once 'lib/graphs/jpgraph/class.genfile.php';
	$ggf=new graphs_genfile();
	$ggf->fileformat='png';
	
	$periods = array(
				'TO' => 'Today',
				'TW' => 'This week',
				'NW' => 'Next week',
				'LW' => 'Last week',
				'TM' => 'This month',
				'NM' => 'Next month',
				'LM' => 'Last month',
				'TQ' => 'This quarter',
				'NQ' => 'Next quarter',
				'LQ' => 'Last quarter',
				'TY' => 'This year',
				'NY' => 'Next year',
				'LY' => 'Last year'
				);
	$gdatas=getManyAssocArrays($request);
	
	switch ($args['report_id'])
	{
	case '53':
		$ggf->legend_label['xaxis']=array('accounts','Activities','Campaigns','Cases','Contacts','Documents','Leads');
		//Summary of created or updated data by sales
		$li=0;
		for ($i=0; $i<17;$i++)
				$somme[$i]=0;//initialisation, chart_data will contain sum
		foreach($gdatas as $gline => $val )
		{
			$ggf->legend_label[$li]=$val['c0']; //user
			$ggf->rept_plot[$li]['C']=
				array($val['c1'],$val['c3'],$val['c5'],$val['c7'],$val['c9'],$val['c11'],$val['c13']);
			$ggf->rept_plot[$li]['U']=
				array($val['c2'],$val['c4'],$val['c6'],$val['c8'],$val['c10'],$val['c12'],$val['c14']);
			for ($i=1; $i<17;$i++)
				$somme[$i]+=$val['c'.$i];
			$li++;
		}
		$ggf->chart_data['C']=
			array($somme[1],$somme[3],$somme[5],$somme[7],$somme[9],$somme[11],$somme[13]);
		$ggf->chart_data['U']=
			array($somme[2],$somme[4],$somme[6],$somme[8],$somme[10],$somme[12],$somme[14]);


		if ($args['dashboard']=='yes')//smaller size for dashboard
			$ggf->chart_data['scale']=0.6;
		else	$ggf->chart_data['scale']=1.0;
		$ggf->subtitle=$periods[$args['period']];
	
		$param['graph_id']='rept053';
		$param['type']='report';
		$param['request']='shared';
		break;

	case '13': //Activities of the month
		$ggf->title=$report[report_name];
		$li=0;
		foreach($gdatas as $gline => $val )
		{
			$ggf->rept_plot[$li]['Atype']=$val['c6'];
			$ggf->rept_plot[$li]['Acreated']=$val['c7'];
			$ggf->rept_plot[$li]['Alabel']=$val['c0']; //user
			$ggf->rept_plot[$li]['Adate']=$val['c2'];
			$ggf->rept_plot[$li]['Aduration']=$val['c4'];
			$li++;
		}
		$param['graph_id']='rept013';
		$param['type']='report';
		$param['request']='shared';
		break;
	case '14': //Activities of the month
		$ggf->title=$report[report_name];
		$li=0;
		foreach($gdatas as $gline => $val )
		{
			$ggf->rept_plot[$li]['Atype']=$val['c6'];
			$ggf->rept_plot[$li]['Acreated']=$val['c7'];
			$ggf->rept_plot[$li]['Alabel']=$val['c0']; //user
			$ggf->rept_plot[$li]['Adate']=$val['c2'];
			$ggf->rept_plot[$li]['Aduration']=$val['c4'];
			$li++;
		}
		$param['graph_id']='rept014';
		$param['type']='report';
		$param['request']='shared';
		break;
	case '15': //Activities of the month
		$ggf->title=$report[report_name];
		$li=0;
		foreach($gdatas as $gline => $val )
		{
			$ggf->rept_plot[$li]['Atype']=$val['c6'];
			$ggf->rept_plot[$li]['Acreated']=$val['c7'];
			$ggf->rept_plot[$li]['Alabel']=$val['c0']; //user
			$ggf->rept_plot[$li]['Adate']=$val['c2'];
			$ggf->rept_plot[$li]['Aduration']=$val['c4'];
			$li++;
		}
		$param['graph_id']='rept015';
		$param['type']='report';
		$param['request']='shared';

		break;
	}//ENDswitch

// 		print_r($args);print_r('<br/>');
// 		print_r($request);print_r('<br/>');
// 		print_r($report);print_r('<br/>');return;
// 	if ( array_sum($ggf->rept_plot)!=0 ) //otherwise illegal rept plot
// 		{
		$result=$ggf->generate($param);
		$result['fname']=urlencode($result['fname']);
// 		}

 	unset($ggf);
	return $result;
}	

?>
