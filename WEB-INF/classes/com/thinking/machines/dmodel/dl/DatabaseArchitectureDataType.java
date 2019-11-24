package com.thinking.machines.dmodel.dl;
import com.thinking.machines.dmframework.annotations.*;
@Display(value="Database Architecture Data Type")
@Table(name="database_architecture_data_type")
public class DatabaseArchitectureDataType implements java.io.Serializable,Comparable<DatabaseArchitectureDataType>
{
@Sort(priority=1)
@Display(value="code")
@Column(name="code")
private Integer code;
@Display(value="database architecture code")
@Column(name="database_architecture_code")
private Integer databaseArchitectureCode;
@Display(value="data type")
@Column(name="data_type")
private String dataType;
@Display(value="max width")
@Column(name="max_width")
private Integer maxWidth;
@Display(value="default size")
@Column(name="default_size")
private Integer defaultSize;
@Display(value="max width of precision")
@Column(name="max_width_of_precision")
private Integer maxWidthOfPrecision;
@Display(value="allow auto increment")
@Column(name="allow_auto_increment")
private Boolean allowAutoIncrement;
public DatabaseArchitectureDataType()
{
this.code=null;
this.databaseArchitectureCode=null;
this.dataType=null;
this.maxWidth=null;
this.defaultSize=null;
this.maxWidthOfPrecision=null;
this.allowAutoIncrement=null;
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
public void setDataType(String dataType)
{
this.dataType=dataType;
}
public String getDataType()
{
return this.dataType;
}
public void setMaxWidth(Integer maxWidth)
{
this.maxWidth=maxWidth;
}
public Integer getMaxWidth()
{
return this.maxWidth;
}
public void setDefaultSize(Integer defaultSize)
{
this.defaultSize=defaultSize;
}
public Integer getDefaultSize()
{
return this.defaultSize;
}
public void setMaxWidthOfPrecision(Integer maxWidthOfPrecision)
{
this.maxWidthOfPrecision=maxWidthOfPrecision;
}
public Integer getMaxWidthOfPrecision()
{
return this.maxWidthOfPrecision;
}
public void setAllowAutoIncrement(Boolean allowAutoIncrement)
{
this.allowAutoIncrement=allowAutoIncrement;
}
public Boolean getAllowAutoIncrement()
{
return this.allowAutoIncrement;
}
public boolean equals(Object object)
{
if(object==null) return false;
if(!(object instanceof DatabaseArchitectureDataType)) return false;
DatabaseArchitectureDataType anotherDatabaseArchitectureDataType=(DatabaseArchitectureDataType)object;
if(this.code==null && anotherDatabaseArchitectureDataType.code==null) return true;
if(this.code==null || anotherDatabaseArchitectureDataType.code==null) return false;
return this.code.equals(anotherDatabaseArchitectureDataType.code);
}
public int compareTo(DatabaseArchitectureDataType anotherDatabaseArchitectureDataType)
{
if(anotherDatabaseArchitectureDataType==null) return 1;
if(this.code==null && anotherDatabaseArchitectureDataType.code==null) return 0;
int difference;
if(this.code==null && anotherDatabaseArchitectureDataType.code!=null) return 1;
if(this.code!=null && anotherDatabaseArchitectureDataType.code==null) return -1;
difference=this.code.compareTo(anotherDatabaseArchitectureDataType.code);
return difference;
}
public int hashCode()
{
if(this.code==null) return 0;
return this.code.hashCode();
}
}
