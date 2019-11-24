package com.thinking.machines.dmodel.dl;
import com.thinking.machines.dmframework.annotations.*;
@Display(value="Database Table Relationship")
@Table(name="database_table_relationship")
public class DatabaseTableRelationship implements java.io.Serializable,Comparable<DatabaseTableRelationship>
{
@Sort(priority=1)
@Display(value="code")
@Column(name="code")
private Integer code;
@Display(value="name")
@Column(name="name")
private String name;
@Display(value="parent database table code")
@Column(name="parent_database_table_code")
private Integer parentDatabaseTableCode;
@Display(value="child database table code")
@Column(name="child_database_table_code")
private Integer childDatabaseTableCode;
public DatabaseTableRelationship()
{
this.code=null;
this.name=null;
this.parentDatabaseTableCode=null;
this.childDatabaseTableCode=null;
}
public void setCode(Integer code)
{
this.code=code;
}
public Integer getCode()
{
return this.code;
}
public void setName(String name)
{
this.name=name;
}
public String getName()
{
return this.name;
}
public void setParentDatabaseTableCode(Integer parentDatabaseTableCode)
{
this.parentDatabaseTableCode=parentDatabaseTableCode;
}
public Integer getParentDatabaseTableCode()
{
return this.parentDatabaseTableCode;
}
public void setChildDatabaseTableCode(Integer childDatabaseTableCode)
{
this.childDatabaseTableCode=childDatabaseTableCode;
}
public Integer getChildDatabaseTableCode()
{
return this.childDatabaseTableCode;
}
public boolean equals(Object object)
{
if(object==null) return false;
if(!(object instanceof DatabaseTableRelationship)) return false;
DatabaseTableRelationship anotherDatabaseTableRelationship=(DatabaseTableRelationship)object;
if(this.code==null && anotherDatabaseTableRelationship.code==null) return true;
if(this.code==null || anotherDatabaseTableRelationship.code==null) return false;
return this.code.equals(anotherDatabaseTableRelationship.code);
}
public int compareTo(DatabaseTableRelationship anotherDatabaseTableRelationship)
{
if(anotherDatabaseTableRelationship==null) return 1;
if(this.code==null && anotherDatabaseTableRelationship.code==null) return 0;
int difference;
if(this.code==null && anotherDatabaseTableRelationship.code!=null) return 1;
if(this.code!=null && anotherDatabaseTableRelationship.code==null) return -1;
difference=this.code.compareTo(anotherDatabaseTableRelationship.code);
return difference;
}
public int hashCode()
{
if(this.code==null) return 0;
return this.code.hashCode();
}
}
