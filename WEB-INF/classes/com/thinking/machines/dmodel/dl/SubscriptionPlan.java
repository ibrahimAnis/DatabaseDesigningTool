package com.thinking.machines.dmodel.dl;
import com.thinking.machines.dmframework.annotations.*;
import java.sql.*;
@Display(value="Subscription Plan")
@Table(name="subscription_plan")
public class SubscriptionPlan implements java.io.Serializable,Comparable<SubscriptionPlan>
{
@Sort(priority=1)
@Display(value="code")
@Column(name="code")
private Integer code;
@Display(value="effective from")
@Column(name="effective_from")
private Date effectiveFrom;
@Display(value="monthly rate")
@Column(name="monthly_rate")
private Integer monthlyRate;
@Display(value="yearly rate")
@Column(name="yearly_rate")
private Integer yearlyRate;
@Display(value="free projects")
@Column(name="free_projects")
private Integer freeProjects;
@Display(value="free tables")
@Column(name="free_tables")
private Integer freeTables;
public SubscriptionPlan()
{
this.code=null;
this.effectiveFrom=null;
this.monthlyRate=null;
this.yearlyRate=null;
this.freeProjects=null;
this.freeTables=null;
}
public void setCode(Integer code)
{
this.code=code;
}
public Integer getCode()
{
return this.code;
}
public void setEffectiveFrom(Date effectiveFrom)
{
this.effectiveFrom=effectiveFrom;
}
public Date getEffectiveFrom()
{
return this.effectiveFrom;
}
public void setMonthlyRate(Integer monthlyRate)
{
this.monthlyRate=monthlyRate;
}
public Integer getMonthlyRate()
{
return this.monthlyRate;
}
public void setYearlyRate(Integer yearlyRate)
{
this.yearlyRate=yearlyRate;
}
public Integer getYearlyRate()
{
return this.yearlyRate;
}
public void setFreeProjects(Integer freeProjects)
{
this.freeProjects=freeProjects;
}
public Integer getFreeProjects()
{
return this.freeProjects;
}
public void setFreeTables(Integer freeTables)
{
this.freeTables=freeTables;
}
public Integer getFreeTables()
{
return this.freeTables;
}
public boolean equals(Object object)
{
if(object==null) return false;
if(!(object instanceof SubscriptionPlan)) return false;
SubscriptionPlan anotherSubscriptionPlan=(SubscriptionPlan)object;
if(this.code==null && anotherSubscriptionPlan.code==null) return true;
if(this.code==null || anotherSubscriptionPlan.code==null) return false;
return this.code.equals(anotherSubscriptionPlan.code);
}
public int compareTo(SubscriptionPlan anotherSubscriptionPlan)
{
if(anotherSubscriptionPlan==null) return 1;
if(this.code==null && anotherSubscriptionPlan.code==null) return 0;
int difference;
if(this.code==null && anotherSubscriptionPlan.code!=null) return 1;
if(this.code!=null && anotherSubscriptionPlan.code==null) return -1;
difference=this.code.compareTo(anotherSubscriptionPlan.code);
return difference;
}
public int hashCode()
{
if(this.code==null) return 0;
return this.code.hashCode();
}
}
