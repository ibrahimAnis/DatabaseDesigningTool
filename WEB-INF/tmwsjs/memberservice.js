function TMForward()
{
}
function Member()
{
this.emailId="";
this.password="";
this.firstName="";
this.lastName="";
this.mobileNumber="";
this.status="";
}
function MemberserviceManager()
{
this.checkMember=function(argument1,argument2,successHandler,exceptionHandler)
{
service.getJSON('memberservice/login?argument-1='+encodeURI(argument1)+'&'+'argument-2='+encodeURI(argument2),null,function(result){
successHandler(result);
},function(exception){
exceptionHandler(exception);
});
}
this.captchaTest=function(argument1,successHandler,exceptionHandler)
{
service.postJSON('memberservice/captchaTest',{
'argument-1': argument1
},
function(result){
successHandler(result);
},function(exception){
exceptionHandler(exception);
});
}
this.createMember=function(argument1,successHandler,exceptionHandler)
{
service.postJSON('memberservice/signup',{
'argument-1': argument1
},
function(result){
successHandler(result);
},function(exception){
exceptionHandler(exception);
});
}
this.logout=function(successHandler,exceptionHandler)
{
service.getJSON('memberservice/logout',null,function(result){
successHandler(result);
},function(exception){
exceptionHandler(exception);
});
}
}
var memberserviceManager=new MemberserviceManager();
