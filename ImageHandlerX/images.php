<?php
    
    
    /*
     function sendSimpleResponse($status = 200, $body = '', $content_type = 'text/html')
     {
     $status_header = 'HTTP/1.1 ' . $status  ;
     header($status_header);
     header('Content-type: ' . $content_type);
     echo $body;
     }
     
     sendSimpleResponse($status = 200, $body = 'foofoofoo', $content_type = 'text/html');
     
     */
    
    $api = new RestDownloader;
    $api->getParameter();
    //--------------------------------
    function sendSimpleResponse($status = 200, $body = '', $content_type = 'text/html')
    {
        $status_header = 'HTTP/1.1 ' . $status  ;
        header($status_header);
        header('Content-type: ' . $content_type);
        echo $body;
    }
    //---------------------------------- 
    class RestDownloader {
        var $host = 'hostname';
        var $username = 'username';
        var $password = '********';
        function getParameter(){
            if (isset($_POST["method"])  )
            {
                
                
                mysql_connect($this->host, $this->username, $this->password );
                switch ($_POST['method'])
                {
                    case "get_Images":
                        $this->get_Images();
                        break;
                    case "select_Image":
                        $this->select_Image($_POST['image_id']);
                        break;
                    case "download_Image":
                        $this->download_Image($_POST['image_filename']);
                        break;
                        
                    case "get_ALL":
                        $this->get_ALL();
                        
                        break;
                        //----DEFAULT--------     
                    default:
                        $this->returnParameter();
                }
            } 
        }
        function returnParameter(){
            $a_methods = array(
                               'Invalid Request Try:',
                               'another method'
                               );
            $result = json_encode($a_methods);
            sendSimpleResponse(400, $result);
            return false;
        }
        function basic_query($query){
            $res  = mysql_query($query );
            while($row  = mysql_fetch_assoc($res )){
                $data [] = $row ;
            }
            return $data;
        }
    	function get_Images() {
            $sql = 'SELECT * FROM mobile.images';
            $data = $this->basic_query($sql);
            $json_head ='{  "get_Images" : [';
            $json_tail= '] }';
            $result = $json_head.json_encode($data).$json_tail;
            sendSimpleResponse(200, $result);
            return true;
        }
		function select_Image($image_name) {
            $sql = 'SELECT * FROM mobile.images WHERE image_name = ".$image_name."  '  ;
            $data = $this->basic_query($sql);
            $json_head ='{  "select_Image" : [';
            $json_tail= '] }';
            $result = $json_head.json_encode($data).$json_tail;
            sendSimpleResponse(200, $result);
            return true;
        }
        function download_Image($file){
        	//http://stackoverflow.com/questions/5648967/force-download-image
            if (file_exists($file)) {
		        header('Content-Description: File Transfer');
		        header('Content-Type: application/octet-stream');
		        header('Content-Disposition: attachment; filename='.basename($file));
		        header('Content-Transfer-Encoding: binary');
		        header('Expires: 0');
		        header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
		        header('Pragma: public');
		        header('Content-Length: ' . filesize($file));
		        ob_clean();
		        flush();
		        readfile($file);
		        exit;
		    }
            
        }
  		function get_ALL() {
            $sql1 = 'SELECT * FROM mobile.questions';
            $data1 = $this->basic_query($sql1);
            $json_head1 ='{   "get_Questions" : [';
            $json_tail1= ']  ';
            $result = $json_head1.json_encode($data1).$json_tail1;
            //-----------------------
            $sql2 = 'SELECT * FROM mobile.answers';
            $data2 = $this->basic_query($sql2);
            $json_head2 =',   "get_Answers" : [';
            $json_tail2= '] ';
            $result .= $json_head2.json_encode($data2).$json_tail2;
            //=========================
            $json_tailLAST= '  }';
            $result .=$json_tailLAST;
            sendSimpleResponse(200, $result);
            return true;
        }
    }
    
    /*
     Notes:
     //MULTIPLE PARAMETERS: if (isset($_POST["PARAM_1"]) && isset($_POST["PARAM_2"]) && isset($_POST["PARAM_3"])) {
     //SPECIFIC RETURN: $result = array(  "name" => $data [0]['name'], );
     */
    
    ?>