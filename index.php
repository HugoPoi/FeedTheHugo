<?php
require 'vendor/autoload.php';

$app = new \Slim\Slim(array(
  'debug' => true,
  'log.enabled' => true,
  'log.level' => \Slim\Log::WARN,
  'mode' => 'development',
  'templates.path' => 'templates'
));

$app->post('/', function () {
  global $app;
  file_put_contents('cache.json', $app->request()->getBody());
  echo "OK";
});

$app->get('/', function () {
  global $app;
  $itemStock = json_decode(file_get_contents('cache.json'),true);
  arsort($itemStock);
  $app->render('home.php',array(
    "title" => "Stock dispo chez Hugo :-)",
    "apptitle" => "Stock dispo chez Hugo :-)",
    "AEdata" => $itemStock,
    "IDMap" => loadIDMap(),
    "getID" => function($UUID){
        $UUID = intval($UUID);
        if($UUID > 32768){
          $id = $UUID % (1 << 15);
          $meta = ($UUID-$id) >> 15;
        }else{
          $id = $UUID;
          $meta = 0;
        }
        return array('id'=> $id, 'meta' => $meta);
      }
  ));
});

$app->run();

function loadIDMap($file = "IDMap.txt"){
  $idmap = array();
  $handler = fopen($file,"r");
  while($line = fgetcsv($handler)){
    
    if(preg_match("`(?:Block. Name: |Item. Name: )(?:tile\.|item\.)?(.*)(?:\. ID: )([0-9]*)`",current($line),$matches) === 1){
      $idmap[$matches[2]] = $matches[1];
    }
  }
  return $idmap;
}
