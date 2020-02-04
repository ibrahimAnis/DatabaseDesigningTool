import com.thinking.machines.dmodel.dl.*;
import com.thinking.machines.dmframework.*;
import com.thinking.machines.dmframework.exceptions.*;
import java.util.*;
import java.sql.*;
class database_architecture
{
public static void main(String gg[])
{
try
{
Class.forName("com.mysql.jdbc.Driver");
Connection c;
c=DriverManager.getConnection("jdbc:mysql://localhost:3306/dmodeldb","dmodel","ibrahim");
DatabaseMetaData dbmd=c.getMetaData();
DataManager dataManager=new DataManager();
//Database_architecture table data starts
String database_architecture_name=dbmd.getDatabaseProductName()+"_"+dbmd.getDatabaseProductVersion();
System.out.println("DatabaseName: "+database_architecture_name);
int database_architecture_max_width_of_column_name=dbmd.getMaxColumnNameLength();
System.out.println("Database Maximum width of column name: "+database_architecture_max_width_of_column_name);
int database_architecture_max_width_of_table_name=dbmd.getMaxTableNameLength();
System.out.println("Database Maximum width of Table name:"+database_architecture_max_width_of_table_name);
int database_architecture_max_width_of_relationship_name=100;
System.out.println("Database Maximum width of Table name:"+database_architecture_max_width_of_relationship_name);
//Database_architecture table data ends
DatabaseArchitecture databaseArchitecture=new DatabaseArchitecture();
databaseArchitecture.setName(database_architecture_name);
databaseArchitecture.setMaxWidthOfColumnName(database_architecture_max_width_of_column_name);
databaseArchitecture.setMaxWidthOfTableName(database_architecture_max_width_of_table_name);
databaseArchitecture.setMaxWidthOfRelationshipName(database_architecture_max_width_of_relationship_name);
dataManager.begin();
dataManager.insert(databaseArchitecture);
dataManager.end();
//Database_engine table starts
dataManager.begin();
DatabaseEngine databaseEngine;
Statement s=c.createStatement(); 
s=c.createStatement(); 
ResultSet r=s.executeQuery("show engines");
while(r.next())
{ 
databaseEngine=new DatabaseEngine();
databaseEngine.setDatabaseArchitectureCode(databaseArchitecture.getCode());
databaseEngine.setName(r.getString(1));
System.out.println("DataBase Engine: "+databaseEngine.getName());
dataManager.insert(databaseEngine);
}
dataManager.end();
s.close();
r.close();
//Database_engine table ends
//Database_architecture_data_type table starts
r=dbmd.getTypeInfo();
String database_architecture_data_type_name;
int database_architecture_data_type_max_width,database_architecture_data_type_default_size;
short database_architecture_data_type_max_width_of_precision;
boolean database_architecture_data_type_allow_auto_increment;
dataManager.begin();
DatabaseArchitectureDataType databaseArchitectureDataType;
while(r.next())
{
database_architecture_data_type_name=r.getString("TYPE_NAME");
database_architecture_data_type_max_width=r.getInt("PRECISION");
database_architecture_data_type_default_size=r.getInt("PRECISION");
database_architecture_data_type_max_width_of_precision=r.getShort("MAXIMUM_SCALE");
database_architecture_data_type_allow_auto_increment=r.getBoolean("AUTO_INCREMENT");
databaseArchitectureDataType=new DatabaseArchitectureDataType();
databaseArchitectureDataType.setDatabaseArchitectureCode(databaseArchitecture.getCode());
databaseArchitectureDataType.setDataType(database_architecture_data_type_name);
databaseArchitectureDataType.setMaxWidth(database_architecture_data_type_max_width);
databaseArchitectureDataType.setDefaultSize(database_architecture_data_type_default_size);
databaseArchitectureDataType.setMaxWidthOfPrecision((int)database_architecture_data_type_max_width_of_precision);
databaseArchitectureDataType.setAllowAutoIncrement(database_architecture_data_type_allow_auto_increment);
dataManager.insert(databaseArchitectureDataType);
System.out.println(database_architecture_data_type_name+":::"+database_architecture_data_type_max_width+":::"+database_architecture_data_type_default_size+":::"+database_architecture_data_type_max_width_of_precision+":::"+database_architecture_data_type_allow_auto_increment);
}
dataManager.end();
//Database_architecture_data_type table ends
r.close();
c.close();
}catch(ValidatorException ve)
{
System.out.println(ve);
}
catch(DMFrameworkException dmfe)
{
System.out.println(dmfe.getMessage());
}
catch(Exception e)
{
System.out.println(e);
}
}
}

