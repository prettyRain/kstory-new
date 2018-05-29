package com.ningpai.index;

import com.ningpai.channel.bean.Channel;
import com.ningpai.channel.bean.ChannelAdver;
import com.ningpai.channel.bean.ChannelStoreyGoods;
import com.ningpai.channel.bean.GoodsSiteSearchBean;
import com.ningpai.channel.service.*;
import com.ningpai.freighttemplate.bean.SysProvince;
import com.ningpai.freighttemplate.service.SysProvinceService;
import com.ningpai.goods.dao.GoodsElasticMapper;
import com.ningpai.goods.util.GoodsMarketingCodeUtil;
import com.ningpai.index.bean.IndexFloor;
import com.ningpai.index.bean.IndexGoodsBean;
import com.ningpai.index.service.ChannelSiteService;
import com.ningpai.index.service.TopAndBottomService;
import com.ningpai.information.service.InformationService;
import com.ningpai.site.goods.service.GoodsCateService;
import com.ningpai.site.goods.vo.GoodsCateVo;
import com.ningpai.system.service.BasicSetService;
import com.ningpai.system.service.DefaultAddressService;
import com.ningpai.temp.vo.ClassifyBarVo;
import com.ningpai.util.MyLogger;
import com.ningpai.util.PageBean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 频道控制器
 */
@Controller
public class NewChannelSiteController {

    /** 记录日志对象 */
    private static final MyLogger LOGGER = new MyLogger(NewChannelSiteController.class);

    private static final Long ATID1 = 157L;

    private static final Long ATID2 = 159L;

    private static final Long ATID3 = 161L;

    private static final Long ATID4 = 162L;//导航页页面广告

    private static final Long ADVERTTYPE = 151L;

    /** 频道设置业务接口 */
    @Resource(name = "ChannelService")
    private ChannelService channelService;

    /** 频道内容业务接口 */
    @Resource(name = "ChannelSiteService")
    private ChannelSiteService channelSiteService;

    /** 广告业务接口 */
    @Resource(name = "ChannelAdverService")
    private ChannelAdverService channelAdverService;

    /** 文章业务接口 */
    @Resource(name = "InformationService")
    private InformationService infoService;

    /**
     * 站点设置服务层接口
     */
    @Resource(name = "basicSetService")
    private BasicSetService basicSetService;

    /**
     * SERVICE-获取头部、底部信息
     */
    @Resource(name = "TopAndBottomService")
    private TopAndBottomService topAndBottomService;

    /** 导航菜单业务类 */
    @Resource(name = "ChannelBarService")
    private ChannelBarService channelBarService;

    @Resource(name = "ChannelStoreyGoodsService")
    private ChannelStoreyGoodsService channelStoreyGoodsService;

    // spring注入
    @Resource(name = "GoodsElasticMapper")
    private GoodsElasticMapper goodsElasticMapper;

    @Resource(name = "SysProvinceService")
    private SysProvinceService sysProvinceService;
    /** 模板广告业务接口 */
    @Resource(name = "ChannelGoodsService")
    private ChannelGoodsService channelGoodsService;
    /**
     * 加载频道信息
     *
     * @param request
     * @param channelId
     *            商品分类ID：一级分类、二级分类
     * @return
     */
    @RequestMapping("/channel")
    public ModelAndView channelView(HttpServletRequest request, Long channelId,Long navId, GoodsSiteSearchBean searchBean, PageBean pageBean) {
        ModelAndView mav = new ModelAndView();
        // 根据商品分类ID获得频道
        Channel channel = channelService.findChannelByID(channelId);
        if("1".equals(channel.getDelflag())) {
            return new ModelAndView("redirect:/index.html");
        }

        mav.setViewName("channel/channel");
        // 站点信息
        mav.addObject("sys", basicSetService.findBasicSet());
        // 频道信息
        mav.addObject("channel", channel);
        mav.addObject("navId", navId);
        /**
         * 商品数量显示为 45件
         * 2017/09/29 dll
         */
        pageBean.setPageSize(45);
        // 初始化频道页楼层数据
        mav.addObject("floor", channelSiteService.getChannelStoreys(request, channel.getChannelId(), channel.getTempId(), searchBean, pageBean));
        // 热销推荐
        List<Object> rushList = channelGoodsService.selectchannelStoreyGoodsByParam(pageBean, null, channel.getChannelId().toString(), null).getList();
        mav.addObject("marketingRush", getFinalPrice(rushList));
        if(navId!=null) {
            if(navId.longValue() == 309l){
                List<Object> list = channelStoreyGoodsService.selectchannelStoreyGoodsByParam(pageBean, null, null, null, navId,"0").getList();
                mav.addObject("navGoods", getFinalPrice(list));
                List<Object> markdowns = channelStoreyGoodsService.selectchannelStoreyGoodsByParam(pageBean, null, null, null, navId,"1").getListNew();
                mav.addObject("mdNavGoods", getFinalPrice(markdowns));
            }else{
                List<Object> list = channelStoreyGoodsService.selectchannelStoreyGoodsByParam(pageBean, null, null, null, navId,null).getList();
                mav.addObject("navGoods", getFinalPrice(list));
            }

        }

        mav.addObject("searchBean", searchBean);
        mav.addObject("navList",channelBarService.selectAllChannelBarByParam(channelId, channel.getTempId(), null));
        // 新闻公告信息
        mav.addObject("infoList", infoService.selectByInfoType(channel.getInfoTypeId()));
        // 获取页面轮播大广告
        mav.addObject("avc",channelAdverService.selectchannelAdverByParamForSite(channel.getChannelId(), channel.getTempId(), null, null, ATID1, ADVERTTYPE, null, "0", null, null,navId));
        // 获取页面轮播小广告
        mav.addObject("avs", channelAdverService.selectchannelAdverByParamForSite(channel.getChannelId(), channel.getTempId(), null, null, ATID2, ADVERTTYPE, null, "0", null, null,navId));
        // 获取页面广告
        mav.addObject("pageAdvs", channelAdverService.selectchannelAdverByParamForSite(channel.getChannelId(), channel.getTempId(), null, null, ATID4, ADVERTTYPE, null, "0", null, null,navId));
        List<ChannelAdver> pageAdvList =channelAdverService.selectchannelAdverByParamForSite(channel.getChannelId(), channel.getTempId(), null, null, ATID3, ADVERTTYPE, null, "0", null, null,null);

        if (!pageAdvList.isEmpty()) {
            mav.addObject("logoAdv1", pageAdvList.get(0));
            if(pageAdvList.size() > 1){
                mav.addObject("logoAdv2", pageAdvList.get(1));
            }
            if(pageAdvList.size() > 2){
                mav.addObject("rushAdv", pageAdvList.get(2));
            }
        }
        // 加载分类导航
        mav.addObject("classifyBar", channelSiteService.getClassifyBar(channel.getChannelId(), channel.getTempId()));
        // 今日推荐商品
//        mav.addObject("channelGoodsFlag2", channelSalesGoodsService.selectChannelGoodsByFlag(channel.getChannelId(), "2", ADVERTNUM));
        return topAndBottomService.getTopAndBottom(mav);
    }

    /**
     * 根据省级id加载对应的三级分类
     * @param provinceId
     * @return
     */
    @RequestMapping("/selectClassifyByProvinceWithAjax")
    @ResponseBody
    public Map selectClassifyByProvinceWithAjax(String provinceId){
        Map map = new HashMap();
        if(provinceId!=null && !"".equals(provinceId)){
            List<SysProvince> provinces = sysProvinceService.selectProvinceByIds(provinceId);
            List<ClassifyBarVo> classifyBars = channelSiteService.getClassifyBarByProvinceId(provinceId);
            for (SysProvince province : provinces) {
                List<String> provinceList = new ArrayList<String>();
                List nameList = new ArrayList();
                if(classifyBars!=null && classifyBars.size()>0){
                    for (ClassifyBarVo classifyBar : classifyBars) {
                        if(province.getProvinceId().toString().equals(classifyBar.getTemp5())){
                            nameList.add(classifyBar.getName());
                        }
                    }
                }
                map.put(province.getProvinceName(),nameList);
            }
        }
        return map;
    }

    /**
     * 计算楼层商品的实际显示价格
     * @param list
     * @return
     */
    private List getFinalPrice(List list){
        for (Object o : list) {
            ChannelStoreyGoods goods = (ChannelStoreyGoods) o;
            goods.setGoodsInfoPreferPrice(goods.getGoodsproductPrice());
            BigDecimal finalPrice = goods.getGoodsproductPrice();
            //查询商品是否有促销，有就显示促销价
            List<GoodsMarketingCodeUtil> codeUtils = goodsElasticMapper.selectProductMarket(goods.getGoodsproductId());
            for (GoodsMarketingCodeUtil gms : codeUtils) {
                if (gms.getCodexId() == 1) {
                    //直降
                    BigDecimal discount = goodsElasticMapper.selectPriceOffMarketingByMarketingId(gms.getMarketingId());
                    finalPrice = goods.getGoodsproductPrice().subtract(discount);
                } else if (gms.getCodexId() == 10) {
                    //团购
                    BigDecimal discount = goodsElasticMapper.selectGrouponByMarketId(gms.getMarketingId());
                    finalPrice = goods.getGoodsproductPrice().multiply(discount);
                } else if (gms.getCodexId() == 11) {
                    //抢购
                    BigDecimal discount = goodsElasticMapper.selectRushByMarketId(gms.getMarketingId());
                    finalPrice = goods.getGoodsproductPrice().multiply(discount);
                } else if (gms.getCodexId() == 15) {
                    //折扣
                    Map<String, Object> param = new HashMap<String, Object>();
                    param.put("goodsId", goods.getGoodsproductId());
                    param.put("marketingId", gms.getMarketingId());
                    BigDecimal discount = goodsElasticMapper.selectDiscountByMarketId(param);
                    finalPrice = goods.getGoodsproductPrice().multiply(discount);
                    String promationinfo = discount.multiply(new BigDecimal(10)).setScale(1,BigDecimal.ROUND_HALF_DOWN).toString();
                    if("0".equals(promationinfo.substring(promationinfo.indexOf(".")+1))){
                        promationinfo = promationinfo.substring(0,promationinfo.indexOf("."));
                    }
                    goods.setPromationinfo(promationinfo);
                }
            }
            goods.setGoodsproductPrice(finalPrice);
        }
        return list;
    }
}
