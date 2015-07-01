package com.aabbcc.double.telegram_bot_api
{
	import com.aabbcc.double.telegram_bot_api.objects.GroupChat;
	import com.aabbcc.double.telegram_bot_api.objects.Message;
	import com.aabbcc.double.telegram_bot_api.objects.ReplyKeyboardMarkup;
	import com.aabbcc.double.telegram_bot_api.objects.Update;
	import com.aabbcc.double.telegram_bot_api.objects.User;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;

	public class TelegramBotAPI
	{
		
		private static const REQ_URI:String = "https://api.telegram.org/bot<token>/";
		
		protected var m_token:String;
		
		protected var request:URLRequest;
		protected var loader:URLLoader;
		protected var variables:URLVariables;
		
		public function TelegramBotAPI(tokenID:String)
		{
			m_token = tokenID;
		}
		
		protected function get req_url():String {
			var str:String = REQ_URI.replace("<token>", m_token);
			return str;
		}
		
		public function getUpdates(onComplete:Function, offset:Object = null, limit:Object = null, timeout:Object = null):void {
			request = new URLRequest(req_url + "getUpdates");
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, function(e:Event):void {
				var result:Vector.<Update> = new Vector.<Update>;
				var response:Object = JSON.parse(loader.data);
				for (var i:int = 0; i < response["result"].length; i++) {
					var update:Update = parseUpdate(response["result"][i]);
					result.push(update);
				};
				
				onComplete(result);
			});
			
			
			variables = new URLVariables();
			
			if (!isNaN(int(offset))) {
				variables.offset = int(offset);
			}
			
			if (!isNaN(int(limit))) {
				variables.limit = int(limit);
			}
			
			if (!isNaN(int(timeout))) {
				variables.timeout = int(timeout);
			}
			
			
			request.data = variables;
			loader.load(request);
		}
		
		public function sendMessage(chat_id:int, text:String, reply_markup:ReplyKeyboardMarkup = null, onSuccess:Function = null):void {
			variables = new URLVariables();
			variables.chat_id = chat_id;
			variables.text = text;
			if (reply_markup) variables.reply_markup = JSON.stringify(reply_markup);
			request = new URLRequest(req_url + "sendMessage");
			request.data = variables;
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, function (e:Event):void {
				if (onSuccess) onSuccess();
			});
			
			loader.load(request);
		}
		
		public function get token():String {
			return m_token;
		}
		
		private function parseUser(obj:Object):User {
			var user:User 			= new User();
			user.first_name 			= obj.first_name;
			user.id 					= obj.id;
			user.last_name 			= obj.last_name;
			user.username 			= obj.username;
			
			return user;
		}
		
		private function parseMessage(obj:Object):Message {
			var message:Message = new Message();
			
			if ( (obj.chat as Object).hasOwnProperty("title")) {
				message.chat		= parseGroupChat(obj.chat);
			} else {
				message.chat		= parseUser(obj.chat);
			}
			message.date			= obj.date;
			message.from			= parseUser(obj.from);
			message.message_id	= obj.message_id;
			message.text 		= obj.text;
			
			return message;
		}
		
		private function parseUpdate(obj:Object):Update {
			var update:Update = new Update();
			
			update.message		= parseMessage(obj.message);
			update.update_id		= obj.update_id;
			
			return update;
		}
		
		private function parseGroupChat(obj:Object):GroupChat {
			var group:GroupChat = new GroupChat();
			
			group.id		= obj.id;
			group.title	= obj.title;
			
			return group;
		}
		
		
		
		
	}
}