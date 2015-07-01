package com.aabbcc.double.telegram_bot_api.objects
{
	public class User implements IChat
	{
		
		private var m_id:int;
		public var first_name:String;
		public var last_name:String;
		public var username:String;
		
		public function User()
		{
			
		}
		
		public function toString():String {
			return JSON.stringify(this);
		}
		
		public function get type():String {
			return ChatType.USER_CHAT;
		}
		
		public function get id():int {
			return m_id;
		}
		
		public function set id(value:int):void {
			m_id = value;
		}
	}
}