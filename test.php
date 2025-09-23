<?php
// Test file for PHP formatting
class TestClass
{
  public function testMethod($param1, $param2)
  {
    if ($param1 > $param2) {
      return $param1 + $param2;
    } else {
      return $param2 - $param1;
    }
  }
}

$test = new TestClass();
$result = $test->testMethod(5, 3);
echo "Result: " . $result;
