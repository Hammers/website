<?php

class Index {
	public function __construct() { if(!php_Boot::$skip_constructor) {
		templo_Loader::$BASE_DIR = "tpl/";
		templo_Loader::$TMP_DIR = "tmp/";
		templo_Loader::$MACROS = null;
		$context = _hx_anonymous(array("userName" => "Nestor", "lovesHaxe" => true, "data" => new _hx_array(array(1, 2, 3, 4, 5))));
		$t = new templo_Loader("test.mtt");
		$r = $t->execute($context);
		php_Lib::hprint($r);
	}}
	static function main() {
		new Index();
	}
	function __toString() { return 'Index'; }
}
