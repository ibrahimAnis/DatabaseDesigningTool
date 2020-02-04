<%@taglib uri="/WEB-INF/tlds/mytags.tld" prefix="tm" %>
<jsp:useBean id="errorBean" scope="request" class="com.thinking.machines.dmodel.services.pojo.ErrorBean" />
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
<script>
function attachEvents()
{
var memberLoginForm=$("#memberLoginForm");
var username=memberLoginForm.find("#username");
var password=memberLoginForm.find("#password");
username.on("input",function(){
if(username.val().trim()) username.removeClass("is-invalid");
else username.addClass("is-invalid");
});
password.on("input",function(){
if(password.val().trim()) password.removeClass("is-invalid");
else password.addClass("is-invalid");
});
}
function processLoginForm()
{
var memberLoginForm=$("#memberLoginForm");
var username=memberLoginForm.find("#username");
var password=memberLoginForm.find("#password");
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
if(errors==0)
{
alert(username.val()+','+password.val());
return 'true';
}
return 'false';
}
window.addEventListener('load', attachEvents);
</script>
</head>
<body class="bg-dark">
<div id="logo-container" class="col-md-4 col-md-offset-1">
    <img src="images/logo.png" class="img-responsive" alt="LOGO">
</div>
<div class="container">
<div class="card card-register mx-auto mt-5">
<div class="card-header">Member Login</div>
<div class="card-body">
<form method="GET" action='/dmodel/webservice/memberservice/login' onsubmit="return processLoginForm()" role="form" class="form-horizontal" id='memberLoginForm' novalidate>
<!-- Personal Information Card Starts here -->
<div class="card card-register mx-auto mt-1">
<div class="card-header">Personal Information</div>

<div class='form-group has-error' id='genericError'>
<center>
<tm:Error name='errorBean' scope='request'>
<font color="red">${error}</font>
</tm:Error>
</center>
</div>
<div class="card-body">
<div class='form-group has-error' id='usernameGroup'>
<div class='form-row'>
<div class='col-md-12'>
<div class='form-label-group'>
<input type='text' id='username' name='argument-1' class='form-control ${validator}'  placeholder='Username/EmailId' required='required' autofocus='autofocus'>
<label for='username'>Username</label>
<div class="invalid-feedback">Please choose a username.</div>
</div>
</div>
</div>
</div>
<div class='form-group has-error' id='passwordGroup'>
<div class='form-row'>
<div class='col-md-12'>
<div class='form-label-group'>
<input type='password' id='password' name='argument-2'  class='form-control ${validator}' placeholder='Password' required='required' autofocus='autofocus'>
<label for='password'>Password</label>
<div class="invalid-feedback">Please enter a valid Password</div>
</div>
</div>
</div>
</div>
<button type='submit'  class="btn btn-primary btn-block">Login</button>
<center><a href='/dmodel/signup.jsp'>Sign Up </a> </center>
</div> <!-- card body ends-->
</div> <!-- Card card ends-->
</form>
</div>  <!-- Container ends-->
<!-- Bootstrap core JavaScript-->
<script src="/dmodel/vendor/jquery/jquery.min.js"></script>
<script src="/dmodel/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Core plugin JavaScript-->
<script src="/dmodel/vendor/jquery-easing/jquery.easing.min.js"></script>
<!-- waiting for plugin -->
<script src="/dmodel/vendor/waiting/bootstrap-waitingfor.js"></script>
</body>
</html>


