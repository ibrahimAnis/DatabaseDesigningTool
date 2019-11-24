function switchToMaintenanceMode()
{
alert('switchToMaintenanceMode');
}
function Service()
{
var prefix='/dmodel/webservice/';
this.getJSON=function(url,requestData,responseHandler,exceptionHandler)
{
if(requestData)
{
$.ajax(prefix+url,{
type: 'GET',
cache: false,
data:requestData,
processData: false,
success: function(res){
if(res.success) if(res.isReturningSomething) responseHandler(res.result); else responseHandler();
else if(res.isException) exceptionHandler(res.exception);
else switchToMaintenanceMode();
},
error: function() {
switchToMaintenanceMode();
}
});
}
else
{
$.ajax(prefix+url,{
type: 'GET',
cache: false,
success: function(res){
if(res.success) if(res.isReturningSomething) responseHandler(res.result); else responseHandler();
else if(res.isException) exceptionHandler(res.exception);
else switchToMaintenanceMode();
},
error: function() {
switchToMaintenanceMode();
}
});
}
} 
this.postJSON=function(url,jsonObject,responseHandler,exceptionHandler)
{
if(!jsonObject) 
{
var exceptionJSONObject={
'exception': 'Missing JSON'
};
exceptionHandler(exceptionJSONObject);
return;
}
$.ajax(prefix+url,{
type: 'POST',
data: JSON.stringify(jsonObject),
cache: false,
contentType: 'application/json',
success: function(res){
if(res.success) if(res.isReturningSomething) responseHandler(res.result); else responseHandler();
else if(res.isException) exceptionHandler(res.exception);
else switchToMaintenanceMode();
},
error: function() {
switchToMaintenanceMode();
}
});
}
this.postData=function(url,data,responseHandler,exceptionHandler){}
this.postFiles=function(url,data,responseHandler,exceptionHandler){}
this.getFile=function(url,data,responseHandler,exceptionHandler){}
this.downloadFile=function(url,data,response,exceptionHandler){}
} // class service ends here
var service=new Service();
