package com.thinking.machines.dmodel.services;
import com.thinking.machines.tmws.annotations.*;
import com.thinking.machines.tmws.captcha.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.thinking.machines.dmodel.services.pojo.*;
import com.thinking.machines.dmframework.*;
import com.thinking.machines.dmframework.exceptions.*;
import com.thinking.machines.tmws.*;
import com.thinking.machines.dmframework.*;
import java.util.*;
import java.io.*;
@Path("/memberservice")
public class MemberService
{
public HttpSession session;
public HttpServletRequest request;
public ServletContext servletContext;
public void setServletContext(ServletContext servletContext)
{
System.out.println("Application is being injected");
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
@InjectSession
@InjectRequest
@Post
@Path("captchaTest")
public Object captchaTest(String captchaCode)
{
Captcha captcha=(Captcha)session.getAttribute(Captcha.CAPTCHA_NAME);
if(!captcha.isValid(captchaCode))
{
session.removeAttribute(Captcha.CAPTCHA_NAME);
return false;
}
session.removeAttribute(Captcha.CAPTCHA_NAME);
return true;
}
@Post
@Path("signup")
public Object createMember(Member member)
{
try
{
System.out.println("member signup  Chali");
com.thinking.machines.dmodel.services.pojo.ServiceException se=new com.thinking.machines.dmodel.services.pojo.ServiceException();
String emailId,firstName,lastName,mobileNumber,password;
emailId=member.getEmailId();
firstName=member.getFirstName();
lastName=member.getLastName();
password=member.getPassword();
mobileNumber=member.getMobileNumber();
boolean flag=true;
if(emailId==null || emailId.length()==0)
{
se.addError("emailId","Required");
flag=false;
}
if(firstName==null || firstName.length()==0)
{
se.addError("firstName","Required");
flag=false;
}
if(lastName==null || lastName.length()==0)
{
se.addError("lastName","Required");
flag=false;
}
if(mobileNumber==null || mobileNumber.length()==0)
{
se.addError("mobileNumber","Required");
flag=false;
}
if(password==null || password.length()==0)
{
se.addError("password","Required");
flag=false;
}
if(flag==false) throw se;
else
{
try
{
if(emailId.trim().length()>100)
{
se.addError("emailId","EmailId can't exceed 100 characters");
flag=false;
}
if(firstName.trim().length()>25)
{
se.addError("firstName","FirstName can't exceed 25 characters");
flag=false;
}
if(lastName.trim().length()>25)
{
se.addError("lastName","LastName can't exceed 25 characters");
flag=false;
}
if(password.trim().length()>100)
{
se.addError("password","Password can't exceed 100 characters");
flag=false;
}
if(flag==true)
{
DataManager dataManager=new DataManager();
dataManager.begin();
List<com.thinking.machines.dmodel.dl.Member> dlMembers;
dlMembers=dataManager.select(com.thinking.machines.dmodel.dl.Member.class).where("emailId").eq(emailId.trim()).query();
dataManager.end();
if(dlMembers.size()>0)
{
se.addError("emailId","Username(EmailId) exists!");
flag=false;
}
}
if(flag==false) throw se;
else
{
DataManager dataManager=new DataManager();
com.thinking.machines.dmodel.dl.Member dlMember=new com.thinking.machines.dmodel.dl.Member();
dlMember.setEmailId(emailId.trim());
dlMember.setFirstName(firstName.trim());
dlMember.setLastName(lastName.trim());
dlMember.setMobileNumber(mobileNumber.trim());
String passwordKey="fhkddhkbfghhi9059";
password=com.thinking.machines.dmodel.utilities.Encryptor.encrypt(password.trim(),passwordKey);
dlMember.setPassword(password);
dlMember.setPasswordKey(passwordKey);
dlMember.setStatus("1");
dlMember.setNumberOfProjects(0);
dataManager.begin();
dataManager.insert(dlMember);
dataManager.end();
} 
}catch(ValidatorException ve)
{
return ve;
}
catch(DMFrameworkException dmFrameworkException)
{
return new Exception(dmFrameworkException.getMessage());
}
}
System.out.println("EmailId: "+emailId+"\nFirstName: "+firstName+"\nLastName: "+lastName+"\nPassword: "+password+"\nMobileNumber: "+mobileNumber);
return true;
}catch(com.thinking.machines.dmodel.services.pojo.ServiceException se)
{
return se;
}
}
@InjectSession
@Path("logout")
public TMForward logout()
{
session.removeAttribute("projects");
session.removeAttribute("member");
return  new com.thinking.machines.tmws.TMForward("/index.jsp");
}
@InjectApplication
@InjectSession
@InjectRequest
@Path("login")
public TMForward checkMember(String username, String password)
{
com.thinking.machines.dmodel.services.pojo.ErrorBean errorBean=new com.thinking.machines.dmodel.services.pojo.ErrorBean();
try
{
System.out.println(this.request);
System.out.println(this.session);
System.out.println("************username:"+username+","+"password:"+password+"*********");
String vPassword="";
boolean flag=true;
if(username==null || username.length()==0)
{
flag=false;
}
if(password==null || password.length()==0)
{
flag=false;
}
if(flag==false)
{
request.setAttribute("validator","is-invalid");
return  new com.thinking.machines.tmws.TMForward("/index.jsp");
}
else
{
try
{
DataManager dataManager=new DataManager();
dataManager.begin();
List<com.thinking.machines.dmodel.dl.Member> dlMembers;
dlMembers=dataManager.select(com.thinking.machines.dmodel.dl.Member.class).where("emailId").eq(username.trim()).query();
dataManager.end();
if(dlMembers.size()==0)
{
errorBean.addError("username or password invalid!");
flag=false;
request.setAttribute("errorBean",errorBean);
request.setAttribute("validator","");
return  new com.thinking.machines.tmws.TMForward("/index.jsp");
}
com.thinking.machines.dmodel.dl.Member dlMember=dlMembers.get(0);
String encryptedPassword=dlMember.getPassword();
String passwordKey=dlMember.getPasswordKey();
vPassword=com.thinking.machines.dmodel.utilities.Encryptor.decrypt(encryptedPassword,passwordKey);
if(vPassword.equals(password))
{
this.session.setAttribute("member",dlMember);
// putting projects in session
List<DatabaseArchitecture> 
databaseArchitectures=(List<DatabaseArchitecture>)this.servletContext.getAttribute("databaseArchitectures");
List<Project> projects=new LinkedList<Project>();
List<Engine> engines;
List<Datatype> datatypes;
Project project;
DatabaseArchitecture databaseArchitecture;
Table table;
Field field;
com.thinking.machines.dmodel.dl.Project dlProject;
List<com.thinking.machines.dmodel.dl.Project> dlProjects;
com.thinking.machines.dmodel.dl.DatabaseTable dlDatabaseTable;
List<com.thinking.machines.dmodel.dl.DatabaseTable> dlDatabaseTables;
com.thinking.machines.dmodel.dl.DatabaseTableField dlDatabaseTableField;
List<com.thinking.machines.dmodel.dl.DatabaseTableField> dlDatabaseTableFields;
dataManager.begin();
dlProjects=dataManager.select(com.thinking.machines.dmodel.dl.Project.class).where("memberCode").eq(dlMember.getCode()).query();
dataManager.end();
Date d;
for(com.thinking.machines.dmodel.dl.Project p:dlProjects)
{
project=new Project();
project.setCode(p.getCode());
project.setTitle(p.getTitle());
d=p.getDateOfCreation();
project.setDateOfCreation(d.getDate());
project.setTimeOfCreation(d.getTime());
int i=0;
for(DatabaseArchitecture dba:databaseArchitectures)
{
if(dba.getCode()==p.getDatabaseArchitectureCode())
{
project.setDatabaseArchitecture(dba);
break;
}
++i;
} // for ends
dataManager.begin();
dlDatabaseTables=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTable.class).where("projectCode").eq(p.getCode()).query();
dataManager.end();
for(com.thinking.machines.dmodel.dl.DatabaseTable dbt:dlDatabaseTables)
{
table=new Table();
table.setCode(dbt.getCode());
table.setName(dbt.getName());
table.setNote(dbt.getNote());
dataManager.begin();
dlDatabaseTableFields=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTableField.class).where("tableCode").eq(dbt.getCode()).query();
dataManager.end();
for(com.thinking.machines.dmodel.dl.DatabaseTableField dbtf:dlDatabaseTableFields)
{
field=new Field();
field.setCode(dbtf.getCode());
field.setName(dbtf.getName());
field.setNote(dbtf.getNote());
field.setWidth(dbtf.getWidth());
field.setNumberOfDecimalPlaces(dbtf.getNumberOfDecimalPlaces());
field.setIsPrimaryKey(dbtf.getIsPrimaryKey());
field.setIsAutoIncrement(dbtf.getIsAutoIncrement());
field.setIsUnique(dbtf.getIsUnique());
field.setIsNotNull(dbtf.getIsNotNull());
field.setDefaultValue(dbtf.getDefaultValue());
field.setCheckConstraint(dbtf.getCheckConstraint());
i=0;
datatypes=(project.getDatabaseArchitecture()).getDatatypes();
for(Datatype dt:datatypes)
{
if(dt.getCode()==dbtf.getDatabaseArchitectureDataTypeCode())
{
field.setDatatype(dt);
break;
}
++i;
}// for ends
table.addField(field);
}// for ends
i=0;
engines=project.getDatabaseArchitecture().getEngines();
for(Engine e:engines)
{
if(e.getCode()==dbt.getDatabaseEngineCode())
{
table.setEngine(e);
break;
}
++i;
}// for ends
project.addTable(table);
}// for ends
projects.add(project);
}// for ends
this.session.setAttribute("projects",projects);
return  new com.thinking.machines.tmws.TMForward("/homepage.jsp");
}
else
{
errorBean.addError("username or password invalid!");
flag=false;
request.setAttribute("validator","");
request.setAttribute("errorBean",errorBean);
return  new com.thinking.machines.tmws.TMForward("/index.jsp");
}
}catch(DMFrameworkException dmFrameworkException)
{
System.out.println(dmFrameworkException);
errorBean.addError(dmFrameworkException.getMessage());
request.setAttribute("validator","");
request.setAttribute("errorBean",errorBean);
return  new com.thinking.machines.tmws.TMForward("/index.jsp");
}
}
}catch(Exception exception)
{
System.out.println(exception);
errorBean.addError(exception.getMessage());
request.setAttribute("validator","");
request.setAttribute("errorBean",errorBean);
return  new com.thinking.machines.tmws.TMForward("/index.jsp");
}
}
}


