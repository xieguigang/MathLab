<?php

include dirname(__DIR__) . "/framework/bootstrap.php";

class App {

	/**
	 * 系统首页
	 * 
	 * @uses view
	*/
	public function index() {
		View::Display();
	}

	/**
	 * 登录系统
	 * 
	 * @uses view
	 * @access *
	*/
	public function login() {
		View::Display();
	}

	/**
	 * 系统锁屏
	 * 
	 * @uses view
	*/
	public function lockscreen() {
		View::Display();
	}

	/**
	 * 管理商品库存
	 * 
	 * @uses view
	*/
	public function inventories() {
		View::Display();
	}

	/**
	 * 重置密码
	 * 
	 * @uses view
	*/
	public function password_reminder() {
		View::Display();
	}

	/**
	 * 商品信息管理
	 * 
	 * @uses view
	*/
	public function goods() {
		View::Display();
	}

	public function phpinfo() {
		phpinfo();		
	}
}