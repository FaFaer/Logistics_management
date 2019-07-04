package model;

public class Order_track {
    private int Order_Track_Id;
    private String Order_Code;
    private String Pre_Status;
    private String Aft_Status;
    private String Operation_Time;
    private String User_Id;

    public Order_track() {

    }

    public int getOrder_Track_Id() {
        return Order_Track_Id;
    }

    public void setOrder_Track_Id(int order_Track_Id) {
        Order_Track_Id = order_Track_Id;
    }

    public String getOrder_Code() {
        return Order_Code;
    }

    public void setOrder_Code(String order_Code) {
        Order_Code = order_Code;
    }

    public String getPre_Status() {
        return Pre_Status;
    }

    public void setPre_Status(String pre_Status) {
        Pre_Status = pre_Status;
    }

    public String getAft_Status() {
        return Aft_Status;
    }

    public void setAft_Status(String aft_Status) {
        Aft_Status = aft_Status;
    }

    public String getOperation_Time() {
        return Operation_Time;
    }

    public void setOperation_Time(String operation_Time) {
        Operation_Time = operation_Time;
    }

    public String getUser_Id() {
        return User_Id;
    }

    public void setUser_Id(String user_Id) {
        User_Id = user_Id;
    }
}