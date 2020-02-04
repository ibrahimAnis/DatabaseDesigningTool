package com.thinking.machines.dmodel.services.pojo;
public class Member implements java.io.Serializable,Comparable<Member>
{
private Integer code;
private String emailId;
private String password;
//private String passwordKey;
private String firstName;
private String lastName;
private String mobileNumber;
private String status;
private Integer numberOfProjects;
public Member()
{
this.code=null;
this.emailId=null;
this.password=null;
//this.passwordKey=null;
this.firstName=null;
this.lastName=null;
this.mobileNumber=null;
this.status=null;
this.numberOfProjects=null;
}
public void setCode(int code)
{
this.code=code;
}
public int getCode()
{
return this.code;
}
public void setStatus(String status)
{
this.status=status;
}
public String getStatus()
{
return this.status;
}
public void setNumberOfProjects(int numberOfProjects)
{
this.numberOfProjects=numberOfProjects;
}
public int getNumberOfProjects()
{
return this.numberOfProjects;
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
public boolean equals(Object object)
{
if(object==null) return false;
if(!(object instanceof Member)) return false;
Member anotherMember=(Member)object;
if(this.emailId==null && anotherMember.emailId==null) return true;
if(this.emailId==null || anotherMember.emailId==null) return false;
return this.emailId.equalsIgnoreCase(anotherMember.emailId);
}
public int compareTo(Member anotherMember)
{
if(anotherMember==null) return 1;
if(this.emailId==null && anotherMember.emailId==null) return 0;
int difference;
if(this.emailId==null && anotherMember.emailId!=null) return 1;
if(this.emailId!=null && anotherMember.emailId==null) return -1;
difference=this.emailId.compareTo(anotherMember.emailId);
return difference;
}
}
