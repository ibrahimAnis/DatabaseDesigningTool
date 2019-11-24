<!doctype html>
<html lang='en'>
<head>
<meta charset='utf-8'>
</head>
<script>
function uploadFile()
{
var file=document.getElementById("upload").files[0];
var formData=new FormData();
alert(file.name);
formData.append("file.name",file);
$.ajax(
{
type:'POST',
enctype:'multipart/form-data',
url:"/institute/fileservice/serviceA/uploadA",
data:formData,
processData:false,
contentType:false,
cache:false,
timeout:600000,
success:function(data)
{
alert("Succesfully uploaded");
},
error:function(e)
{
alert("Could not upload file");
}

});

}

</script>
<body>
<br/>
<input type='file' name='upload' id='upload' multiple>
<button value='Browse' onclick='uploadFile()'></button>
</body>
</html>
