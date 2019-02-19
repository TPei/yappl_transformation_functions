<?php
function main(array $args) : array
{
    $length = strlen($args["data"]);
    $response = str_repeat("*", $length);
    return ["data" => $response];
}
?>
