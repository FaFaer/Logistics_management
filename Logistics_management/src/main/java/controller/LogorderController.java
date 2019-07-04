package controller;

import model.*;
import model.mapping.LogorderMappingDAO;
import model.mapping.VehicleMappingDAO;
import model.mapping.WarehouseMappingDAO;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class LogorderController {
    @Autowired
    private LogorderMappingDAO logorderMappingDAO;
    @Autowired
    private WarehouseMappingDAO warehouseMappingDAO;
    @Autowired
    private VehicleMappingDAO vehicleMappingDAO;
    private static final String SUCCESS = "/JSP/success.jsp";
    private static final String ERROR = "/JSP/error.jsp";
    private SimpleDateFormat timer = new SimpleDateFormat("YYmmssSSSS");

    @RequestMapping(value = "/AddorderTo", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String AddorderTo(Clientele clientele, HttpServletRequest request) {
        String warehouseId = warehouseMappingDAO.AddorderTo(clientele);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("warehouseId", warehouseId);
        return jsonObject.toString();
    }

    /**
     * 导入订单订货单
     *
     * @param request
     * @param httpServletRequest
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/import", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String impotrt(MultipartHttpServletRequest request, HttpServletRequest httpServletRequest) throws Exception {
        MultipartFile file = request.getFile("file");
        String fileName = file.getName();
        InputStream inputStream = file.getInputStream();
        XSSFWorkbook workbook = new XSSFWorkbook(inputStream);
        XSSFSheet sheet = workbook.getSheetAt(0);

        Log_order order = new Log_order();
        // 订单编号
        String s = String.valueOf((int) (Math.random() * 10000) / 1);
        order.setOrder_Code(timer.format(new Date()) + s);
        // 订单创建人
        Users users = (Users) httpServletRequest.getSession().getAttribute("user");
        order.setUser_Id(String.valueOf(users.getUser_Id()));
        // 订单状态
        order.setOrder_Status("0");
        // 订单商品表
        Order_goods orderGoods = new Order_goods();
        // 获取客户CODE
        XSSFRow row = sheet.getRow(0);
        XSSFCell cell = row.getCell(1);
        row.getCell(1).setCellType(Cell.CELL_TYPE_STRING);
        String clienteleCode = cell.getStringCellValue();
        Clientele clientele = logorderMappingDAO.queryId(clienteleCode);

        JSONObject jsonObject = new JSONObject();
        String result = "";
        if (clientele == null) { // 如果客户id 不存在
            result = "0";
            jsonObject.put("msg", "0");
        } else {
            order.setClientele_Id(String.valueOf(clientele.getClientele_Id()));
            order.setWarehouse_Id(clientele.getClientele_Warehouse());
            // 订单轨迹
            Order_track orderTrack = new Order_track();
            orderTrack.setUser_Id(String.valueOf(users.getUser_Id()));
            orderTrack.setPre_Status("-1");
            orderTrack.setAft_Status("0");
            orderTrack.setOrder_Code(order.getOrder_Code());
            order.setClientele_Id(String.valueOf(clientele.getClientele_Id()));

            // 添加订单商品到数据库
            List<Order_goods> order_goodsList = new ArrayList<>();
            Inventory inventory;
            int j = 0;
            for (int i = 2; i <= sheet.getLastRowNum(); i++) {
                row = sheet.getRow(i);
                // 设置单元格数据格式
                row.getCell(0).setCellType(Cell.CELL_TYPE_STRING);
                row.getCell(1).setCellType(Cell.CELL_TYPE_STRING);

                String goodsCode = row.getCell(0).getStringCellValue();
                int goodsAmount = Integer.parseInt(row.getCell(1).getStringCellValue());
                orderGoods.setOrder_Code(clientele.getClientele_Warehouse());
                orderGoods.setOrder_Goods_Code(goodsCode);

                // 查该商品的库存,库存数量需要大于0
                inventory = logorderMappingDAO.queryInventory(orderGoods);
                //如果有库存 才保存
                if (inventory != null) {
                    // 如果需要的数量大于库存量，只发库存的数量
                    if (goodsAmount > inventory.getInventory_Amount()) {
                        goodsAmount = inventory.getInventory_Amount();
                    }

                    orderGoods.setOrder_Code(inventory.getInventory_Goods_Name());
                    Order_goods orderGoods1 = new Order_goods(orderGoods.getOrder_Code(), orderGoods.getOrder_Goods_Code(), goodsAmount);
                    order_goodsList.add(orderGoods1);
                    orderGoods.setOder_Goods_Amount(goodsAmount);
                    orderGoods.setOrder_Code(goodsCode);
                    orderGoods.setOrder_Code(order.getOrder_Code());
                    // 把商品插入到当你订单商品表中，同时删除库存表里的库存
                    j += logorderMappingDAO.AddOrderGoods(orderGoods);
                    logorderMappingDAO.updateInventory(orderGoods);
                }
            }
            int k = logorderMappingDAO.AddOrder(order);
            JSONArray jsonArray = JSONArray.fromObject(order_goodsList);
            jsonObject.put("order_goodsList", jsonArray);
            if (j == order_goodsList.size() && j != 0 && k == 1) {
                result = "1";
                // 如导入成功，则添加操作轨迹
                logorderMappingDAO.addOrderTrack(orderTrack);
            } else {
                result = "2";
                // 如果导入失败则删除与该订单有关的所有数据
                int i = deleteTool(order);
            }

        }
        jsonObject.put("result", result);
        return jsonObject.toString();
    }

    /**
     * 分页查订单列表
     *
     * @param log_order
     * @return
     */
    @RequestMapping(value = "/listL", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String listL(Log_order log_order) {
        log_order.setOrder_Code("%" + log_order.getOrder_Code().trim() + "%");
        int j = log_order.getOrder_Id();
        log_order.setOrder_Id(j * 10);
        List<Log_order> log_orderList = logorderMappingDAO.queryLogOrder(log_order);
        JSONArray jsonArray = JSONArray.fromObject(log_orderList);
        return jsonArray.toString();
    }

    /**
     * 分页查订单数量
     *
     * @param log_order
     * @return
     */
    @RequestMapping(value = "/listLnumber", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String listLnumber(Log_order log_order) {
        log_order.setOrder_Code("%" + log_order.getOrder_Code().trim() + "%");
        int i = logorderMappingDAO.queryLogOrderN(log_order);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("sum", i);
        return jsonObject.toString();
    }

    /**
     * 查订单商品列表
     *
     * @param order_goods
     * @return
     */
    @RequestMapping(value = "/orderGoodList", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String orderGoodList(Order_goods order_goods) {
        List<Order_goods> order_goodsList = logorderMappingDAO.orderGoodList(order_goods);
        JSONArray jsonArray = JSONArray.fromObject(order_goodsList);
        return jsonArray.toString();
    }

    /**
     * 查某个客户的详细信息
     *
     * @param clientele
     * @return
     */
    @RequestMapping(value = "/orderClientele", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String orderClientele(Clientele clientele) {
         clientele = logorderMappingDAO.orderClientele(clientele);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("clientele",clientele);
        return jsonObject.toString();
    }


    /**
     * 删除订单 删除订单表和订单商品表,修改库存把商品从订单商品中加回来
     *
     * @param log_order
     * @return
     */
    @RequestMapping(value = "/deleteL", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String deleteL(Log_order log_order) {
        int i = deleteTool(log_order);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("i", i);
        return jsonObject.toString();
    }

    // 因为两个类都需要用到所有另外放
    public int deleteTool(Log_order log_order) {
        // 删除订单表记录
        int i = logorderMappingDAO.deleteOrder(log_order);
        // 添加库存
        List<Order_goods> order_goodsList = logorderMappingDAO.orderGoodList1(log_order);
        for (Order_goods orderGoods : order_goodsList) {
            logorderMappingDAO.updateInventoryForDown(orderGoods);
        }
        // 删除商品表记录
        int j = logorderMappingDAO.deleteOrderGoods(log_order);
        return i;
    }

    /**
     * 根据订单查询可分配车辆,需要注意车辆状态
     *
     * @param log_order
     * @return
     */
    @RequestMapping(value = "/searchVForOrder", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String searchVForOrder(Log_order log_order) {
        List<Vehicle> vehicleList = logorderMappingDAO.searchVForOrder(log_order);
        JSONArray jsonArray = JSONArray.fromObject(vehicleList);
        return jsonArray.toString();
    }

    /**
     * 给订单添加车辆
     *
     * @param log_order
     * @return
     */
    @RequestMapping(value = "/addvehicleforOrder", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String addvehicleforOrder(Log_order log_order, HttpServletRequest request) {
        // 给订单添加车辆
        boolean b = logorderMappingDAO.addvehicleforOrder(log_order);
        // 修改车辆状态
        Vehicle vehicle = new Vehicle();
        vehicle.setVehicle_Id(Integer.parseInt(log_order.getVehicle_Id()));
        vehicle.setVehicle_Code("1");
        vehicleMappingDAO.updatevhiclestatus(vehicle);
        // 添加订单操作轨迹
        Order_track orderTrack = new Order_track();
        Users users = (Users) request.getSession().getAttribute("user");
        orderTrack.setUser_Id(String.valueOf(users.getUser_Id()));
        orderTrack.setPre_Status("0");
        orderTrack.setAft_Status("1");
        orderTrack.setOrder_Code(log_order.getOrder_Code());
        logorderMappingDAO.addOrderTrack(orderTrack);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("result", b);
        return jsonObject.toString();
    }

    /**
     * 修改订单状态，配送或已到达
     *
     * @param log_order
     * @return
     */
    @RequestMapping(value = "/updateorderStatus", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String updateorderStatus(Log_order log_order, HttpServletRequest request) {
        int i = logorderMappingDAO.updateorderStatus(log_order);

        Order_track orderTrack = new Order_track();
        Users users = (Users) request.getSession().getAttribute("user");
        orderTrack.setUser_Id(String.valueOf(users.getUser_Id()));
        orderTrack.setPre_Status(log_order.getClientele_Id());
        orderTrack.setAft_Status(log_order.getOrder_Status());
        orderTrack.setOrder_Code(log_order.getOrder_Code());
        logorderMappingDAO.addOrderTrack(orderTrack);
        //如果状态改为完成 需要修改车辆状态
        if ("3".equals(log_order.getOrder_Status())) {
            log_order = logorderMappingDAO.queryOnlyOrder(log_order);
            // 修改车辆状态
            Vehicle vehicle = new Vehicle();
            vehicle.setVehicle_Id(Integer.parseInt(log_order.getVehicle_Id()));
            vehicle.setVehicle_Code("0");
            vehicleMappingDAO.updatevhiclestatus(vehicle);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("i", i);
        return jsonObject.toString();
    }

    /**
     * 查订单轨迹列表
     *
     * @param order_goods
     * @return
     */
    @RequestMapping(value = "/orderTrackList", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String orderTrackList(Order_goods order_goods) {
        List<Order_track> order_tracks = logorderMappingDAO.orderTrackList(order_goods);
        JSONArray jsonArray = JSONArray.fromObject(order_tracks);
        return jsonArray.toString();
    }

    /**
     * 导出
     * @param response
     * @return
     * @throws IOException
     */
    @RequestMapping("/createExcel")
    public String createExcel(HttpServletResponse response) throws IOException {
        XSSFWorkbook wb = new XSSFWorkbook();
//建立新的sheet对象（excel的表单）
        XSSFSheet sheet=wb.createSheet("订货单导入模板");
        XSSFRow row = sheet.createRow(0);
        XSSFCell cell = row.createCell(0);
        cell.setCellValue("用户编号");
        cell = row.createCell(1);
        cell.setCellValue("请在此填写十四位客户编号，例：12345678910111");

        row = sheet.createRow(1);
        cell = row.createCell(0);
        cell.setCellValue("商品编号");
        cell = row.createCell(1);
        cell.setCellValue("商品数量");

        row = sheet.createRow(2);
        cell = row.createCell(0);
        cell.setCellValue("请在此填写商品条形码，例：2546213215");
        cell = row.createCell(1);
        cell.setCellValue("请在此填写商品数量，例：100");

        OutputStream output=response.getOutputStream();
        response.reset();
        response.setHeader("Content-disposition", "attachment; filename=orderTemplate.xls");
        response.setContentType("application/msexcel");
        wb.write(output);
        output.close();
        return null;
    }
}
