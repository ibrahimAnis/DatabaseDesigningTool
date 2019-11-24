package com.thinking.machines.dmodel.services.pojo;
import java.util.*;
public class Project
{
private int code;
private String title;
private long dateOfCreation;
private long timeOfCreation;
private List<Table> tables;
private DatabaseArchitecture databaseArchitecture;
public Project()
{
this.code=0;
this.title="";
this.dateOfCreation=0;
this.timeOfCreation=0;
this.tables=new LinkedList<Table>();
this.databaseArchitecture=null;
}
public int getCode()
{
return this.code;
}
public void setCode(int code)
{
this.code=code;
}
public String getTitle()
{
return this.title;
}
public void setTitle(String title)
{
this.title=title;
}
public void addTable(Table table)
{
this.tables.add(table);
}
public List<Table> getTables()
{
return this.tables;
}
public void setDatabaseArchitecture(DatabaseArchitecture databaseArchitecture)
{
this.databaseArchitecture=databaseArchitecture;
}
public DatabaseArchitecture getDatabaseArchitecture()
{
return this.databaseArchitecture;
}
public void setDateOfCreation(long dateOfCreation)
{
this.dateOfCreation=dateOfCreation;
}
public long getDateOfCreation()
{
return this.dateOfCreation;
}
public void setTimeOfCreation(long timeOfCreation)
{
this.timeOfCreation=timeOfCreation;
}
public long getTimeOfCreation()
{
return this.timeOfCreation;
}

}
