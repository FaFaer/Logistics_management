package model;

public class Users {
    private int User_Id;
    private String User_Code;
    private String User_Name;
    private String User_Password;
    private String User_Email;
    private String User_Tel;
    private String User_Status;
    private String User_Permission;
    private String Create_User_Id;
    private String Create_Time;
    private String Update_Time;

    public Users() {

    }

    public String getUser_Code() {
        return User_Code;
    }

    public void setUser_Code(String user_Code) {
        User_Code = user_Code;
    }

    public int getUser_Id() {
        return User_Id;
    }

    public String getUser_Status() {
        return User_Status;
    }

    public void setUser_Status(String user_Status) {
        User_Status = user_Status;
    }

    public String getUser_Email() {
        return User_Email;
    }

    public void setUser_Email(String user_Email) {
        User_Email = user_Email;
    }

    public String getUser_Tel() {
        return User_Tel;
    }

    public void setUser_Tel(String user_Tel) {
        User_Tel = user_Tel;
    }

    public void setUser_Id(int user_Id) {
        User_Id = user_Id;
    }


    public String getUser_Name() {
        return User_Name;
    }

    public void setUser_Name(String user_Name) {
        User_Name = user_Name;
    }

    public String getUser_Password() {
        return User_Password;
    }

    public void setUser_Password(String user_Password) {
        User_Password = user_Password;
    }

    public String getUser_Permission() {
        return User_Permission;
    }

    public void setUser_Permission(String user_Permission) {
        User_Permission = user_Permission;
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