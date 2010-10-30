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
	import org.spicefactory.cinnamon.service.ServiceRequest;
	import org.spicefactory.parsley.core.messaging.command.Command;
	import org.spicefactory.parsley.core.messaging.command.CommandFactory;

	public class ServiceRequestCommandFactory implements CommandFactory
	{
		public function createCommand(returnValue:Object, message:Object, selector:* = undefined) : Command
		{
			return new FakeServiceRequestCommand(ServiceRequest(returnValue), message, selector);
		}
	}
}

import org.spicefactory.cinnamon.service.ServiceRequest;
import org.spicefactory.cinnamon.service.ServiceResponse;
import org.spicefactory.lib.reflect.ClassInfo;
import org.spicefactory.parsley.core.messaging.command.impl.AbstractCommand;

class FakeServiceRequestCommand extends AbstractCommand
{
	public function FakeServiceRequestCommand(request:ServiceRequest, message:Object, selector:*)
	{
		super(request, message, selector);
		request.addResultHandler(complete).addErrorHandler(error);
		start();
	}
	
	protected override function complete(result:* = null) : void
	{
		super.complete(result);
	}
	
	protected override function error(result:* = null) : void
	{
		super.error(result);
	}

	protected override function selectResultValue(result:*, targetType:ClassInfo) : *
	{
		if (targetType.isType(ServiceResponse))
			return result;
		
		return ServiceResponse(result).result;
	}

	protected override function selectErrorValue(result:*, targetType:ClassInfo) : *
	{
		if (targetType.isType(ServiceResponse))
			return result;
		
		return ServiceResponse(result).result;
	}
}