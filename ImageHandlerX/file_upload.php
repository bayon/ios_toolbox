<?php
    //echo(__FILE__); 
    
    function upload(){
        //$html = "<form id='".$this->form_id."' enctype='multipart/form-data' action='".$this->form_action."' method='POST'>
		$URL = $_SERVER['PHP_SELF'];
		$form_id="form_upload1";
		$page="page";
		$target_path="//Applications//MAMP//htdocs//UTILITY//PHP//FILE//";
		$target_path="";
		//MAXIMUM FILE SIZE IS CURRENTLY SET TO : 300KB !!!
		$html = "<form id='".$form_id."' enctype='multipart/form-data' action='".$URL."' method='POST' >
        <input type='hidden' name='page' value='".$page."'  />
        <input type='hidden' name='function' value='upload' />
        <input type='hidden' name='MAX_FILE_SIZE' value='300000' />
        <div class='row'>
        <div class='item form_label' >Upload A File</div>
        <div class='item'>
        <input name='uploadedfile' type='file' /> 
        <input type='submit' value='upload' />
        </div>
		</div>
		</form>";
        //$html .="<div class='row'>File Upload:</div>";
		//$target_path = $this->target_path;
		$target_path = $target_path . basename( $_FILES['uploadedfile']['name']); 
		
		if(move_uploaded_file($_FILES['uploadedfile']['tmp_name'], $target_path)) {
		    $html .= "<span style='font-size:9px;'>SUCCESS: ".  basename( $_FILES['uploadedfile']['name'])." uploaded.</span>";
			//echo('<br>moved to: '.$target_path);
			saveFileToDB("/path/to/file/".$target_path);
		} else{
		    $html .=  " FAILED TO UPLOAD  ";
			//echo("<br>target_path: ".$target_path); 
		}
		/**/
		//echo("<br>".BASE_URL."<br>".$this->page);
        //echo("HIT FILE UPLOAD");
		return $html;
	}
	
	function saveFileToDB($target_path){
		//echo("<br>Saving filepath..:".$target_path);
		//echo("<br>Saving filename..:".basename($target_path));
		/*
         $filename = basename($target_path);
         $filepath = $targetpath;
         */
		/* * */
		$image_filename = basename($target_path);
		$partsTemp = explode(".",$image_filename);
        
		$image_name  = $partsTemp[0];
		$image_extension  = $partsTemp[1];
		$image_filepath = $targetpath;
		
        
		/*
		 //file_info
         $parts = pathinfo('/var/website/htdocs/index.php');
         echo "<br>dirname:".$parts ['dirname'], "<br />";
         echo "<br>basename:".$parts ['basename'], "<br />";
         $getFileName =$parts ['basename']; $partsTemp = explode(".",$getFileName);
         $filename  = $partsTemp[0];
         echo "<br>filename:".$filename;
         echo "<br>extension:".$parts ['extension'], "<br />";
		 
		 */
		mysql_connect("mysql","bayonforte","ph0rt3w0rk$");
		$sql = "INSERT INTO mobile.images (image_id,image_filename,image_name,image_extension,image_filepath) VALUES ('NULL', '".$image_filename."', '".$image_name."', '".$image_extension."', '".$image_filepath."' ) " ;
		//echo($sql);
		
		mysql_query($sql); 
		//echo(mysql_error()); 
	}
    
	$html = upload();
	echo($html);
	
    ?>