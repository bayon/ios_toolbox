
<?php
//CONNECT TO DATABASE
$host = "mysql";       
$user = "bayonforte";                      
$pword = "*************";           
$db = "coredata";             
          
mysql_connect($host,$user,$pword);
echo(mysql_error());



echo('HERE: include a form to admin the questions.{ questions need: id, question, active,order.}');



//-------CONSTANTS---------------
$STANDARDEndStartTag = '" >';
//EQUALS
$equalsStart = ' ="';
$equalsEndBeforeAnotherParameter ='" ';
$equalsEndLastParameter = ' ';
//WRAPPER
$XMLWrapperStartTag = "<AppDrillDown>";
$XMLWrapperEndTag = "</AppDrillDown>";
//MASTER
$masterStartTag = "<master ";
$masterEndTag = "</master>";
$master_id ="master_id";
$a_MasterFields = array('master_id','name');
 //DETAILS
$detailsStartTag="<detail "; 
$detailsEndTag = "</detail>";
$detail_id ="detail_id";
$a_DetailsFields = array('detail_id','master_id','detail_name','master_name');
 //SUBDETAILS
$subdetailsStartTag="<subdetail "; 
$subdetailsEndTag = "</subdetail>";
$subdetail_id ="subdetail_id";
$a_SubdetailsFields = array('subdetail_id','detail_id', 'master_id' , 'subdetail_name','detail_name','master_name');

//-----START WRITING-------------

//GET DATA FROM DATABASE
$tableMaster = "master"; 
$sqlMaster = "SELECT * FROM ".$db.".".$tableMaster." ";
echo('<br>sqlMaster:'.$sqlMaster);
$resMaster = mysql_query($sqlMaster);
 while($rowMaster = mysql_fetch_assoc($resMaster)){
     $dataMaster[] = $rowMaster;
}
 
//WRITE THE XML TO VARIABLE  
$coredataXMLD = $XMLWrapperStartTag;
$countDataMaster = count($dataMaster)  ;
$i = 0;
//Loop Through Entire Data Array
while( $i < $countDataMaster ){
	//echo('<br>i='.$i.'<br>');
	// <MASTER LEVEL>
	$coredataXMLD .= $masterStartTag;
	 $numFields = count($a_MasterFields);
	 $lastParameterNo = $numFields - 1;
	 $j = 0;
	 //Loop Through Array of MasterTable Field Names
	 while($j < $numFields)
	 {
	 	if($j != $lastParameterNo)
	 	{
			$coredataXMLD .= $a_MasterFields[$j].$equalsStart.$dataMaster[$i][$a_MasterFields[$j]].$equalsEndBeforeAnotherParameter;
	 	}else{
	 		$coredataXMLD .= $a_MasterFields[$j].$equalsStart.$dataMaster[$i][$a_MasterFields[$j]].$equalsEndLastParameter;
	 	}
		$j++;
	 }
	$coredataXMLD .= $STANDARDEndStartTag;
	//echo('<br>j='.$j.'<br>');
	// <DETAILS LEVEL>
		//$currentSelection = $i+1;//POINT OF FAILURE
		//echo("IS THIS THE RIGHT ID:".$dataMaster[$i]['master_id']);
		
		$currentSelection = $dataMaster[$i][$master_id];
		$tableDetail = "detail"; 
		$sqlDetails = "SELECT * FROM ".$db.".".$tableDetail." WHERE ".$master_id."=".$currentSelection."";
		echo('<br>sqlDetails:'.$sqlDetails);
		$resDetails = mysql_query($sqlDetails);
		 while($rowDetails = mysql_fetch_assoc($resDetails)){
		     $dataDetails[] = $rowDetails;
		}
		 $coredataXMLD .= $detailsStartTag;
		 	//echo("The count of dataDetails[i] :".count($dataDetails[$i])."<br>");///----->>>
		 	//print_r($dataDetails);
			$numFieldsDetails = count($dataDetails[$i]);///----->>>
			$lastDetailsParameterNo = $numFieldsDetails - 1;
			$d = 0;
			 while($d <= $numFieldsDetails)
				 {
				 	if($d != $lastDetailsParameterNo)
				 	{
						$coredataXMLD .= $a_DetailsFields[$d].$equalsStart.$dataDetails[$i][$a_DetailsFields[$d]].$equalsEndBeforeAnotherParameter;
				 	}else{
				 		$coredataXMLD .= $a_DetailsFields[$d].$equalsStart.$dataDetails[$i][$a_DetailsFields[$d]].$equalsEndLastParameter;
 						$coredataXMLD .= $STANDARDEndStartTag;
						break;
				 	}
					$d++;
				 }
				 //echo('<br>d='.$d.'<br>');
				//<----------------------------------------------------------------------------------------------------------------
				// <SUBDETAILS LEVEL>
					//$currentSelection = $i+1;
					$currentSelection = $dataDetails[$i][$detail_id];
					//echo("<br>Is this the correct id:".$currentSelection);
					$tableSubdetail = "subdetail"; 
					$sqlSubdetails = "SELECT * FROM ".$db.".".$tableSubdetail." WHERE ".$detail_id."=".$currentSelection."";
					echo('<br>sqlSubdetails:'.$sqlSubdetails);
					$resSubdetails = mysql_query($sqlSubdetails);
					 while($rowSubdetails = mysql_fetch_assoc($resSubdetails)){
					     $dataSubdetails[] = $rowSubdetails;
					}
					 $coredataXMLD .= $subdetailsStartTag;
					 	//echo("The count of dataSubdetails[i] :".count($dataSubdetails[$i])."<br>");///----->>>
					 	//print_r($dataSubdetails);
						$numFieldsSubdetails = count($dataSubdetails[$i]);///----->>>
						 $lastSubdetailsParameterNo = $numFieldsSubdetails - 1;
						$s = 0;
						 while($s <= $numFieldsSubdetails)
							 {
							 	if($s != $lastSubdetailsParameterNo)
							 	{
									$coredataXMLD .= $a_SubdetailsFields[$s].$equalsStart.$dataSubdetails[$i][$a_SubdetailsFields[$s]].$equalsEndBeforeAnotherParameter;
							 	}else{
							 		$coredataXMLD .= $a_SubdetailsFields[$s].$equalsStart.$dataSubdetails[$i][$a_SubdetailsFields[$s]].$equalsEndLastParameter;
 									$coredataXMLD .= $STANDARDEndStartTag;
 									break;
							 	}
								$s++;
							 }
							  //echo('<br>s='.$s.'<br>');
							//------->>>>>>    //HERE: drill down farther here if need be.
								
 						// </SUBDETAILS LEVEL>
						$coredataXMLD .= $subdetailsEndTag;
						
				//>----------------------------------------------------------------------------------------------------------------
			// </DETAILS LEVEL>
			$coredataXMLD .= $detailsEndTag;
			
	// </MASTER LEVEL>
	$coredataXMLD .= $masterEndTag;
	$i++;
}
$coredataXMLD .= $XMLWrapperEndTag;
//echo('<pre>');
//echo($coredataXMLD);
//echo('</pre>');
?>
<?php

//WRITE XML TO FILE
//DEFINE WHERE TO WRITE THE FILE
define('BASE_PATH',realpath(dirname(__FILE__)));
//---PC   $filename="C:/Program Files/Apache Software Foundation/Apache2.2/htdocs/00_UTILITIES/XML/test.xml";
//---MAC   $filename="file:///Users/jwiley/Documents/root.xml";
//---FORTEWORKS LIVE
$filename="/XMLMasterDetailsSubdetails.xml";

//VERIFY WORKING
//echo "<p>Writing to ".$filename." ... </p>";

$fp = fopen($filename, "w") or die("Couldn't open $filename");
fwrite($fp, $coredataXMLD); 
fclose($fp);
/*BASIC EXAMPLE
$foo="MasterField";
for($i=1;$i<5;$i++){
	$var = $foo.$i;
	$$var = $foo."_".$i;
}
echo($MasterField1);
echo('<br>');
echo($MasterField2);
echo('<br>');
echo($MasterField3);
echo('<br>');
echo($MasterField4);
echo('<br>');
echo($MasterField5);
echo('<br>');
*/
?>