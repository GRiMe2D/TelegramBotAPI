package com.aabbcc.double.telegram_bot_api.objects
{

	public class Message
	{
		
		public var message_id:int;
		public var from:User;
		public var date:int;
		public var chat:IChat;
		public var text:String;
		
		public function Message() 
		{
			
		}
		
		public function toString():String {
			return JSON.stringify(this);
		}
	}
}