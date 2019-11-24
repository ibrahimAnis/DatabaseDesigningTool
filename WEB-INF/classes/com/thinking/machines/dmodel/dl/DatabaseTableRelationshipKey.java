package com.thinking.machines.dmodel.dl;
import com.thinking.machines.dmframework.annotations.*;
@Display(value="Database Table Relationship Key")
@Table(name="database_table_relationship_key")
public class DatabaseTableRelationshipKey implements java.io.Serializable,Comparable<DatabaseTableRelationshipKey>
{
@Sort(priority=1)
@Display(value="code")
@Column(name="code")
private Integer code;
@Display(value="database table relationship code")
@Column(name="database_table_relationship_code")
private Integer databaseTableRelationshipCode;
@Display(value="parent database table field code")
@Column(name="parent_database_table_field_code")
private Integer parentDatabaseTableFieldCode;
@Display(value="child database table field code")
@Column(name="child_database_table_field_code")
private Integer childDatabaseTableFieldCode;
public DatabaseTableRelationshipKey()
{
this.code=null;
this.databaseTableRelationshipCode=null;
this.parentDatabaseTableFieldCode=null;
this.childDatabaseTableFieldCode=null;
}
public void setCode(Integer code)
{
this.code=code;
}
public Integer getCode()
{
return this.code;
}
public void setDatabaseTableRelationshipCode(Integer databaseTableRelationshipCode)
{
this.databaseTableRelationshipCode=databaseTableRelationshipCode;
}
public Integer getDatabaseTableRelationshipCode()
{
return this.databaseTableRelationshipCode;
}
public void setParentDatabaseTableFieldCode(Integer parentDatabaseTableFieldCode)
{
this.parentDatabaseTableFieldCode=parentDatabaseTableFieldCode;
}
public Integer getParentDatabaseTableFieldCode()
{
return this.parentDatabaseTableFieldCode;
}
public void setChildDatabaseTableFieldCode(Integer childDatabaseTableFieldCode)
{
this.childDatabaseTableFieldCode=childDatabaseTableFieldCode;
}
public Integer getChildDatabaseTableFieldCode()
{
return this.childDatabaseTableFieldCode;
}
public boolean equals(Object object)
{
if(object==null) return false;
if(!(object instanceof DatabaseTableRelationshipKey)) return false;
DatabaseTableRelationshipKey anotherDatabaseTableRelationshipKey=(DatabaseTableRelationshipKey)object;
if(this.code==null && anotherDatabaseTableRelationshipKey.code==null) return true;
if(this.code==null || anotherDatabaseTableRelationshipKey.code==null) return false;
return this.code.equals(anotherDatabaseTableRelationshipKey.code);
}
public int compareTo(DatabaseTableRelationshipKey anotherDatabaseTableRelationshipKey)
{
if(anotherDatabaseTableRelationshipKey==null) return 1;
if(this.code==null && anotherDatabaseTableRelationshipKey.code==null) return 0;
int difference;
if(this.code==null && anotherDatabaseTableRelationshipKey.code!=null) return 1;
if(this.code!=null && anotherDatabaseTableRelationshipKey.code==null) return -1;
difference=this.code.compareTo(anotherDatabaseTableRelationshipKey.code);
return difference;
}
public int hashCode()
{
if(this.code==null) return 0;
return this.code.hashCode();
}
}
