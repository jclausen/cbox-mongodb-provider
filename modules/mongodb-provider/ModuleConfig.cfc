/**
*********************************************************************************
* Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
* www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************
*/
component {

	// Module Properties
	this.title 				= "MongoDB Provider";
	this.author 			= "Ortus Solutions";
	this.webURL 			= "http://www.ortussolutions.com";
	this.description 		= "MongoDB Provider for Cachebox";
	this.version			= "2.0.0.@build.version@";
	
	this.viewParentLookup 	= true;
	
	this.layoutParentLookup = true;
	
	this.entryPoint			= "/MongoDBProvider";

	this.modelNamespace		= "MongoDBProvider";
	
	this.cfmapping			= "MongoDBProvider";
	
	this.dependencies 		= ['CBMongoDB-SDK'];
	

	function configure(){

		parseParentSettings();

	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
		
		//ensure cbjavaloader is active
		if(!Wirebox.getColdbox().getModuleService().isModuleActive( 'cbjavaloader' )){

			Wirebox.getColdbox().getModuleService().reload( 'cbjavaloader' );	
		
		}

		var modulePath = getDirectoryFromPath( getCurrentTemplatePath() );

		var jLoader = Wirebox.getInstance("loader@cbjavaloader");
		
		jLoader.appendPaths( modulePath & '/lib/' );

		binder.map( "Stats@MongoDBProvider" )
			.to("MongoDBProvider.models.MongoDB.Stats")
			.noInit();

		var CacheBox = Wirebox.getCachebox();

		var MongoDBCaches = VARIABLES.MongoDBConfig.caches;

		for( var cacheName in MongoDBCaches ){
			var cacheConfig = MongoDBCaches[cacheName];

			Cachebox.getConfig().cache(
				cacheName,
				"MongoDBProvider.models.MongoDB.ColdboxProvider",
				cacheConfig.properties
			);
		}

	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){

	}

	private function parseParentSettings(){

		var oConfig 			= controller.getSetting( "ColdBoxConfig" );
		var configStruct 		= controller.getConfigSettings();
		var MongoDBSettings	= oConfig.getPropertyMixin( "MongoDB", "variables", {} );
			
		//default config struct
		configStruct.MongoDB = {
			// The default couchbase caches
			caches = {
				// Named cache for all coldbox event and view template caching
				"template":getDefaultCacheConfig( "templateCache" ),
				"MongoDB":getDefaultCacheConfig( "defaultCache" )
			}
		};

		//check if a config has been misplaced within the custom settings structure
		if( structIsEmpty( MongoDBSettings ) and structKeyExists( configStruct, "MongoDB" ) ){
			MongoDBSettings = duplicate( configStruct.MongoDB );
		}
		// Incorporate settings
		structAppend( configStruct.MongoDB, MongoDBSettings, true );

		VARIABLES.MongoDBConfig = configStruct.MongoDB;

	}

	private function getDefaultCacheConfig( required string collectionName = "default" ){
		var defaultConfig = {
			"provider":"MongoDBProvider.MongoDB.ColdboxProvider",
			"properties":{
				objectDefaultTimeout:120,
				objectDefaultLastAccessTimeout:30,
				useLastAccessTimeouts:true,
				freeMemoryPercentageThreshold:0,
				reapFrequency:5,
				evictionPolicy:"LRU",
				evictCount:2,
				maxObjects:300,
				objectStore:"ConcurrentSoftReferenceStore", //memory sensitive
				collection:ARGUMENTS.collectionName
			}
		};

	}

}