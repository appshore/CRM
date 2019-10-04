<?php
/**
 * *************************************************************************\
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice MICHEL <bmichel@appshore.com>                 *
 * Copyright (C) 2004 Brice MICHEL                                          *
 * -------------------------------------------------------------------------*
 * This program is free software; you can redistribute it and/or modify it  *
 * under the terms of the GNU General Public License as published by the    *
 * Free Software Foundation; either version 2 of the License, or (at your   *
 * option) any later version.                                               *
 * \*************************************************************************
 */

class dashboards_rss 
{
        
    function publish( $urls)
    {
		require_once APPSHORE_INCLUDES.SEP.'simplepie'.SEP.'simplepie.inc';		
        $GLOBALS['appshore']->add_xsl('dashboards.rss');
        
		$feed = new SimplePie();
		$feed->set_feed_url($urls);
		$feed->enable_order_by_date(false);
		$feed->set_cache_location('/tmp');
		$feed->init();

		$result['title'] = $feed->get_title();
		$result['link'] = $feed->get_link();
		$result['permalink'] = $feed->get_permalink();
				
		foreach ($feed->get_items(0, 5) as $item ) 
		{
			$result['items'][] = array(
				'title' 		=> $item->get_title(),
				'link' 			=> $item->get_link(),
				'description'	=> $item->get_description(),
				'date'			=> $item->get_date('j F Y'),
				'datetime'		=> $item->get_date('j F Y g:i a')
				);
		}	
		
        return $result;
    } 
    
    function appshore_blog()
    {
		$urls = array(
			'http://blog.appshore.com/rss.xml'
#			,'http://rss.news.yahoo.com/rss/hotzone'
			);

    	return $this->publish( $urls);
    
    }

    
    function appshore_twitter()
    {
		$urls = array(
			'http://twitter.com/statuses/user_timeline/18700373.rss'
			);

    	$result = $this->publish( $urls);
 
 		foreach ($result['items'] as $key => $val ) 
		{
			$result['items'][$key]['title'] = str_replace('AppShore:', '',  $val['title']);
		}	
   
   		return $result;
   
    }

}
