<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin - Charts</title>

    <!-- Bootstrap core CSS-->
    <link href="/dmodel/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template-->
    <link href="/dmodel/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

    <!-- Page level plugin CSS-->
    <link href="/dmodel/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/dmodel/css/sb-admin.css" rel="stylesheet">

  </head>

    <!-- Bootstrap core JavaScript-->
    <script src="/dmodel/vendor/jquery/jquery.min.js"></script>
    <script src="/dmodel/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/dmodel/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Page level plugin JavaScript-->
    <script src="/dmodel/vendor/chart.js/Chart.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/dmodel/js/sb-admin.min.js"></script>
	<script src='/dmodel/js/fontmetrics.js'></script>
<script src='/dmodel/webservice/js/TMService.js'></script>
<script src='/dmodel/webservice/js/projectservice.js'></script>
<script>
var tableComponents=[];
var project=null;
var selectedTableComponent=null;
var selectedField=null;
var canvas=null;
var context=null;
var DEFAULT_HEIGHT=150;
var DEFAULT_WIDTH=180;
var DRAW_TABLE=false;
var DRAW_TEXT=false;
var DRAW_LINE=false;
var DRAG_TABLE=false;
var selectedMenu="";
var canvasDimension=null;
var index=-1;

function paintAllComponents()
{
for(var i=0;i<tableComponents.length;i++) tableComponents[i].draw();
}
function getTitle()
{
var cnt=0;
var title;
var max=0;
for(var i=0;i<tableComponents.length;i++)
{
title=tableComponents[i].databaseTable.title;
if(title.search(/table/)!=-1)
{
cnt=Number(title.charAt(title.length-1));
console.log("cnt"+cnt);
if(max<cnt) max=cnt;
}
}
if(max==0) return 'table_1';
else return 'table_'+(max+1);
}

function indexOfTableComponent(x,y)
{
console.log("finding at "+x+" "+y);
var obj;
for(var i=0;i<tableComponents.length;i++)
{
obj=tableComponents[i].databaseTable.drawableTable;
//alert("abscissa:"+obj.abscissa+" ordinate:"+obj.ordinate);
if((x>=obj.abscissa) && (x<=(obj.abscissa+obj.width)) && (y>=obj.ordinate) && (y<=(obj.height+obj.ordinate)))
{
console.log("found at "+i);
//index=i;
return i;
}
}
return -1;
}


function DrawableLine(x1,y1,x2,y2)
{

}
this.drawLine=function(x1,y1,x2,y2)
{
context.beginPath();
context.moveTo(x1,y1);
context.lineTo(x2,y2);
//context.strokeStyle='black';
context.stroke();
}

drawText=function(x,y,text)
{
context.fillText(text,x,y);
}


function DrawableText(xcor,ycor,vHeight,vWidth)
{
this.x=xcor;
this.y=ycor;
this.height=vHeight;
this.width=vWidth;
}


function DrawableTable(xcor,ycor,vWidth,vHeight)
{
this.abscissa=xcor;
this.ordinate=ycor;
this.height=vHeight;
this.width=vWidth;
this.databaseTable=null;
var THIS=this;
this.drawTable=function()
{
//alert("table processing:"+THIS.databaseTable.title);
context.fillStyle='black';
var textMetrics=context.measureText(THIS.databaseTable.title);
var titleWidth,titleHeight;
titleWidth=textMetrics.width;
titleHeight=textMetrics.height;
var maxWidth,maxHeight,tmp;
maxWidth=0;
if(maxWidth<textMetrics.width) maxWidth=textMetrics.width;
tmp=40;
var databaseField=null;
var databaseFields=THIS.databaseTable.databaseFields;
var texts=[];
for(var i=0;i<databaseFields.length;i++)
{
//alert("field:"+databaseFields[i].name);
databaseField=databaseFields[i];
text=databaseField.name;
text+=" "+databaseField.datatype;
if(databaseField.width>0) text+="("+databaseField.width+")";
if(databaseField.isPrimaryKey) text+=" PK";
if(databaseField.isForeignKey) text+=" FK";
if(databaseField.isUnique) text+=" UNN";
if(databaseField.isAutoIncrement) text+=" AUTO";
if(databaseField.isNotNull) text+=" NN";
textMetrics=context.measureText(text);
textWidth=textMetrics.width;
textHeight=textMetrics.height;
tmp+=textHeight+5;
if(textWidth>maxWidth) maxWidth=textWidth;
//context.globalCompositeOperation='destination-over';
//context.fillText(text,THIS.abscissa+5,THIS.ordinate+tmp);
texts.push(text);
}

THIS.height=tmp+10;
THIS.width=maxWidth+5;
context.clearRect(THIS.abscissa,THIS.ordinate,THIS.width,THIS.height);
context.globalCompositeOperation='destination-over';
context.fillText(THIS.databaseTable.title,THIS.abscissa+(THIS.width-titleWidth)/2,THIS.ordinate+(80-titleHeight)/2);
drawLine(THIS.abscissa,THIS.ordinate+40,THIS.abscissa+THIS.width,THIS.ordinate+40);
context.rect(THIS.abscissa,THIS.ordinate,THIS.width,THIS.height);
context.stroke();

tmp=40;
for(var i=0;i<texts.length;++i)
{
text=texts[i];
textMetrics=context.measureText(text);
textWidth=textMetrics.width;
textHeight=textMetrics.height;
tmp+=textHeight+5;
context.globalCompositeOperation='destination-over';
context.fillText(text,THIS.abscissa+5,THIS.ordinate+tmp);
}



}
this.drawCircles=function()
{
context.clearRect(THIS.abscissa,THIS.ordinate,THIS.width,THIS.height);
THIS.drawTable();
context.fillStyle='blue';
context.beginPath();
context.arc(THIS.abscissa,THIS.ordinate,5,0,2*Math.PI);
context.stroke();
context.fill();
context.beginPath();
context.arc(THIS.abscissa+THIS.width,THIS.ordinate,5,0,2*Math.PI);
context.stroke();
context.fill()
context.beginPath();
context.arc(THIS.abscissa,THIS.ordinate+THIS.height,5,0,2*Math.PI);
context.stroke();
context.fill()
context.beginPath();
context.arc(THIS.abscissa+THIS.width,THIS.ordinate+THIS.height,5,0,2*Math.PI);
context.stroke();
context.fill();
}
this.eraseCircles=function()
{
//alert("earase chala");
context.clearRect(THIS.abscissa-6,THIS.ordinate-6,THIS.width+12,THIS.height+12);
THIS.drawTable();
}
}
function DatabaseTable(vTitle,vDrawableTable)
{
this.title=vTitle;
this.databaseFields=[];
this.primaryKeyCount=0;
this.alternateKeyCount=0;
this.drawableTable=vDrawableTable;
this.engine="";
}

function DatabaseField()
{
this.name="";
this.datatype="";
this.isPrimaryKey=false;
this.isNotNull=false;
this.isAutoIncrement=false;
this.iseForeignKey=false;
this.defaultValue="";
this.checkConstraint="";
this.precision=0;
this.isUnique=false;
this.note="Abhi add nahi kiya";
this.width=0;
this.drawableField=null;
}
function TableComponent()
{
this.databaseTable=null;
this.entityController=null;
var THIS=this;
this.draw=function()
{
THIS.databaseTable.drawableTable.drawTable();
}
}

function createTable(x,y,width,height)
{
var drTable=new DrawableTable(x,y,width,height);
var dTable=new DatabaseTable(getTitle(),drTable);
drTable.databaseTable=dTable;
var tableComponent=new TableComponent();
tableComponent.databaseTable=dTable;
tableComponent.draw();
tableComponents.push(tableComponent);
//alert(tableComponents.length);
return tableComponent;
}
function onTableMenuClicked()
{
selectedMenu="CREATE_TABLE";
}



// Initialising Project
function initializeProject()
{
projectserviceManager.getProject(function(data)
{
//alert(JSON.stringify(data));
var select=document.getElementById('databaseEngines');
var options=data.databaseArchitecture.engines;
var option=null;
project=data;
alert(JSON.stringify(project));
for(var i=0;i<options.length;i++)
{
option=document.createElement("OPTION");
option.value=options[i].name;
option.label=options[i].name;
if(i==0) option.selected='true';
select.appendChild(option);
}
select=document.getElementById('datatypes');
//alert(JSON.stringify(data.databaseArchitecture));
options=data.databaseArchitecture.datatypes;
option=null;
for(var i=0;i<options.length;i++)
{
option=document.createElement("OPTION");
option.value=options[i].datatype;
option.label=options[i].datatype;
if(i==0) option.selected='true';
select.appendChild(option);
}

var databaseTable=null;
var databaseField=null;
var drawableTable=null;
var tableComponent=null;
var databaseFields=[];
var table=null;
var field=null;
var point=null;
var tables=[];
var fields=[];
var datatype=null;
var engine=null;
tables=project.tables;
for(var i=0;i<tables.length;i++)
{
table=tables[i];
point=table.point;
engine=table.engine;
drawableTable=new DrawableTable(point.abscissa,point.ordinate,DEFAULT_WIDTH,DEFAULT_HEIGHT);
databaseTable=new DatabaseTable(table.name,drawableTable);
databaseTable.title=table.name;
databaseTable.engine=engine.name;
databaseTable.note=table.note;
fields=table.fields;
for(var j=0;j<fields.length;j++)
{
field=fields[i];
datatype=field.datatype;
databaseField=new DatabaseField();
databaseField.name=field.name;
databaseField.datatype=datatype.datatype;
databaseField.width=field.width;
databaseField.isPrimaryKey=field.isPrimaryKey;
databaseField.isAutoIncrement=field.isAutoIncrement;
databaseField.isUnique=field.isUnique;
databaseField.isNotNull=field.isNotNull;
databaseField.defaultValue=field.defaultValue;
databaseField.checkConstraint=field.checkConstraint;
databaseField.note=field.note;
databaseFields.push(databaseField);
}
databaseTable.databaseFields=databaseFields;
tableComponent=new TableComponent();
tableComponent.databaseTable=databaseTable;
tableComponent.drawableTable=drawableTable;
tableComponent.drawableTable.databaseTable=databaseTable;
tableComponents.push(tableComponent);
}
paintAllComponents();

alert("populating ends here");
},function(error)
{
alert(JSON.stringify(error));
});



$("#entityModal").on('shown.bs.modal',function()
{

var tableViewDivision=$("#tableView");
if(selectedTableComponent.entityController)
{
selectedTableComponent.entityController.updateTable(selectedTableComponent.databaseTable.databaseFields);
}
else 
{
var entityController=new EntityController(selectedTableComponent.databaseTable.databaseFields);
selectedTableComponent.entityController=entityController;
}

var div=document.getElementById('addField');
if(div.style.display=='none') div.style.display='block';
div=document.getElementById('editField')
div.style.display='none';
div=document.getElementById('deleteField');
div.style.display='none';

console.log("modal opened");
$("#tableName").val(selectedTableComponent.databaseTable.title);
$("#note").val(selectedTableComponent.databaseTable.note);
$("#databaseEngines").find(":selected").val(selectedTableComponent.databaseTable.engine);




});
$("#entityModal").on('hidden.bs.modal',function()
{

var tableName=$("#tableName").val();
alert("tableName:"+tableName);
//var tableName=document.getElementById("tableName");
if(tableName.length>0) selectedTableComponent.databaseTable.title=tableName
selectedTableComponent.databaseTable.note=$("#note").val();
selectedTableComponent.databaseTable.engine=$("#databaseEngines").find(":selected").val();
//selectedTableComponent.databaseTable.drawableTable.eraseCircles();
selectedTableComponent.databaseTable.drawableTable.drawTable();
selectedTableComponent.databaseTable.drawableTable.drawCircles();
});
canvas=document.getElementById("canvas");
context=canvas.getContext("2d");
canvas.style.font="30px Times";
context.font='30px Times';
canvasDimension=canvas.getBoundingClientRect();
canvas.ondblclick=function(event)
{
//alert("open modal");
var relativeX=event.clientX-canvasDimension.left;
var relativeY=event.clientY-canvasDimension.top;
var index=indexOfTableComponent(relativeX,relativeY);
if(index==-1)
{
//alert("outside");
 return;
}
//selectedTableComponent=tableComponents[index]
$('#entityModal').modal({backdrop:'static', keyboard:false});
}

canvas.onmouseup=function(event)
{
var title;
var relativeX=event.clientX-canvasDimension.left;
var relativeY=event.clientY-canvasDimension.top;
if(selectedMenu=='CREATE_TABLE')
{
if(selectedTableComponent)
{
selectedTableComponent.databaseTable.drawableTable.eraseCircles();
selectedTableComponent=null;
}
title=getTitle();
selectedTableComponent=createTable(relativeX,relativeY,title);
selectedTableComponent.databaseTable.drawableTable.drawCircles();
selectedMenu="";
}
else
{
// draw blue circles around dragged table after redrawing whole canvas;
index=indexOfTableComponent(relativeX,relativeY);
if(index==-1) 
{
console.log("index not found");
if(selectedTableComponent)
{
selectedTableComponent.databaseTable.drawableTable.eraseCircles();
selectedTableComponent=null;
}
}
else
{
if(selectedTableComponent!=tableComponents[index])
{
if(selectedTableComponent) selectedTableComponent.databaseTable.drawableTable.eraseCircles();
selectedTableComponent=tableComponents[index];
/*setTimeout(function()
{
//if(!selectedTableComponent.drawableTable) alert("It is null");
selectedTableComponent.databaseTable.drawableTable.drawCircles();
},100);*/

selectedTableComponent.databaseTable.drawableTable.drawCircles();

}
}

}
}

} // attach events end here


var isAttributeActive=false;
var isDescriptionActive=false;

function addAttribute()
{
var div=$("#addField");
var fieldName=div.find("#fieldName");
var datatypes=div.find("#datatypes");
var isNotNull=document.getElementById("notNull");
var isPrimaryKey=document.getElementById("key");
var isUnique=document.getElementById("unique");
var width=document.getElementById('width');
var precision=document.getElementById('precision');
var autoIncrement=document.getElementById('autoIncrement');
var check=div.find("#check");
var defaultField=div.find("#default");
var databaseField=new DatabaseField();
databaseField.name=fieldName.val();
databaseField.datatype=datatypes.find(":selected").val();
//alert(databaseField.datatype);
databaseField.isNotNull=isNotNull.checked;
databaseField.isPrimaryKey=isPrimaryKey.checked;
databaseField.defaultValue=defaultField.val();
databaseField.checkConstraint=check.val();
databaseField.isAutoIncrement=autoIncrement.checked;
databaseField.isUnique=isUnique.checked;
databaseField.width=width.value;
//alert(width.value);
databaseField.precision=precision.val;
selectedTableComponent.databaseTable.databaseFields.push(databaseField);
selectedTableComponent.entityController.updateTable(selectedTableComponent.databaseTable.databaseFields);
fieldName.val("");
isNotNull.checked=false;
isUnique.checked=false;
isPrimaryKey.checked=false;
check.val("");
defaultField.val("");
width.val=0;
precision.val="";
}



/*function showAttributeTab()
{
var tableViewDivision=$("#tableView");
if(selectedTableComponent.entityController)
{
selectedTableComponent.entityController.updateTable(selectedTableComponent.databaseTable.databaseFields);
}
else 
{
var entityController=new EntityController(selectedTableComponent.databaseTable.databaseFields);
selectedTableComponent.entityController=entityController;
}

var div=document.getElementById('addField');
if(div.style.display=='none') div.style.display='block';
div=document.getElementById('editField')
div.style.display='none';
div=document.getElementById('deleteField');
div.style.display='none';
}
function showDescription()
{
if(isDescriptionActive) return;
isDescriptionActive=true;
isAttributeActive=false;
}*/



window.addEventListener('load',initializeProject);
function EntityGrid(vModel,vContainerID)
{
var container;
var containerID;
var model=vModel;
var data=[];
var table;
var tableBody;
var tableHeader;
var selectedRowIndex=-1;
var THIS=this;
// event handlers start
this.onRowSelected=null;
this.onCellContentClicked=null;
this.selectRow=null;
this.update=function()
{
var rowCount=model.getRowCount();
var columnCount=model.getColumnCount();
var s,t;
var src=[];
var i;
tableBody.innerHTML="";
var tr,td,cellType,textNode,imageNode,image;
function cellContentClickHandlerCreator(rowNumber,cellNumber)
{
return function()
{
raiseCellContentClickedEvent(rowNumber,cellNumber);
};
}

function rowSelectionHandlerCreator(rowNumber)
{
return function()
{
raiseRowSelectedEvent(rowNumber);
};
}
for(i=0;i<rowCount;i++)
{
tr=document.createElement("tr");
tr.setAttribute('class',model.getRowStyle(i));
tr.rowNumber=i;
for(j=0;j<columnCount;j++)
{
td=document.createElement("td");
td.style.width=model.getColumnWidth(j);
td.setAttribute('class',model.getCellStyle(i,j));
cellType=model.getCellType(i,j).toUpperCase();
if(cellType=='TEXT')
{
textNode=document.createTextNode(model.getValueAt(i,j));
textNode.onclick=cellContentClickHandlerCreator(i,j);
td.appendChild(textNode);
} else if(cellType=='IMAGE')
{
image=document.createElement('img');
s=model.getValueAt(i,j);
src=s.split(",");
if(src.length>1)
{
image.src=src[0];
td.appendChild(image);
image=document.createElement('img');
image.src=src[1];
td.appendChild(image);
}
else
{
image.src=src[0];
td.appendChild(image);
}
}
tr.appendChild(td);
}
tr.style.cursor='pointer';
tr.onclick=rowSelectionHandlerCreator(i);
tableBody.appendChild(tr);
}
}  // update function ends here

containerID=vContainerID;
container=document.getElementById(containerID);
// creating one time table structure ends here
var THIS=this;
this.selectRow=function(rowNumber)
{
setTimeout(function()
{
raiseRowSelectedEvent(rowNumber);
},200);
};
function raiseRowSelectedEvent(rowNumber)
{
if(rowNumber==selectedRowIndex) return;
if(selectedRowIndex!=-1) tableBody.rows[selectedRowIndex].setAttribute('class',model.getRowStyle());
selectedRowIndex=rowNumber;
//alert("Selected row index"+selectedRowIndex);
tableBody.rows[selectedRowIndex].setAttribute('class',model.getSelectedRowStyle());
if(THIS.onRowSelected)
{
setTimeout(function()
{
THIS.onRowSelected(selectedRowIndex);
},5);
}
}
function raiseCellContentClickedEvent(rowNumber,cellNumber)
{
if(THIS.onCellContentClicked)
{
//alert("cell is clicked");
setTimeout(function()   // not done
{
THIS.onCellContentClicked(selectedRowIndex,cellNumber);
},100);
}
}

function createTable()
{
table=document.createElement('table');
tableHeader=document.createElement('thead');
var i;
var tr,th,td;
var border;
tr=document.createElement("tr");
var columnCount=model.getColumnCount();
border='1px solid'+model.getBorderColor();
for(i=0;i<columnCount;i++)
{
th=document.createElement("th");
th.innerHTML=model.getColumnTitle(i);
th.setAttribute('class',model.getHeaderStyle(i));
th.style.width=model.getColumnWidth(i);
th.style.border=border;
tr.appendChild(th);
}
tableHeader.appendChild(tr);
table.appendChild(tableHeader);
tableBody=document.createElement("tbody");
tableBody.style.display='block';
if(model.getBodyHeight) tableBody.style.height=model.getBodyHeight();
tableBody.style.overflow='scroll';
table.style.display='block';
table.appendChild(tableBody);
table.border=border;
table.style.borderCollapse='collapse';
container.innerHTML="";
container.appendChild(table);
}// create table ends here
createTable();
this.update();
model.setGrid(this);
table.setAttribute("tabindex",0);
table.addEventListener('keydown',function(ev)
{
if(ev.keyCode==38)
{
if(selectedRowIndex>0)
{
raiseRowSelectedEvent(selectedRowIndex-1);
}
}
if(ev.keyCode==40)
{
if(selectedRowIndex<model.getRowCount()-1)
{
raiseRowSelectedEvent(selectedRowIndex+1);
}
}
if(ev.keyCode==38 || ev.keyCode==40)
{
if(ev.preventDefault) ev.preventDefault();
else if(ev.cancelBubble) ev.cancelBubble=true;
}
});
}
// TM ENDS HERE
function EntityModel()
{
var numberOfRecords=0;
var databaseFields=[];
var navigationButtonCount=5;
var grid=null;
var titles=["S.No","Key","Field Name","Datatype","NotNull","Unique","Default","Check","Edit","Delete"];
var THIS=this;
this.setSelectedRow=function(rowNumber)
{
grid.selectRow(rowNumber);
}
this.setDatabaseFieldCount=function(vNumberOfRecords)
{
numberOfRecords=vNumberOfRecords;
}
this.setGrid=function(vGrid)
{
grid=vGrid;
}
this.getDatabaseField=function(index)
{
return databaseFields[index];
}
this.getRowCount=function()
{
return databaseFields.length;
}
this.getColumnCount=function()
{
return titles.length;
}
this.getColumnTitle=function(columnIndex)
{
return titles[columnIndex];
}
this.getBodyHeight=function()
{
return "150px";
}
this.getColumnWidth=function(columnIndex)
{
if(columnIndex==0) return "40px";
if(columnIndex==1) return "40px";
if(columnIndex==2) return "40px";
if(columnIndex==3) return "40px";
if(columnIndex==4) return "40px";
if(columnIndex==5) return "40px";
if(columnIndex==6) return "40px";
if(columnIndex==7) return "40px";
if(columnIndex==8) return "40px";
if(columnIndex==9) return "40px";
}
this.getHeaderStyle=function()
{
return "gridHeader";
}
this.getBorderColor=function()
{
return '#000000';
}
this.getLoadingHTML=function()
{
return "<label class='loading'>Loading....</label>";  
}
this.getRowStyle=function(rowIndex)
{
if(rowIndex%2==0) return 'gridEvenRow';
else return "gridOddRow";
}
this.getSelectedRowStyle=function()
{
return 'gridSelectedRow';
}
this.getCellStyle=function(rowIndx,columnIndex)
{
if(columnIndex==0) return "serialNumberColumn";
if(columnIndex==1) return "iconColumn";
if(columnIndex==2) return "fieldColumn";
if(columnIndex==3) return "fieldColumn";
if(columnIndex>=4 && columnIndex<6) return "iconColumn";
if(columnIndex==6) return "fieldColumn";
if(columnIndex==7) return "fieldColumn";
if(columnIndex>=8) return "iconColumn";
}
this.getCellType=function(rowIndex,columnIndex)
{
if(columnIndex==0) return "TEXT";
if(columnIndex==1) return "IMAGE";
if(columnIndex==2) return "TEXT";
if(columnIndex==3) return "TEXT";
if(columnIndex==4) return "IMAGE";
if(columnIndex==5) return "IMAGE";
if(columnIndex==6) return "TEXT";
if(columnIndex==7) return "TEXT";
if(columnIndex==8) return "IMAGE";
if(columnIndex==9) return "IMAGE";
}
this.getValueAt=function(rowIndex,columnIndex)
{
if(columnIndex==0) return rowIndex+1;
if(columnIndex==1) 
{
if(databaseFields[rowIndex].isPrimaryKey && databaseFields[rowIndex].isAutoIncrement) return '/dmodel/images/key.png,/dmodel/images/plus.png';
else if(databaseFields[rowIndex].isPrimaryKey) return "/dmodel/images/key.png";
else if(databaseFields[rowIndex].isAutoIncrement) return "/dmodel/images/plus.png";
else return "";
}
if(columnIndex==2) return databaseFields[rowIndex].name;
if(columnIndex==3) return databaseFields[rowIndex].datatype;
if(columnIndex==4)
{
if(databaseFields[rowIndex].isNotNull) return "/dmodel/images/checked.png";
else return "/dmodel/images/cancel.png";
}
if(columnIndex==5)
{
if(databaseFields[rowIndex].isUnique) return "/dmodel/images/checked.png";
else return "/dmodel/images/cancel.png";
}
if(columnIndex==6)
{
return databaseFields[rowIndex].defaultValue;
}
if(columnIndex==7) return databaseFields[rowIndex].checkConstraint;
if(columnIndex==8) return "/dmodel/images/edit_icon.png";
if(columnIndex==9) return "/dmodel/images/delete_icon.png";
}
this.setDatabaseFields=function(vDatabaseFields)
{
databaseFields=vDatabaseFields
grid.update();
}
}
function EntityController(vDatabaseFields)
{
var entityModel=null;
var entityGrid=null;
var databaseFields=vDatabaseFields;
entityModel=new EntityModel();
entityGrid=new EntityGrid(entityModel,'tableView');
if(databaseFields)
{
entityModel.setDatabaseFieldCount(databaseFields.length);
entityModel.setDatabaseFields(databaseFields);
}
entityGrid.onRowSelected=function(index)
{
alert(JSON.stringify(entityModel.getDatabaseField(index)));
}
entityGrid.onCellContentClicked=function(rowIndex,columnIndex)
{
if(columnIndex==8) alert("The user wants to edit:->"+JSON.stringify(entityModel.getDatabaseField(rowIndex)));
if(columnIndex==9) alert("The user wants to delete:->"+JSON.stringify(entityModel.getDatabaseField(rowIndex)));
}
this.updateTable=function(databaseFields)
{
alert(JSON.stringify(databaseFields));
entityModel.setDatabaseFields(databaseFields);
}
}  // EntityController ends here


function getEngineCode(name)
{
var engines=project.databaseArchitecture.engines;
for(var i=0;i<engines.length;i++)
{
if(engines[i].name==name)
{
alert("found:"+engines[i].name+" "+engines[i].code);
return engines[i].code;
}
}
return -1;
}
function getDatatypeCode(name)
{
var datatypes=project.databaseArchitecture.datatypes;
for(var i=0;i<datatypes.length;i++)
{
if(datatypes[i].datatype==name)
{
alert("found:"+datatypes[i].datatype+" "+datatypes[i].code);
return datatypes[i].code;
}
}
return -1;
}


function save()
{
var tables=[];
var table=null;
var field=null;
var fields=[];
var point=null;
var db=null;
var df=null;
var point=null;
var dfields=[];
var engine=null;
var datatype=null;
for(var i=0;i<tableComponents.length;i++)
{
db=tableComponents[i].databaseTable;
table=new Table();
table.name=db.title;
engine=new Engine();
engine.name=db.engine;
engine.code=getEngineCode(engine.name);
table.engine=engine;
alert("table engine"+JSON.stringify(table.engine));
point=new Point();
point.abscissa=db.drawableTable.abscissa;
point.ordinate=db.drawableTable.ordinate;
table.point=point;
table.note=db.note;
table.fields=[];
dfields=db.databaseFields;
//alert(JSON.stringify(dfields));
for(var j=0;j<dfields.length;j++)
{
df=dfields[i];
field=new Field();
field.name=df.name;
datatype=new Datatype();
datatype.datatype=df.datatype;
datatype.code=getDatatypeCode(df.datatype);
field.datatype=datatype;
field.isPrimaryKey=df.isPrimaryKey;
field.isNotNull=df.isNotNull;
field.isAutoIncrement=df.isAutoIncrement;
field.numberOfDecimalPlaces=df.precision;
field.width=df.width;
field.isUnique=df.isUnique;
field.note=df.note;
field.checkConstraint=df.checkConstraint;
field.defaultValue=df.defaultValue;
table.fields.push(field);
}
//alert("table field length:"+table.fields.length);
tables.push(table);
}

project.tables=tables;
//alert("databaseArchitecture"+JSON.stringify(project.databaseArchitecture));
//alert("tables"+JSON.stringify(project.tables));
alert(project);
projectserviceManager.saveProject(project,function(data)
{
alert(data);
},function(err)
{
alert(err);
});
}
function download()
{
alert("Download");
window.location.href='/dmodel/webservice/projectservice/download';
}

</script>
<style>
.gridHeader
{
font-family:"Times New Roman",Times,serif;
font-style:bold;
font-size:15px;
}
.serialNumberColumn
{
font-family:"Times New Roman",Times,serif;
font-style:normal;
font-size:15px;
text-align:right;
}
.fieldColumn
{
font-family:"Times New Roman",Times,serif;
font-style:normal;
font-size:15px;
text-align:left;
}
.gridEvenRow
{
background-color:#D6D6D6;
color:black;
height:15px;
min-height:15px;
}
.gridOddRow
{
background-color:white;
color:black;
height:15px;
min-height:15px;
}

.gridSelectedRow
{
background-color:#2693FF;
color:#FFFFFF;
height:15px;
min-height:15px;
}
.iconColumn
{
text-align:center;
}
</style>

<body id="page-top">

    <nav class="navbar navbar-expand navbar-dark bg-dark static-top">

      <a class="navbar-brand mr-1" href="homepage.jsp" id='title'>${currentProject.title}</a>

      <!-- Navbar Search -->
     

      <!-- Navbar -->
      <ul class="navbar-nav mx-auto">
        <li class="nav-item no-arrow ml-2">
         <button class='btn btn-link btn-default navbar-btn' onclick='onTableMenuClicked()'>
            <img src="/dmodel/images/table.png"></img>
        </li>
<li class='nav-item ml-2'>
<button class='btn btn-link navbar-btn' onclick='save()'><i class="far fa-save"></i>
</li>
<li class='nav-item ml-2'><button class='btn btn-link navbar-btn' onclick='download()'><img src='/dmodel/images/download.png'></img></li>
</ul>
</nav>
<div id="wrapper">
 <!-- Sidebar -->
      <ul class="sidebar navbar-nav bg-dark">
        <li class="nav-item">
          <a class="nav-link" href="index.html">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>Dashboard</span>
          </a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="pagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="fas fa-fw fa-folder"></i>
            <span>Pages</span>
          </a>
          <div class="dropdown-menu" aria-labelledby="pagesDropdown">
            <h6 class="dropdown-header">Login Screens:</h6>
            <a class="dropdown-item" href="login.html">Login</a>
            <a class="dropdown-item" href="register.html">Register</a>
            <a class="dropdown-item" href="forgot-password.html">Forgot Password</a>
            <div class="dropdown-divider"></div>
            <h6 class="dropdown-header">Other Pages:</h6>
            <a class="dropdown-item" href="404.html">404 Page</a>
            <a class="dropdown-item" href="blank.html">Blank Page</a>
          </div>
        </li>
        <li class="nav-item active">
          <a class="nav-link" href="charts.html">
            <i class="fas fa-fw fa-chart-area"></i>
            <span>Charts</span></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="tables.html">
            <i class="fas fa-fw fa-table"></i>
            <span>Tables</span></a>
        </li>
      </ul>
<div id='contentWrapper'>
<canvas id='canvas' width='1000px' height='800' style='border:1px solid#000000'>
</div>
</div>
<!---/wrapper--->
     

<!-- Entity Modal-->
<!---
    <div class="modal fade " id="entityModal2" tabindex="-1" role="dialog" aria-labelledby="entityModalLabel" aria-hidden="true">
      <div class="modal-dialog modal" role="document">
        <div class="modal-content" id="modal-content">
          <div class="modal-header">
            <h5 class="modal-title text-center">Configuration</h5>
            <button class="btn btn-secondary" type="button" data-dismiss="modal">&times;</button>
          </div>
          <div class="modal-body">

<div id='tableView' height="250px">Hello World</div>

</div>
















    <!-- Entity Modal-->

    <div class="modal fade " id="entityModal" tabindex="-1" role="dialog" aria-labelledby="entityModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content" id="modal-content">
          <div class="modal-header">
            <h5 class="modal-title text-center">Configuration</h5>
            <button class="btn btn-secondary" type="button" data-dismiss="modal">&times;</button>
          </div>
          <div class="modal-body">


<form>
  <div class="form-row">
    <div class="form-group col-md-6">
      <label for="Table">Table Name</label>
      <input type="text" class="form-control" id="tableName" placeholder="Table Name">
    </div>
    <div class="form-group col-md-4">
      <label for="Engine">Engine</label>
      <select id="databaseEngines" class="form-control"></select>
           </div>
    
  </div>




<div id='tableView' height="250px">Hello World</div>
<div id='addField1'>



  <div class="form-group">
    <label for="Field">Field</label>
    <input type="text" class="form-control" id=" " placeholder="Field Name">
  </div>
  <div class="form-group">
    <label for="Data Type">Data type</label>

 <select id="datatypes" class="form-control"> </select>



  </div>
  <div class="form-row">
    <div class="form-check">
  <label for="constraints">Constraints</label>

      <input class="form-check-input" type="checkbox" id="gridCheck">
      <label class="form-check-label" for="gridCheck">Primary Key
      </label>
    
<input class="form-check-input" type="checkbox" id="gridCheck">
      <label class="form-check-label" for="gridCheck">Not Null
      </label>
    
<input class="form-check-input" type="checkbox" id="gridCheck">
      <label class="form-check-label" for="gridCheck"> Unique
      </label>
    
<input class="form-check-input" type="checkbox" id="gridCheck">
      <label class="form-check-label" for="gridCheck">Auto Increment
      </label>
    

          </div>
      </div>

<div class="form-row">
    <div class="form-group col-md-6">
      <label for="Table">Width</label>
      <input type="text" class="form-control" id="tableName" placeholder="Table Name">
    </div>
    <div class="form-group col-md-4">
      <label for="Engine">Precision</label>
  <input type="text" class="form-control" id="tableName" placeholder="Engine Name">
        
</div>
    
  </div>
<div class="form-row">
 <div class="form-group col-md-6">
      <label for="Table">Default</label>
      <input type="text" class="form-control" id="tableName" placeholder="Table Name">
    </div>
    <div class="form-group col-md-4">
      <label for="Engine">Check</label>
  <input type="text" class="form-control" id="tableName" placeholder="Table Name">
    </div>
</div>
<div class="form-row">
    
 <div class="form-group col-md-6">
      <label for="Table">Table Name</label>
      <input type="text" class="form-control" id="tableName" placeholder="Table Name">
    </div>
    <div class="form-group col-md-4">
      <label for="Engine">Engine</label>
  <input type="text" class="form-control" id="tableName" placeholder="Table Name">
    </div>        
</div>
    




<button type="button" class="btn btn-primary btn-lg btn-block">Block level button</button>
</form>
</div>
<div class="modal-footer"></div>


















    <!-- Entity Modal-->
    <div class="modal fade" id="entityModal1" tabindex="-1" role="dialog" aria-labelledby="entityModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content" id="modal-content">
          <div class="modal-header">
            <h5 class="modal-title text-center">Configuration</h5>
            <button class="btn btn-secondary" type="button" data-dismiss="modal">&times;</button>
          </div>
          <div class="modal-body">
<label>Table Name</label>
<input type='text' id='tableName'><br/>
<ul class='nav-center'>
<ul class='nav nav-tabs ml-mr-0'>
<li class='nav-tabs' id='descriptionTab'><a href='#description' data-toggle='tab' aria-expanded='true' class='nav-link'>Description</a></li>
<li class='nav-tabs'><a href='#attributeTab' onclick='showAttributeTab()' data-toggle='tab' aria-expanded='false' class='nav-link'>Attributes</a></li>
</div>
<div class='tab-content' id='tabContents'>
<div id='description' class='tab-pane fade in active'>
<label>Engines</label>
<select id='databaseEngines'></select><br/>
<label>Description</label>
<textarea rows='5' col='100' id='note'></textarea>
<br/>
</div>
<div id='attributeTab' class='tab-pane fade in active'>
<div id='tableView' height="250px"></div>
<div id='addField'>
<label>Field</label>
<input type='text' id='fieldName'>
<label>Datatype</label>
<select id='datatypes'></select><br/>
<label>Constraints</label>
<input type='checkbox' id='key'>Key
<input type='checkbox' id='notNull'>NotNull
<input type='checkbox' id='unique'>Unique
<input type='checkbox' id='autoIncrement'>Auto Increment <br/>
<label>Width</label>
<input type='number' id='width'><br/>
<label>Precision</label>
<input type='number' id='precision'><br/>
<label>Default</label>
<input type='text' id='default'><br/>
<label>Check</label>
<input type='text' id='check'><br/>
<button type='submit' onclick='addAttribute()'>OK</button>
</div>
<div id='editField'>
<label>Edit</label>
</div>
<div id='deleteField'>
<label>Delete</label>
</div>
</div>
</div>
</div>
          <div class="modal-footer">
          </div>
        </div>
      </div>
    </div>
</body>

</html>
