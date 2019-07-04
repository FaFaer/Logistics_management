package controller;

import model.Goods;
import model.Inventory;
import model.mapping.GoodsMappingDAO;
import model.mapping.InventoryMappingDAO;
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
public class InventoryController {
    @Autowired
    private InventoryMappingDAO inventoryMappingDAO;
    private static final String SUCCESS = "/JSP/success.jsp";
    private static final String ERROR = "/JSP/error.jsp";
    private SimpleDateFormat timer = new SimpleDateFormat("YYmmssSSSS");

    /**
     * 查库存列表
     *
     * @param inventory
     * @return
     */
    @RequestMapping(value = "/listI", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String listI(Inventory inventory) {
        inventory.setInventory_Goods_Name("%" + inventory.getInventory_Goods_Name().trim() + "%");
        int j = inventory.getInventory_Id();
        inventory.setInventory_Id(j*10);
        List<Inventory> inventoryList = inventoryMappingDAO.queryInventoryL(inventory);
        JSONArray jsonArray = JSONArray.fromObject(inventoryList);
        return jsonArray.toString();
    }

    /**
     * 分页查数量
     *
     * @param inventory
     * @return
     */
    @RequestMapping(value = "/listINumber", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String listINumber(Inventory inventory) {
        inventory.setInventory_Goods_Name("%" + inventory.getInventory_Goods_Name().trim() + "%");
        int i = inventoryMappingDAO.queryInventoryN(inventory);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("sum", i);
        return jsonObject.toString();
    }


    /**
     * 添加库存
     *
     * @param inventory
     * @param request
     * @return
     */
    @RequestMapping(value = "/addInventory", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String addInventory(Inventory inventory, HttpServletRequest request) {
        List<Inventory> inventoryList = inventoryMappingDAO.queryPreAdd(inventory);
        boolean b = false;
        if (inventoryList.isEmpty()) {
            String s = String.valueOf((int) (Math.random() * 10000) / 1);
            inventory.setInventory_Code(timer.format(new Date()) + s);
           b = inventoryMappingDAO.addInventory(inventory);
        } else {
            for (Inventory inventory1 : inventoryList) {
                inventory1.setInventory_Amount(inventory.getInventory_Amount()+inventory1.getInventory_Amount());
                b = inventoryMappingDAO.updateInventory(inventory1);
            }
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("result",b);
        return jsonObject.toString();
    }

}
