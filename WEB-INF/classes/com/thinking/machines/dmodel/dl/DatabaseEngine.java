package com.thinking.machines.dmodel.dl;
import com.thinking.machines.dmframework.annotations.*;
@Display(value="Database Engine")
@Table(name="database_engine")
public class DatabaseEngine implements java.io.Serializable,Comparable<DatabaseEngine>
{
@Sort(priority=1)
@Display(value="code")
@Column(name="code")
private Integer code;
@Display(value="database architecture code")
@Column(name="database_architecture_code")
private Integer databaseArchitectureCode;
@Display(value="name")
@Column(name="name")
private String name;
public DatabaseEngine()
{
this.code=null;
this.databaseArchitectureCode=null;
this.name=null;
}
public void setCode(Integer code)
{
this.code=code;
}
public Integer getCode()
{
return this.code;
}
public void setDatabaseArchitectureCode(Integer databaseArchitectureCode)
{
this.databaseArchitectureCode=databaseArchitectureCode;
}
public Integer getDatabaseArchitectureCode()
{
return this.databaseArchitectureCode;
}
public void setName(String name)
{
this.name=name;
}
public String getName()
{
return this.name;
}
public boolean equals(Object object)
{
if(object==null) return false;
if(!(object instanceof DatabaseEngine)) return false;
DatabaseEngine anotherDatabaseEngine=(DatabaseEngine)object;
if(this.code==null && anotherDatabaseEngine.code==null) return true;
if(this.code==null || anotherDatabaseEngine.code==null) return false;
return this.code.equals(anotherDatabaseEngine.code);
}
public int compareTo(DatabaseEngine anotherDatabaseEngine)
{
if(anotherDatabaseEngine==null) return 1;
if(this.code==null && anotherDatabaseEngine.code==null) return 0;
int difference;
if(this.code==null && anotherDatabaseEngine.code!=null) return 1;
if(this.code!=null && anotherDatabaseEngine.code==null) return -1;
difference=this.code.compareTo(anotherDatabaseEngine.code);
return difference;
}
public int hashCode()
{
if(this.code==null) return 0;
return this.code.hashCode();
}
}
