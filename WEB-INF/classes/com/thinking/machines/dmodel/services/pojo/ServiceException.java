package com.thinking.machines.dmodel.services.pojo;
import java.util.*;
public class ServiceException extends RuntimeException
{
private Map<String,String> errors;
private List<String> genericErrors;
public ServiceException()
{
this.errors=new HashMap<String,String>();
this.genericErrors=new LinkedList<String>();
}
public void addError(String property,String error)
{
errors.put(property,error);
}
public List<String> getErrors()
{
return this.genericErrors;
}
public void addError(String error)
{
genericErrors.add(error);
}
public String getError(String property)
{
String error=errors.get(property);
if(error==null) error="";
return error;
}

public Object getExceptions()
{
return this.errors;
}
}
