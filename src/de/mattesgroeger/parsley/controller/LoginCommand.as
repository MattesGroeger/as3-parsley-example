/*
 * Copyright (c) 2010 Mattes Groeger
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package de.mattesgroeger.parsley.controller
{
	import de.mattesgroeger.parsley.message.LoginFailure;
	import de.mattesgroeger.parsley.message.LoginRequest;
	import de.mattesgroeger.parsley.message.LoginSuccess;
	import de.mattesgroeger.parsley.service.ISessionService;

	import org.spicefactory.cinnamon.service.ServiceRequest;
	
	public class LoginCommand
	{
		[Inject]
		public var service:ISessionService;
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Init]
		public function init() : void
		{
			trace("LoginCommand added to context");
		}

		public function execute(message:LoginRequest) : ServiceRequest
		{
			return service.login(message.userName, message.password);
		}

		public function result(sessionId:String) : void
		{
			dispatcher(new LoginSuccess(sessionId));
		}

		public function error(message:String) : void
		{
			dispatcher(new LoginFailure(message));
		}
		
		[Destroy]
		public function destroy() : void
		{
			trace("LoginCommand removed from context");
		}
	}
}