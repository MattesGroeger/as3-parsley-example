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
package de.mattesgroeger.parsley.service.fake 
{
	import org.spicefactory.cinnamon.service.ServiceResponse;
	import org.spicefactory.cinnamon.service.ServiceContext;
	import org.spicefactory.cinnamon.service.ServiceOperation;
	import org.spicefactory.cinnamon.service.ServiceRequest;

	import flash.utils.setTimeout;

	public class FakeServiceRequest extends ServiceRequest 
	{
		private var expectedResult : Array;
		private var errorMessage : String;

		public function FakeServiceRequest(expectedResult : Array, errorMessage : String = null)
		{
			this.expectedResult = expectedResult;
			this.errorMessage = errorMessage;
			
			super(new ServiceOperation(null, null, null, null), null);
		}

		public override function addResultHandler(handler : Function) : ServiceRequest 
		{
			if (errorMessage == null)
				setTimeout(delayedResultCall, 1000, handler);
			
			return this;
		}

		public override function addErrorHandler(handler : Function) : ServiceRequest 
		{
			if (errorMessage != null)
				setTimeout(delayedErrorCall, 1000, handler);
			
			return this;
		}

		private function delayedResultCall(handler : Function) : void 
		{
			handler.apply(handler, [new ServiceResponse(expectedResult)]);
		}

		private function delayedErrorCall(handler : Function) : void 
		{
			handler.apply(handler, [new ServiceResponse(errorMessage)]);
		}
	}
}