import com.thinking.machines.tmws.annotations.*;
import com.thinking.machines.dmframework.*;
import com.thinking.machines.dmframework.exceptions.*;
import com.thinking.machines.dmodel.services.pojo.*;
import com.thinking.machines.dmodel.dl.*;
import com.thinking.machines.dmodel.utilities.*;
import java.sql.*;
import java.util.*;
@Path("/admin")
public class AddSubscriptionPlan implements java.io.Serializable
{
@Path("add")
public void add()
{
com.thinking.machines.dmodel.dl.SubscriptionPlan sp=new com.thinking.machines.dmodel.dl.SubscriptionPlan();
java.util.Date d=new java.util.Date();
java.sql.Date sqlDate=new java.sql.Date(d.getYear(),d.getMonth(),d.getDay());
System.out.println(d);
sp.setMonthlyRate(100);
sp.setYearlyRate(1000);
sp.setFreeTables(25);
sp.setFreeProjects(5);
sp.setEffectiveFrom(sqlDate);
try
{
DataManager dataManager;
dataManager=new DataManager();
dataManager.begin();
dataManager.insert(sp);
dataManager.end();
}catch(ValidatorException validatorException)
{
System.out.println(validatorException.getMessage());
}
catch(DMFrameworkException dmFrameworkException)
{
System.out.println(dmFrameworkException.getMessage());
}
}
public static void main(String gg[])
{
AddSubscriptionPlan a=new AddSubscriptionPlan();
a.add();
}
}
