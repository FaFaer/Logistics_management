package model;

public class Vehicle {
    private int Vehicle_Id;
    private String Vehicle_Code;
    private String Vehicle_Status;//车辆状态0：正常使用，1：送货去了，2：出现故障在维修
    private String Vehicle_Warehouse;
    private String Vehicle_Keeper;//车辆负责人
    private String User_Id;
    private String Create_Time;
    private String Update_Time;

    public Vehicle() {

    }

    public String getVehicle_Keeper() {
        return Vehicle_Keeper;
    }

    public void setVehicle_Keeper(String vehicle_Keeper) {
        Vehicle_Keeper = vehicle_Keeper;
    }

    public String getUser_Id() {
        return User_Id;
    }

    public void setUser_Id(String user_Id) {
        User_Id = user_Id;
    }

    public int getVehicle_Id() {
        return Vehicle_Id;
    }

    public void setVehicle_Id(int vehicle_Id) {
        Vehicle_Id = vehicle_Id;
    }

    public String getVehicle_Code() {
        return Vehicle_Code;
    }

    public void setVehicle_Code(String vehicle_Code) {
        Vehicle_Code = vehicle_Code;
    }

    public String getVehicle_Status() {
        return Vehicle_Status;
    }

    public void setVehicle_Status(String vehicle_Status) {
        Vehicle_Status = vehicle_Status;
    }

    public String getVehicle_Warehouse() {
        return Vehicle_Warehouse;
    }

    public void setVehicle_Warehouse(String vehicle_Warehouse) {
        Vehicle_Warehouse = vehicle_Warehouse;
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