package com.thinking.machines.dmodel.dl;
import com.thinking.machines.dmframework.annotations.*;
import java.sql.*;
@Display(value="Project")
@Table(name="project")
public class Project implements java.io.Serializable,Comparable<Project>
{
@Sort(priority=1)
@Display(value="code")
@Column(name="code")
private Integer code;
@Display(value="title")
@Column(name="title")
private String title;
@Display(value="member code")
@Column(name="member_code")
private Integer memberCode;
@Display(value="database architecture code")
@Column(name="database_architecture_code")
private Integer databaseArchitectureCode;
@Display(value="date of creation")
@Column(name="date_of_creation")
private Date dateOfCreation;
@Display(value="time of creation")
@Column(name="time_of_creation")
private Time timeOfCreation;
@Display(value="number of table")
@Column(name="number_of_table")
private Integer numberOfTable;
public Project()
{
this.code=null;
this.title=null;
this.memberCode=null;
this.databaseArchitectureCode=null;
this.dateOfCreation=null;
this.timeOfCreation=null;
this.numberOfTable=null;
}
public void setCode(Integer code)
{
this.code=code;
}
public Integer getCode()
{
return this.code;
}
public void setTitle(String title)
{
this.title=title;
}
public String getTitle()
{
return this.title;
}
public void setMemberCode(Integer memberCode)
{
this.memberCode=memberCode;
}
public Integer getMemberCode()
{
return this.memberCode;
}
public void setDatabaseArchitectureCode(Integer databaseArchitectureCode)
{
this.databaseArchitectureCode=databaseArchitectureCode;
}
public Integer getDatabaseArchitectureCode()
{
return this.databaseArchitectureCode;
}
public void setDateOfCreation(Date dateOfCreation)
{
this.dateOfCreation=dateOfCreation;
}
public Date getDateOfCreation()
{
return this.dateOfCreation;
}
public void setTimeOfCreation(Time timeOfCreation)
{
this.timeOfCreation=timeOfCreation;
}
public Time getTimeOfCreation()
{
return this.timeOfCreation;
}
public void setNumberOfTable(Integer numberOfTable)
{
this.numberOfTable=numberOfTable;
}
public Integer getNumberOfTable()
{
return this.numberOfTable;
}
public boolean equals(Object object)
{
if(object==null) return false;
if(!(object instanceof Project)) return false;
Project anotherProject=(Project)object;
if(this.code==null && anotherProject.code==null) return true;
if(this.code==null || anotherProject.code==null) return false;
return this.code.equals(anotherProject.code);
}
public int compareTo(Project anotherProject)
{
if(anotherProject==null) return 1;
if(this.code==null && anotherProject.code==null) return 0;
int difference;
if(this.code==null && anotherProject.code!=null) return 1;
if(this.code!=null && anotherProject.code==null) return -1;
difference=this.code.compareTo(anotherProject.code);
return difference;
}
public int hashCode()
{
if(this.code==null) return 0;
return this.code.hashCode();
}
}
