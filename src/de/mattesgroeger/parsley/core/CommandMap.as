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
package de.mattesgroeger.parsley.core
{
	import org.spicefactory.parsley.core.registry.DynamicObjectDefinition;
	import org.spicefactory.parsley.dsl.ObjectDefinitionBuilderFactory;
	import org.spicefactory.parsley.dsl.context.ContextBuilder;
	import org.spicefactory.parsley.dsl.messaging.impl.DynamicCommandBuilder;

	public class CommandMap
	{
		private var definitionBuilderFactory:ObjectDefinitionBuilderFactory;
		
		public function CommandMap(contextBuilder:ContextBuilder)
		{
			this.definitionBuilderFactory = contextBuilder.objectDefinition();
		}

		public function register(commandType:Class, messageType:Class, selector:* = null, scope:String = null) : void
		{
			var targetDef:DynamicObjectDefinition = definitionBuilderFactory.forClass(commandType)
					.asDynamicObject()
						.build();

			var builder:DynamicCommandBuilder = DynamicCommandBuilder.newBuilder(targetDef);

			if (scope != null)
				builder.scope(scope);
			
			if (selector != null)
				builder.selector(selector);
			
			builder.messageType(messageType)
				.stateful(false)
				.build();
		}
	}
}