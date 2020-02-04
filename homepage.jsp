<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin - Blank Page</title>

    <!-- Bootstrap core CSS-->
    <link href="/dmodel/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template-->
    <link href="/dmodel/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

    <!-- Page level plugin CSS-->
    <link href="/dmodel/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/dmodel/css/sb-admin.css" rel="stylesheet">
 <script src='/dmodel/webservice/js/memberservice.js' type='text/javascript'></script>
 <script src='/dmodel/webservice/js/projectservice.js' type='text/javascript'></script>
 <script src='/dmodel/webservice/js/TMService.js' type='text/javascript'></script>
  <script>
function attachEvents()
{
var  createProjectModal=$('#createProjectModal');
var projectName=createProjectModal.find("#projectName");
projectName.on("input",function(){
if(projectName.val().trim()) projectName.removeClass("is-invalid");
else projectName.addClass("is-invalid");
});
}
function openCreateProjectModal()
{
$('#createProjectModal').modal({backdrop: 'static', keyboard: false});
}
function openOpenProjectModal()
{
$('#openProjectModal').modal({backdrop: 'static', keyboard: false});
}
function createProject()
{
var  createProjectModal=$('#createProjectModal');
var projectName=createProjectModal.find("#projectName");
var architectureCode=createProjectModal.find("#databaseArchitecture");
var title=projectName.val();
architectureCode=architectureCode.find(":selected").val();
alert(title+","+architectureCode);
if(!projectName.val().trim())
{
if(!projectName.hasClass("is-invalid"))
{
projectName.addClass("is-invalid");
}
projectName.focus();
}
else
{
if(projectName.hasClass("is-invalid"))
{
projectName.removeClass("is-invalid");
}
projectserviceManager.createProject(title,architectureCode,function(data){
alert("database architecture code"+data.databaseArchitecture.code);
var projectCode=data.code;
if(projectCode)
{
window.location.href="/dmodel/webservice/projectservice/openProject?argument-1="+window.encodeURI(projectCode)+"&argument-2="+window.encodeURI(databaseArchitectureCode);	
}
else
{
alert(data);
}
},function(e)
{
var ttt=JSON.parse(JSON.stringify(e));
alert(ttt.title);     
var createProjectModal=$("#createProjectModal");
if(ttt.title)
{
document.getElementById("projectNameError").innerHTML=ttt.title;
createProjectModal.find("#projectName").addClass("is-invalid");
}
});
}
}
window.addEventListener("load",attachEvents);
</script>
</head>
<body id="page-top">
<nav class="navbar navbar-expand navbar-dark bg-dark static-top">
<div class="container-fluid">
<div class="navbar-header">
<a class="navbar-brand" href="#">Menu</a>
</div>
<ul class="nav navbar-nav navbar-right">
<li  style="color:white;" ><i class="fas fa-user-circle fa-fw"></i>
<span>${member.firstName}</span></li>
</ul>
</div>
</nav>
<div id="wrapper">
<!-- Sidebar -->
      <ul class="sidebar navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="#"  onclick='openCreateProjectModal()'>
            <span>Create New Project</span>
          </a>

        </li>
        <li class="nav-item">
          <a class="nav-link" href="#"  onclick='openOpenProjectModal()'>
            <span>Open Project</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="index.jsp">
            <span>Edit Profile</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="index.jsp">
            <span>My Subscription</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/dmodel/webservice/memberservice/logout">
            <span>Logout</span>
          </a>
        </li>

      </ul>
<!-- Open Projet Modal -->
<div class="modal" id="openProjectModal">
<div class="modal-dialog modal-dialog-centered modal-lg">
<div class="modal-content">
<!-- Modal Header -->
<div class="modal-header">
<h6 class="modal-title">Projects</h6>
<button type="button" class="close" data-dismiss="modal">&times;</button>
</div>
<!-- Modal body -->
<div class="modal-body" id='modalBody'>
<div class="list-group">
<c:forEach var="project" items="${projects}" >
<a href="/dmodel/webservice/projectservice/openProject?argument-1=${project.code}&argument-2=${project.databaseArchitecture.code}" class="list-group-item list-group-item-action">${project.title}</a>
</c:forEach>
</div>
</div>   
</div>
</div>
</div>
<!-- Create Project Modal -->
<div class="modal" id="createProjectModal">
<div class="modal-dialog modal-dialog-centered modal-lg">
<div class="modal-content">
<!-- Modal Header -->
<div class="modal-header">
<h6 class="modal-title">Create New Project</h6>
<button type="button" class="close" data-dismiss="modal">&times;</button>
</div>
<!-- Modal body -->
<div class="modal-body" id='modalBody'>
<div class='form-group has-error' id='projectNameGroup'>
<div class='form-row'>
<div class='col-md-12'>
<div class='form-label-group'>
<input type='text' id='projectName' class='form-control' placeholder='Project-Name' required='required' autofocus='autofocus'>
<label for='projectName'>Project Name</label>
<div class="invalid-feedback" id='projectNameError'>Please choose a valid Project Name</div>
</div>
</div>
</div>
</div>
<div class='form-group has-error' id='dataBaseArchitectureGroup'>
<div class='form-row'>
<div class='col-md-12'>
<div class="form-group">
<label for="databaseArchitecture">Select Architecture</label>
<select class="form-control" id="databaseArchitecture">
<c:forEach var="databaseArchitecture" items="${databaseArchitectures}" >
<option value='${databaseArchitecture.code}'>${databaseArchitecture.name}</option>
</c:forEach>
</select>
</div>
</div>
</div>
</div>
<!-- Modal footer -->
<button type='button' onclick='createProject()' class="btn btn-primary btn-block">Create</button>
</div>   		
</div>
</div>
</div>
<div id="content-wrapper">
<div class="container-fluid">
</div>
<!-- /.container-fluid -->
<!-- Sticky Footer -->
<footer class="sticky-footer">
          <div class="container my-auto">
            <div class="copyright text-center my-auto">
              <span>Copyright Â© dmodel2018</span>
            </div>
          </div>
        </footer>

      </div>
      <!-- /.content-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
      <i class="fas fa-angle-up"></i>
    </a>

   
    <!-- Bootstrap core JavaScript-->
    <script src="/dmodel/vendor/jquery/jquery.min.js"></script>
    <script src="/dmodel/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/dmodel/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/dmodel/js/sb-admin.min.js"></script>

  </body>

</html>
