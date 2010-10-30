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
package de.mattesgroeger.parsley.service
{
	import de.mattesgroeger.parsley.service.fake.FakeServiceRequest;

	import org.spicefactory.cinnamon.service.ServiceRequest;
	import org.spicefactory.cinnamon.service.support.AbstractServiceBase;

	public class SessionService extends AbstractServiceBase implements ISessionService
	{
		public function login(userName:String, password:String) : ServiceRequest
		{
			if (userName == "admin" && password == "test")
				return new FakeServiceRequest(["d41d8cd98f00b204e9800998ecf8427e"]);
			else
				return new FakeServiceRequest([], "Wrong user name or password!");
		}

		public function logout(sessionId:String) : ServiceRequest
		{
			return new FakeServiceRequest([true]);
		}
	}
}