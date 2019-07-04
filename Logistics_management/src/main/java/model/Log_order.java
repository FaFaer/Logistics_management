package model;

public class Log_order {
    private int Order_Id;
    private String Order_Code;
    private String Clientele_Id;
    private String Warehouse_Id;
    private String Vehicle_Id;
    private String Order_Status;
    private String User_Id;
    private String Create_Time;
    private String Update_Time;

    public Log_order() {

    }


    public int getOrder_Id() {
        return Order_Id;
    }

    public void setOrder_Id(int order_Id) {
        Order_Id = order_Id;
    }

    public String getOrder_Code() {
        return Order_Code;
    }

    public void setOrder_Code(String order_Code) {
        Order_Code = order_Code;
    }

    public String getClientele_Id() {
        return Clientele_Id;
    }

    public void setClientele_Id(String clientele_Id) {
        Clientele_Id = clientele_Id;
    }

    public String getWarehouse_Id() {
        return Warehouse_Id;
    }

    public void setWarehouse_Id(String warehouse_Id) {
        Warehouse_Id = warehouse_Id;
    }

    public String getVehicle_Id() {
        return Vehicle_Id;
    }

    public void setVehicle_Id(String vehicle_Id) {
        Vehicle_Id = vehicle_Id;
    }


    public String getOrder_Status() {
        return Order_Status;
    }

    public void setOrder_Status(String order_Status) {
        Order_Status = order_Status;
    }

    public String getUser_Id() {
        return User_Id;
    }

    public void setUser_Id(String user_Id) {
        User_Id = user_Id;
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