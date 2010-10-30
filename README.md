Parsley Commands Example
========================

This example shows how to use Parsley with pure [ActionScript configuration](http://www.spicefactory.org/parsley/docs/2.3/manual/config.php#as3) and [Short-lived Command Objects](http://www.spicefactory.org/parsley/docs/2.3/manual/messaging.php#command_objects). 

Parsley is an advanced open source application framework. Download and documentation can be [found here](http://www.spicefactory.org/parsley/).

About the example
-----------------

This mvc example demonstrates login and logout functionality over an faked `SessionService` (see below under "Fake Service"). 

The login only works with the following login data:

	user name: 	admin
	password:	test

The credentials are validated within the Service. In case the credentials are wrong, the view displays an `Alert` pop up. If they are correct an result page is displayed and you can logout again. Login and Logout is controlled by short-lived command objects.

Short-lived Command Objects
---------------------------

Since Parsley 2.2 the framework supports commands. Part of this implementation is the support of short-lived command objects. That are commands that are only created when a specific message has been dispatched. Afterwards the command is immediately removed from the context. For further information [read on here](http://www.spicefactory.org/parsley/docs/2.3/manual/messaging.php#command_objects).

Until now an easy configuration is only available via `MXML` or `XML` configuration, by using the `DynamicCommand` tag. But by using `XML` you loose the strong type check of the compiler. And the `MXML` approach is not possible in pure ActionScript applications. 

If you want to use this feature with pure ActionScript configurations, you have to use the [Configuration DSL](http://www.spicefactory.org/parsley/docs/2.3/manual/config.php#dsl). Because this configuration is not well documented and a bit more complicated, I encapsulated this feature within a `CommandMap` class. So you can easily reuse this class if you need this feature.

**Important:** In order to use the `CommandMap` you have to build the Context by using the Configuration DSL, like in the following example. The `MainConfig` is the class where all the definitions for the context have to be defined.

	var contextBuilder:ContextBuilder = ContextBuilder.newSetup()
    	.viewRoot(this)
		.newBuilder();
		
	var commandMap:CommandMap = new CommandMap(contextBuilder);
	commandMap.register(LoginCommand, LoginRequest);
	commandMap.register(LogoutCommand, LogoutRequest);
			
	contextBuilder.config(ActionScriptConfig.forClass(MainConfig));
	contextBuilder.build();

The first step is to create the `ContextBuilder` which then has to be passed into the `CommandMap` instance. Afterwards you can register all your command mappings. The last step is to build the context.

But why does the example uses Flex then?
----------------------------------------

Flex has been used to provide an fast and simple output. Special features that were used are [explicit component wiring for Flex](http://www.spicefactory.org/parsley/docs/2.3/manual/view.php#config_explicit) to register `MXML` views automatically in the context. The actual command mapping which is demonstrated in the example can be used in pure ActionScript projects.

Fake Service
------------

There are two classes that were necessary for the asynchronous fake service implementation: `FakeServiceRequest` and `ServiceRequestCommandFactory`. The first one just implements the delay of one second. The second one is used by Parsley for the reflection on the return type of the execute method in the commands. 

The factory has to be registered in Parsley:

	var settings:MessageSettings = 
		GlobalFactoryRegistry.instance.messageSettings;
	settings.commandFactories.addCommandFactory(
		ServiceRequest, new ServiceRequestCommandFactory());

More information can be found here [in the Parsley documentation](http://www.spicefactory.org/parsley/docs/2.3/manual/extensions.php#commands).

Limits
------

Because the mapping takes place in the construction phase of the context it is not possible to un-map these commands later at runtime. The only way to remove the mapping would be to destroy the context where they are registered in.

Contact
-------
Blog: [blog.mattes-groeger.de](http://blog.mattes-groeger.de/)  
Twitter: [@MattesGroeger](https://twitter.com/MattesGroeger)