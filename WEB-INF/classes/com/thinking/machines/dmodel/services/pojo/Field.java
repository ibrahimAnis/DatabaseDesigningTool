package com.thinking.machines.dmodel.services.pojo;
import java.util.*;
public class Field
{
private int code;
private String name;
private Datatype datatype;
private int width;
private int numberOfDecimalPlaces;
private Boolean isPrimaryKey;
private Boolean isAutoIncrement;
private Boolean isUnique;
private Boolean isNotNull;
private String defaultValue;
private String checkConstraint;
private String note;
public Field()
{
this.code=0;
this.name="";
this.width=0;
this.numberOfDecimalPlaces=0;
this.isPrimaryKey=false;
this.isAutoIncrement=false;
this.isUnique=false;
this.isNotNull=false;
this.defaultValue="";
this.checkConstraint="";
this.datatype=null;
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
public void setWidth(int width)
{
this.width=width;
}
public  int getWidth()
{
return this.width;
}



public void setNumberOfDecimalPlaces(int numberOfDecimalPlaces)
{
this.numberOfDecimalPlaces=numberOfDecimalPlaces;
}
public  int getNumberOfDecimalPlaces()
{
return this.numberOfDecimalPlaces;
}

public void setIsPrimaryKey(Boolean isPrimaryKey)
{
this.isPrimaryKey=isPrimaryKey;
}
public  Boolean getIsPrimaryKey()
{
return this.isPrimaryKey;
}

public void setIsAutoIncrement(Boolean isAutoIncrement)
{
this.isAutoIncrement=isAutoIncrement;
}
public  Boolean getIsAutoIncrement()
{
return this.isAutoIncrement;
}

public void setIsNotNull(Boolean isNotNull)
{
this.isNotNull=isNotNull;
}
public  Boolean getIsNotNull()
{
return this.isNotNull;
}

public void setIsUnique(Boolean isUnique)
{
this.isUnique=isUnique;
}
public Boolean getIsUnique()
{
return this.isUnique;
}
public void setDatatype(Datatype datatype)
{
this.datatype=datatype;
}
public Datatype getDatatype()
{
return this.datatype;
}
public void setNote(String note)
{
this.note=note;
}
public String getNote()
{
return this.note;
}
public void setDefaultValue(String defaultValue)
{
this.defaultValue=defaultValue;
}
public String getDefaultValue()
{
return this.defaultValue;
}
public void setCheckConstraint(String checkConstraint)
{
this.checkConstraint=checkConstraint;
}
public String getCheckConstraint()
{
return this.checkConstraint;
}

}

