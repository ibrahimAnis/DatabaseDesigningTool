package com.thinking.machines.dmodel.services.pojo;
import java.util.*;
public class ErrorBean implements java.io.Serializable
{
private LinkedList<String> genericErrors=new LinkedList<>();
private HashMap<String,String> propertyErrors=new HashMap<>();
public void addError(String property,String error)
{
propertyErrors.put(property,error);
}
public void addError(String error)
{
genericErrors.add(error);
}
public String getError(String property)
{
String error=propertyErrors.get(property);
if(error==null) error="";
return error;
}
public LinkedList<String> getGenericErrors()
{
return this.genericErrors;
}
}

