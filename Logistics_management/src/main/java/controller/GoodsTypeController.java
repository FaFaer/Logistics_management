package controller;

import model.Goods;
import model.Goods_type;
import model.Role;
import model.mapping.GoodsMappingDAO;
import model.mapping.GoodsTypeMappingDAO;
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
public class GoodsTypeController {
    @Autowired
    private GoodsTypeMappingDAO goodsTypeMappingDAO;
    private static final String SUCCESS = "/JSP/success.jsp";
    private static final String ERROR = "/JSP/error.jsp";
    private SimpleDateFormat timer = new SimpleDateFormat("YYmmssSSSS");

    /**
     * 查商品类型列表
     *
     * @param goods_type
     * @return
     */
    @RequestMapping(value = "/listGT", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String listGT(Goods_type goods_type) {
        int j = goods_type.getGoods_Id();
        goods_type.setGoods_Id(j*10);
        goods_type.setGoods_Name("%" + goods_type.getGoods_Name().trim() + "%");
        List<Goods_type> goodstypes = goodsTypeMappingDAO.queryDoods_type(goods_type);
        JSONArray jsonArray = JSONArray.fromObject(goodstypes);
        return jsonArray.toString();
    }

    /**
     * 分页查数量
     *
     * @param goods_type
     * @return
     */
    @RequestMapping(value = "/listGTNumber", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String listGTNumber(Goods_type goods_type) {
        goods_type.setGoods_Name("%" + goods_type.getGoods_Name().trim() + "%");
        int i = goodsTypeMappingDAO.queryGnumbers(goods_type);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("sum", i);
        return jsonObject.toString();
    }

    /**
     * 添加商品类型
     *
     * @param goodsType
     * @param request
     * @return
     */
    @RequestMapping(value = "/addGoodsType", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String addGoodsType(Goods_type goodsType, HttpServletRequest request) {
        String s = String.valueOf((int) (Math.random() * 10000) / 1);
        goodsType.setGoods_Code(timer.format(new Date()) + s);
        boolean b = goodsTypeMappingDAO.addGoodsType(goodsType);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("result", b);
        return jsonObject.toString();
    }

    /**
     * 删除商品类型
     *
     * @param goodsType
     * @return
     */
    @RequestMapping(value = "/deleteGT", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String deleteGT(Goods_type goodsType) {
        // 先查询库存表里还有没有该种商品
        JSONObject jsonObject = new JSONObject();
        int j = goodsTypeMappingDAO.queryForDelGoodsType(goodsType);
        if (j > 0) {
            jsonObject.put("j", j);
        } else {
            jsonObject.put("j", 0);
            int i = goodsTypeMappingDAO.delGoodsType(goodsType);
            jsonObject.put("i", i);
        }
        return jsonObject.toString();
    }

    /**
     * 查商品类型列表all
     *
     * @param
     * @return
     */
    @RequestMapping(value = "/listGTAll", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String listGTAll() {
        List<Goods_type> goodstypes = goodsTypeMappingDAO.GOODS_TYPE_LIST();
        JSONArray jsonArray = JSONArray.fromObject(goodstypes);
        return jsonArray.toString();
    }

}
