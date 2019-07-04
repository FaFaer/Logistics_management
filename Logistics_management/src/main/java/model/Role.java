package model;

public class Role {
    private int Role_Id;
    private String Role_Code;
    private String Role_Name;
    private String Role_User_Permission; //对用户的权限
    private String Role_Resource_Permission; // 对资源的权限
    private String Role_Describe; // 描述
    private String Role_Status; // 状态：A 启用 X停用
    private String Create_User_Id; // 创建用户的id
    private String Create_Time;
    private String Update_Time;

    public Role() {

    }

    public String getRole_Code() {
        return Role_Code;
    }

    public void setRole_Code(String role_Code) {
        Role_Code = role_Code;
    }

    public int getRole_Id() {
        return Role_Id;
    }

    public void setRole_Id(int role_Id) {
        Role_Id = role_Id;
    }

    public String getRole_Name() {
        return Role_Name;
    }

    public void setRole_Name(String role_Name) {
        Role_Name = role_Name;
    }

    public String getRole_User_Permission() {
        return Role_User_Permission;
    }

    public void setRole_User_Permission(String role_User_Permission) {
        Role_User_Permission = role_User_Permission;
    }

    public String getRole_Resource_Permission() {
        return Role_Resource_Permission;
    }

    public void setRole_Resource_Permission(String role_Resource_Permission) {
        Role_Resource_Permission = role_Resource_Permission;
    }

    public String getRole_Describe() {
        return Role_Describe;
    }

    public void setRole_Describe(String role_Describe) {
        Role_Describe = role_Describe;
    }

    public String getRole_Status() {
        return Role_Status;
    }

    public void setRole_Status(String role_Status) {
        Role_Status = role_Status;
    }

    public String getCreate_User_Id() {
        return Create_User_Id;
    }

    public void setCreate_User_Id(String create_User_Id) {
        Create_User_Id = create_User_Id;
    }

    public String getCreate_Time() {
        return Create_Time;
    }

    public void setCreate_Time(String create_Time) {
        Create_Time = create_Time;
    }

    public String getUpdate_Time() {
        return Update_Time;
    }

    public void setUpdate_Time(String update_Time) {
        Update_Time = update_Time;
    }
}