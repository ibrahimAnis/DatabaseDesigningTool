package com.thinking.machines.dmodel.dl;
import com.thinking.machines.dmframework.annotations.*;
@Display(value="Database Architecture")
@Table(name="database_architecture")
public class DatabaseArchitecture implements java.io.Serializable,Comparable<DatabaseArchitecture>
{
@Sort(priority=1)
@Display(value="code")
@Column(name="code")
private Integer code;
@Display(value="name")
@Column(name="name")
private String name;
@Display(value="max width of column name")
@Column(name="max_width_of_column_name")
private Integer maxWidthOfColumnName;
@Display(value="max width of table name")
@Column(name="max_width_of_table_name")
private Integer maxWidthOfTableName;
@Display(value="max width of relationship name")
@Column(name="max_width_of_relationship_name")
private Integer maxWidthOfRelationshipName;
public DatabaseArchitecture()
{
this.code=null;
this.name=null;
this.maxWidthOfColumnName=null;
this.maxWidthOfTableName=null;
this.maxWidthOfRelationshipName=null;
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
public void setMaxWidthOfColumnName(Integer maxWidthOfColumnName)
{
this.maxWidthOfColumnName=maxWidthOfColumnName;
}
public Integer getMaxWidthOfColumnName()
{
return this.maxWidthOfColumnName;
}
public void setMaxWidthOfTableName(Integer maxWidthOfTableName)
{
this.maxWidthOfTableName=maxWidthOfTableName;
}
public Integer getMaxWidthOfTableName()
{
return this.maxWidthOfTableName;
}
public void setMaxWidthOfRelationshipName(Integer maxWidthOfRelationshipName)
{
this.maxWidthOfRelationshipName=maxWidthOfRelationshipName;
}
public Integer getMaxWidthOfRelationshipName()
{
return this.maxWidthOfRelationshipName;
}
public boolean equals(Object object)
{
if(object==null) return false;
if(!(object instanceof DatabaseArchitecture)) return false;
DatabaseArchitecture anotherDatabaseArchitecture=(DatabaseArchitecture)object;
if(this.code==null && anotherDatabaseArchitecture.code==null) return true;
if(this.code==null || anotherDatabaseArchitecture.code==null) return false;
return this.code.equals(anotherDatabaseArchitecture.code);
}
public int compareTo(DatabaseArchitecture anotherDatabaseArchitecture)
{
if(anotherDatabaseArchitecture==null) return 1;
if(this.code==null && anotherDatabaseArchitecture.code==null) return 0;
int difference;
if(this.code==null && anotherDatabaseArchitecture.code!=null) return 1;
if(this.code!=null && anotherDatabaseArchitecture.code==null) return -1;
difference=this.code.compareTo(anotherDatabaseArchitecture.code);
return difference;
}
public int hashCode()
{
if(this.code==null) return 0;
return this.code.hashCode();
}
}
