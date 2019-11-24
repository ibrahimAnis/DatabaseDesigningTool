package com.thinking.machines.dmodel.services.pojo;
public class Administrator implements java.io.Serializable,Comparable<Administrator>
{
private String username;
private String password;
private String passwordKey;
private String emailId;
private String firstName;
private String lastName;
private String mobileNumber;
public Administrator()
{
this.username=null;
this.password=null;
this.passwordKey=null;
this.emailId=null;
this.firstName=null;
this.lastName=null;
this.mobileNumber=null;
}
public void setUsername(String username)
{
this.username=username;
}
public String getUsername()
{
return this.username;
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
public void setEmailId(String emailId)
{
this.emailId=emailId;
}
public String getEmailId()
{
return this.emailId;
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
if(!(object instanceof Administrator)) return false;
Administrator anotherAdministrator=(Administrator)object;
if(this.username==null && anotherAdministrator.username==null) return true;
if(this.username==null || anotherAdministrator.username==null) return false;
return this.username.equals(anotherAdministrator.username);
}
public int compareTo(Administrator anotherAdministrator)
{
if(anotherAdministrator==null) return 1;
if(this.username==null && anotherAdministrator.username==null) return 0;
int difference;
if(this.username==null && anotherAdministrator.username!=null) return 1;
if(this.username!=null && anotherAdministrator.username==null) return -1;
difference=this.username.compareTo(anotherAdministrator.username);
return difference;
}
public int hashCode()
{
if(this.username==null) return 0;
return this.username.hashCode();
}
}
