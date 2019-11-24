package com.thinking.machines.dmodel.tags;
import javax.servlet.jsp.*;
import java.util.*;
import javax.servlet.jsp.tagext.*;
import com.thinking.machines.dmodel.services.pojo.*;
public class ErrorTagHandler extends BodyTagSupport
{
private String property;
private String name;
private String scope;
private ErrorBean errorBean;
private int index;
private List<String> genericErrors;
public ErrorTagHandler()
{
reset();
}
public void setProperty(String property)
{
this.property=property;
}
public String getProperty()
{
return this.property;
}
public void setName(String name)
{
this.name=name;
}
public String getName()
{
return this.name;
}
public void setScope(String scope)
{
this.scope=scope;
}
public String getScope()
{
return this.scope;
}
public int doStartTag()
{
try
{
if(scope.equals("request"))errorBean=(ErrorBean)pageContext.getAttribute(name,PageContext.REQUEST_SCOPE);
if(scope.equals("session"))errorBean=(ErrorBean)pageContext.getAttribute(name,PageContext.SESSION_SCOPE);
if(scope.equals("application"))errorBean=(ErrorBean)pageContext.getAttribute(name,PageContext.APPLICATION_SCOPE);
if(errorBean==null)
{
return super.SKIP_BODY;
}
if(property==null)
{
index=0;
genericErrors=errorBean.getGenericErrors();
if(genericErrors.size()==0) return super.SKIP_BODY;
pageContext.setAttribute("error",genericErrors.get(index));
return super.EVAL_BODY_INCLUDE;
}
else
{
pageContext.setAttribute("error",errorBean.getError(this.property));
return super.EVAL_BODY_INCLUDE;
}
}catch(Exception exception)
{
System.out.println(exception); // remove after testing
}
return super.SKIP_BODY;
}
public int doAfterBody()
{
if(property!=null) return super.SKIP_BODY;
index++;
if(genericErrors.size()==index) return super.SKIP_BODY;
pageContext.setAttribute("error",genericErrors.get(index));
return super.EVAL_BODY_AGAIN;
}
public int doEndTag()
{
reset();
return super.EVAL_PAGE;
}
public void reset()
{
this.property=null;
this.name=null;
this.scope=null;
this.errorBean=null;
this.genericErrors=null;
this.index=0;
}
}
