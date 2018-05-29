package com.ningpai.goods.controller;

import com.ningpai.common.safe.CSRFTokenManager;
import com.ningpai.goods.bean.Goods;
import com.ningpai.goods.bean.GoodsSearch;
import com.ningpai.goods.service.GoodsSearchService;
import com.ningpai.goods.util.PathUtil;
import com.ningpai.goods.util.SelectBean;
import com.ningpai.goods.util.ValueUtil;
import com.ningpai.goods.vo.GoodsSearchVo;
import com.ningpai.logger.util.OperaLogUtil;
import com.ningpai.util.MenuSession;
import com.ningpai.util.MyLogger;
import com.ningpai.util.PageBean;
import org.elasticsearch.common.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 商品搜索控制器
 */
@Controller
public class GoodsSearchController {
    /** 记录日志对象 */
    private static final MyLogger LOGGER = new MyLogger(GoodsSearchController.class);
    private static final String LOGGERINFO1 = "-->关键字【";
    private static final String LOGGERINFO2 = "】";

    @Resource
    private GoodsSearchService goodsSearchService;

    /**
     * 通过分页参数查询搜索关键字
     * @param request
     * @param response
     * @param pb
     * @param selectBean
     * @return
     */
    @RequestMapping("/findAllKeyword")
    public ModelAndView findAllKeyword(HttpServletRequest request, HttpServletResponse response, PageBean pb, SelectBean selectBean) {
        MenuSession.sessionMenu(request);
        ModelAndView mav = new ModelAndView();
        mav.setViewName(PathUtil.GOODSSEARCH);
        mav.addObject("pb", goodsSearchService.searchAllByPageBean(pb, selectBean));
        // 参数设置到作用域中
        request.setAttribute(ValueUtil.SELECTBEAN, selectBean);
        LOGGER.info(ValueUtil.SEARCHGOODSBRAND);
        return mav;
    }

    /**
     * ajax获取关键字对应的分类和品牌
     * @param searchKeyword
     * @return
     */
    @RequestMapping("/findAllByKeywordAjax")
    @ResponseBody
    public GoodsSearchVo findAllByKeywordAjax(String searchKeyword) {
        return goodsSearchService.findAllByKeywordAjax(searchKeyword);
    }

    /**
     * 保存搜索关键字
     * @param goodsSearch
     * @param request
     * @return
     */
    @RequestMapping("/addKeywordsform")
    public ModelAndView saveBrand(GoodsSearch goodsSearch, HttpServletRequest request) {
        // 判断是否重名
        if (goodsSearchService.selectByKeyword(goodsSearch.getSearchKeyword()) == 0) {
            // 插入商品关键字
            int result = this.goodsSearchService.insertGoodsSearch(goodsSearch);
            // 非空验证 关键字 和是否保存成功
            if (null != goodsSearch.getSearchKeyword() && 1 == result) {
                // 操作日志
                OperaLogUtil.addOperaLog(request, (String) request.getSession().getAttribute(ValueUtil.NAME), "保存商品关键字",
                        (String) request.getSession().getAttribute(ValueUtil.OPERAPATH) + LOGGERINFO1 + goodsSearch.getSearchKeyword() + LOGGERINFO2
                                + (String) request.getSession().getAttribute(ValueUtil.NAME));
                LOGGER.info(ValueUtil.SAVEBRANDINFO + "保存关键字为" + goodsSearch.getSearchKeyword() + "成功");
            }
        }
        // 返回到查询所有商品关键字的控制器
        return new ModelAndView(new RedirectView(PathUtil.ALLSEARCHCONTROLLER + ValueUtil.TOKENPARAM + CSRFTokenManager.getTokenFromRequest(request)));
    }

    /**
     * 删除关键字
     * @param ids  id
     * @param request
     * @return
     */
    @RequestMapping("/deleteGoodsSearch")
    @ResponseBody
    public String deleteGoodsSearch(String ids,HttpServletRequest request){
        Map map=new HashMap<String,List<Long>>();
        try {
            if (StringUtils.isNotBlank(ids)) {
                if (ids.indexOf(",") == -1) {
                    List list = new ArrayList();
                    list.add(Long.valueOf(ids));
                    map.put("ids", list);
                } else {
                    List list = new ArrayList();
                    String[] arrids = ids.split(",");
                    if (arrids != null && arrids.length > 0) {
                        for (String str : arrids) {
                            if (StringUtils.isNotBlank(str)) {
                                list.add(Long.valueOf(str));
                            }
                        }
                    }
                    if (list.size() > 0 && list != null) {
                        map.put("ids", list);
                    }
                }
            }
        }catch(Exception e){
            e.printStackTrace();
            return "no";
        }
        //删除关键字
        if(map.size()>0 && map!=null){
            this.goodsSearchService.deleteGoodsSearch(map);
        }
        // 返回到查询所有商品关键字的控制器
        return "ok";
    }

    /**
     * 根据ID查询 关键字搜索类
     * @param keywordId
     * @return
     */
    @RequestMapping("/queryKeywordById")
    @ResponseBody
    public GoodsSearchVo queryKeywordById(Long keywordId){
        GoodsSearchVo goodsSearchVo = new GoodsSearchVo();
         if(keywordId !=null && keywordId>0){
             goodsSearchVo=this.goodsSearchService.queryKeywordById(keywordId);
         }
         return goodsSearchVo;
    }

    /**
     * 修改关键字搜索
     * @param goodsSearch
     * @return
     */
    @RequestMapping("/updateKeywordsform")
    public ModelAndView updateKeywordsform(GoodsSearch goodsSearch,HttpServletRequest request){
        if(goodsSearch!=null){
           this.goodsSearchService.updateKeywordsform(goodsSearch);
        }
        // 返回到查询所有商品关键字的控制器
        return new ModelAndView(new RedirectView(PathUtil.ALLSEARCHCONTROLLER + ValueUtil.TOKENPARAM + CSRFTokenManager.getTokenFromRequest(request)));
    }

    /**
     * 查看此关键字是否被占用
     * @param titleVal 关键字
     * @return
     */
    @RequestMapping("/checkedTitleVal")
    @ResponseBody
    public String checkedTitleVal(String titleVal){
        Integer i=this.goodsSearchService.checkedTitleVal(titleVal);
        return i+"";
    }
}
