package com.thinking.machines.dmodel.dl;
import com.thinking.machines.dmframework.annotations.*;
import java.sql.*;
@Display(value="Member Subscription")
@Table(name="member_subscription")
public class MemberSubscription implements java.io.Serializable,Comparable<MemberSubscription>
{
@Sort(priority=1)
@Display(value="invoice number")
@Column(name="invoice_number")
private Integer invoiceNumber;
@Display(value="invoice date")
@Column(name="invoice_date")
private Date invoiceDate;
@Display(value="member code")
@Column(name="member_code")
private Integer memberCode;
@Display(value="subscription plan code")
@Column(name="subscription_plan_code")
private Integer subscriptionPlanCode;
@Display(value="plan type")
@Column(name="plan_type")
private String planType;
@Display(value="quantity")
@Column(name="quantity")
private Integer quantity;
@Display(value="rate")
@Column(name="rate")
private Integer rate;
@Display(value="effective from")
@Column(name="effective_from")
private Date effectiveFrom;
@Display(value="effective upto")
@Column(name="effective_upto")
private Date effectiveUpto;
public MemberSubscription()
{
this.invoiceNumber=null;
this.invoiceDate=null;
this.memberCode=null;
this.subscriptionPlanCode=null;
this.planType=null;
this.quantity=null;
this.rate=null;
this.effectiveFrom=null;
this.effectiveUpto=null;
}
public void setInvoiceNumber(Integer invoiceNumber)
{
this.invoiceNumber=invoiceNumber;
}
public Integer getInvoiceNumber()
{
return this.invoiceNumber;
}
public void setInvoiceDate(Date invoiceDate)
{
this.invoiceDate=invoiceDate;
}
public Date getInvoiceDate()
{
return this.invoiceDate;
}
public void setMemberCode(Integer memberCode)
{
this.memberCode=memberCode;
}
public Integer getMemberCode()
{
return this.memberCode;
}
public void setSubscriptionPlanCode(Integer subscriptionPlanCode)
{
this.subscriptionPlanCode=subscriptionPlanCode;
}
public Integer getSubscriptionPlanCode()
{
return this.subscriptionPlanCode;
}
public void setPlanType(String planType)
{
this.planType=planType;
}
public String getPlanType()
{
return this.planType;
}
public void setQuantity(Integer quantity)
{
this.quantity=quantity;
}
public Integer getQuantity()
{
return this.quantity;
}
public void setRate(Integer rate)
{
this.rate=rate;
}
public Integer getRate()
{
return this.rate;
}
public void setEffectiveFrom(Date effectiveFrom)
{
this.effectiveFrom=effectiveFrom;
}
public Date getEffectiveFrom()
{
return this.effectiveFrom;
}
public void setEffectiveUpto(Date effectiveUpto)
{
this.effectiveUpto=effectiveUpto;
}
public Date getEffectiveUpto()
{
return this.effectiveUpto;
}
public boolean equals(Object object)
{
if(object==null) return false;
if(!(object instanceof MemberSubscription)) return false;
MemberSubscription anotherMemberSubscription=(MemberSubscription)object;
if(this.invoiceNumber==null && anotherMemberSubscription.invoiceNumber==null) return true;
if(this.invoiceNumber==null || anotherMemberSubscription.invoiceNumber==null) return false;
return this.invoiceNumber.equals(anotherMemberSubscription.invoiceNumber);
}
public int compareTo(MemberSubscription anotherMemberSubscription)
{
if(anotherMemberSubscription==null) return 1;
if(this.invoiceNumber==null && anotherMemberSubscription.invoiceNumber==null) return 0;
int difference;
if(this.invoiceNumber==null && anotherMemberSubscription.invoiceNumber!=null) return 1;
if(this.invoiceNumber!=null && anotherMemberSubscription.invoiceNumber==null) return -1;
difference=this.invoiceNumber.compareTo(anotherMemberSubscription.invoiceNumber);
return difference;
}
public int hashCode()
{
if(this.invoiceNumber==null) return 0;
return this.invoiceNumber.hashCode();
}
}
