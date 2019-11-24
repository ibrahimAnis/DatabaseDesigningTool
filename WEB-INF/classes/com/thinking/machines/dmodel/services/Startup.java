package com.thinking.machines.dmodel.services;
import com.thinking.machines.tmws.annotations.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.thinking.machines.dmodel.services.pojo.*;
import com.thinking.machines.dmframework.*;
import com.thinking.machines.dmframework.exceptions.*;
import com.thinking.machines.tmws.*;
import com.thinking.machines.dmframework.*;
import java.util.*;
import java.io.*;
@Path("/startup")
public class Startup
{
public ServletContext servletContext;
public void setServletContext(ServletContext servletContext)
{
this.servletContext=servletContext;
}
@InjectApplication
@OnStart(1)
public void loadDatabaseArchitecture()
{
try
{
DataManager dataManager=new DataManager();
DatabaseArchitecture databaseArchitecture;
Engine engine;
Datatype datatype;
List<com.thinking.machines.dmodel.dl.DatabaseArchitecture> dlDatabaseArchitectures;
List<DatabaseArchitecture> databaseArchitectures=new LinkedList<DatabaseArchitecture>();
List<com.thinking.machines.dmodel.dl.DatabaseEngine> dlDatabaseEngines;
List<com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType> dlDatabaseArchitectureDataTypes;
com.thinking.machines.dmodel.dl.DatabaseArchitecture dlDatabaseArchitecture;
com.thinking.machines.dmodel.dl.DatabaseEngine dlDatabaseEngine;
com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType dlDatabaseArchitectureDataType;
dataManager.begin();
dlDatabaseArchitectures=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseArchitecture.class).query();
dataManager.end();
for(com.thinking.machines.dmodel.dl.DatabaseArchitecture da:dlDatabaseArchitectures)
{
System.out.println("Architecture:"+da.getName());
databaseArchitecture=new DatabaseArchitecture();
databaseArchitecture.setCode(da.getCode());
databaseArchitecture.setName(da.getName());
databaseArchitecture.setMaxWidthOfColumnName(da.getMaxWidthOfColumnName());
databaseArchitecture.setMaxWidthOfTableName(da.getMaxWidthOfTableName());
databaseArchitecture.setMaxWidthOfRelationshipName(da.getMaxWidthOfRelationshipName());
dataManager.begin();
dlDatabaseEngines=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseEngine.class).where("databaseArchitectureCode").eq(da.getCode()).query();
dataManager.end();
for(com.thinking.machines.dmodel.dl.DatabaseEngine de:dlDatabaseEngines)
{
System.out.println("Engine:"+de.getName());
engine=new Engine();
engine.setCode(de.getCode());
engine.setName(de.getName());
databaseArchitecture.addEngine(engine);
}
dataManager.begin();
dlDatabaseArchitectureDataTypes=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType.class).where("databaseArchitectureCode").eq(da.getCode()).query();
dataManager.end();
for(com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType dadt:dlDatabaseArchitectureDataTypes)
{
System.out.println("Datatype:"+dadt.getDataType());
datatype=new Datatype();
datatype.setCode(dadt.getCode());
datatype.setDatatype(dadt.getDataType());
datatype.setMaxWidth(dadt.getMaxWidth());
datatype.setDefaultSize(dadt.getDefaultSize());
datatype.setMaxWidthOfPrecision(dadt.getMaxWidthOfPrecision());
datatype.setAllowAutoIncrement(dadt.getAllowAutoIncrement());
databaseArchitecture.addDatatype(datatype);
}
databaseArchitectures.add(databaseArchitecture);
}
this.servletContext.setAttribute("databaseArchitectures",databaseArchitectures);

}catch(DMFrameworkException dmfe)
{
System.out.println(dmfe.getMessage());
}
catch(Exception e)
{
System.out.println(e);
}
}
}
