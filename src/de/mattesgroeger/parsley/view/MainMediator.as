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
package de.mattesgroeger.parsley.view
{
	import de.mattesgroeger.parsley.message.LoginFailure;
	import de.mattesgroeger.parsley.message.LoginRequest;
	import de.mattesgroeger.parsley.message.LoginSuccess;
	import de.mattesgroeger.parsley.message.LogoutRequest;
	import de.mattesgroeger.parsley.message.LogoutSuccess;

	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.CursorManager;

	public class MainMediator
	{
		[MessageDispatcher]
		public var dispatcher:Function;
		
		private var mainView:MainView;
		private var sessionId:String;

		[Observe]
		public function initView(view:MainView) : void
		{
			mainView = view;
		}

		internal function handleSubmitClick() : void
		{
			disableApplication();
			
			dispatcher(new LoginRequest(mainView.loginView.userName.text, mainView.loginView.password.text));
		}
		
		[MessageHandler]
		public function handleLoginSuccess(message:LoginSuccess) : void
		{
			sessionId = message.sessionId;
			
			enableApplication();
			
			mainView.applicationView.result.text = "Session: " + message.sessionId;
			mainView.viewStack.selectedIndex = 1;
			mainView.logoutButton.visible = true;
		}
		
		[MessageHandler]
		public function handleLoginFailure(message:LoginFailure) : void
		{
			enableApplication();
			
			Alert.show(message.errorMessage);
		}

		internal function handleLogoutClick() : void
		{
			disableApplication();
			
			dispatcher(new LogoutRequest(sessionId));
		}
		
		[MessageHandler]
		public function handleLogoutSuccess(message:LogoutSuccess) : void
		{
			enableApplication();
			
			if (!message.success)
				return;
			
			mainView.viewStack.selectedIndex = 0;
			mainView.logoutButton.visible = false;
		}
		
		private function disableApplication() : void
		{
			FlexGlobals.topLevelApplication.enabled = false;
			CursorManager.setBusyCursor();
		}

		private function enableApplication() : void
		{
			FlexGlobals.topLevelApplication.enabled = true;
			CursorManager.removeBusyCursor();
		}
	}
}
