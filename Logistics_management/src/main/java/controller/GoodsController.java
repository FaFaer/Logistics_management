package controller;

import model.Goods;
import model.Users;
import model.Warehouse;
import model.mapping.GoodsMappingDAO;
import model.mapping.GoodsTypeMappingDAO;
import model.mapping.WarehouseMappingDAO;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class GoodsController {
    @Autowired
    private GoodsMappingDAO goodsMappingDAO;
    private static final String SUCCESS = "/JSP/success.jsp";
    private static final String ERROR = "/JSP/error.jsp";
    private SimpleDateFormat timer = new SimpleDateFormat("YYmmssSSSS");

    @RequestMapping(value = "goodsList", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
    public String edit1warehouse(Goods goods, HttpServletRequest request) {
        List<Goods> goodsList = goodsMappingDAO.goodsList(goods);
        request.setAttribute("goods", goodsList);
        return "/JSP/goods/List.jsp";
    }

    /**
     * 查商品列表
     *
     * @param goods
     * @return
     */
    @RequestMapping(value = "/listG", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String listG(Goods goods) {
        int j = goods.getGoods_Id();
        goods.setGoods_Id(j * 10);
        goods.setGoods_Name("%" + goods.getGoods_Name().trim() + "%");
        List<Goods> goodstypes = goodsMappingDAO.queryDoods(goods);
        JSONArray jsonArray = JSONArray.fromObject(goodstypes);
        return jsonArray.toString();
    }

    /**
     * 根据商品类型查商品列表
     *
     * @param goods
     * @return
     */
    @RequestMapping(value = "/listGforType", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String listGforType(Goods goods) {
        List<Goods> goodstypes = goodsMappingDAO.goodsListforType(goods);
        JSONArray jsonArray = JSONArray.fromObject(goodstypes);
        return jsonArray.toString();
    }


    /**
     * 分页查数量
     *
     * @param goods
     * @return
     */
    @RequestMapping(value = "/listGNumber", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String listGNumber(Goods goods) {
        goods.setGoods_Name("%" + goods.getGoods_Name().trim() + "%");
        int i = goodsMappingDAO.queryGnumbers(goods);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("sum", i);
        return jsonObject.toString();
    }

    /**
     * 添加商品
     *
     * @param goods
     * @param request
     * @return
     */
    @RequestMapping(value = "/addGoods", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String addGoods(Goods goods, HttpServletRequest request) {
        String s = String.valueOf((int) (Math.random() * 10000) / 1);
        boolean b = goodsMappingDAO.addGoods(goods);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("result", b);
        return jsonObject.toString();
    }

    /**
     * 删除商品，先查询库存表
     *
     * @param goods
     * @return
     */
    @RequestMapping(value = "/deleteG", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String deleteG(Goods goods) {
        // 先查询库存表里还有没有该种商品
        JSONObject jsonObject = new JSONObject();
        int j = goodsMappingDAO.queryForDelGoods(goods);
        if (j > 0) {
            jsonObject.put("j", j);
        } else {
            jsonObject.put("j", 0);
            int i = goodsMappingDAO.delGoods(goods);
            jsonObject.put("i", i);
        }

        return jsonObject.toString();
    }
}
