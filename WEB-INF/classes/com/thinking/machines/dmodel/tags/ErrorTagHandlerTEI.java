package com.thinking.machines.dmodel.tags;
import javax.servlet.jsp.*;
import java.util.*;
import javax.servlet.jsp.tagext.*;
import com.thinking.machines.dmodel.services.pojo.*;
public class ErrorTagHandlerTEI extends TagExtraInfo
{
public VariableInfo[] getVariableInfo(TagData data)
{
VariableInfo v[]=new VariableInfo[2];
v[0]=new VariableInfo("error","java.lang.String",true,VariableInfo.NESTED);
v[1]=new VariableInfo("validation","java.lang.String",true,VariableInfo.NESTED);
return v;
}
}
