package com.thinking.machines.dmodel.dl;
import com.thinking.machines.dmframework.annotations.*;
@Display(value="Database Table Field")
@Table(name="database_table_field")
public class DatabaseTableField implements java.io.Serializable,Comparable<DatabaseTableField>
{
@Sort(priority=1)
@Display(value="code")
@Column(name="code")
private Integer code;
@Display(value="table code")
@Column(name="table_code")
private Integer tableCode;
@Display(value="name")
@Column(name="name")
private String name;
@Display(value="database architecture data type code")
@Column(name="database_architecture_data_type_code")
private Integer databaseArchitectureDataTypeCode;
@Display(value="width")
@Column(name="width")
private Integer width;
@Display(value="number of decimal places")
@Column(name="number_of_decimal_places")
private Integer numberOfDecimalPlaces;
@Display(value="is primary key")
@Column(name="is_primary_key")
private Boolean isPrimaryKey;
@Display(value="is auto increment")
@Column(name="is_auto_increment")
private Boolean isAutoIncrement;
@Display(value="is unique")
@Column(name="is_unique")
private Boolean isUnique;
@Display(value="is not null")
@Column(name="is_not_null")
private Boolean isNotNull;
@Display(value="default value")
@Column(name="default_value")
private String defaultValue;
@Display(value="check constraint")
@Column(name="check_constraint")
private String checkConstraint;
@Display(value="note")
@Column(name="note")
private String note;
public DatabaseTableField()
{
this.code=null;
this.tableCode=null;
this.name=null;
this.databaseArchitectureDataTypeCode=null;
this.width=null;
this.numberOfDecimalPlaces=null;
this.isPrimaryKey=null;
this.isAutoIncrement=null;
this.isUnique=null;
this.isNotNull=null;
this.defaultValue=null;
this.checkConstraint=null;
this.note=null;
}
public void setCode(Integer code)
{
this.code=code;
}
public Integer getCode()
{
return this.code;
}
public void setTableCode(Integer tableCode)
{
this.tableCode=tableCode;
}
public Integer getTableCode()
{
return this.tableCode;
}
public void setName(String name)
{
this.name=name;
}
public String getName()
{
return this.name;
}
public void setDatabaseArchitectureDataTypeCode(Integer databaseArchitectureDataTypeCode)
{
this.databaseArchitectureDataTypeCode=databaseArchitectureDataTypeCode;
}
public Integer getDatabaseArchitectureDataTypeCode()
{
return this.databaseArchitectureDataTypeCode;
}
public void setWidth(Integer width)
{
this.width=width;
}
public Integer getWidth()
{
return this.width;
}
public void setNumberOfDecimalPlaces(Integer numberOfDecimalPlaces)
{
this.numberOfDecimalPlaces=numberOfDecimalPlaces;
}
public Integer getNumberOfDecimalPlaces()
{
return this.numberOfDecimalPlaces;
}
public void setIsPrimaryKey(Boolean isPrimaryKey)
{
this.isPrimaryKey=isPrimaryKey;
}
public Boolean getIsPrimaryKey()
{
return this.isPrimaryKey;
}
public void setIsAutoIncrement(Boolean isAutoIncrement)
{
this.isAutoIncrement=isAutoIncrement;
}
public Boolean getIsAutoIncrement()
{
return this.isAutoIncrement;
}
public void setIsUnique(Boolean isUnique)
{
this.isUnique=isUnique;
}
public Boolean getIsUnique()
{
return this.isUnique;
}
public void setIsNotNull(Boolean isNotNull)
{
this.isNotNull=isNotNull;
}
public Boolean getIsNotNull()
{
return this.isNotNull;
}
public void setDefaultValue(String defaultValue)
{
this.defaultValue=defaultValue;
}
public String getDefaultValue()
{
return this.defaultValue;
}
public void setCheckConstraint(String checkConstraint)
{
this.checkConstraint=checkConstraint;
}
public String getCheckConstraint()
{
return this.checkConstraint;
}
public void setNote(String note)
{
this.note=note;
}
public String getNote()
{
return this.note;
}
public boolean equals(Object object)
{
if(object==null) return false;
if(!(object instanceof DatabaseTableField)) return false;
DatabaseTableField anotherDatabaseTableField=(DatabaseTableField)object;
if(this.code==null && anotherDatabaseTableField.code==null) return true;
if(this.code==null || anotherDatabaseTableField.code==null) return false;
return this.code.equals(anotherDatabaseTableField.code);
}
public int compareTo(DatabaseTableField anotherDatabaseTableField)
{
if(anotherDatabaseTableField==null) return 1;
if(this.code==null && anotherDatabaseTableField.code==null) return 0;
int difference;
if(this.code==null && anotherDatabaseTableField.code!=null) return 1;
if(this.code!=null && anotherDatabaseTableField.code==null) return -1;
difference=this.code.compareTo(anotherDatabaseTableField.code);
return difference;
}
public int hashCode()
{
if(this.code==null) return 0;
return this.code.hashCode();
}
}
