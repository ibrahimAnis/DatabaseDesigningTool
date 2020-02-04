package com.thinking.machines.dmodel.dl;
import com.thinking.machines.dmframework.annotations.*;
import java.sql.*;
@Display(value="Member Address")
@Table(name="member_address")
public class MemberAddress implements java.io.Serializable,Comparable<MemberAddress>
{
@Sort(priority=1)
@Display(value="code")
@Column(name="code")
private Integer code;
@Display(value="member code")
@Column(name="member_code")
private Integer memberCode;
@Display(value="address")
@Column(name="address")
private String address;
@Display(value="effective from")
@Column(name="effective_from")
private Date effectiveFrom;
public MemberAddress()
{
this.code=null;
this.memberCode=null;
this.address=null;
this.effectiveFrom=null;
}
public void setCode(Integer code)
{
this.code=code;
}
public Integer getCode()
{
return this.code;
}
public void setMemberCode(Integer memberCode)
{
this.memberCode=memberCode;
}
public Integer getMemberCode()
{
return this.memberCode;
}
public void setAddress(String address)
{
this.address=address;
}
public String getAddress()
{
return this.address;
}
public void setEffectiveFrom(Date effectiveFrom)
{
this.effectiveFrom=effectiveFrom;
}
public Date getEffectiveFrom()
{
return this.effectiveFrom;
}
public boolean equals(Object object)
{
if(object==null) return false;
if(!(object instanceof MemberAddress)) return false;
MemberAddress anotherMemberAddress=(MemberAddress)object;
if(this.code==null && anotherMemberAddress.code==null) return true;
if(this.code==null || anotherMemberAddress.code==null) return false;
return this.code.equals(anotherMemberAddress.code);
}
public int compareTo(MemberAddress anotherMemberAddress)
{
if(anotherMemberAddress==null) return 1;
if(this.code==null && anotherMemberAddress.code==null) return 0;
int difference;
if(this.code==null && anotherMemberAddress.code!=null) return 1;
if(this.code!=null && anotherMemberAddress.code==null) return -1;
difference=this.code.compareTo(anotherMemberAddress.code);
return difference;
}
public int hashCode()
{
if(this.code==null) return 0;
return this.code.hashCode();
}
}
