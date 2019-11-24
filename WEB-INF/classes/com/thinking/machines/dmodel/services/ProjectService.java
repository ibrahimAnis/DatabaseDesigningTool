package com.thinking.machines.dmodel.services;
import com.thinking.machines.tmws.annotations.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.thinking.machines.dmodel.services.pojo.*;
import com.thinking.machines.dmframework.*;
import com.thinking.machines.dmframework.exceptions.*;
import com.thinking.machines.tmws.*;
import com.thinking.machines.dmframework.*;
import java.io.*;
import java.util.*;
@Path("/projectservice")
public class ProjectService
{
public HttpSession session;
public ServletContext servletContext;
public HttpServletRequest request;
public File directory;
public void setDirectory(File directory)
{
System.out.println("Directory is set");
this.directory=directory;
}
public void setServletContext(ServletContext servletContext)
{
System.out.println("Application is being Injected");
this.servletContext=servletContext;
}
public void setHttpSession(HttpSession session)
{
System.out.println("Session is being injected");
this.session=session;
}
public void setHttpRequest(HttpServletRequest request)
{
System.out.println("Request is being injected");
this.request=request;
}
@Path("engine")
public void setEngine(Engine engine)
{}
@Path("table")
public void setTable(Table table)
{}
@Path("field")
public void setField(Field field)
{
}
@Path("point")
public void setPoint(Point point)
{
}
@Path("databaseArchitecture")
public void setDatabaseArchitecture(DatabaseArchitecture dba)
{
}
@Path("datatype")
public void setDatatype(Datatype datatype)
{
}
@InjectApplication
@InjectSession
@Path("createProject")
public Object createProject(String title,int architectureCode)
{
try
{
com.thinking.machines.dmodel.services.pojo.ServiceException se=new com.thinking.machines.dmodel.services.pojo.ServiceException();
if(title==null || title.length()==0)
{
se.addError("title","Required");
throw se;
}
if(title.length()>100)
{
se.addError("title","Maximum Length of title exceeded");
throw se;
}
List<Project> projects=(List<Project>)this.session.getAttribute("projects");
for(Project p:projects)
{
if(p.getTitle().equalsIgnoreCase(title))
{
se.addError("title","Name Exists!!");
throw se;
}
}

DataManager dataManager=new DataManager();
com.thinking.machines.dmodel.dl.Project dlProject=new com.thinking.machines.dmodel.dl.Project();
dlProject.setTitle(title);
dlProject.setMemberCode(((com.thinking.machines.dmodel.dl.Member)this.session.getAttribute("member")).getCode());
dlProject.setDatabaseArchitectureCode(architectureCode);
long time=new Date().getTime(); 
dlProject.setDateOfCreation(new java.sql.Date(time));
dlProject.setTimeOfCreation(new java.sql.Time(time));
dlProject.setNumberOfTable(0);
dataManager.begin();
dataManager.insert(dlProject);
dataManager.end();
Project project=new Project();
project.setCode(dlProject.getCode());
project.setTitle(title);
project.setDateOfCreation(time);
project.setTimeOfCreation(time);
List<DatabaseArchitecture> databaseArchitectures=(List<DatabaseArchitecture>)this.servletContext.getAttribute("databaseArchitectures");
for(DatabaseArchitecture dba:databaseArchitectures)
{
if(dba.getCode()==architectureCode) 
{
project.setDatabaseArchitecture(dba);
break;
}
}
projects.add(project);
return project;
}catch(com.thinking.machines.dmodel.services.pojo.ServiceException serviceException)
{
return serviceException;
}
catch(DMFrameworkException dmFrameworkException)
{
com.thinking.machines.dmodel.services.pojo.ServiceException se=new com.thinking.machines.dmodel.services.pojo.ServiceException();
se.addError(dmFrameworkException.getMessage());
return se;
}
catch(Exception exception)
{
com.thinking.machines.dmodel.services.pojo.ServiceException se=new com.thinking.machines.dmodel.services.pojo.ServiceException();
se.addError(exception.getMessage());
return se;
}
}
@Post
@InjectApplication
@InjectSession
@Path("saveProject")
public Object saveProject(Project project)
{
System.out.println("Project title"+project.getTitle());
List<com.thinking.machines.dmodel.dl.Project> dlProjects;
com.thinking.machines.dmodel.dl.Project dlProject;
int projectCode;
com.thinking.machines.dmodel.dl.DatabaseTable dlTable;
com.thinking.machines.dmodel.dl.DatabaseTableField dlField;
List<com.thinking.machines.dmodel.dl.DatabaseTable> dlTables;
List<com.thinking.machines.dmodel.dl.DatabaseTableField> dlFields;
int engineCode;
int databaseArchitectureCode=project.getDatabaseArchitecture().getCode();
List<Table> tables;
List<Field> fields;
Engine engine;
Datatype datatype;
String title;
Point point;
projectCode=project.getCode();
try
{
DataManager dataManager=new DataManager();
dataManager.begin();
dlProjects=dataManager.select(com.thinking.machines.dmodel.dl.Project.class).where("code").eq(projectCode).query();
dlProject=dlProjects.get(0);
dataManager.end();
if(!dlProject.getTitle().equals(project.getTitle()))
{
//dataManager.update(com.thinking.machines.dmodel.dl.Project.class). // update
}
dataManager.begin();
dlTables=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTable.class).where("projectCode").eq(projectCode).query();
for(com.thinking.machines.dmodel.dl.DatabaseTable dt:dlTables)
{
System.out.println("Table:"+dt.getName()+" code:"+dt.getCode());
dlFields=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTableField.class).where("tableCode").eq(dt.getCode()).query();
for(com.thinking.machines.dmodel.dl.DatabaseTableField df:dlFields) dataManager.delete(com.thinking.machines.dmodel.dl.DatabaseTableField.class,df.getCode());
dataManager.delete(com.thinking.machines.dmodel.dl.DatabaseTable.class,dt.getCode());
}
dataManager.end();
tables=project.getTables();
int fieldCount=0;
for(Table table:tables)
{
dataManager.begin();
System.out.println("Inserting:"+table.getName());
fields=table.getFields();
System.out.println("fields length:"+fields.size());
dlTable=new com.thinking.machines.dmodel.dl.DatabaseTable();
dlTable.setName(table.getName());
dlTable.setProjectCode(projectCode);
engine=table.getEngine();
System.out.println("Engine name"+engine.getName()+"Engine Code"+engine.getCode());
dlTable.setDatabaseEngineCode(engine.getCode());
dlTable.setNote(table.getNote());
point=table.getPoint();
dlTable.setAbscissa(point.getAbscissa());
dlTable.setOrdinate(point.getOrdinate());
System.out.println(dlTable.getOrdinate());
dlTable.setNumberOfFields(0);
dataManager.insert(dlTable);
dataManager.end();
table.setCode(dlTable.getCode());
System.out.println("Code added"+dlTable.getCode());
for(Field field:fields)
{
fieldCount++;
System.out.println("Inserting field:"+field.getName());
dataManager.begin();
dlField=new com.thinking.machines.dmodel.dl.DatabaseTableField();
dlField.setName(field.getName());
dlField.setTableCode(table.getCode());
datatype=field.getDatatype();
dlField.setDatabaseArchitectureDataTypeCode(datatype.getCode());
dlField.setWidth(field.getWidth());
dlField.setNumberOfDecimalPlaces(field.getNumberOfDecimalPlaces());
dlField.setIsPrimaryKey(field.getIsPrimaryKey());
dlField.setIsAutoIncrement(field.getIsAutoIncrement());
dlField.setIsUnique(field.getIsUnique());
dlField.setIsNotNull(field.getIsNotNull());
dlField.setDefaultValue(field.getDefaultValue());
dlField.setCheckConstraint(field.getCheckConstraint());
dlField.setNote(field.getNote());
dataManager.insert(dlField);
field.setCode(dlField.getCode());
dataManager.end();
}
}
return "Saved Successfully";
}catch(ValidatorException exception)
{
HashMap<String,LinkedList<com.thinking.machines.dmframework.pojo.Pair<Integer,String>>> mp=exception.getExceptions();
LinkedList<com.thinking.machines.dmframework.pojo.Pair<Integer,String>> list;
for(Map.Entry<String,LinkedList<com.thinking.machines.dmframework.pojo.Pair<Integer,String>>> m:mp.entrySet())
{
list=m.getValue();
for(com.thinking.machines.dmframework.pojo.Pair<Integer,String> p:list)
{
System.out.println(p.getFirst()+" "+p.getSecond());
}
}
return exception;
}
catch(Exception exception)
{
System.out.println(exception.getMessage());
ErrorBean errorBean=new ErrorBean();
errorBean.addError(exception.getMessage());
return errorBean;
}

}




@InjectApplication
@InjectSession
@Path("openProject")
public TMForward openProject(int projectCode,int databaseArchitectureCode)
{
try
{
System.out.println("openProject chala"+projectCode+" "+databaseArchitectureCode);
List<com.thinking.machines.dmodel.dl.Project> dlProjects;
com.thinking.machines.dmodel.dl.Project dlProject;
Project project;

List<DatabaseArchitecture> databaseArchitectures;
DatabaseArchitecture databaseArchitecture;


List<com.thinking.machines.dmodel.dl.DatabaseTable> dlTables;
List<Table> tables;
Table table;
int tableCode;

List<com.thinking.machines.dmodel.dl.DatabaseTableField> dlFields;
List<Field> fields;
Field field;
int fieldCode;

List<com.thinking.machines.dmodel.dl.DatabaseEngine> dlEngines;
com.thinking.machines.dmodel.dl.DatabaseEngine dlEngine;
Engine engine;
int engineCode;

List<com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType> dlDataTypes;
com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType dlDataType;
Datatype dataType;
int dataTypeCode;

Point point;
DataManager dataManager=new DataManager();
dataManager.begin();
dlProjects=dataManager.select(com.thinking.machines.dmodel.dl.Project.class).where("code").eq(projectCode).query();
dlProject=dlProjects.get(0);
project=new Project();
project.setCode(dlProject.getCode());
project.setTitle(dlProject.getTitle());
Date date=dlProject.getDateOfCreation();
System.out.println("Day:"+date.getDate()+" Time:"+date.getTime());
project.setDateOfCreation(date.getDate());
project.setTimeOfCreation(date.getTime());
dlTables=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTable.class).where("projectCode").eq(projectCode).query();
tables=new LinkedList<Table>();
for(com.thinking.machines.dmodel.dl.DatabaseTable dlTable:dlTables)
{
tableCode=dlTable.getCode();
table=new Table();
table.setCode(tableCode);
table.setName(dlTable.getName());
table.setNote(dlTable.getNote());
table.setNumberOfFields(dlTable.getNumberOfFields());
point=new Point();
point.setAbscissa(dlTable.getAbscissa());
point.setOrdinate(dlTable.getOrdinate());
table.setPoint(point);
engineCode=dlTable.getDatabaseEngineCode();
dlEngines=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseEngine.class).where("code").eq(engineCode).query();
dlEngine=dlEngines.get(0);
engine=new Engine();
engine.setName(dlEngine.getName());
engine.setCode(dlEngine.getCode());
table.setEngine(engine);
dlFields=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTableField.class).where("tableCode").eq(tableCode).query();
fields=new LinkedList<Field>();
for(com.thinking.machines.dmodel.dl.DatabaseTableField dlField:dlFields)
{
field=new Field();
field.setCode(dlField.getCode());
field.setName(dlField.getName());
field.setWidth(dlField.getWidth());
field.setNumberOfDecimalPlaces(dlField.getNumberOfDecimalPlaces());
field.setIsPrimaryKey(dlField.getIsPrimaryKey());
field.setIsAutoIncrement(dlField.getIsAutoIncrement());
field.setIsUnique(dlField.getIsUnique());
field.setIsNotNull(dlField.getIsNotNull());
field.setDefaultValue(dlField.getDefaultValue());
field.setCheckConstraint(dlField.getCheckConstraint());
field.setNote(dlField.getNote());
dataTypeCode=dlField.getDatabaseArchitectureDataTypeCode();
dlDataTypes=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType.class).where("code").eq(dataTypeCode).query();
dlDataType=dlDataTypes.get(0);
dataType=new Datatype();
dataType.setCode(dlDataType.getCode());
dataType.setDatatype(dlDataType.getDataType());
dataType.setMaxWidth(dlDataType.getMaxWidth());
dataType.setDefaultSize(dlDataType.getDefaultSize());
dataType.setMaxWidthOfPrecision(dlDataType.getMaxWidthOfPrecision());
dataType.setAllowAutoIncrement(dlDataType.getAllowAutoIncrement());
field.setDatatype(dataType);
fields.add(field);
}
for(Field fld:fields) table.addField(fld);
tables.add(table);
}
for(Table tlb:tables) project.addTable(tlb);

databaseArchitectures=(List<DatabaseArchitecture>)this.servletContext.getAttribute("databaseArchitectures");
for(DatabaseArchitecture dba:databaseArchitectures)
{
if(dba.getCode()==databaseArchitectureCode) 
{
project.setDatabaseArchitecture(dba);
break;
}
}

dataManager.end();

System.out.println("project code"+project.getCode()+" project title"+project.getTitle());
session.setAttribute("currentProject",project);
return new TMForward("/projectView.jsp");
}catch(Exception exception)
{
exception.printStackTrace();
ErrorBean errorBean=new ErrorBean();
errorBean.addError(exception.getMessage());
return new TMForward("/homepage.jsp");
}
}
@InjectSession
@Path("getProject")
public Object getProject()
{
return session.getAttribute("currentProject");
}
@InjectDirectory
@Path("download")
public FileDownloadWrapper download()
{
System.out.println("download");

FileDownloadWrapper fw=null;
TMForward tm=null;
try
{
File f=new File(directory.getAbsolutePath()+"/images/hd.jpg");
fw=new FileDownloadWrapper();
fw.setContentType("image/jpg");
fw.setFile(f);
fw.isAttachment(true);
fw.setFileName("hd.jpg");
System.out.println("File is set to wrapper");
}catch(Exception e)
{
System.out.println(e);
}
return fw;
}
}
