package com.thinking.machines.dmodel.services.pojo;
import java.util.*;
public class Table
{
private int code;
private String name;
private String note;
private Point point;
private Engine engine;
private List<Field> fields;
private int numberOfFields;
public Table()
{
this.code=0;
this.name="";
this.note="";
this.engine=null;
this.point=null;
this.fields=new ArrayList<>();
this.numberOfFields=0;
}
public void setNumberOfFields(int number)
{
this.numberOfFields=number;
}
public int getNumberofFields()
{
return this.numberOfFields;
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
public void setNote(String note)
{
this.note=note;
}
public String getNote()
{
return this.note;
}
public  void addField(Field field)
{
this.fields.add(field);
}
public List<Field> getFields()
{
return this.fields;
}
public  void setEngine(Engine engine )
{
this.engine=engine;
}
public Engine getEngine()
{
return this.engine;
}
public void setPoint(Point point)
{
this.point=point;
}
public Point getPoint()
{
return this.point;
}

}



