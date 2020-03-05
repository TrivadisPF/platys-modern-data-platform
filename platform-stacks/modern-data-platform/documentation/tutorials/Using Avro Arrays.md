# Using Avro Arrays

Add the following Avro Schema

```
{
  "type": "record",
  "name": "DigitalDataObject",
  "namespace": "de.printus.edh.avro.DigitalDataObject.v1",
  "fields": [
      { "name":"number",
        "doc": "",
        "type":"int"
      },
      { "name":"name",
        "doc": "",
        "type":"string"
      },      
      {
         "name":"events",
         "doc":"",
         "type":{
            "type":"array",
            "items":{
            	"type": "record",
            	"name": "EventRecord",
            	"fields": [
			    	{	
      					"name": "temperature",
      					"default": null,
      					"type": [ "null",
      						{
							"type": "record",
							"name": "TemperatureRecord",
    						"fields" : [
                        		{
                           			"name":"type",
                           			"doc":"",
                           			"default":null,
                           			"type":[
                              			"null",
                              			"string"
                           			]	
                        		},
                        		{
                           			"name":"temp",
                           			"doc":"",
                           			"default":null,
                           			"type":[
                              			"null",
                              			"int"
                           			]	
                        		}
    							]	      		      						} 
      					]
    				},
			    	{	
      					"name": "position",
      					"default": null,
      					"type": [ "null",{
							"type": "record",
							"name": "PostitionRecord",
    						"fields" : [
                        		{
                           			"name":"type",
                           			"doc":"",
                           			"default": null,
                           			"type":[
                              			"null",
                              			"string"
                           			]	
                        		},
                        		{
                           			"name":"latitude",
                           			"default": null,
                           			"doc":"",
                           			"type":[
                              			"null",
                              			"int"
                           			]	
                        		},
                        		{
                           			"name":"longitude",
                           			"default": null,
                           			"doc":"",
                           			"type":[
                              			"null",
                              			"int"
                           			]	
                        		}
    						]      					
      					} ]
    				}
            	]            
            }
         }
      }
   ]
}      
```

Send a message with two events

```
{
  "checked": false,
  "nested": {
    "width": 5,
    "height": 10
  },
  "number": 1,
  "name": "A green door",
  "events": [
    { "temperature":     {
      			"type": "temperature",
      			"temp": 10
    			}
    },
    { "temperature":  {}, "position": {
      			"type": "position",
      			"latitude": 10,
      			"longitude": 20
    			}
    }
  ]
}
```

Send a message with no events (empty collection)

```
{
  "checked": false,
  "nested": {
    "width": 5,
    "height": 10
  },
  "number": 1,
  "name": "A green door",
  "events": []
}
```
