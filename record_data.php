<?php

function prn($msg) {
            error_log(print_r($msg, true));
}
if(!is_dir("data")){
    //Directory does not exist, so lets create it.
    mkdir("data", 0755);
}
$post_data = json_decode(file_get_contents('php://input'), true);
// the directory "data" must be writable by the server
$name = "data/".$post_data['filename'].".csv";
$data = $post_data['data'];
// // prn($data);
// // write the file to disk
file_put_contents($name, $data);
?>
//
