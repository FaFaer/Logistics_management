package controller;

import model.Role;
import model.Users;
import model.Warehouse;
import model.mapping.RoleMappingDAO;
import model.mapping.WarehouseMappingDAO;
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
public class WarehouseController {
    @Autowired
    private WarehouseMappingDAO warehouseMappingDAO;
    private static final String SUCCESS = "/JSP/success.jsp";
    private static final String ERROR = "/JSP/error.jsp";
    private SimpleDateFormat timer = new SimpleDateFormat("YYmmssSSSS");

    /**
     * 添加仓库
     *
     * @param warehouse
     * @param request
     * @return
     */
    @RequestMapping(value = "/addwarehouse", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String addwarehouse(Warehouse warehouse, HttpServletRequest request) {
        warehouse.setWarehouse_Name(warehouse.getWarehouse_Name().trim());
        warehouse.setWarehouse_Address(warehouse.getWarehouse_Address().trim());
        String s = String.valueOf((int) (Math.random() * 10000) / 1);
        warehouse.setWarehouse_Code(timer.format(new Date()) + s);
        Users users = (Users) request.getSession().getAttribute("user");
        warehouse.setCreate_User_Id(String.valueOf(users.getUser_Id()));
        boolean b = warehouseMappingDAO.savewarehouse(warehouse);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("result",b);
        return jsonObject.toString();
    }

    //
//    /**
//     * 查询所有角色
//     *
//     * @return
//     */
//    @RequestMapping(value = "/selectRole", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
//    @ResponseBody
//    public String roleListController() {
//        List<Role> roleList = roleMappingDAO.roleList();
//        JSONArray jsonArray = JSONArray.fromObject(roleList);
//        return jsonArray.toString();
//    }
//
    @RequestMapping(value = "/deleteW", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String deleteW(Warehouse warehouse) {
        // 先查询库存表里还有没有该种商品
        JSONObject jsonObject = new JSONObject();
        int j = warehouseMappingDAO.queryForDelwarehouse(warehouse);
        if (j > 0) {
            jsonObject.put("j", j);
        } else {
            jsonObject.put("j", 0);
            int i = warehouseMappingDAO.deleteWarehouse(warehouse);
            jsonObject.put("i", i);
        }
        return jsonObject.toString();
    }

    /**
     * 查用户列表
     *
     * @param warehouse
     * @return
     */
    @RequestMapping(value = "/listW", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String listW(Warehouse warehouse) {
        warehouse.setWarehouse_Address("%" + warehouse.getWarehouse_Address().trim() + "%");
        warehouse.setWarehouse_Name("%" + warehouse.getWarehouse_Name().trim() + "%");
        int j = warehouse.getWarehouse_Id();
        warehouse.setWarehouse_Id(j * 10);
        List<Warehouse> warehouseList = warehouseMappingDAO.querywarehouse(warehouse);
        JSONArray jsonArray = JSONArray.fromObject(warehouseList);
        return jsonArray.toString();
    }


    /**
     * 分页查数量
     *
     * @param warehouse
     * @return
     */
    @RequestMapping(value = "/listWnumber", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String listWnumber(Warehouse warehouse) {
        warehouse.setWarehouse_Address("%" + warehouse.getWarehouse_Address().trim() + "%");
        warehouse.setWarehouse_Name("%" + warehouse.getWarehouse_Name().trim() + "%");
        int i = warehouseMappingDAO.querywarehousenumber(warehouse);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("sum", i);
        return jsonObject.toString();
    }

    /**
     * 修改前跳转查询
     *
     * @param warehouse
     * @return
     */
    @RequestMapping(value = "/editwarehouse", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String editwarehouse(Warehouse warehouse) {
        warehouse = warehouseMappingDAO.selectWOnly(warehouse);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("warehouse", warehouse);
        return jsonObject.toString();
    }

    @RequestMapping(value = "edit1warehouse", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String edit1warehouse(Warehouse warehouse) {
        int i = warehouseMappingDAO.updatewarehouse(warehouse);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("i", i);
        return jsonObject.toString();
    }
}
