import com.thinking.machines.tmws.annotations.*;
import com.thinking.machines.dmframework.*;
import com.thinking.machines.dmframework.exceptions.*;
import com.thinking.machines.dmodel.utilities.*;
import com.thinking.machines.dmodel.dl.*;
public class AdminService
{
public void add()
{
Administrator admin=new Administrator();
admin.setFirstName("Ibrahim");
admin.setLastName("Anis");
admin.setPasswordKey("ibrahim");
String password=Encryptor.encrypt("thinkingmachines","ibrahim");
admin.setPassword(password);
admin.setMobileNumber("8878052877");
admin.setEmailId("anisibrahim21@gmail.com");
admin.setUsername("anisibrahim21");
try
{
DataManager dataManager;
dataManager=new DataManager();
dataManager.begin();
dataManager.insert(admin);
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
AdminService a=new AdminService();
a.add();
}
}
