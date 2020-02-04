package com.thinking.machines.dmodel.dl;
import com.thinking.machines.dmframework.annotations.*;
@Display(value="Member")
@Table(name="member")
public class Member implements java.io.Serializable,Comparable<Member>
{
@Sort(priority=1)
@Display(value="code")
@Column(name="code")
private Integer code;
@Display(value="email id")
@Column(name="email_id")
private String emailId;
@Display(value="password")
@Column(name="password")
private String password;
@Display(value="password key")
@Column(name="password_key")
private String passwordKey;
@Display(value="first name")
@Column(name="first_name")
private String firstName;
@Display(value="last name")
@Column(name="last_name")
private String lastName;
@Display(value="mobile number")
@Column(name="mobile_number")
private String mobileNumber;
@Display(value="status")
@Column(name="status")
private String status;
@Display(value="number of projects")
@Column(name="number_of_projects")
private Integer numberOfProjects;
public Member()
{
this.code=null;
this.emailId=null;
this.password=null;
this.passwordKey=null;
this.firstName=null;
this.lastName=null;
this.mobileNumber=null;
this.status=null;
this.numberOfProjects=null;
}
public void setCode(Integer code)
{
this.code=code;
}
public Integer getCode()
{
return this.code;
}
public void setEmailId(String emailId)
{
this.emailId=emailId;
}
public String getEmailId()
{
return this.emailId;
}
public void setPassword(String password)
{
this.password=password;
}
public String getPassword()
{
return this.password;
}
public void setPasswordKey(String passwordKey)
{
this.passwordKey=passwordKey;
}
public String getPasswordKey()
{
return this.passwordKey;
}
public void setFirstName(String firstName)
{
this.firstName=firstName;
}
public String getFirstName()
{
return this.firstName;
}
public void setLastName(String lastName)
{
this.lastName=lastName;
}
public String getLastName()
{
return this.lastName;
}
public void setMobileNumber(String mobileNumber)
{
this.mobileNumber=mobileNumber;
}
public String getMobileNumber()
{
return this.mobileNumber;
}
public void setStatus(String status)
{
this.status=status;
}
public String getStatus()
{
return this.status;
}
public void setNumberOfProjects(Integer numberOfProjects)
{
this.numberOfProjects=numberOfProjects;
}
public Integer getNumberOfProjects()
{
return this.numberOfProjects;
}
public boolean equals(Object object)
{
if(object==null) return false;
if(!(object instanceof Member)) return false;
Member anotherMember=(Member)object;
if(this.code==null && anotherMember.code==null) return true;
if(this.code==null || anotherMember.code==null) return false;
return this.code.equals(anotherMember.code);
}
public int compareTo(Member anotherMember)
{
if(anotherMember==null) return 1;
if(this.code==null && anotherMember.code==null) return 0;
int difference;
if(this.code==null && anotherMember.code!=null) return 1;
if(this.code!=null && anotherMember.code==null) return -1;
difference=this.code.compareTo(anotherMember.code);
return difference;
}
public int hashCode()
{
if(this.code==null) return 0;
return this.code.hashCode();
}
}
