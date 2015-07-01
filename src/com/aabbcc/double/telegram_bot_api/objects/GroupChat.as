package com.aabbcc.double.telegram_bot_api.objects
{
	public class GroupChat implements IChat
	{
		
		private var m_id:int;
		public var title:String;
		
		
		public function GroupChat()
		{
		}
		
		public function get type():String {
			return ChatType.GROUP_CHAT;
		}
		
		public function get id():int {
			return m_id;
		}
		
		public function set id(value:int):void {
			m_id = value;
		}
		
		
	}
}