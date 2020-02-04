package com.thinking.machines.dmodel.services.pojo;
import java.util.*;
public class DatabaseArchitecture
{
private int code;
private String name;
private int maxWidthOfColumnName;
private int maxWidthOfRelationshipName;
private int maxWidthOfTableName;
private List<Datatype> datatypes;
private List<Engine> engines;
public DatabaseArchitecture()
{
this.code=0;
this.name="";
this.maxWidthOfColumnName=0;
this.maxWidthOfRelationshipName=0;
this.maxWidthOfTableName=0;
this.engines=new LinkedList<Engine>();
this.datatypes=new LinkedList<Datatype>();
}
public void setCode(int code)
{
this.code=code;
}
public int getCode()
{
return this.code;
}
public void setName(String name)
{
this.name=name;
}
public String getName()
{
return this.name;
}
public void setMaxWidthOfColumnName(int maxWidthOfColumnName)
{
this.maxWidthOfColumnName=maxWidthOfColumnName;
}
public int getMaxWidthOfColumnName()
{
return this.maxWidthOfColumnName;
}

public void setMaxWidthOfTableName(int maxWidthOfTableName)
{
this.maxWidthOfTableName=maxWidthOfTableName;
}
public int getMaxWidthOfTableName()
{
return this.maxWidthOfTableName;
}
public void setMaxWidthOfRelationshipName(int maxWidthOfRelationshipName)
{
this.maxWidthOfRelationshipName=maxWidthOfRelationshipName;
}
public int getMaxWidthOfRelationshipName()
{
return this.maxWidthOfRelationshipName;
}

public  void addDatatype(Datatype datatype)
{
this.datatypes.add(datatype);
}
public List<Datatype> getDatatypes()
{
return this.datatypes;
}
public  void addEngine(Engine engine )
{
this.engines.add(engine);
}
public List<Engine> getEngines()
{
return this.engines;
}

}
