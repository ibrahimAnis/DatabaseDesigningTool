<!DOCTYPE html>
<html lang="en" class="no-js">

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
  var showAddForm=false;
  var sqlScript="";
var tableComponents=[];
var databaseTableRelationships=[] // new changes
var relationshipTables=[];
var pTable=null;
var cTable=null;
var project=null;
var selectedTableComponent=null;
var selectedTableIndex=-1
var selectedField=null;
var canvas=null;
var context=null;
var textContext=null;
var rectContext=null;
var DEFAULT_HEIGHT=150;
var DEFAULT_WIDTH=180;
var DRAW_TABLE=false;
var DRAW_TEXT=false;
var DRAW_RELATIONSHIP=false;
var DRAG_TABLE=false;
var selectedMenu="";
var canvasDimension=null;
var index=-1;
var attributeFlag=false;
var isSaved=false;
var prevX=0,prevY=0,currX=0,currY=0;
        var qx=0,qy=0;
        var cx=0,cy=0;
        var isMouseDown=false;
        var oldX=0,oldY=0,newX=0,newY=0,diffX=0,diffY=0;
        var parentTable=null;
     var childTable=null;
     var relationshipCurve=null;
     var relationshipFlag=false;
     var zoomRatio=1;
     var zoomClick=0;
     var loading=false;

function paintAllComponents()
{
drawCurves();
drawTables();
}
function showLoading()
{
  loading=true;
  var div=document.getElementById("loader");
  div.display="block";
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
//console.log("cnt"+cnt);
if(max<cnt) max=cnt;
}
}
if(max==0) return 'table_1';
else return 'table_'+(max+1);
}
function indexOfRelationship(parentTableName,childTableName)
{
  var t;
  for(var i=0;i<databaseTableRelationships.length;++i)
  {
    t=databaseTableRelationships[i];
    if(t.parentTableName==parentTableName && t.childTableName==childTableName) return i;
  }
  return -1;
  }
function indexOfTableComponent(x,y)
{
var obj;
for(var i=0;i<tableComponents.length;i++)
{
obj=tableComponents[i].databaseTable.drawableTable;
//alert("abscissa:"+obj.abscissa+" ordinate:"+obj.ordinate);
if((x>=obj.abscissa) && (x<=(obj.abscissa+obj.width)) && (y>=obj.ordinate) && (y<=(obj.height+obj.ordinate)))
{
console.log("found at "+i);
selectedTableIndex=i;
return i;
}
}
return -1;
}

function parseToField(databaseField)
{
var field=new Field();
field.name=databaseField.name;
var datatype=new Datatype();
datatype.datatype=databaseField.datatype;
datatype.code=getDatatypeCode(databaseField.datatype);
field.datatype=datatype;
field.isPrimaryKey=databaseField.isPrimaryKey;
field.isForeignKey=databaseField.isForeignKey;
field.isNotNull=databaseField.isNotNull;
field.isAutoIncrement=databaseField.isAutoIncrement;
field.numberOfDecimalPlaces=databaseField.precision;
field.width=databaseField.width;
field.isUnique=databaseField.isUnique;
field.note=databaseField.note;
field.checkConstraint="add later";
field.defaultValue=0;
return field;
}

//-------Changes made on 19 March 2020----------------

function Curve(vx1,vy1,vx2,vy2,qx,qy,cx,cy)
{
this.parentAbscissa=vx1;
this.parentOrdinate=vy1;
this.childAbscissa=vx2;
this.childOrdinate=vy2;
this.controlPointX=qx;
this.controlPointY=qy;
this.centerPointX=cx   // center's x coordinate of the circle to the end point of curve
this.centerPointY=cy  // center's y coordinate of the circle to the end point of curve
}


function DatabaseTableRelationship()
{
    this.parentTableName="";
    this.childTableName="";
    this.databaseTableRelationshipKeys=[];
}

function DatabaseTableRelationshipKey()
{
  this.parentTableFieldName="";
  this.childTableFieldName="";
  this.curve=null;
}

/*this.paintAllComponents=function()
			{
                clear(canvas);
                paintRectangles();
                paintLines();

               
               // console.log(selectedRectangle.index);

                
			}*/
            this.clear=function(canvas)
            {
            	canvas.height=canvas.height;
            }

//drawCircle(curve.centerPointX,curve.centerPointY);


function getCoordinates(prevX,prevY,currX,currY,parentTable,childTable)
{

var qx=0,qy=0,cx=0,cy=0

    if((prevX<=currX && prevX+parentTable.databaseTable.drawableTable.width>=currX) || (prevX>=currX && prevX<=currX+childTable.databaseTable.drawableTable.width))
            {
                // in range of x
                if(prevY>=currY)
                {


                    //parent table top edge
                    // child table bottom edge


                    if(prevX<currX)
                    {

                    prevX=parentTable.databaseTable.drawableTable.abscissa+(parentTable.databaseTable.drawableTable.width/2)+((parentTable.databaseTable.drawableTable.width/20)*parentTable.databaseTable.drawableTable.topRelCount);
                    currX=childTable.databaseTable.drawableTable.abscissa+(childTable.databaseTable.drawableTable.width/2)-(childTable.databaseTable.drawableTable.width/20)*childTable.databaseTable.drawableTable.bottomRelCount;
                    
                    }
                    else
                    {
                         prevX=parentTable.databaseTable.drawableTable.abscissa+(parentTable.databaseTable.drawableTable.width/2)-((parentTable.databaseTable.drawableTable.width/20)*parentTable.databaseTable.drawableTable.topRelCount);
                         currX=childTable.databaseTable.drawableTable.abscissa+(childTable.databaseTable.drawableTable.width/2)+(childTable.databaseTable.drawableTable.width/20)*childTable.databaseTable.drawableTable.bottomRelCount;
                    
                    }
                    parentTable.databaseTable.drawableTable.topRelCount+=1;
                    prevY=parentTable.databaseTable.drawableTable.ordinate;
                    currY=childTable.databaseTable.drawableTable.ordinate+childTable.databaseTable.drawableTable.height;
                    childTable.databaseTable.drawableTable.bottomRelCount+=1;
                    qx=prevX;
                    qy=currY;
                    cx=currX;
                    cy=currY+5

                }
                else 
                {
                    // parent table bottom edge
                    // child table top edge
                
                
                    if(prevX<currX)
                    {

                    prevX=parentTable.databaseTable.drawableTable.abscissa+(parentTable.databaseTable.drawableTable.width/2)+((parentTable.databaseTable.drawableTable.width/20)*parentTable.databaseTable.drawableTable.bottomRelCount);
                    currX=childTable.databaseTable.drawableTable.abscissa+(childTable.databaseTable.drawableTable.width/2)-(childTable.databaseTable.drawableTable.width/20)*childTable.databaseTable.drawableTable.topRelCount;
                    
                    }
                    else
                    {
                         prevX=parentTable.databaseTable.drawableTable.abscissa+(parentTable.databaseTable.drawableTable.width/2)-((parentTable.databaseTable.drawableTable.width/20)*parentTable.databaseTable.drawableTable.bottomRelCount);
                         currX=childTable.databaseTable.drawableTable.abscissa+(childTable.databaseTable.drawableTable.width/2)+(childTable.databaseTable.drawableTable.width/20)*childTable.databaseTable.drawableTable.topRelCount;
                    
                    }
                    parentTable.databaseTable.drawableTable.bottomRelCount+=1;
                    prevY=parentTable.databaseTable.drawableTable.ordinate+parentTable.databaseTable.drawableTable.height;
                    currY=childTable.databaseTable.drawableTable.ordinate;
                    childTable.databaseTable.drawableTable.topRelCount+=1;
                    qx=prevX;
                    qy=currY;
                    cx=currX
                    cy=currY+5
                    



                
                }
            }
            else if((prevY<=currY && prevY+parentTable.databaseTable.drawableTable.height>=currY) || (prevY>=currY && prevY<=currY+childTable.databaseTable.drawableTable.height))
            {
                // in range of y
                if(prevX>=currX)
                {
                    //parent table left edge
                    // child table right edge


                    if(prevY<currY)
                    {
                         prevY=parentTable.databaseTable.drawableTable.ordinate+(parentTable.databaseTable.drawableTable.height/2)+((parentTable.databaseTable.drawableTable.height/20)*parentTable.databaseTable.drawableTable.leftRelCount);
                         currY=childTable.databaseTable.drawableTable.ordinate+(childTable.databaseTable.drawableTable.height/2)-(childTable.databaseTable.drawableTable.width/20)*childTable.databaseTable.drawableTable.rightRelCount;
                    
                    }
                    else
                    {
                         prevY=parentTable.databaseTable.drawableTable.ordinate+(parentTable.databaseTable.drawableTable.height/2)-((parentTable.databaseTable.drawableTable.height/20)*parentTable.databaseTable.drawableTable.leftRelCount);
                         currY=childTable.databaseTable.drawableTable.ordinate+(childTable.databaseTable.drawableTable.height/2)+(childTable.databaseTable.drawableTable.width/20)*childTable.databaseTable.drawableTable.rightRelCount;
                    
                    }
                    parentTable.databaseTable.drawableTable.leftRelCount+=1;
                    prevX=parentTable.databaseTable.drawableTable.abscissa;
                    currX=childTable.databaseTable.drawableTable.abscissa+childTable.databaseTable.drawableTable.width;
                    childTable.databaseTable.drawableTable.rightRelCount+=1;
                    qx=prevX;
                    qy=currY;
                    cx=currX+5
                    cy=currY

                }
                else 
                {
                    // parent table right edge
                    // child table left edge

                    if(prevY<currY)
                    {
                         prevY=parentTable.databaseTable.drawableTable.ordinate+(parentTable.databaseTable.drawableTable.height/2)+((parentTable.databaseTable.drawableTable.height/20)*parentTable.databaseTable.drawableTable.rightRelCount);
                         currY=childTable.databaseTable.drawableTable.ordinate+(childTable.databaseTable.drawableTable.height/2)-(childTable.databaseTable.drawableTable.width/20)*childTable.databaseTable.drawableTable.leftRelCount;
                    }
                    else
                    {
                         prevY=parentTable.databaseTable.drawableTable.ordinate+(parentTable.databaseTable.drawableTable.height/2)-((parentTable.databaseTable.drawableTable.height/20)*parentTable.databaseTable.drawableTable.rightRelCount);
                         currY=childTable.databaseTable.drawableTable.ordinate+(childTable.databaseTable.drawableTable.height/2)+(childTable.databaseTable.drawableTable.width/20)*childTable.databaseTable.drawableTable.leftRelCount; 
                    }
                    parentTable.databaseTable.drawableTable.rightRelCount+=1;
                    prevX=parentTable.databaseTable.drawableTable.abscissa+parentTable.databaseTable.drawableTable.width;
                    currX=childTable.databaseTable.drawableTable.abscissa;
                    childTable.databaseTable.drawableTable.leftRelCount+=1;
                    qx=prevX;
                    qy=currY;
                    cx=currX-5
                    cy=currY

                }
            }
           else if(prevX<currX)
            {
                if(prevY>currY)
                {
                    prevX=parentTable.databaseTable.drawableTable.abscissa+(parentTable.databaseTable.drawableTable.width/2)+((parentTable.databaseTable.drawableTable.width/20)*parentTable.databaseTable.drawableTable.topRelCount);
                    parentTable.databaseTable.drawableTable.topRelCount+=1;
                    prevY=parentTable.databaseTable.drawableTable.ordinate;
                    currX=childTable.databaseTable.drawableTable.abscissa;
                    currY=childTable.databaseTable.drawableTable.ordinate+(childTable.databaseTable.drawableTable.height/2)+((childTable.databaseTable.drawableTable.height/20)*childTable.databaseTable.drawableTable.leftRelCount);
                    childTable.databaseTable.drawableTable.leftRelCount+=1;
                    qx=prevX;
                    qy=currY;
                    cx=currX-5
                    cy=currY


                    //parent table top edge
                    // child table left edge

                }
                else if(prevY<currY)
                {
                    //   paretn table right edge
                    // child table top edge
                    prevX=parentTable.databaseTable.drawableTable.abscissa+parentTable.databaseTable.drawableTable.width;
                    prevY=parentTable.databaseTable.drawableTable.ordinate+(parentTable.databaseTable.drawableTable.height/2)+((parentTable.databaseTable.drawableTable.height/20)*parentTable.databaseTable.drawableTable.rightRelCount);
                    parentTable.databaseTable.drawableTable.rightRelCount+=1;
                    currY=childTable.databaseTable.drawableTable.ordinate;
                    currX=childTable.databaseTable.drawableTable.abscissa+(childTable.databaseTable.drawableTable.width/2)-((childTable.databaseTable.drawableTable.width/20)*childTable.databaseTable.drawableTable.topRelCount);
                    childTable.databaseTable.drawableTable.topRelCount+=1;
                    qx=currX;
                    qy=prevY;
                    cx=currX;
                    cy=currY-5
                }

            }
            else if(prevX>currX)
            {
                if(prevY>currY)
                {
                    //parent table top edge
                    // child table right edge

                
                prevX=parentTable.databaseTable.drawableTable.abscissa+(parentTable.databaseTable.drawableTable.width/2)+(parentTable.databaseTable.drawableTable.width/20)*childTable.databaseTable.drawableTable.topRelCount;
                prevY=parentTable.databaseTable.drawableTable.ordinate;
                parentTable.databaseTable.drawableTable.topRelCount+=1;
                currX=childTable.databaseTable.drawableTable.abscissa+childTable.databaseTable.drawableTable.width;
                currY=childTable.databaseTable.drawableTable.ordinate+childTable.databaseTable.drawableTable.height/2+(childTable.databaseTable.drawableTable.height/20*childTable.databaseTable.drawableTable.rightRelCount);
                childTable.databaseTable.drawableTable.rightRelCount+=1;
                qx=prevX;
                qy=currY;
                cx=currX+5;
                cy=currY;
                }
                else if(prevY<currY)
                {
                    //   paretn table left edge
                    // child table top edge

                prevX=parentTable.databaseTable.drawableTable.abscissa;
                prevY=parentTable.databaseTable.drawableTable.ordinate+(parentTable.databaseTable.drawableTable.height/2)+(parentTable.databaseTable.drawableTable.height/20)*parentTable.databaseTable.drawableTable.leftRelCount
                parentTable.databaseTable.drawableTable.leftRelCount+=1;
                currX=childTable.databaseTable.drawableTable.abscissa+(childTable.databaseTable.drawableTable.width/2)+(childTable.databaseTable.drawableTable.width/20)*childTable.databaseTable.drawableTable.topRelCount;
                currY=childTable.databaseTable.drawableTable.ordinate;
                childTable.databaseTable.drawableTable.topRelCount+=1;
                qx=currX;
                qy=prevY;
                cx=currX;
                cy=currY-5;
                }


            }
            //console.log(prevX+" "+prevY)

return {prevX: prevX, prevY: prevY, currX: currX, currY: currY,qx: qx,qy: qy, cx:cx, cy:cy}

}

function drawTables()
{
  for(var i=0;i<tableComponents.length;i++) tableComponents[i].draw();
}
function drawCurves()
        {
          console.log("************DRWING CURVE*****************");
            for (var i=0;i<databaseTableRelationships.length;++i)
{
  console.log("parent table name: "+databaseTableRelationships[i].parentTableName);
  for(var j=0;j<databaseTableRelationships[i].databaseTableRelationshipKeys.length;++j)
  {
  //  console.log("parent table field name "+databaseTableRelationships[i].databaseTableRelationshipKeys[j].curve);
     drawQuadraticCurveTo(databaseTableRelationships[i].databaseTableRelationshipKeys[j].curve);
  }
    /*if(selectedTableComponent && selectedTableComponent!=databaseTableRelationships[i].parent)
    {

    drawQuadraticCurveTo(databaseTableRelationships[i].curve);
    //drawCircle(databaseTableRelationships[i].curve.currX,databaseTableRelationships[i].curve.currY);
    //console.log("line mili");
    }*/
}
        }




function drawQuadraticCurveTo(curve)
  {
    if(!curve) return;
    var prevLineWidth=context.lineWidth;
    var prevFillStyle=context.fillStyle;
    context.globalCompositeOperation="destination-over";
    context.beginPath();
   context.moveTo(curve.parentAbscissa,curve.parentOrdinate);
context.quadraticCurveTo(curve.controlPointX,curve.controlPointY,curve.childAbscissa,curve.childOrdinate);
context.arc(curve.centerPointX,curve.centerPointY,4,0,2*Math.PI)
context.fillStyle='#007bff';
context.lineWidth=3
context.stroke();
context.lineWidth=prevLineWidth;
context.fillStyle=prevFillStyle;
  }




//------------End----------------
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

this.drawText=function(x,y,text)
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

// changes made on 19 March 2020
function DrawableTable(xcor,ycor,vWidth,vHeight)
{
this.abscissa=xcor;
this.ordinate=ycor;
this.height=vHeight;
this.width=vWidth;
this.topRelCount=0;
this.bottomRelCount=0;
this.leftRelCount=0;
this.rightRelCount=0;
this.databaseTable=null;
var THIS=this;
this.drawTable=function()
{

//alert("table processing:"+THIS.databaseTable.title);
context.fillStyle='black';
context.font="20px Times";
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
//alert("number of fields"+databaseFields.length);
for(var i=0;i<databaseFields.length;i++)
{
//alert("field:"+databaseFields[i].name);
databaseField=databaseFields[i];
text=databaseField.name;
text+="          "+(databaseField.datatype.toLowerCase());
if(databaseField.width>0) text+="("+databaseField.width+")";
if(databaseField.isPrimaryKey) text+=" PK";
if(databaseField.isForeignKey) text+=" Fk";
if(databaseField.isUnique) text+=" unn";
if(databaseField.isAutoIncrement) text+=" auto";
if(databaseField.isNotNull) text+=" nn";
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
context.globalCompositeOperation='source-over';
//context.fillStyle="#007bff";
context.fillStyle="#212529";
context.fillRect(THIS.abscissa,THIS.ordinate,THIS.width,40);
context.stroke();
context.fillStyle='white';
context.font="bold 20px Times";
context.fillText(THIS.databaseTable.title,THIS.abscissa+(THIS.width-titleWidth)/2,THIS.ordinate+(80-titleHeight)/2);
context.stroke();
context.fillStyle='black';
drawLine(THIS.abscissa,THIS.ordinate+40,THIS.abscissa+THIS.width,THIS.ordinate+40);
context.stroke();
context.fillStyle='black';
context.rect(THIS.abscissa,THIS.ordinate,THIS.width,THIS.height);
context.stroke();
context.font="normal 20px Times";
tmp=40;
context.globalCompositeOperation='destination-over';
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
this.primaryKeyCount=0;
this.alternateKeyCount=0;
this.databaseFields=[]
this.childs=[];
this.parents=[];
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
this.isForeignKey=false;
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
var engine=new Engine();
engine.name="InnoDB";
engine.code=getEngineCode(engine.name);
var table=new Table();
table.name=dTable.title;
table.abscissa=x;
table.ordinate=y;
table.fields=[];
table.childs=[];
table.parents=[];
table.engine=engine;
table.numberOfFields=0;
tableComponent.databaseTable=dTable;
tableComponent.draw();
tableComponents.push(tableComponent);
tables.push(table);
//alert("drew")
//alert(tables.length);
return tableComponent;
}
function onTableMenuClicked()
{
selectedMenu="CREATE_TABLE";
}

function onRelationshipMenuClicked()
{
  selectedMenu="CREATE_RELATIONSHIP";
}


function getTableDict()
{
  dict={};
  table=null;
  for(var i=0;i<tableComponents.length;++i)
  {
    table=tableComponents[i].databaseTable;
    dict[table.title]={table:tables[i],tableComponent:tableComponents[i]};
  }
  return dict;
}



// Initialising Project
function initializeProject()
{
  $('#preloader').delay(2000).fadeOut('slow'); // will fade out the white DIV that covers the website. 
  $('body').css({'overflow':'visible'});



canvas=document.getElementById("canvas");
context=canvas.getContext("2d");
projectserviceManager.getProject(function(data)
{
var select=document.getElementById('databaseEngines');
var options=data.databaseArchitecture.engines;
var option=null;
project=data;
//alert(JSON.stringify(project));
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
var table=null;
var field=null;
var child=null;
var curve=null;
var fields=[];
var childs=[];
var parents=[];
var datatype=null;
var engine=null;
var rtk=null;
var adjacenTable=null;
var adjacentTableComponent=null;
tables=project.tables;
var visited=Array(tables.length);
var dict=Array(tables.length);
for(var i=0;i<tables.length;i++)
{
table=tables[i];
engine=table.engine;
drawableTable=new DrawableTable(table.abscissa,table.ordinate,DEFAULT_WIDTH,DEFAULT_HEIGHT);
databaseTable=new DatabaseTable(table.name,drawableTable);
databaseTable.title=table.name;
databaseTable.engine=engine.name;
delete table.numberofFields;
databaseTable.note=table.note;
fields=table.fields;
childs=table.childs;
//alert("childs list:"+JSON.stringify(childs));
//alert("parent list: "+JSON.stringify(parents));
for(var j=0;j<fields.length;j++)
{
field=fields[j];
datatype=field.datatype;
databaseField=new DatabaseField();
databaseField.name=field.name;
databaseField.datatype=datatype.datatype;
databaseField.width=field.width;
databaseField.isPrimaryKey=field.isPrimaryKey;
databaseField.isForeignKey=field.isForeignKey;
databaseField.isAutoIncrement=field.isAutoIncrement;
databaseField.isUnique=field.isUnique;
databaseField.isNotNull=field.isNotNull;
databaseField.defaultValue=field.defaultValue;
databaseField.checkConstraint=field.checkConstraint;
databaseField.note=field.note;
databaseTable.databaseFields.push(databaseField);
}

visited[table.name]=false;
tableComponent=new TableComponent();
tableComponent.databaseTable=databaseTable;
tableComponent.drawableTable=drawableTable;
tableComponent.drawableTable.databaseTable=databaseTable;
tableComponents.push(tableComponent);
dict[table.name]={table:tables[i],tableComponent:tableComponents[i]};
}

stk=[];
for(var i=0;i<tables.length;++i)
{
  if(visited[tables[i].name]==true) continue;
  src=tables[i];
  stk.push(src);
  visited[src.name]=true;
  console.log("src: "+src.name)
  while(stk.length>0)
  {
    table=stk.pop();
    console.log("popped: "+table.name)
    console.log("childs length "+table.childs.length)
    visited[table.name]=true;
    tableComponent=dict[table.name].tableComponent;
    tableComponent.draw();
    for(var j=0;j<table.childs.length;++j)
    {
      adj=table.childs[j];

      x=dict[adj.childTableName];
      //alert("child: "+adj.childTableName);
      adjacentTableComponent=x.tableComponent;
      adjacentTable=x.table;
      databaseTableRelationship=new DatabaseTableRelationship();
      databaseTableRelationship.parentTableName=adj.parentTableName;
      databaseTableRelationship.childTableName=adj.childTableName;
      databaseTableRelationship.databaseTableRelationshipKeys=[];
      for(var k=0;k<adj.relationshipTableKeys.length;++k)
      {
        rtk=adj.relationshipTableKeys[k];
        //alert("parent field name: "+rtk.parentTableFieldName);
        //alert("child field name: "+rtk.childTableFieldName);
        databaseTableRelationshipKey=new DatabaseTableRelationshipKey();
        databaseTableRelationshipKey.parentTableFieldName=rtk.parentTableFieldName;
        databaseTableRelationshipKey.childTableFieldName=rtk.childTableFieldName;
        curve=new Curve(0,0,0,0,0,0,0,0);
        prevX=table.abscissa
        prevY=table.ordinate
        currX=adjacentTable.abscissa
        currY=adjacentTable.ordinate;        
        var cords=getCoordinates(prevX,prevY,currX,currY,tableComponent,adjacentTableComponent);
         //alert(JSON.stringify(cords))
         curve=new Curve(cords.prevX,cords.prevY,cords.currX,cords.currY,cords.qx,cords.qy,cords.cx,cords.cy);
         databaseTableRelationshipKey.curve=curve;
         drawQuadraticCurveTo(curve);
         databaseTableRelationship.databaseTableRelationshipKeys.push(databaseTableRelationshipKey);
      }
      tableComponent.databaseTable.childs.push(databaseTableRelationship);
      adjacentTableComponent.databaseTable.parents.push(databaseTableRelationship);
        adjacentTable.parents.push(adj);
        databaseTableRelationships.push(databaseTableRelationship);
        if(visited[adj.childTableName]==false) stk.push(adjacentTable);
           
    }
  }
}


//paintAllComponents();

//alert("populating ends here");
},function(error)
{
alert(JSON.stringify(error));
});

$('#relationshipModal').on('shown.bs.modal',function()
{
var select=document.getElementById('parentTableFields');
//alert(JSON.stringify(data.databaseArchitecture));
var options=parentTable.databaseTable.databaseFields;
var option=null;
for(var i=0;i<options.length;i++)
{
option=document.createElement("OPTION");
option.value=JSON.stringify(options[i])
option.label=options[i].name;
if(i==0) option.selected='true';
select.appendChild(option);
}
select=document.getElementById('childTableFields');
options=childTable.databaseTable.databaseFields;
option=null;
for(var i=0;i<options.length;i++)
{
option=document.createElement("OPTION");
option.value=JSON.stringify(options[i])
option.label=options[i].name;
if(i==0) option.selected='true';
select.appendChild(option);
}
});

$("#Save").on('shown.bs.modal',function()
{
  var div=document.getElementById("messageBody")
  while(div.hasChildNodes()) div.removeChild(div.firstChild)
  var element=document.createElement("strong");
  element.innerHTML="Saved Successfully !!";
      div.appendChild(element);
});






$("#longModal").on('shown.bs.modal',function()
{
  var div=document.getElementById("scriptBody")
  while(div.hasChildNodes()) div.removeChild(div.firstChild)
  var p=null;
  var breakLine=null;
  var text="";
  for(var i=0;i<sqlScript.length;++i)
  {
    if(sqlScript[i]=='\n')
    {
      p=document.createElement("p");
      p.innerHTML=text;
      text="";
      breakLine=document.createElement("br");
      p.appendChild(breakLine);
      div.appendChild(p);
    }
    text+=sqlScript[i];
  }
  if(text.length>0)
  {p=document.createElement("p");
      p.innerHTML=text;
      text="";
      breakLine=document.createElement("br");
      p.appendChild(breakLine);
      div.appendChild(p);
  }
});

$("#relationshipModal").on('hidden.bs.modal',function()
{
if(relationshipFlag)
{
  var select,parentTableField,childTableField,databaseTableRelationshipKey;
  select=document.getElementById("parentTableFields");
  if(select==null)
  {
selectedMenu="";
isMouseDown=false;
parentTable=null;
childTable=null;
relationshipFlag=false;
return;
  }
  else if(select.selectedIndex==-1)
  {
  selectedMenu="";
isMouseDown=false;
parentTable=null;
childTable=null;
relationshipFlag=false;
alert("Choose parent table field");
return;
  }
  //alert(select.selectedIndex);
  parentTableField=JSON.parse(select.options[select.selectedIndex].value);
  select=document.getElementById("childTableFields");
  if(select==null)
  {
selectedMenu="";
isMouseDown=false;
parentTable=null;
childTable=null;
relationshipFlag=false;
return;
  }
  else if(select.selectedIndex==-1)
  {
  selectedMenu="";
isMouseDown=false;
parentTable=null;
childTable=null;
relationshipFlag=false;
alert("Choose child table field");
return;
  }
  childTableField=JSON.parse(select.options[select.selectedIndex].value);
  var cTableField=cTable.fields[select.selectedIndex];
  databaseTableRelationshipKey=new DatabaseTableRelationshipKey();
  databaseTableRelationshipKey.parentTableFieldName=parentTableField.name;
  databaseTableRelationshipKey.childTableFieldName=childTableField.name;
  databaseTableRelationshipKey.curve=relationshipCurve;
  var relationshipTableKey=new RelationshipTableKey();
  relationshipTableKey.parentTableFieldName=parentTableField.name;
  relationshipTableKey.childTableFieldName=childTableField.name;
  childTableField.isForeignKey=true;
  cTableField.isForeignKey=true;
  //alert(parentTableField.name);
  var index=indexOfRelationship(parentTable,childTable);
  var databaseTableRelationship=null;
  var relationshipTable=null;
  if(index==-1)
  {
    databaseTableRelationship=new DatabaseTableRelationship();
    databaseTableRelationship.parentTableName=parentTable.databaseTable.title;
         databaseTableRelationship.childTableName=childTable.databaseTable.title;
         databaseTableRelationship.databaseTableRelationshipKeys.push(databaseTableRelationshipKey);
         parentTable.databaseTable.childs.push(databaseTableRelationship);
         childTable.databaseTable.parents.push(databaseTableRelationship);
         databaseTableRelationships.push(databaseTableRelationship);
         relationshipTables.push(relationshipTable);
         relationshipTable=new RelationshipTable();
         relationshipTable.name="Abhi bacha he";
         relationshipTable.parentTableName=pTable.name;
         relationshipTable.childTableName=cTable.name;
         relationshipTable.relationshipTableKeys=[];
         relationshipTable.relationshipTableKeys.push(relationshipTableKey);
         pTable.childs.push(relationshipTable);
         cTable.parents.push(relationshipTable); 
  } 
  else
  {
    databaseTableRelationship=databaseTableRelationships[index];
    relationshipTable=relationshipTables[index];
         databaseTableRelationship.databaseTableRelationshipKeys.push(databaseTableRelationshipKey);
         relationshipTable.relationshipTableKeys.push(relationshipTableKey);
  } 
         drawQuadraticCurveTo(relationshipCurve);
}
else {
  selectedMenu="";
isMouseDown=false;
parentTable=null;
childTable=null;
return;
}

if(select.hasChildNodes()) while (select.hasChildNodes()) select.removeChild(select.firstChild);
  select=document.getElementById("parentTableFields");
  if(select.hasChildNodes()) while (select.hasChildNodes()) select.removeChild(select.firstChild);
selectedMenu="";
isMouseDown=false;
parentTable=null;
childTable=null;
});
$("#entityModal").on('shown.bs.modal',function()
{
attributeFlag=false;
var entityModal=$("#entityModal");
var tableBox=entityModal.find("#tableName");
tableBox.val(selectedTableComponent.databaseTable.title);

var entityController=new EntityController(selectedTableComponent,selectedTableIndex);

var div=document.getElementById('addField');
if(!showAddForm) div.style.display='none';
div=document.getElementById('editField')
div.style.display='none';

//alert("table name"+selectedTableComponent.databaseTable.title);
//$("#databaseEngines").find(":selected").val(selectedTableComponent.databaseTable.engine);
//document.getElementById("databaseEngines").value=selectedTableComponent.databaseTable.engine;
});
$("#entityModal").on('hidden.bs.modal',function()
{
selectedTableComponent.databaseTable.engine=document.getElementById("databaseEngines").value;
var engine=new Engine();
engine.name=selectedTableComponent.databaseTable.engine;
engine.code=getEngineCode(engine.name);
tables[selectedTableIndex].engine=engine;
//selectedTableComponent.databaseTable.drawableTable.eraseCircles();
//selectedTableComponent.databaseTable.drawableTable.drawTable();
selectedTableComponent.databaseTable.drawableTable.drawCircles();
document.getElementById("addField").style.display='none';
var tableDiv=$("#tableDiv")
  var tableName=tableDiv.find("#tableName");
if(tableName.hasClass("is-invalid")) tableName.removeClass("is-invalid");
if(tableName.hasClass("is-valid")) tableName.removeClass("is-valid");
});
canvas=document.getElementById("canvas");
context=canvas.getContext("2d");
canvas.style.font="20px Times";
context.font='20px Times';
rectContext=canvas.getContext("2d");
textContext=canvas.getContext("2d");
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

// New changes 20 march 2019---------
canvas.onmousemove=function(event)
{
    newX=event.clientX;
    newY=event.clientY;
    diffX=newX-oldX;
    diffY=newY-oldY;
    var cords;
    if(selectedMenu=="CREATE_RELATIONSHIP") return;
    if(isMouseDown && selectedTableComponent)
    {
      isSaved=false;
      //console.log("mouse is down")
        clear(canvas);
        paintAllComponents()
            selectedTableComponent.databaseTable.drawableTable.abscissa+=diffX;

            selectedTableComponent.databaseTable.drawableTable.ordinate+=diffY;

for(var i=0;i<selectedTableComponent.databaseTable.childs.length;++i)
{
for(var j=0;j<selectedTableComponent.databaseTable.childs[i].databaseTableRelationshipKeys.length;++j)
{
    selectedTableComponent.databaseTable.childs[i].databaseTableRelationshipKeys[j].curve.parentAbscissa+=diffX
    selectedTableComponent.databaseTable.childs[i].databaseTableRelationshipKeys[j].curve.parentOrdinate+=diffY
    selectedTableComponent.databaseTable.childs[i].databaseTableRelationshipKeys[j].curve.controlPointX+=diffX

   /* cords=getCoordinates(newX,newY,selectedTableComponent.databaseTable.childs[i].curve.childAbscissa,selectedTableComponent.databaseTable.childs[i].curve.childOrdinate,selectedTableComponent.databaseTable,selectedTableComponent.databaseTable.childs[i])
            selectedTableComponent.databaseTable.childs[i].curve.parentAbscissa=cords.prevX  // updating the new location of parent table that is being moved by user
             
            selectedTableComponent.databaseTable.childs[i].curve.parentOrdinate=cords.prevY
             
            selectedTableComponent.databaseTable.childs[i].curve.controlPointX=cords.qx;
            //selectedTableComponent.databaseTable.childs[i].curve.centerPointX=cords.cx;  not required it will remain same because we are moving parent child
            //selectedTableComponent.databaseTable.childs[i].curve.centerPointX=cords.cy;*/
          //  selectedTableComponent.databaseTable.childs[i].curve=new Curve(cords.prevX,cords.prevY,cords.currX,cords.currY,cords.qx,cords.qy,cords.cx,cords.cy)

            drawQuadraticCurveTo(selectedTableComponent.databaseTable.childs[i].databaseTableRelationshipKeys[j].curve);
}
}

for(var i=0;i<selectedTableComponent.databaseTable.parents.length;++i)

{
  for(var j=0;j<selectedTableComponent.databaseTable.parents[i].databaseTableRelationshipKeys.length;++j)
{
    selectedTableComponent.databaseTable.parents[i].databaseTableRelationshipKeys[j].curve.childAbscissa+=diffX;
    selectedTableComponent.databaseTable.parents[i].databaseTableRelationshipKeys[j].curve.childOrdinate+=diffY
    selectedTableComponent.databaseTable.parents[i].databaseTableRelationshipKeys[j].curve.controlPointY+=diffY
    selectedTableComponent.databaseTable.parents[i].databaseTableRelationshipKeys[j].curve.centerPointX+=diffX
    selectedTableComponent.databaseTable.parents[i].databaseTableRelationshipKeys[j].curve.centerPointY+=diffY


    /*cords=getCoordinates(selectedTableComponent.databaseTable.parents[i].curve.x1,selectedTableComponent.databaseTable.parents[i].curve.parentOrdinate,selectedTableComponent.databaseTable.parents[i].curve.childAbscissa,selectedTableComponent.databaseTable.parents[i].curve.childOrdinate,selectedTableComponent.databaseTable.parents[i],selectedTableComponent.databaseTable)
           selectedTableComponent.databaseTable.parents[i].curve.childAbscissa=cords.currX;
             
            selectedTableComponent.databaseTable.parents[i].curve.childOrdinate=cords.currY;
             
            selectedTableComponent.databaseTable.parents[i].curve.centerPointX=cords.cx
            
            selectedTableComponent.databaseTable.parents[i].curve.centerPointY=cords.cy
             
            selectedTableComponent.databaseTable.parents[i].curve.controlPointY=cords.qy*/
          //  selectedTableComponent.databaseTable.parents[i].curve=new Curve(cords.prevX,cords.prevY,cords.currX,cords.currY,cords.qx,cords.qy,cords.cx,cords.cy)
            drawQuadraticCurveTo(selectedTableComponent.databaseTable.parents[i].databaseTableRelationshipKeys[j].curve);
}
}

     selectedTableComponent.draw();
          }
        oldX=newX;
        oldY=newY;
    }

    canvas.onmousedown=function(event)
{
    oldX=event.clientX;
    oldY=event.clientY
    isMouseDown=true;
    var relativeX=event.clientX-canvasDimension.left;
var relativeY=event.clientY-canvasDimension.top;
//alert(isMouseDown);
index=indexOfTableComponent(relativeX,relativeY);
if(index==-1 || tableComponents[index]!=selectedTableComponent)
{
   selectedTableComponent=null;
   selectedTableIndex=-1;

}
}



// End

canvas.onmouseup=function(event)
{
isMouseDown=false;
var title,childX,childY,parentX,parentY;
var relativeX=event.clientX-canvasDimension.left;
var relativeY=event.clientY-canvasDimension.top;
//alert(isMouseDown);
index=indexOfTableComponent(relativeX,relativeY);
clear(canvas);
paintAllComponents();
if(selectedMenu=='CREATE_TABLE')
{
selectedTableComponent=createTable(relativeX,relativeY,DEFAULT_WIDTH,DEFAULT_HEIGHT);
selectedTableComponent.databaseTable.drawableTable.drawCircles();
selectedMenu="";
}
else if(selectedMenu=="CREATE_RELATIONSHIP")
{
if(index!=-1)
{
  selectedTableComponent=tableComponents[index];
  selectedTableIndex=index;
}
else{
  alert("choose Table correctly");
  selectedMenu="";
  if(parentTable) parentTable=null;
  if(childTable) childTable=null;
  selectedTableComponent=null;
  selectedTableIndex=-1;
  return;
}
if(!parentTable) 
        {
            parentTable=selectedTableComponent;
            pTable=tables[selectedTableIndex];
            // find coordinates of points
            prevX=event.clientX;
            prevY=event.clientY;
        }
        else if(!childTable)
        {
    
         currX=event.clientX;
         currY=event.clientY;
         childTable=selectedTableComponent
         cTable=tables[selectedTableIndex]
         var cords=getCoordinates(prevX,prevY,currX,currY,parentTable,childTable)
         //alert(JSON.stringify(cords))
         relationshipCurve=new Curve(cords.prevX,cords.prevY,cords.currX,cords.currY,cords.qx,cords.qy,cords.cx,cords.cy);
         $('#relationshipModal').modal({backdrop:'static', keyboard:false});
        }


}
else 
{
// drag and drop
// draw blue circles around dragged table after redrawing whole canvas;
/*clear(canvas);
paintAllComponents();*/
if(index==-1) 
{
if(selectedTableComponent)
{
   selectedTableComponent=null;
selectedTableIndex=-1;
}
selectedMenu=""
}
else
{
//  console.log("draw circle")
selectedTableComponent=tableComponents[index];
selectedTableIndex=index;
//alert(JSON.stringify(selectedTableComponent.databaseTable.databaseFields[0]));
selectedTableComponent.databaseTable.drawableTable.drawCircles();

}

} 
}

} // attach events end here


var isAttributeActive=false;
var isDescriptionActive=false;

function addAttribute()
{
  //alert("Adding field....");
isSaved=false;
var div=$("#addField");
var fieldName=div.find("#fieldName");
var datatypes=div.find("#datatypes");
var isNotNull=document.getElementById("notNull");
var isPrimaryKey=document.getElementById("key");
var isUnique=document.getElementById("unique");
var width=document.getElementById('width');
//var precision=document.getElementById('precision');
var autoIncrement=document.getElementById('autoIncrement');
//var check=div.find("#check");
var defaultField=div.find("#default");
var databaseField=new DatabaseField();
databaseField.name=fieldName.val();
databaseField.datatype=datatypes.find(":selected").val();
//alert(databaseField.datatype);
databaseField.isNotNull=isNotNull.checked;
databaseField.isPrimaryKey=isPrimaryKey.checked;
databaseField.isForeignKey=false;
databaseField.defaultValue=defaultField.val();
//databaseField.checkConstraint="Not complete"
databaseField.isAutoIncrement=autoIncrement.checked;
databaseField.isUnique=isUnique.checked;
databaseField.width=width.value;
//alert(width.value);
databaseField.precision=0; // incomplete
selectedTableComponent.databaseTable.databaseFields.push(databaseField);
var field=new Field();
field.name=databaseField.name;
var datatype=new Datatype();
datatype.datatype=databaseField.datatype;
datatype.code=getDatatypeCode(databaseField.datatype);
field.datatype=datatype;
field.isPrimaryKey=databaseField.isPrimaryKey;
field.isForeignKey=databaseField.isForeignKey;
field.isNotNull=databaseField.isNotNull;
field.isAutoIncrement=databaseField.isAutoIncrement;
field.numberOfDecimalPlaces=databaseField.precision;
field.width=databaseField.width;
field.isUnique=databaseField.isUnique;
field.note=databaseField.note;
field.checkConstraint="add later";
field.defaultValue=0;
tables[selectedTableIndex].fields.push(field);
//alert(tables[selectedTableIndex].fields.length);

if(selectedTableComponent.entityController!=null)
{
  //alert(selectedTableComponent.entityController);
  selectedTableComponent.entityController.updateTable(selectedTableComponent.databaseTable.databaseFields);

} 
else
{
  var entityController=new EntityController(selectedTableComponent,selectedTableIndex);
  selectedTableComponent.entityController=entityController;

//console.log("entity controller is "+selectedTableComponent.entityController)
}

fieldName.val("");
isNotNull.checked=false;
isUnique.checked=false;
isPrimaryKey.checked=false;
autoIncrement.checked=false;
//check.val("");
defaultField.val("");
width.value=0;
//alert("ends here");
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


function dismissRelationship()
{
  relationshipFlag=false;
  $('#relationshipModal').modal('hide');
}
function addRelationship()
{
relationshipFlag=true;
isSaved=false;
$('#relationshipModal').modal('hide');

}

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
//alert("row count:"+rowCount);
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
image.onclick=cellContentClickHandlerCreator(i,j);
td.appendChild(image);
}
else
{
image.src=src[0];
image.onclick=cellContentClickHandlerCreator(i,j);
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
setTimeout(function()   // not done
{
THIS.onCellContentClicked(selectedRowIndex,cellNumber);
},100);
}
}

function createTable()
{
isSaved=false;
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
function EntityModel(vDatabaseFields)
{
this.numberOfRecords=0;
if(vDatabaseFields) this.numberOfRecords=vDatabaseFields.length;
this.databaseFields=null;
this.databaseFields=vDatabaseFields;
this.navigationButtonCount=5;
this.grid=null;
var titles=["S.No","Key","Field Name","Datatype","NotNull","Unique","Edit","Delete"];
var THIS=this;
this.setSelectedRow=function(rowNumber)
{
THIS.grid.selectRow(rowNumber);
}
this.setDatabaseFieldCount=function(vNumberOfRecords)
{
numberOfRecords=vNumberOfRecords;
}
this.setGrid=function(vGrid)
{
THIS.grid=vGrid;
}
this.getDatabaseField=function(index)
{
return THIS.databaseFields[index];
}
this.getRowCount=function()
{
return THIS.databaseFields.length;
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
if(columnIndex==0) return "50px";
if(columnIndex==1) return "90px";
if(columnIndex==2) return "250px";
if(columnIndex==3) return "116px";
if(columnIndex==4) return "60px";
if(columnIndex==5) return "60px";
if(columnIndex==6) return "60px";
if(columnIndex==7) return "60px";
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
else if(columnIndex==1) return "iconColumn";
else if(columnIndex==2) return "fieldColumn";
else if(columnIndex==3) return "fieldColumn";
else return "iconColumn";
}
this.getCellType=function(rowIndex,columnIndex)
{
if(columnIndex==0) return "TEXT";
else if(columnIndex==1) return "IMAGE";
else if(columnIndex==2) return "TEXT";
else if(columnIndex==3) return "TEXT";
else return "IMAGE";
}
this.getValueAt=function(rowIndex,columnIndex)
{
  var databaseFields=THIS.databaseFields;
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
if(columnIndex==6) return "/dmodel/images/edit_icon.png";
if(columnIndex==7) return "/dmodel/images/delete_icon.png";
}
this.setDatabaseFields=function(vDatabaseFields)
{
THIS.databaseFields=vDatabaseFields;
//if(!THIS.grid) alert("grid is null");
THIS.grid.update();
}
}
function EntityController(vSelectedTableComponent,vSelectedTableIndex)
{
this.entityModel=null;
this.entityGrid=null;
this.databaseFields=vSelectedTableComponent.databaseTable.databaseFields;
var THIS=this;
this.entityModel=new EntityModel(this.databaseFields);
this.entityGrid=new EntityGrid(this.entityModel,'tableView');
var databaseField=null;
var databaseTable=null;
var table=null;
var THIS=this;
/*if(databaseFields)
{
entityModel.setDatabaseFieldCount(databaseFields.length);
entityModel.setDatabaseFields(databaseFields);
}*/
this.entityGrid.onRowSelected=function(index)
{
alert(JSON.stringify(THIS.entityModel.getDatabaseField(index)));
}
this.entityGrid.onCellContentClicked=function(rowIndex,columnIndex)
{
//  console.log("chala"+rowIndex+" "+columnIndex);
if(columnIndex==6)
{
 //  alert("The user wants to edit:->"+JSON.stringify(THIS.entityModel.getDatabaseField(rowIndex)));
}
if(columnIndex==7)
{
  //alert("The user wants to delete:->"+JSON.stringify(THIS.entityModel.getDatabaseField(rowIndex)));
  databaseField=THIS.entityModel.getDatabaseField(rowIndex);
  //alert("before delete:"+THIS.databaseFields[rowIndex].name);
  THIS.databaseFields.splice(rowIndex,1);
  //alert("after delete"+THIS.databaseFields[rowIndex].name);
  databaseTable=selectedTableComponent.databaseTable;
  databaseTable.childs=[];
  databaseTable.databaseFields.splice(rowIndex,1);
  table=tables[selectedTableIndex];
  table.fields.splice(rowIndex,1);

  var dict=getTableDict()
var relationshipTable=null;
var x;
var i,j,k;
var ind=-1;
var relationshipTableKey=null;
var indices=[]
  for(i=0;i<table.childs.length;++i)
  {
    relationshipTable=table.childs[i];
    x=dict[relationshipTable.childTableName];
    childTable=x.table;
    childTableComponent=x.tableComponent;
    for(j=0;j<childTable.parents.length;++j)
    {
      relationshipTable=childTable.parents[j];
      databaseTableRelationship=childTableComponent.databaseTable.parents[j];
      for(k=0;k<relationshipTable.relationshipTableKeys.length;++k)
      {
        relationshipTableKey=relationshipTable.relationshipTableKeys[k];
        if(relationshipTableKey.parentTableFieldName==databaseField.name)
        {
          break;
          ind=indexOfRelationship(relationshipTable.parentTableName,relationshipTable.childTableName);
          databaseTableRelationships[ind].databaseTableRelationshipKeys.splice(k,1);
        }
      }
      relationshipTable.relationshipTableKeys.splice(k,1);
      databaseTableRelationship.databaseTableRelationshipKeys.splice(k,1);
      if(relationshipTable.relationshipTableKeys.length==0) indices.push(j);
    }
    for(var t=0;t<indices.length;++t)
    {
      childTableComponent.databaseTable.parents.splice(indices[t],1);
       childTable.parents.splice(indices[t],1);
  }
  //alert("end");
  table.childs=[];
  selectedTableComponent.databaseTable.childs=[];
  THIS.updateTable(THIS.databaseFields);
  paintAllComponents();
} 
}
}
this.updateTable=function(databaseFields)
{
//alert("updating table after deletion"+JSON.stringify(databaseFields));
THIS.entityModel.setDatabaseFields(databaseFields);
}
}  // EntityController ends here


function getEngineCode(name)
{
var engines=project.databaseArchitecture.engines;
for(var i=0;i<engines.length;i++)
{
if(engines[i].name==name)
{
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
return datatypes[i].code;
}
}
return -1;
}


function save()
{
  var tb;
  var tl;
  var db;

for(var i=0;i<tables.length;++i)
{
  tables[i].abscissa=tableComponents[i].databaseTable.drawableTable.abscissa;
  tables[i].ordinate=tableComponents[i].databaseTable.drawableTable.ordinate;

}

project.tables=tables;
projectserviceManager.saveProject(project,function(data)
{
 //alert("Saved");
//alert(JSON.stringify(data));

$('#Save').modal({backdrop:'static', keyboard:false});

isSaved=true;
},function(err)
{
alert(JSON.stringify(err));
});
}

function download()
{
//var downloadImageButton=document.createElement("A");
var image=canvas.toDataURL("image/png").replace("image/png","image/octet-stream");
//downloadImageButton.=project.title+".png";
//downloadImageButton.setAttribute("href",image);
window.location.href=image;
}

function generateScript()
{
  if(isSaved)
  {
    //window.location.href='/dmodel/webservice/projectservice/generateScript';
    projectserviceManager.generateScript(function(data)
    {
      sqlScript=data;
     $('#longModal').modal({backdrop:'static', keyboard:false});
    },function(error)
    {
      alert(error)
    });
  }
  else
  {
    alert("Data Not Saved")
  }
}

function zoomIn()
{
  clear(canvas);
  zoomClick++;
  zoomRatio=(zoomClick*10+100)/100;
  context.scale(zoomRatio,zoomRatio);
  paintAllComponents();
}
function zoomOut()
{
  zoomClick--;
  clear(canvas);
  zoomRatio=(zoomClick*10+100)/100;
  context.scale(zoomRatio,zoomRatio);
  paintAllComponents();
}


function onAddButtonClicked()
{
  showAddForm=true;
  var div=document.getElementById("addField");
  if(div.style.display=='none') div.style.display='block'
}
function onCancelButtonClicked()
{
  var div=$("#addField");
var fieldName=div.find("#fieldName");
var datatypes=div.find("#datatypes");
var isNotNull=document.getElementById("notNull");
var isPrimaryKey=document.getElementById("key");
var isUnique=document.getElementById("unique");
var width=document.getElementById('width');
//var precision=document.getElementById('precision');
var autoIncrement=document.getElementById('autoIncrement');
//var check=div.find("#check");
var defaultField=div.find("#default");
fieldName.val("");
isNotNull.checked=false;
isUnique.checked=false;
isPrimaryKey.checked=false;
autoIncrement.checked=false;
//check.val("");
defaultField.val("");
width.value=0;
showAddForm=false;
document.getElementById("addField").style.display='none'

}
function saveTableName()
{
  var label=document.getElementById("label");
  var tableNameError=document.getElementById("tableNameError");
  var tableDiv=$("#tableDiv")
  var tableName=tableDiv.find("#tableName");
  var name=tableName.val().trim();
  //alert(name);
  for(var i=0;i<tableComponents.length;++i)
  {
    if(tableComponents[i].databaseTable.title==name)
    {
      if(tableName.hasClass("is-valid"))
      {
        tableName.removeClass("is-valid");
        label.innerHTML="";
      }
      tableName.addClass("is-invalid");
      tableNameError.innerHTML="Name exists";
      //tableDiv.addClass("is-invalid");
      return;
    }
  }
if(name.length>0)
{
   selectedTableComponent.databaseTable.title=name;
   tables[selectedTableIndex].name=name;
   if(tableName.hasClass("is-invalid"))
   {
      tableName.removeClass("is-invalid");
      tableNameError.innerHTML="";
   }
   tableName.addClass("is-valid");
   label.innerHTML="Table Name Saved";
}
else 
{
  tableName.addClass("is-invalid");
   tableNameLabel.innerHTML="Choose a valid table name";  
}
}


window.onclick = function(event) {
  var modal = document.getElementById('Save');
  if (event.target == modal) {
    $("#Save").modal('hide')
  }
}


</script>
<style>

.canvasStyle
{
border: 1px solid black;
overflow-x: scroll;
overflow-y: scroll;
}


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

/* Paste this css to your style sheet file or under head tag */
/* This only works with JavaScript, 
if it's not present, don't show loader */



body {
  overflow: hidden;
}


/* Preloader */

#preloader {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color:#343a40;
  /* change if the mask should have another color then white */
  z-index: 99;
  /* makes sure it stays on top */
}

#status {
  width: 200px;
  height: 200px;
  position: absolute;
  left: 50%;
  /* centers the loading animation horizontally one the screen */
  top: 50%;
  /* centers the loading animation vertically one the screen */
  background: url(/dmodel/images/loader2.gif) center no-repeat #343a40;
  /* path to your loading animation */
  background-repeat: no-repeat;
  background-position: center;
  margin: -100px 0 0 -100px;
  /* is width and height divided by two */
}



/* Tooltip container */
.tooltip {
  position: relative;
  display: inline-block;
  border-bottom: 1px dotted black; /* If you want dots under the hoverable text */
}

/* Tooltip text */
.tooltip .tooltiptext {
  visibility: hidden;
  width: 120px;
  background-color: black;
  color: #fff;
  text-align: center;
  padding: 5px 0;
  border-radius: 6px;
 
  /* Position the tooltip text - see examples below! */
  position: absolute;
  z-index: 1;
}

/* Show the tooltip text when you mouse over the tooltip container */
.tooltip:hover .tooltiptext {
  visibility: visible;
}
</style>











</style>
<!--script>
	//paste this code under head tag or in a seperate js file.
	// Wait for window load
	$(window).load(function() {
		// Animate loader off screen
		//$(".se-pre-con").fadeOut("slow");;
	});
</script-->

</head>

<body id="page-top" >
  <!-- Paste this code after body tag -->
	<div id="preloader">
    <div id="status">&nbsp;</div>
  </div>
	<!-- Ends -->
	

    <nav class="navbar navbar-expand navbar-dark bg-dark static-top">

      <a class="navbar-brand mr-1" href="homepage.jsp" id='title'>${currentProject.title}</a>

      <!-- Navbar Search -->
     

      <!-- Navbar -->
      <ul class="navbar-nav mx-auto">

        <li class='nav-item ml-2'>
          <button class='btn btn-link navbar-btn' title="Create Table" onclick='onTableMenuClicked()'><i class="fas fa-table"></i>
          </button>
          </li>


          <li class='nav-item ml-2'>
            <button class='btn btn-link navbar-btn' title="Create Relationship" onclick='onRelationshipMenuClicked()'><i class="fas fa-bezier-curve"></i>
            </li>
        
        
        <li class='nav-item ml-2'>
        <button class="btn btn-link navbar-btn" title="Download Image" onclick='download()'><i class="fa fa-download"></i></a>
          </li>
          
            
    <li class='nav-item ml-2'>
<button class='btn btn-link navbar-btn' title="Save" onclick='save()'><i class="far fa-save"></i>
</li>


  <li class='nav-item ml-2'>
    <button class='btn btn-link navbar-btn' title="Zoom In" onclick='zoomIn()'><i class="fas fa-search-plus"></i>
    </li>

    <li class='nav-item ml-2'>
      <button class='btn btn-link navbar-btn' title="Zoom Out" onclick='zoomOut()'><i class="fas fa-search-minus"></i>
      </li>

  <li class='nav-item ml-2'>
    <button class='btn btn-link navbar-btn'><i class="fas fa-comment"></i>
    </li>

  <li class='nav-item ml-2'>
    <button class='btn btn-link navbar-btn'><i class="fas fa-share-alt"></i>
    </li>


</ul>
<ul class="nav navbar-nav navbar-right">
  <li  style="color:white;" ><i class="fas fa-user-circle fa-fw"></i>
  <span>${member.firstName}</span></li>
  </ul>
  
</nav>
<div id="wrapper">
 <!-- Sidebar -->
      <ul class="sidebar navbar-nav bg-dark">
        <li class="nav-item">
          <a class="nav-link" href="index.html">
            <i class="fas fa-fw fa-home"></i>
            <span>Home</span>
          </a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="pagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="fas fa-fw fa-folder"></i>
            <span>Projects</span>
          </a>
          <div class="dropdown-menu" aria-labelledby="pagesDropdown">
            <c:forEach var="project" items="${projects}">
<a href="/dmodel/webservice/projectservice/openProject?argument-1=${project.code}&argument-2=${project.databaseArchitecture.code}"
value="${project.code}" class="list-group-item list-group-item-action"><c:out value="${project.title}"/></a>
</c:forEach>
            <a class="dropdown-item" href="login.html">p1</a>
            <a class="dropdown-item" href="register.html">p2</a>
            <a class="dropdown-item" href="forgot-password.html">p3</a>
        </li>

        <li class="nav-item active">
          <a class="nav-link" href="#" onclick="generateScript()">
            <i class="far fa-file-alt"></i>
            <span>Generate SQL Script</span></a>
        </li>
      </ul>

  <div id='contentWrapper' style="max-height: 600px;max-width:1150px;">
    <canvas id='canvas' width="1100px" height="580px" class="canvasStyle"></canvas>
</div>  
<!---/wrapper--->




<!-- Modal -->
<div class="modal fade" id="longModal" tabindex="-1" role="dialog" aria-labelledby="SQL Script" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Generated SQL Script</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="scriptBody">

      </div>
      <div class="modal-footer">

      </div>
    </div>
  </div>
</div>







<!-- Modal -->
<div class="modal fade" id="relationshipModal" tabindex="-1" role="dialog" aria-labelledby="relationshipModalTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Relationship</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">    
    <label for="parentTable">Parent Table Fields</label>

    <select id="parentTableFields" class="form-control"> </select>
        
    <label for="childTable">Child Table Fields</label>

    <select id="childTableFields" class="form-control"> </select>


      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" onclick="dismissRelationship()">Close</button>
        <button type="button" onclick="addRelationship()"class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>


<!-- Saved Modal-->


<div class="modal fade bd-example-modal-sm" id="Save" tabindex="-1" role="dialog" aria-labelledby="saved status" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content" id="messageBody">
      
    </div>
  </div>
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
  <div class="form-row" id="attribute">
    <div class="form-group col-md-6" id="tableDiv">
      <!--label for="Table">Table Name</label-->
      <input type="text" class="form-control" id="tableName" placeholder="Table Name">
      <div class="invalid-feedback" id='tableNameError'>Choose a valid table name</div>
      <div class="valid-feedback" id='label'>Name Saved!!</div>
      
    </div>
    <div class="form-group col-md-2">
      <span><img src='/dmodel/images/save.png' onclick="saveTableName()"></span>  
      <!--label for="Engine">Engine</label>
      <select id="databaseEngines" class="form-control"></select-->
    </div>

    <div class="form-group col-md-4">
      <select id="databaseEngines" class="form-control"></select>
    </div>
    
  </div>




<div id='tableView' height="250px"></div>

<button type="button" class="fa fa-plus" aria-hidden="true" onclick="onAddButtonClicked()">
  <!--span class="glyphicon glyphicon-plus-sign"></span-->
</button>
<div id='addField'>
  <div class="form-group">
    <label for="Field">Field</label>
    <input type="text" class="form-control" id="fieldName" placeholder="Field Name">
  </div>
  <div class="form-group">
    <label for="Data Type">Data type</label>

 <select id="datatypes" class="form-control"> </select>
</div> 

    
    
  <label>Constraints:</label>
  &nbsp &nbsp &nbspKey&nbsp &nbsp &nbsp
  <input type='checkbox' id='key'>
  &nbsp &nbsp &nbspNotNull &nbsp &nbsp &nbsp <input type='checkbox' id='notNull'>
  &nbsp &nbsp &nbsp Unique &nbsp &nbsp &nbsp <input type='checkbox' id='unique'>
  &nbsp &nbsp &nbsp Auto Increment &nbsp &nbsp &nbsp <input type='checkbox' id='autoIncrement'><br/>
 
    



<div class="form-row">
    <div class="form-group col-md-6">
      <label for="Width">Width</label>
      <input type="number" class="form-control" id="width" placeholder="Width">
    </div>
 <div class="form-group col-md-6">
      <label for="Default">Default</label>
      <input type="text" class="form-control" id="default" placeholder="">
    </div>
    <div class="mx-auto">
          <button type="button" onclick="addAttribute()" class="btn btn-primary mr-5">Save</button> 

          <button type="button" onclick="onCancelButtonClicked()" class="btn btn-primary ml-5">Cancel</button> 
    </div>
</div>
    
</form>
</div>


<div id='editField'>
  <div class="form-group">
    <label for="Field">Field</label>
    <input type="text" class="form-control" id="editFieldName" placeholder="Field Name">
  </div>
  <div class="form-group">
    <label for="Data Type">Data type</label>

 <select id="editDatatypes" class="form-control"> </select>
</div> 

    
    
  <label>Constraints:</label>
  &nbsp &nbsp &nbspKey&nbsp &nbsp &nbsp
  <input type='checkbox' id='editKey'>
  &nbsp &nbsp &nbspNotNull &nbsp &nbsp &nbsp <input type='checkbox' id='editNotNull'>
  &nbsp &nbsp &nbsp Unique &nbsp &nbsp &nbsp <input type='checkbox' id='editUnique'>
  &nbsp &nbsp &nbsp Auto Increment &nbsp &nbsp &nbsp <input type='checkbox' id='editAutoIncrement'><br/>
 
    



<div class="form-row">
    <div class="form-group col-md-6">
      <label for="Width">Width</label>
      <input type="number" class="form-control" id="editWidth" placeholder="Width">
    </div>
 <div class="form-group col-md-6">
      <label for="Default">Default</label>
      <input type="text" class="form-control" id="editDefault" placeholder="">
    </div>
</div>
<div class="form-row">
    

<button type="button" onclick="addAttribute()" class="btn btn-primary btn-lg btn-block">SAVE</button>
</form>
</div>





<div class="modal-footer"></div>
