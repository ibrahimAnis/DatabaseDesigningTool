<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>SB Admin - Register</title>
<!-- Bootstrap core CSS-->
<link href="/dmodel/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom fonts for this template-->
<link href="/dmodel/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<!-- Custom styles for this template-->
<link href="/dmodel/css/sb-admin.css" rel="stylesheet">
<link href="/dmodel/site/css/styles.css" rel="stylesheet">
<link href='/dmodel/css/font_awesome_5.css' rel="stylesheet">
<style>
.bd-example-modal-lg .modal-dialog{
    display: table;
    position: relative;
    margin: 0 auto;
    top: calc(50% - 24px);
  }
  
  .bd-example-modal-lg .modal-dialog .modal-content{
    background-color: transparent;
    border: none;
  }
</style>
<script src='/dmodel/webservice/js/memberservice.js' type='text/javascript'></script>
<script src='/dmodel/webservice/js/TMService.js' type='text/javascript'></script>
<script>
function attachEvents()
{
var memberSignupForm=$("#memberSignupForm");
var username=memberSignupForm.find("#username");
var firstName=memberSignupForm.find("#firstName");
var lastName=memberSignupForm.find("#lastName");
var password=memberSignupForm.find("#password");
var rePassword=memberSignupForm.find("#rePassword");
var mobileNumber=memberSignupForm.find("#mobileNumber");
var captchaCode=memberSignupForm.find("#captchaCode");
username.on("input",function(){
if(username.val().trim()) username.removeClass("is-invalid");
else username.addClass("is-invalid");
});
firstName.on("input",function(){
if(firstName.val().trim()) firstName.removeClass("is-invalid");
else firstName.addClass("is-invalid");
});
lastName.on("input",function(){
if(lastName.val().trim()) lastName.removeClass("is-invalid");
else lastName.addClass("is-invalid");
});
password.on("input",function(){
if(password.val().trim()) password.removeClass("is-invalid");
else password.addClass("is-invalid");
});
rePassword.on("input",function(){
if(rePassword.val().trim()) rePassword.removeClass("is-invalid");
else rePassword.addClass("is-invalid");
});
mobileNumber.on("input",function(){
if(mobileNumber.val().trim()) mobileNumber.removeClass("is-invalid");
else mobileNumber.addClass("is-invalid");
});
captchaCode.on("input",function(){
if(captchaCode.val().trim()) captchaCode.removeClass("is-invalid");
else captchaCode.addClass("is-invalid");
});
}
function processSignupForm()
{
document.getElementById("mobileNumberError").innerHTML="Plaese Choose a valid Mobile Number";
document.getElementById("usernameError").innerHTML="Please choose a username.";
document.getElementById("passwordError").innerHTML="Please choose a valid Password";
document.getElementById("firstNameError").innerHTML="Please choose a valid first Name";
document.getElementById("lastNameError").innerHTML="Please choose a valid Last Name";
var memberSignupForm=$("#memberSignupForm");
var username=memberSignupForm.find("#username");
var firstName=memberSignupForm.find("#firstName");
var lastName=memberSignupForm.find("#lastName");
var password=memberSignupForm.find("#password");
var rePassword=memberSignupForm.find("#rePassword");
var mobileNumber=memberSignupForm.find("#mobileNumber");
var captchaCode=memberSignupForm.find("#captchaCode");
var errors=0;
if(!username.val().trim())
{
if(!username.hasClass("is-invalid"))
{
username.addClass("is-invalid");
}
errors++;
if(errors==1) username.focus();
}
else
{
if(username.hasClass("is-invalid"))
{
username.removeClass("is-invalid");
}
}
if(!firstName.val().trim())
{
if(!firstName.hasClass("is-invalid"))
{
firstName.addClass("is-invalid");
}
errors++;
if(errors==1) firstName.focus();
}
else
{
if(firstName.hasClass("is-invalid"))
{
firstName.removeClass("is-invalid");
}
}
if(!lastName.val().trim())
{
if(!lastName.hasClass("is-invalid"))
{
lastName.addClass("is-invalid");
}
errors++;
if(errors==1) lastName.focus();
}
else
{
if(lastName.hasClass("is-invalid"))
{
lastName.removeClass("is-invalid");
}
}
if(!password.val().trim())
{
if(!password.hasClass("is-invalid"))
{
password.addClass("is-invalid");
}
errors++;
if(errors==1) password.focus();
}
else
{
if(password.hasClass("is-invalid"))
{
password.removeClass("is-invalid");
}
}
if((!rePassword.val().trim()) || rePassword.val().trim()!=password.val().trim())
{
if(!rePassword.hasClass("is-invalid"))
{
rePassword.addClass("is-invalid");
}
errors++;
if(errors==1) rePassword.focus();
}
else
{
if(rePassword.hasClass("is-invalid"))
{
rePassword.removeClass("is-invalid");
}
}
if(!mobileNumber.val().trim())
{
if(!mobileNumber.hasClass("is-invalid"))
{
mobileNumber.addClass("is-invalid");
}
errors++;
if(errors==1)  mobileNumber.focus();
}
else
{
var a='0123456789';
var e=0;
vMobileNumber=mobileNumber.val();
while(e<vMobileNumber.length)
{ 
if(a.indexOf(vMobileNumber.charAt(e))==-1)
{
if(!mobileNumber.hasClass("is-invalid"))
{
mobileNumber.addClass("is-invalid");
}
errors++;
if(errors==1) mobileNumber.focus();
break;
} 
e++;
} 
if(e==vMobileNumber.length)
{
mobileNumber.removeClass("is-invalid");
}
}
if(!captchaCode.val().trim())
{
if(!captchaCode.hasClass("is-invalid"))
{
captchaCode.addClass("is-invalid");
}
errors++;
if(errors==1) captchaCode.focus();
}
else
{
if(captchaCode.hasClass("is-invalid"))
{
captchaCode.removeClass("is-invalid");
}
}
if(errors==0)
{
var member =new Member();
member.emailId=username.val();
member.password=password.val();
member.firstName=firstName.val();
member.lastName=lastName.val();
member.mobileNumber=mobileNumber.val();
//alert(member+"  "+member.emailId+" "+member.firstName+" "+member.lastName+" "+member.mobileNumber+" "+member.password);
processCaptchaCode(member);
}
else
{
if(!captchaCode.hasClass("is-invalid"))
{
captchaCode.addClass("is-invalid");
}
errors++;
if(errors==1) captchaCode.focus();
}
}
//Sending work
function processSignup(member)
{
//alert('process signup');
memberserviceManager.createMember(member,function(data){
//alert(JSON.stringify(data));
if(JSON.stringify(data)=='true')
{
window.location.href="/dmodel/continueToLogin.jsp";	
}
else
{
alert(data);
}
},function(e)
{     
var ttt=JSON.parse(JSON.stringify(e));
alert(ttt);
alert('ee'+ttt.lastName);
var memberSignupForm=$("#memberSignupForm");
var captchaCode=memberSignupForm.find("#captchaCode");
captchaCode.val("");
d = new Date();
//alert(d+data);
captchaImage=document.getElementById('captchaImage');
captchaImage.src="/dmodel/webservice/captcha?"+d.getTime();
if(ttt.emailId)
{
document.getElementById("usernameError").innerHTML=ttt.emailId;
memberSignupForm.find("#username").addClass("is-invalid");
}
if(ttt.firstName)
{
document.getElementById("firstNameError").innerHTML=ttt.firstName;
memberSignupForm.find("#firstName").addClass("is-invalid");
}
if(ttt.lastName)
{
document.getElementById("lastNameError").innerHTML=ttt.lastName;
memberSignupForm.find("#lastName").addClass("is-invalid");
}
if(ttt.password)
{
document.getElementById("passwordError").innerHTML=ttt.password;
memberSignupForm.find("#password").addClass("is-invalid");
}
if(ttt.mobileNumber)
{
document.getElementById("mobileNumberError").innerHTML=ttt.mobileNumber;
memberSignupForm.find("#mobileNumber").addClass("is-invalid");
}
}); 
}
function processCaptchaCode(member)
{
var memberSignupForm=$("#memberSignupForm");
var captchaCode=memberSignupForm.find("#captchaCode");
memberserviceManager.captchaTest(captchaCode.val(),function(data){
if(JSON.stringify(data)=='true')
{
processSignup(member);
}
else
{
captchaCode.addClass("is-invalid");
var memberSignupForm=$("#memberSignupForm");
var d = new Date();
captchaImage=document.getElementById('captchaImage');
captchaImage.src="/tmdmodel/webservice/captcha?"+d.getTime();
//alert(captchaImage.attr("src", "/tmdmodel/webservice/captcha?"+d.getTime()));
captchaCode.val("");
}
},function(e)
{
alert(JSON.stringify(e));
}); 
/*waitingDialog.show("Processing");
w1=waitingDialog.animate("Processing");
setTimeout(function()
{
waitingDialog.stopAnimate(w1);
waitingDialog.message("ruk na");
}
,2000);
*/
 $('.modal').modal('show');
setTimeout(function () {
console.log('modal is running');
$('.modal').modal('hide');
}, 3000);


}
window.addEventListener('load', attachEvents);
// see to it that this should happen only once:-->  attachEvents();

</script>
</head>
<body class="bg-dark">
<div id="logo-container" class="col-md-4 col-md-offset-1">
    <img src="images/logo.png" class="img-responsive" alt="LOGO">
</div>
<div class="container">
<div class="card card-register mx-auto mt-5">
<div class="card-header">Member Signup</div>
<div class="card-body">
<form id='memberSignupForm' novalidate>
<!-- Personal Information Card Starts here -->
<div class="card card-register mx-auto mt-1">
<div class="card-header">Personal Information</div>
<div class="card-body">

<div class='form-group has-error' id='usernameGroup'>
<div class='form-row'>
<div class='col-md-12'>
<div class='form-label-group'>
<input type='text' id='username' class='form-control' placeholder='Username/EmailId' required='required' autofocus='autofocus'>
<label for='username'>Username</label>
<div class="invalid-feedback" id='usernameError'>Please choose a username.</div>
</div>
</div>
</div>
</div>

<div class='form-group has-error' id='nameGroup'>
<div class='form-row'>
<div class='col-md-6'>
<div class='form-label-group'>
<input type='text' id='firstName' class='form-control' placeholder='FirstName' required='required' autofocus='autofocus'>
<label for='firstName'>FirstName</label>
<div class="invalid-feedback" id='firstNameError'>Please choose a valid FirstName</div>
</div>
</div>
<div class='col-md-6'>
<div class='form-label-group'>
<input type='text' id='lastName' class='form-control' placeholder='LastName' required='required' autofocus='autofocus'>
<label for='lastName'>LastName</label>
<div class="invalid-feedback" id='lastNameError'>Please choose a valid LastName</div>
</div>
</div>
</div>
</div>

<div class='form-group has-error' id='passwordGroup'>
<div class='form-row'>
<div class='col-md-6'>
<div class='form-label-group'>
<input type='password' id='password' class='form-control' placeholder='Password' required='required' autofocus='autofocus'>
<label for='password'>Password</label>
<div class="invalid-feedback" id='passwordError'>Please enter a valid Password</div>
</div>
</div>
<div class='col-md-6'>
<div class='form-label-group'>
<input type='password' id='rePassword' class='form-control' placeholder='ReEnter Password' required='required' autofocus='autofocus'>
<label for='rePassword'>ReEnter Password</label>
<div class="invalid-feedback">Enter Password again</div>
</div>
</div>
</div>
</div>

<div class='form-group has-error' id='mobileNumberGroup'>
<div class='form-row'>
<div class='col-md-12'>
<div class='form-label-group'>
<input type='text' id='mobileNumber' class='form-control' placeholder='Mobile Number' required='required' autofocus='autofocus' >
<label for='mobileNumber'>Mobile Number</label>
<div class="invalid-feedback" id='mobileNumberError'>Please Enter a valid Mobile Number</div>
</div>
</div>
</div>
</div>
</div>
</div>

<div class='card card-register mx-auto mt-1'>
<div class='card-header'>Input security</div>
<div class='card-body'>
<div class='form-group' >
<div class='form-row'>
<div class='col-md-6'>
<img src='/dmodel/webservice/captcha' id="captchaImage"/>
</div>
<div class='col-md-6'>
<div class='form-label-group'>
<input type='text' id='captchaCode' placeholder='CAPTCHA' required='required' class='form-control'>
<label for='captchaCode'>CAPTCHA</label>
<div class="invalid-feedback">Please Enter a valid Captcha Code</div>
</div>
</div>
</div>
</div>
</div> <!-- card body -->
</div> <!-- card -->
<!-- Security Card Ends here -->
<button type='button' onclick='processSignupForm()' class="btn btn-primary btn-block">Signup</button>
</form>
</div>
</div>
</div>
<div class="modal fade bd-example-modal-lg" data-backdrop="static" data-keyboard="false" tabindex="-1">
    <div class="modal-dialog modal-sm">
        <div class="modal-content" style="width: 48px">
            <span class="fa fa-spinner fa-spin fa-3x"></span>
        </div>
    </div>
</div>
<!-- Bootstrap core JavaScript-->
<script src="/dmodel/vendor/jquery/jquery.min.js"></script>
<script src="/dmodel/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Core plugin JavaScript-->
<script src="/dmodel/vendor/jquery-easing/jquery.easing.min.js"></script>
<!-- waiting for plugin -->
<script src="/dmodel/vendor/waiting/bootstrap-waitingfor.js"></script>
</body>
</html>


