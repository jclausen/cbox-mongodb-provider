# Coldbox MongoDB Provider Module
The MongoDB Provider for Cachebox is a Coldbox module that allows you to connect CacheBox to a MongoDB cluster and leverage that cluster in your ColdBox applications or any application that leverages CacheBox in its standalone version.

##LICENSE
Apache License, Version 2.0.

##IMPORTANT LINKS
- Documentation: http://wiki.coldbox.org/wiki/CacheBox-MongoDB.cfm
- Source: https://github.com/jclausen/cbox-mongodb-provider
- ForgeBox: http://forgebox.io/view/mongodb-provider

##SYSTEM REQUIREMENTS
- Lucee 4.5+
- Railo 4+ (Deprecated)
- ColdFusion 9+

## INSTRUCTIONS

Just drop into your **modules** folder or use the box-cli to install

`box install couchbase-provider`


## Settings
You can add a `MongoDB` structure of settings to your `ColdBox.cfc` to configure custom caches:

```js
//The global MongoDB settings config
MongoDB = {
	// Register all the custom named caches you like here
    caches : { 
		"template" : {
			properties : {
			    objectDefaultTimeout : 15,
			    opQueueMaxBlockTime : 5000,
			    opTimeout : 5000,
			    timeoutExceptionThreshold : 5000,
			    ignoreCouchBaseTimeouts : true,				
				bucket:"default",
				username:"",
				password:"",
				servers:"127.0.0.1:8091"
			}
		},
		"couchBase" : {
		    properties : {
		        objectDefaultTimeout : 15,
		        opQueueMaxBlockTime : 5000,
		        opTimeout : 5000,
		        timeoutExceptionThreshold : 5000,
		        ignoreCouchBaseTimeouts : true,				
		    	bucket:"default",
		    	username:"",
		    	password:"",
		    	servers:"127.0.0.1:8091"
		    }
		}
	}
}

```



## Usage
You can read more about using this module here: https://github.com/jclausen/cbox-mongodb-provider/wiki
