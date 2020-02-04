package com.thinking.machines.dmodel.dl;
import com.thinking.machines.dmframework.annotations.*;
@Display(value="Administrator")
@Table(name="administrator")
public class Administrator implements java.io.Serializable,Comparable<Administrator>
{
@Sort(priority=1)
@Display(value="username")
@Column(name="username")
private String username;
@Display(value="password")
@Column(name="password")
private String password;
@Display(value="password key")
@Column(name="password_key")
private String passwordKey;
@Display(value="email id")
@Column(name="email_id")
private String emailId;
@Display(value="first name")
@Column(name="first_name")
private String firstName;
@Display(value="last name")
@Column(name="last_name")
private String lastName;
@Display(value="mobile number")
@Column(name="mobile_number")
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
