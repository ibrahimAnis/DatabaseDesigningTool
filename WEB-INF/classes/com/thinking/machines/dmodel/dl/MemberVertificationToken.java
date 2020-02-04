package com.thinking.machines.dmodel.dl;
import com.thinking.machines.dmframework.annotations.*;
@Display(value="Member Vertification Token")
@Table(name="member_vertification_token")
public class MemberVertificationToken implements java.io.Serializable,Comparable<MemberVertificationToken>
{
@Sort(priority=1)
@Display(value="member code")
@Column(name="member_code")
private Integer memberCode;
@Display(value="token")
@Column(name="token")
private String token;
public MemberVertificationToken()
{
this.memberCode=null;
this.token=null;
}
public void setMemberCode(Integer memberCode)
{
this.memberCode=memberCode;
}
public Integer getMemberCode()
{
return this.memberCode;
}
public void setToken(String token)
{
this.token=token;
}
public String getToken()
{
return this.token;
}
public boolean equals(Object object)
{
if(object==null) return false;
if(!(object instanceof MemberVertificationToken)) return false;
MemberVertificationToken anotherMemberVertificationToken=(MemberVertificationToken)object;
if(this.memberCode==null && anotherMemberVertificationToken.memberCode==null) return true;
if(this.memberCode==null || anotherMemberVertificationToken.memberCode==null) return false;
return this.memberCode.equals(anotherMemberVertificationToken.memberCode);
}
public int compareTo(MemberVertificationToken anotherMemberVertificationToken)
{
if(anotherMemberVertificationToken==null) return 1;
if(this.memberCode==null && anotherMemberVertificationToken.memberCode==null) return 0;
int difference;
if(this.memberCode==null && anotherMemberVertificationToken.memberCode!=null) return 1;
if(this.memberCode!=null && anotherMemberVertificationToken.memberCode==null) return -1;
difference=this.memberCode.compareTo(anotherMemberVertificationToken.memberCode);
return difference;
}
public int hashCode()
{
if(this.memberCode==null) return 0;
return this.memberCode.hashCode();
}
}
