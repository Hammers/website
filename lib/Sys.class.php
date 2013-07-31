<?php

class Sys {
	public function __construct(){}
	static function sleep($seconds) {
		usleep($seconds * 1000000);
		return;
	}
	function __toString() { return 'Sys'; }
}
