<?php
// Tell the browser that this is CSS instead of HTML
header("Content-type: text/css");
require_once "palette.php";

$theme = 'default';

if( isset($palette[$_GET['theme_id']]) )
	$theme = $_GET['theme_id'];
	
if( $_GET['language_direction'] == 'rtl' ) 
{
	$language_direction = 'rtl';	
	$start_direction = 'right';	
	$end_direction = 'left';
}
else 
{
	$language_direction = 'ltr';	
	$start_direction = 'left';	
	$end_direction = 'right';
}

if (preg_match('|MSIE ([0-9].[0-9]{1,2})|',$_SERVER['HTTP_USER_AGENT'],$matched)) 
	$browser='IE';
elseif(preg_match('|Firefox/([0-9\.]+)|',$_SERVER['HTTP_USER_AGENT'],$matched)) 
	$browser='Firefox';
elseif(preg_match('|Safari/([0-9\.]+)|',$_SERVER['HTTP_USER_AGENT'],$matched)) 
	$browser='WebKit';
elseif (preg_match( '|Opera ([0-9].[0-9]{1,2})|',$_SERVER['HTTP_USER_AGENT'],$matched)) 
	$browser='Opera';
else 
	$browser='other';


$fontInc 		= 1;
$fontUnit 		= 'px';
$fontSizeNormal = 13;

$fontSizeSmallest	= ($fontSizeNormal-(2*$fontInc)).$fontUnit;
$fontSizeSmall		= ($fontSizeNormal-(1*$fontInc)).$fontUnit;
$fontSizeNormal 	= $fontSizeNormal.$fontUnit;
$fontSizeLarge 		= ($fontSizeNormal+(1*$fontInc)).$fontUnit;
$fontSizeLargest	= ($fontSizeNormal+(2*$fontInc)).$fontUnit;

?>

.link {
	color: <?= $palette[$theme]['bglink'] ?>;
	text-decoration:none;
	cursor: pointer;
}
.link:hover {
	color: <?= $palette[$theme]['fglink'] ?>;
	text-decoration: underline;
	cursor: pointer;
}
A:link {
	color: <?= $palette[$theme]['bglink'] ?>;
	text-decoration: none;
	cursor: pointer;
}

img {
	vertical-align: middle;
}

.clearboth {
	clear:both;
}

.readonly {
	border-width: 0px;
}

.active  {
	background-color: <?= $palette[$theme]['bgbase'] ?>;
}
A:visited {
	color: <?= $palette[$theme]['bglink'] ?>;
	text-decoration: none;
}
A:hover {
	color: <?= $palette[$theme]['fglink'] ?>;
	text-decoration: underline;
}
A:active {
	color: <?= $palette[$theme]['bglink'] ?>;
	text-decoration: underline;
}
HTML {
	direction: <?= $language_direction ?>;
}
.start_direction {
	text-align: <?= $start_direction ?>;
	/*align: <?= $start_direction ?>;*/
}
.end_direction {
	text-align: <?= $end_direction ?>;
	/*align: <?= $end_direction ?>;*/
}
body {
	background-color: white;
	margin: 0;
}
body, div, input, option, select, td, textarea, .formtextarea {
	font-family: helvetica, arial, sans-serif, verdana; 
	font-size: <?= $fontSizeNormal ?>; 
	font-weight: normal; 
}
HR {
	border: 1px dashed <?= $palette[$theme]['bgform'] ?>;
}

form {
	margin: 0px;
	padding: 0px;
}

select,textarea,input[type=text],input[type=password]  {
	background: white;
	border: thin solid lightgrey;
}

.left_panel {
	vertical-align: top;
	width: 160px;
}
.right_panel {
	vertical-align: top;
	width: <?= ( $browser == 'IE' ) ?'*':'100%'; ?>;
}

.copyright {
	font-size: <?= $fontSizeSmallest ?>;
	color: <?= $palette[$theme]['fgbase'] ?>;
}

.title {
	padding-<?= $end_direction ?>: 5px;
	color: <?= $palette[$theme]['fgbase'] ?>;
	font-weight: bold;
	font-size: <?= $fontSizeLarge ?>; 
}
.boxtitle  {
	color: <?= $palette[$theme]['fglink'] ?>;
	font-weight: bold;
	font-size: <?= $fontSizeLarge ?>;
	padding:0px;
}
.box {
	border: <?= $palette[$theme]['bgtext'] ?> 1px solid;
}
.content {
	color: <?= $palette[$theme]['fgbase'] ?>;
}
.void {
	background-color: <?= $palette[$theme]['bgform'] ?>;
	color: <?= $palette[$theme]['bglink'] ?>;
	border-color: <?= $palette[$theme]['fgbase'] ?>;	
}
.fglink {
	color: <?= $palette[$theme]['fglink'] ?>;
}
.failure {
	color: <?= $palette[$theme]['bgwarn'] ?>;
	font-weight: bold;
}
.success {
	color: <?= $palette[$theme]['fgwarn'] ?>;
	font-weight: bold;
}
.helpmsg {
	background-color: <?= $palette[$theme]['helpmsg'] ?>;
	border:1px solid orange;
	clear:both;
	line-height: 1.5em;
	margin: 0 10px 10px 0;
	padding: 10px;
}
.label {
	padding-left: 3px;
	padding-right: 3px;
	background-color: <?= $palette[$theme]['bgform'] ?>;
}
.mandatory_label {
	padding-left: 3px;
	padding-right: 3px;
	background-color: <?= $palette[$theme]['bgform'] ?>;
	color: <?= $palette[$theme]['bgwarn'] ?>;
}
.unique_label {
	padding-left: 3px;
	padding-right: 3px;
	background-color: <?= $palette[$theme]['bgform'] ?>;
	text-decoration: underline;
}

.unique_mandatory_label {
	padding-left: 3px;
	padding-right: 3px;
	background-color: <?= $palette[$theme]['bgform'] ?>;
	color: <?= $palette[$theme]['bgwarn'] ?>;
	text-decoration: underline;
}

.field {
	padding-left: 3px;
	padding-right: 3px;
	background-color: <?= $palette[$theme]['fgform'] ?>;
}

.readonly_field {
	padding-left: 3px;
	padding-right: 3px;
	border: solid <?= $palette[$theme]['fgform'] ?>;
	background-color: <?= $palette[$theme]['fgform'] ?>;
}


.fieldAssociatedLink {
	color: <?= $palette[$theme]['bglink'] ?>;
	cursor: pointer;	
	font-size: <?= $fontSizeSmallest ?>;
	text-decoration: none;
}

.fieldContainer  {
	margin-right:<?= ( $browser == 'IE' ) ?'5px':'2px'; ?>;
	width: 100%;
}
.fieldDesignBlock  {
	border: 2px dashed lightgray ;
	cursor:move;
	width: 99%;
}
.fieldDesignMode  {
	background-color: <?= $palette[$theme]['bgbase'] ?>;
	cursor: move;
}

.fieldDesignMode:hover {
	border: 1px solid <?= $palette[$theme]['bgform'] ?>;
}

.fieldInputAutoComplete {
	width: 10em;
}

.fieldInputCheckbox {
	margin-left: 0px;
	vertical-align: middle;
}

.fieldInputCurrency {
	width: 10em;
}

.fieldInputDate {
	width: 10em;
}

.fieldInputDateTime {
	width: 13em;
}

.fieldInputEditor {
	width: 100%;
}

.fieldInputEmail {
	width: 80%;
}

.fieldInputFile {
}

.fieldInputLookup {
	width: 85%;
	readonly: true;
}

.fieldInputNumeric {
	width: 10em;
}

.fieldInputPercentage {
	width: 3em;
}

.fieldInputRadio {
	margin-left: 0px;
}

.fieldInputSelect {
	min-width: 5em;
}

.fieldInputSelectMultiple {
	min-width: 5em;
	line-height: 1em;
}

.fieldInputSelectOptionIndent {
	padding-<?= $start_direction ?>: 10px;
}

.fieldInputText {
	width: 90%;
}

.fieldInputTextarea {
	overflow: auto;
	width: 100%;
}

.fieldInputTextareaEmail {
	overflow: auto;
	width: 100%;
}


.fieldInputTime {
	width: 5em;
}

.fieldInputUrl {
	width: 85%;
}

.fieldInputMailto {
	width: 85%;
}


.fieldLabel {
	color: #4E4848;
	font-size: <?= $fontSizeSmall ?>;
}

.fieldLabelContainer  {
	padding-top:5px;
	vertical-align:bottom;
}

.fieldLabelMandatory {
	color: <?= $palette[$theme]['bgwarn'] ?>;
}

.fieldLabelUnique {
	text-decoration: underline;
}

.fieldLabelReadonly {
}

.fieldText {
}

.fieldTextarea {
	background-color: <?= $palette[$theme]['bgbase'] ?>;
	border: 1px solid lightgrey;
	overflow:auto;
	width: 100%;
}

.formBar  {
	background-color: <?= $palette[$theme]['fgform'] ?>;
	font-size: <?= $fontSizeSmall ?>;
	width: 100%;
}
.formBarButton  {
	cursor: pointer;
	font-size: <?= $fontSizeSmall ?>;
}
.formBarButton:hover {
	color: <?= $palette[$theme]['fglink'] ?>;
}
.formBarButtonNav  {
	cursor: pointer;
	font-size: <?= $fontSizeSmall ?>;
	font-weight: bold;
	width: 2em;
}
.formBarButtonNav:hover {
	color: <?= $palette[$theme]['fglink'] ?>;
}
.formBarContent  {
	font-size: <?= $fontSizeSmall ?>;
	padding: 0 2px 0 2px;
}
.formBarSelect  {
	font-size: <?= $fontSizeSmall ?>;
}
.formBlockTitle  {
	border-bottom: 1px solid lightgrey;
	color: <?= $palette[$theme]['fglink'] ?>;
	font-size: <?= $fontSizeLarge ?>;
	font-weight: bold;
	padding-top: 5px;	
}

.formTable  {
	background-color: <?= $palette[$theme]['bgbase'] ?>;
	border-left: 1px solid <?= $palette[$theme]['fgform'] ?>;
	border-right: 1px solid <?= $palette[$theme]['fgform'] ?>;
	padding: 0px 5px 5px 5px;
	width: 100%;	
}

.formTd  {
	width: 100%;
}

.formTdLeft  {
	width: 50%;
	padding-right: 10px;
}

.formTdRight  {
	width: 50%;
}

.formTitle  {
	color: <?= $palette[$theme]['fglink'] ?>;
	font-size: <?= $fontSizeLarge ?>;
	font-weight: bold;
	line-height: 2em;
	padding-right: 5px;	
}

.formTitleTags  {
	color: <?= $palette[$theme]['fglink'] ?>;
	font-size: <?= $fontSizeLarge ?>;
	font-weight: bold;
	line-height: 2em;
}

.formTr  {
	vertical-align: top;
	width: 100%;
}

.verticalMenusBoxHeader {
	font-weight: bold;
}
.verticalMenusBoxContainer {
	padding: 10px 10px 5px 5px;
}
.verticalMenusBoxBody {
	vertical-align: middle;
}
.verticalMenusBoxBodyLine {
	padding-bottom:5px;
}
.verticalMenusBoxBodySubLine {
	padding-top: 5px;
	padding-left: 15px;
}


.popupFormTable  {
	background-color: <?= $palette[$theme]['bgbase'] ?>;
	margin: 0;
	padding: 0;
	width: 100%;	
}

.popuplink {

}

.popuptitle {
	background-color: <?= $palette[$theme]['bgform'] ?>;
	color: <?= $palette[$theme]['fglink'] ?>;
	font-weight: bold;
	height: 2em;
}
.popup {
}

.popupborder  {
	background-color: <?= $palette[$theme]['fgform'] ?>;
	border-top: 2px solid lightgrey ;
	border-left: 2px solid lightgrey ;	
	border-bottom: 2px solid darkgrey ;
	border-right: 2px solid darkgrey ;
}
.popupcontent {
	background-color: <?= $palette[$theme]['bgbase'] ?>;	
}
.popuptext {
	color: <?= $palette[$theme]['fgbase'] ?>;
	background-color: <?= $palette[$theme]['fgform'] ?>;		
}
.popupclose {
	background-color: <?= $palette[$theme]['bgform'] ?>;
	color: <?= $palette[$theme]['bglink'] ?>;
	font-size: <?= $fontSizeLarge ?>;
	cursor: pointer;
}

.linkedFormBar  {
	background-color: <?= $palette[$theme]['fgform'] ?>;
	padding: 0px 2px 0px 2px;
	vertical-align: middle;
}
.linkedFormTitle  {
	color: <?= $palette[$theme]['fglink'] ?>;
	font-size: <?= $fontSizeLarge ?>;
	font-weight: bold;
	padding-right: 5px;	
	padding-top: 10px;
}

.searchResultsCells { 
	border-bottom: lightgrey 1px solid;
	padding:0 5px 0 5px;	
}
.searchResultsCellsDesign { 
	background-color: white;
	border-bottom: lightgrey 1px solid;
	font-style: italic;
	overflow:hidden;
	height:2em;
	width:100px;
	padding-left:2px;	
}
.searchResultsCheckbox {	
	margin:0;
	vertical-align: middle;
}
.searchResultsHeader { 
	background-color: <?= $palette[$theme]['bgform'] ?>;
	font-style: normal;
}
.searchResultsHeaderCells { 
	background-repeat: no-repeat;
	background-position: right center;
	border-bottom: lightgrey 1px solid;
	border-right: white 1px solid;
	padding:0 12px 0 5px;	
	text-align: <?= $start_direction ?>;
}
.searchResultsHeaderIcons { 
	border-bottom: lightgrey 1px solid;
	border-right: white 1px solid;
	text-align: center;
	width: 25px;
}
.searchResultsIcons { 
	border-bottom: lightgrey 1px solid;
	padding:1px 0 2px 0;
	text-align: center;
	width: 25px;
}
.searchResultsSelected {
	background-color: <?= $palette[$theme]['fgform'] ?>; 
}
.searchResultsTable { 
	background-color: <?= $palette[$theme]['bgbase'] ?>;
	border-left: 1px solid <?= $palette[$theme]['fgform'] ?>;
	border-right: 1px solid <?= $palette[$theme]['fgform'] ?>;
	text-align: <?= $start_direction ?>;
	width: 100%;
}

.tagContainer {
	background-color: <?= $palette[$theme]['bgbase'] ?>;
	border: 1px solid lightgrey;
	padding: 2px 1px 2px 3px;
}



/* resizable table */
.resizable { 
}
th {
	border-right: 1px solid lightgrey;
	font-weight: normal;
}
th.resize-handle-active {
	cursor: e-resize;
}
div.resize-handle {
	cursor: e-resize;
	width: 2px;
	border-right: 1px dashed grey;
	position:absolute;
	top:0;
	left:0;
}

.history{
}

/* Default containing element */
.toolset {
	position:   absolute;
	text-align: left;
	z-index:    100;
	margin:     0;
	padding:    0;
	overflow:   visible
}
/* Default inner elements */
.toolset-title {}
.toolset-content {}

/* Default theme */
.toolset.theme-default {
	background: <?= $palette[$theme]['fgform'] ?>;
	border: 1px solid <?= $palette[$theme]['bgform'] ?>;
	padding: 2px 5px 2px 5px;
}
.toolset-title.theme-default {
}
.toolset-content.theme-default {
}

/**
 * IE6 Themes:
 * #toolset.theme-default, #toolsetNr2.theme-default {}
 * #toolset-title.theme-default, #toolsetNr2-title.theme-default {}
 * #toolset-content.theme-default, #toolsetNr2-content.theme-default {}
 **/

.calendarGrid {
	background-color: <?= $palette[$theme]['bgform'] ?>;
}

.calendarBox {
	background-color: <?= $palette[$theme]['fgform'] ?>;
	font-size: <?= $fontSizeSmallest ?>;
    -moz-border-radius:5px; /* for mozilla firefox */ 
    -webkit-border-radius:5px; /* for safari, google chrome */ 	
}

.calendarBoxSelected {
	background-color: <?= $palette[$theme]['expired'] ?>;
	cursor: pointer;
	font-size: <?= $fontSizeSmallest ?>;
}

.calendarBoxTitle {
	background-color: <?= $palette[$theme]['bgform'] ?>;
	font-size: <?= $fontSizeSmallest ?>;
}

.calendarBoxTitleSelected {
	background-color: <?= $palette[$theme]['bgform'] ?>;
	cursor:move;
	font-size: <?= $fontSizeSmallest ?>;
}

.calendarBoxContent {
	font-size: <?= $fontSizeSmallest ?>;
	width:100%;
}

.calendarTime {
	background-color: <?= $palette[$theme]['fgform'] ?>;
	font-size: <?= $fontSizeSmallest ?>;
}

.calendarAllDay {
	background-color: white;
	border-left: lightgrey 3px double;
}

.calendarPeriod {
	background-color: white;
	border-left: lightgrey 3px double;	
	border-top: lightgrey 1px solid;
}

.calendarDay {
	background-color: white;
	border-left: lightgrey 3px double;	
	margin-right: 3px ;	
}

.calendarWeekName {
	font-size: <?= $fontSizeSmallest ?>;
	font-weight: normal;
}

.calendarWeekNumber {
	font-size: <?= $fontSizeSmallest ?>;
	font-weight: normal;
}

.calendarMonth {
	background-color: white;
	border-right:1px lightgrey solid;
	border-bottom:1px lightgrey solid;
}

.calendarMonthSelected {
	background-color: <?= $palette[$theme]['new'] ?>;
	border-right:1px lightgrey solid;
	border-bottom:1px lightgrey solid;
}

.calendars-users {
}

.selectedtextarea {
	background-color: <?= $palette[$theme]['bgform'] ?>;
	border: 0;
}

.textarea {
	background-color: <?= $palette[$theme]['fgform'] ?>;
	border: 0;
}

.image {
	border: 0px;
	margin: 0px;
	vertical-align: middle;
}
.icon {
	border:0;
	cursor: pointer;	
	height:16px;
	margin:1px 3px 1px 1px; 
	vertical-align: middle;
	width:16px;
}
.selectedmenu {
	font-weight: bold;
}
.unselectedmenu {
}

.selectedtext {
	background-color: <?= $palette[$theme]['bgform'] ?>; 
}

.unselectedtext {
	background-color: <?= $palette[$theme]['bgbase'] ?>; 
}

.new {
	background-color: <?= $palette[$theme]['new'] ?>; 
}

.expired {
	background-color: <?= $palette[$theme]['expired'] ?>; 
}

.inprogress {
	background-color: <?= $palette[$theme]['inprogress'] ?>; 
}

.sideboxcontent {
	padding: 5px;
	line-height: 20px;
	background-color: <?= $palette[$theme]['fgform'] ?>;
}

.sideboxtext {
	line-height: 20px;
	color: <?= $palette[$theme]['bgwarn'] ?>;
}

.sideboxtitle  {
	background-color: <?= $palette[$theme]['fgform'] ?>;
	font-weight: bold;
}

.sidebox  {
	border: <?= $palette[$theme]['bgtext'] ?> 1px solid;
}

.normalbox {
	border: <?= $palette[$theme]['fgtext'] ?> 1px solid;
}

.row_on, .th_bright, .bgform {
	background-color: <?= $palette[$theme]['bgform'] ?>;
}

.row_off, .fgform {
	background-color: <?= $palette[$theme]['fgform'] ?>;
}

.tabmenu {
	border-style: solid none none;
	border-width: 1px 0px 0px;
	border-color: <?= $palette[$theme]['fgbase'] ?>;
	padding: 3px;
	height: 20px;
	vertical-align: middle;
}
.tabmenuselected {
	border-style: solid none none;
	border-width: 1px 0px 0px;
	border-color: <?= $palette[$theme]['fgbase'] ?>;
	padding: 3px;
	height: 20px;
	background-color: <?= $palette[$theme]['bgform'] ?>;
	vertical-align: middle;
}

.tabsepselected  {
	background-color: <?= $palette[$theme]['bgform'] ?>;
	height: 20px;
	vertical-align: middle;	
}

.tabsep  {
	background-color: <?= $palette[$theme]['bgbase'] ?>;
	height: 20px;
	vertical-align: middle;
}

.tabsubmenu  {
	padding: 0px;
	background-color: <?= $palette[$theme]['bgform'] ?>;
	border-bottom: 1px solid DarkGray ;
}

.tab {
	border-style: solid;
	border-width: 1px 1px 0px;
	border-color: <?= $palette[$theme]['fgbase'] ?>;
	padding: 4px;
	width: 60px;
}

.tab_active {
	border-style: solid;
	border-width: 1px 1px 0px;
	border-color: <?= $palette[$theme]['fgbase'] ?>;
	padding: 6px;
	width: 60px;
}

.tab_body {
	border-style: solid;
	border-color: <?= $palette[$theme]['fgbase'] ?>;
	border-width: 1px;
}

.verticalBar {
	border-<?= $end_direction ?>: 1px solid <?= $palette[$theme]['fgtext'] ?>;
}

.verticalBarDotted {
	border-<?= $end_direction ?>: 1px dotted <?= $palette[$theme]['fgtext'] ?> ;
}

.verticalmenuselected {
	border: 1px solid <?= $palette[$theme]['fgform'] ?>;
	margin: 3px;
	padding: 3px;	
	background-color: <?= $palette[$theme]['bgform'] ?>;
}

.verticalmenu {
	border: 1px solid <?= $palette[$theme]['fgform'] ?>;
	margin: 3px;
	padding: 3px;	
	background-color: <?= $palette[$theme]['fgform'] ?>; 
}

div.blocks {

}

.custom_is_custom_Y {
	font-style: italic;	
}
.custom_field {
	text-align: <?= $start_direction ?>;
}
.custom_group  {
	clear: both;
	width: 100%;
	min-height: 8em;	
}
.custom_box
{
	border: 1px <?= $palette[$theme]['bgform'] ?>;
	float: <?= $start_direction ?>;						
}
.custom_box_void
{
	border: 1px dotted <?= $palette[$theme]['bgform'] ?>;
}
.custom_box_dotted
{
	border: 1px dotted <?= $palette[$theme]['bgform'] ?>;
	margin: 1px;
	cursor: move;		
	float: <?= $start_direction ?>;
}
.custom_box_dashed
{
	border: 1px dashed <?= $palette[$theme]['bgform'] ?>;
	margin: 1px;
	cursor: move;		
	float: <?= $start_direction ?>;						
}
.custom_label {
	text-align: <?= $start_direction ?>;
}
.custom_is_title_Y {
	color: <?= $palette[$theme]['fglink'] ?>;
	font-weight: bold;
}
.custom_is_mandatory {
	color: <?= $palette[$theme]['bgwarn'] ?>;
}

.searchfield {
	float: <?= $start_direction ?>;
	min-height:50px;
	padding-<?= $end_direction ?>: 10px;
}

.start_float {
	float: <?= $start_direction ?>;
}

.end_float {
	float: <?= $end_direction ?>;
}

.grid_left  {
	padding-left: 3px;
	text-align: <?= $start_direction ?>;  
}
.grid_center  {
	text-align: center;  
}
.grid_right  {
	padding-right: 3px;
	text-align: <?= $end_direction ?>;  
}

.link_hide  {
	color: lightgrey;
}
.link_show  {
}

/* dashlet */
.dashletContainer, .dashletColumn {
}
.dashlet_body {
	background-color: <?= $palette[$theme]['bgbase'] ?>;
	padding: 5px;
}
.dashlet_bodyline {
	padding-bottom:2px;
}
.dashlet_header {
	background-color: <?= $palette[$theme]['fgform'] ?>;
	color: <?= $palette[$theme]['fglink'] ?>;
	cursor: move; 
	padding: 2px 3px 1px 3px;
}
.dashlet_title {
	color: <?= $palette[$theme]['fglink'] ?>;
	font-size: <?= $fontSizeLarge ?>;
	font-weight: bold;
}
.dashlet_button_hide {
	color: grey;
}
.dashlet_button_show {
	color: <?= $palette[$theme]['fglink'] ?>;
	font-weight: bold;
}
.dashlet {
	border-top: 1px solid lightgrey ;
	border-right: 1px solid DarkGray ;
	border-bottom: 1px solid DarkGray ;
	border-left: 1px solid lightgrey ;	
	width: 99%;
	margin: 0 0 15px 0;
	float: <?= $start_direction ?>;
	display: inline;
}
.dashlet_label {
	font-weight: bold;
}

/* panelet */
.panelet_header {
	background-color: <?= $palette[$theme]['fgform'] ?>;
	color: <?= $palette[$theme]['fgtext'] ?>;
	cursor: move; 
	font-size: <?= $fontSizeLarge ?>;
	font-weight: bold;
	width: 100%;
}
.panelet {
	border-top: 1px solid lightgrey ;
	border-left: 1px solid lightgrey ;	
	border-bottom: 1px solid DarkGray ;
	border-right: 1px solid DarkGray ;
	width: 140px;
	margin: 10px 10px 0 5px;
}
.panelet_label {
	font-weight: bold;
}
.panelet_body {
	background-color: <?= $palette[$theme]['bgbase'] ?>;
	padding: 3px 3px 1px 3px;
	vertical-align: middle;
	width: 133px;
}
.panelet_bodyline {
	padding-bottom:2px;
}
.panelet_help {
	background-color: <?= $palette[$theme]['helpmsg'] ?>;
	border:1px solid orange;
	margin: 10px 10px 0 5px;
	padding: 5px;
	text-align:center;
	width: 130px;
}



/* RTE */
.rteImage {
	background-color: <?= $palette[$theme]['bgform'] ?>;
	border: 1px solid <?= $palette[$theme]['bgform'] ?>;
	cursor: pointer;
}
.rteImageRaised, .rteImage:hover {
	background-color: <?= $palette[$theme]['bgform'] ?>;
	border: 1px outset;
	cursor: pointer;
}
.rteImageLowered, .rteImage:active {
	background-color: <?= $palette[$theme]['bgform'] ?>;
	border: 1px inset;
	cursor: pointer;
}
.rteVertSep {
	margin: 0 2px 0 2px;
}
.rteBack {
	background-color: <?= $palette[$theme]['bgform'] ?>;
	border: 1px outset;
	padding: 2px;
}
.rteContent {
	background-color: white;
	border-top: 1px inset lightgrey;
	border-left: 1px inset lightgrey;	
	border-bottom: 0px;
	border-right: 0px;	
}
.rteBack tbody tr td, .rteBack tr td {
	background-color: <?= $palette[$theme]['bgform'] ?>;
	padding: 0;
}
.rteDiv{
	display: block;
	position: relative;
}

.sortcol {
	cursor: pointer;
	background-repeat: no-repeat;
	background-position: right center;
}
.sortasc {
	background-image: url(../images/asc.gif);
	font-weight:bold;
}
.sortdesc {
	background-image: url(../images/desc.gif);
	font-weight:bold;
}
.nosort {
	cursor: default;
}

/* auto complete */
div.auto_complete {
	width: 350px;
	background: #fff;
	z-index: 1000;
}
div.auto_complete ul {
	border: 1px solid #888;
	margin: 0;
	padding: 0;
	width: 100%;
	list-style-type: none;
}
div.auto_complete ul li {
	margin: 0;
	padding: 3px;
}
div.auto_complete ul li.selected { 
	background-color: <?= $palette[$theme]['bgform'] ?>; 
}
div.auto_complete ul strong.highlight { 
	color: #800; 
	margin: 0;
	padding: 0;
}  

/* rounded corner */
b.rounded {
	display: block;
	background: white;
}
b.rounded b {
	display: block;
	height: 1px;
	overflow: hidden;
}
b.r1 {
	margin: 0 5px;
	font-size: 1px;
}
b.r2 {
	margin: 0 3px;
	font-size: 1px;
}
b.r3 {
	margin: 0 2px;
	font-size: 1px;
}
b.rounded b.r4 {
	margin: 0 1px;
	height: 2px;
	font-size: 1px;
}

.overlay_alphacube {
	background-color: #85BBEF;
	filter:alpha(opacity=60);
	-moz-opacity: 0.6;
	opacity: 0.6;
}

.alphacube_nw {
	background: transparent url(alphacube/left-top.gif) no-repeat 0 0;			
  width:10px;
  height:25px;
}

.alphacube_n {
  background: transparent url(alphacube/top-middle.gif) repeat-x 0 0;			
  height:25px;
}

.alphacube_ne {
  background: transparent url(alphacube/right-top.gif) no-repeat 0 0;			
  width:10px;	  
  height:25px;
}

.alphacube_w {
  background: transparent url(alphacube/frame-left.gif) repeat-y top left;			
  width:7px;
}

.alphacube_e {
  background: transparent url(alphacube/frame-right.gif) repeat-y top right;			
  width:7px;	  
}

.alphacube_sw {
  background: transparent url(alphacube/bottom-left-c.gif) no-repeat 0 0;			
  width:7px;
  height:7px;
}

.alphacube_s {
  background: transparent url(alphacube/bottom-middle.gif) repeat-x 0 0;			
  height:7px;
}

.alphacube_se, .alphacube_sizer  {
  background: transparent url(alphacube/bottom-right-c.gif) no-repeat 0 0;			
  width:7px;
  height:7px;
}

.alphacube_sizer {
	cursor:se-resize;	
}

.alphacube_close {
	width: 23px;
	height: 23px;
	background: transparent url(alphacube/button-close-focus.gif) no-repeat 0 0;			
	position:absolute;
	top:0px;
	right:11px;
	cursor:pointer;
	z-index:1000;
}

.alphacube_minimize {
	width: 23px;
	height: 23px;
	background: transparent url(alphacube/button-min-focus.gif) no-repeat 0 0;			
	position:absolute;
	top:0px;
	right:55px;
	cursor:pointer;
	z-index:1000;
}

.alphacube_maximize {
	width: 23px;
	height: 23px;
	background: transparent url(alphacube/button-max-focus.gif) no-repeat 0 0;			
	position:absolute;
	top:0px;
	right:33px;
	cursor:pointer;
	z-index:1000;
}

.alphacube_title {
	float:left;
	height:14px;
	font-size:14px;
	text-align:center;
	margin-top:2px;
	width:100%;
	color:#123456;
}

.alphacube_content {
	overflow:auto;
	color: #000;
	font-family: Tahoma, Arial, sans-serif;
  font: 12px arial;
	background:#FDFDFD;
}

/* For alert/confirm dialog */
.alphacube_window {
	border:1px solid #F00;	
	background: #FFF;
	padding:20px;
	margin-left:auto;
	margin-right:auto;
	width:400px;
}

.alphacube_message {
  font: 12px arial;
	text-align:center;
	width:100%;
	padding-bottom:10px;
}

.alphacube_buttons {
	text-align:center;
	width:100%;
}

.alphacube_buttons input {
	width:20%;
	margin:10px;
}

.alphacube_progress {
	float:left;
	margin:auto;
	text-align:center;
	width:100%;
	height:16px;
	background: #FFF url('alert/progress.gif') no-repeat center center
}

.alphacube_wired_frame {
	background: #FFF;
	filter:alpha(opacity=60);
	-moz-opacity: 0.6;
	opacity: 0.6;	
}

/** Growler **/
div.Growler-notice {
	background-color: 		lightblue;
	color: 					black;
	opacity: 				.60;
	filter: 				alpha(opacity = 60);
	zoom: 					1;
	width: 					95%;
	padding: 				<?= ($browser=='IE')?'5px':'5px'; ?>;
	margin-top: 			3px;
	margin-bottom: 			3px;
	margin-left: 			auto;
	margin-right: 			auto;
	font-size: 				<?= $fontSizeNormal ?>;
	text-align: 			<?= $start_direction ?>;
	display: 				none;
	-moz-border-radius: 	5px;
	-webkit-border-radius:	5px;
}

div.Growler-notice-head {
	font-weight: 			bold;
	font-size:				<?= $fontSizeNormal ?>;
}

div.Growler-notice-exit,div.Growler-notice-exit:hover {
	float: right;
	font-size: <?= $fontSizeNormal ?>;
	color: grey;
	cursor:	pointer;
}

div.Growler-notice-exit:hover {
	color: <?= $palette[$theme]['fglink'] ?>;
	font-weight: bold;
	text-decoration: underline;
}

/* jQuery multiSelect plugin*/

a.multiSelect {
	background: #FFF url(../images/arrow_black_down.gif) right center no-repeat;
	border: solid 1px lightgrey;
	padding: 0px 20px 0px 0px;
	margin-top: <?= ( $browser == 'WebKit' ) ? '2px' : '0px'; ?>;
	position: relative;
	text-decoration: none;
	color: black;
	min-height: <?= ( $browser == 'WebKit' ) ? '21px' : '19px'; ?>;
	display: -moz-inline-stack;
	display: inline-block;
	vertical-align: top;
}

a.multiSelect:link, a.multiSelect:visited, a.multiSelect:hover, a.multiSelect:active {
	color: black;
	text-decoration: none;
}

a.multiSelect span {
	margin: 1px 0px 1px 3px;
	overflow: hidden;
	display: -moz-inline-stack;
	display: inline-block;
	white-space: nowrap;
}

a.multiSelect.hover {
#	background-image: url(images/dropdown.blue.hover.png);
}

a.multiSelect.active, 
a.multiSelect.focus {
	border: solid 1px lightgrey;
}

a.multiSelect.active {
#	background-image: url(images/dropdown.blue.active.png);
}

.multiSelectOptions {
	margin-top: -1px;
	overflow-y: auto;
	overflow-x: hidden;
	border: solid 1px lightgrey;
	background: #FFF;
}

.multiSelectOptions LABEL {
	padding: 0px 2px;
	display: block;
	white-space: nowrap;
}

.multiSelectOptions LABEL.optGroup {
	font-weight: bold;
}

.multiSelectOptions .optGroupContainer LABEL {
	padding-left: 10px;
}

.multiSelectOptions.optGroupHasCheckboxes .optGroupContainer LABEL {
	padding-left: 18px;
}

.multiSelectOptions input{
	vertical-align: middle;
}

.multiSelectOptions LABEL.checked {
	background-color: <?= $palette[$theme]['bgform'] ?>;
}

.multiSelectOptions LABEL.selectAll {
}

.multiSelectOptions LABEL.hover {
	background-color: <?= $palette[$theme]['bgform'] ?>;
}

