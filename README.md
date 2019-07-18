
# Json to CSV Converter


A Ruby on Rails API Version 5.2.3 web service that take JSON format and the payload is an array of objects, and return same payload in CSV format.
The CSV must include all keys and values of all JSON objects."
 

### Example 
S = “do not go out and look for a successful personality and duplicate it”


### This application requires:

    Ruby version 2.4.4
	Rails version 5.2.3


Please run the below command in terminal window.
```
$ bundle
```

### Execute Test

```
$ bundle exec rspec spec
```


### Sample Input Request
Put URLs in your browser after starting rails server 

**Sample input 1:** Invalid Capital letter 
```
http://localhost:3000/api/convert?json_object=name'
```
Expexted output
```
{"errors":{"json_object":["must be an array"]},"status":400}
```


**Sample input 2:**  
``` [ 
{"name": "bed", "color": "black", "size": "12", "date_created": "12/6", "condition": "New"},
{"name": "chair", "color": "brown", "size": "7", "date_created": "6/13", "condition": "Used"},
{"name": "desk", "color": "maple", "size": "9", "date_created": "2/13" , "add":"1111"}] 
```
```
http://localhost:3000/api/convert?json_object=[ {"name": "bed", "color": "black", "size": "12", "date_created": "12/6", "condition": "New"}, {"name": "chair", "color": "brown", "size": "7", "date_created": "6/13", "condition": "Used"},{"name": "desk", "color": "maple", "size": "9", "date_created": "2/13" , "add":"1111"}]
```
Expexted output
```
name,color,size,date_created,condition,add
bed,black,12,12/6,New,
chair,brown,7,6/13,Used,
desk,maple,9,2/13,,1111

``` 
