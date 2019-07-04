package controller;

import model.Users;
import model.Vehicle;
import model.mapping.VehicleMappingDAO;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class VehicleController {
    @Autowired
    private VehicleMappingDAO vehicleMappingDAO;

    private SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private SimpleDateFormat timer = new SimpleDateFormat("YYmmssSSSS");
    private static final String SUCCESS = "/JSP/success.jsp";
    private static final String ERROR = "/JSP/error.jsp";

    /**
     * 根据仓库查询车辆列表
     *
     * @param vehicle
     * @return
     */
    @RequestMapping(value = "/listVForOrder", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String listVForOrder(Vehicle vehicle) {
        List<Vehicle> vehicles = vehicleMappingDAO.listVForOrder(vehicle);
        JSONArray jsonArray = JSONArray.fromObject(vehicles);
        return jsonArray.toString();
    }

    /**
     * 添加车辆
     *
     * @param vehicle
     * @param request
     * @return
     */
    @RequestMapping(value = "/addvehicle", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String addvehicle(Vehicle vehicle, HttpServletRequest request) {
        Users users = (Users) request.getSession().getAttribute("user");
        vehicle.setUser_Id(String.valueOf(users.getUser_Id()));
        vehicle.setVehicle_Code(vehicle.getVehicle_Code().trim());
        vehicle.setVehicle_Status("0");
        boolean b = vehicleMappingDAO.saveVehicle(vehicle);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("result",b);
        return jsonObject.toString();
    }

    /**
     * 查车辆列表
     *
     * @param vehicle
     * @return
     */
    @RequestMapping(value = "/listV", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String listV(Vehicle vehicle) {
        vehicle.setVehicle_Id(vehicle.getVehicle_Id() * 10);
        List<Vehicle> vehicles = vehicleMappingDAO.queryvehicle(vehicle);
        JSONArray jsonArray = JSONArray.fromObject(vehicles);
        return jsonArray.toString();
    }

    /**
     * 分页查数量
     *
     * @param vehicle
     * @return
     */
    @RequestMapping(value = "/listvnumber", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String querynumber(Vehicle vehicle) {
        int i = vehicleMappingDAO.queryvehiclenumber(vehicle);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("sum", i);
        return jsonObject.toString();
    }

    /**
     * 删除车辆
     *
     * @param vehicle
     * @return
     */
    @RequestMapping(value = "/deleteV", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String deleteV(Vehicle vehicle) {
        int i = vehicleMappingDAO.deleteVehicle(vehicle);
        JSONArray jsonArray = new JSONArray();
        jsonArray.add(i);
        return jsonArray.toString();
    }

    /**
     * 修改前查询需要修改的车辆信息
     * @param vehicle
     * @return
     */
    @RequestMapping(value = "/editvehicle", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String editvehicle(Vehicle vehicle) {
        vehicle = vehicleMappingDAO.queryveh(vehicle);
        JSONObject jsonObject = JSONObject.fromObject(vehicle);
        return jsonObject.toString();
    }

    /**
     * 修改车辆信息
     *
     * @param vehicle
     * @return
     */
    @RequestMapping(value = "/editvehicle1", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    public String editvehicle1(Vehicle vehicle) {
        int i = vehicleMappingDAO.editcehicle1(vehicle);
        if (i > 0) {
            return SUCCESS;
        } else return ERROR;
    }

    /**
     * 修改车辆状态，code代表改到什么状态，只能从等待该到维修，从维修改到等待，或者是之后的建立订单把状态改成送货状态
     * @param vehicle
     * @return
     */
    @RequestMapping(value = "/updateVehicleStatus", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String updateVehicleStatus(Vehicle vehicle) {
        int i = vehicleMappingDAO.updatevhiclestatus(vehicle);
        JSONArray jsonArray = new JSONArray();
        jsonArray.add(i);
        return jsonArray.toString();
    }
}
