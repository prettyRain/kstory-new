/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */
package com.ningpai.customer.controller;

import com.ningpai.comment.bean.ValueUtil;
import com.ningpai.common.safe.CSRFTokenManager;
import com.ningpai.customer.bean.AvatarNotice;
import com.ningpai.customer.bean.Customer;
import com.ningpai.customer.bean.CustomerPoint;
import com.ningpai.customer.bean.CustomerPointLevel;
import com.ningpai.customer.service.CustomerFollowServiceMapper;
import com.ningpai.customer.service.CustomerPointServiceMapper;
import com.ningpai.customer.service.CustomerServiceMapper;
import com.ningpai.customer.util.IPAddressUtil;
import com.ningpai.customer.vo.CustomerStatisticVo;
import com.ningpai.logger.util.OperaLogUtil;
import com.ningpai.other.bean.*;
import com.ningpai.other.util.CustomerConstantStr;
import com.ningpai.other.util.IPAddress;
import com.ningpai.system.bean.City;
import com.ningpai.system.bean.District;
import com.ningpai.system.service.CityService;
import com.ningpai.system.service.DistrictService;
import com.ningpai.thirdaudit.service.StoreInfoService;
import com.ningpai.util.MyLogger;
import com.ningpai.util.PageBean;
import com.ningpai.util.UtilDate;
import com.ningpai.utils.TaskUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

//import com.ningpai.util.UploadUtil;

/**
 * 会员控制层
 *
 * @author NINGPAI-zhangqiang
 * @version 0.0.1
 * @since 2013年12月14日11:05:38
 */
@Controller("customerController")
public class CustomerController {

    // 记录日志对象
    private static final MyLogger LOGGER = new MyLogger(CustomerController.class);

    private static final String PAGEBEAN = "pageBean";
    private static final String LOGGERINFO = ",用户编号:";

    // spring 注解
    private CustomerServiceMapper customerServiceMapper;

    private CustomerFollowServiceMapper customerFollowServiceMapper;

    @Resource(name = "StoreService")
    private StoreInfoService storeInfoService;

    @Resource(name = "customerPointServiceMapper")
    private CustomerPointServiceMapper customerPointServiceMapper;


    /**
     * 初始化会员列表
     *
     * @param pageBean
     *            {@link com.ningpai.util.PageBean}
     * @return
     */
    @RequestMapping("/initCustomer")
    public ModelAndView initMethod(PageBean pageBean, CustomerAllInfo allinfo) {
        pageBean.setUrl(CustomerConstantStr.INITUSTOMERHTM);
        customerServiceMapper.selectCustmerByAllInfo(allinfo, pageBean);
        setCustomerPointLevelName(pageBean);
        return new ModelAndView(CustomerConstantStr.CUSTOMERJSP, PAGEBEAN, pageBean);
    }

    /**
     * 审核用户头像列表
     * @param pageBean
     * @return
     */
    @RequestMapping("/queryAuditImg")
    public ModelAndView queryAuditImg(PageBean pageBean) {
        pageBean.setUrl("queryAuditImg.htm");
        customerServiceMapper.selectAllCustmerImg(pageBean);
        return new ModelAndView("jsp/customer/customerauditimg", PAGEBEAN, pageBean);
    }

    /**
     * 审核用户头像
     * @param customerIds 用户id
     * @param mark 标示：1、通过 2、拒绝
     * @param imgpath 存放图片路径 拒绝需要删除图片
     * @param request
     * @return
     */
    @RequestMapping("/customerAuditImg")
    @ResponseBody
    public int customerAuditImg(Long[] customerIds,int mark,String[] imgpath, HttpServletRequest request) {
            try {
                if(customerIds.length > 0){
                    Map<String, Object> map = new HashMap<>();
                    map.put("customerIds", customerIds);
                    map.put("mark", mark);
                    map.put("auditPersion", request.getSession().getAttribute("name"));
                    int n = customerServiceMapper.auditImg(map);
                    if(mark == 2 && n > 1){
                        //删除服务器图片
                        deleteServImg(imgpath);
                    }
                    //消息提示
                    for(Long id:customerIds){
                        AvatarNotice avatarNotice=new AvatarNotice();

                        avatarNotice.setCustomerId(id);
                        avatarNotice.setIsRead("0");
                        if(mark==2){
                            avatarNotice.setNoticeTitle("头像审核未通过");
                            avatarNotice.setNoticeContent("您新上传的头像未通过审核，请重新上传！");
                        }else if(mark==1){
                            avatarNotice.setNoticeTitle("头像审核通过");
                            avatarNotice.setNoticeContent("您新上传的头像已审核通过，快去看一看吧！");
                        }
                        avatarNotice.setCreateTime(new Date());
                        this.customerServiceMapper.addAvatarNatice(avatarNotice);

                    }
                    return n;
                }
            }catch (Exception e){
                e.printStackTrace();
            }
            return 0;
    }

    private void deleteServImg(String[] relate){
        try {
            //获取配置文件
            InputStream in=CustomerController.class.getResourceAsStream("/com/ningpai/web/config/upload.properties");
            Properties pro=new Properties();
            pro.load(in);
            //图片根路径
            String path=(String)pro.get("DELPATH");
            if(relate.length > 0){
                for(String str : relate){
                    //判断是不是又拍云
                    if(!str.contains("upaiyun")){
                        String onePath=str.substring(str.indexOf("upload/")+7,str.indexOf("upload/")+15);
                        String twoPath=str.substring(str.lastIndexOf("/")+1,str.lastIndexOf("/")+14);
                        //获取四个图片对象
                        File file=new File(path+"/"+onePath);
                        File fileBig=new File(path+"/"+onePath+"/"+twoPath+".jpg");
                        File fileSmallOne=new File(path+"/"+onePath+"/"+twoPath+"!56.jpg");
                        File fileSmallTwo=new File(path+"/"+onePath+"/"+twoPath+"!160.jpg");
                        File fileSmallThree=new File(path+"/"+onePath+"/"+twoPath+"!352.jpg");
                        // 在服务器 删除图片
                        if(fileBig.exists()){
                            fileBig.delete();
                            fileSmallOne.delete();
                            fileSmallTwo.delete();
                            fileSmallThree.delete();
                            File[] files=file.listFiles();
                            if(files.length==0){
                                file.delete();
                            }
                        }
                    }
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    /**
     * 设置会员的等级名称
     *
     * @param pageBean
     */
    private void setCustomerPointLevelName(PageBean pageBean) {
        // 获得所有会员
        List<Object> list = pageBean.getList();

        if (CollectionUtils.isEmpty(list)) {
            return;
        }

        CustomerAllInfo customerAllInfo = null;

        for (Object o : list) {

            if (o.getClass() == CustomerAllInfo.class) {
                customerAllInfo = (CustomerAllInfo) o;
                customerAllInfo.setPointLevelName(getCustomerPointLevelName(customerAllInfo.getCustomerId()));
                HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
            }
        }
    }


    /**
     * 添加会员
     *
     * @param allinfo
     *            会员全部信息
     * @return
     */
    @RequestMapping("/addCustomer")
    public ModelAndView addCustomer(@Valid CustomerAllInfo allinfo, HttpServletRequest request, MultipartHttpServletRequest multipartRequest) {
        // 保存新注册的会员信息 非空验证 会员姓名
        if (null != allinfo.getInfoRealname()) {
            LOGGER.info("保存名称为【" + allinfo.getInfoRealname() + "】的会员信息");

        }
        // 获取IP地址
        allinfo.setLoginIp(IPAddress.getIpAddr(request));
        // 设置会员头像 setCustomerImg(allinfo,request,multipartRequest);
        allinfo.setIsSeller("0");
        //后台添加会员是时判断手机号码是否为空，如果不为空就把后台是否验证手机字段改为已验证
        if (StringUtils.isNotEmpty(allinfo.getInfoMobile())) {
            allinfo.setIsMobile("1");
        }
        //后台添加会员是时判断邮箱是否为空，如果不为空就把后台是否验证邮箱字段改为已验证
        if (StringUtils.isNotEmpty(allinfo.getInfoEmail())) {
            allinfo.setIsEmail("1");
        }
        // 添加会员
        customerServiceMapper.addCustomer(allinfo);
        LOGGER.debug(CustomerConstantStr.ADDCUSTOMER + allinfo.getCustomerUsername());
        OperaLogUtil.addOperaLog(request, (String) request.getSession().getAttribute(CustomerConstantStr.NAME), CustomerConstantStr.ADDCUSTOMER,
                request.getSession().getAttribute(CustomerConstantStr.OPERAPATH) + ",用户名:" + allinfo.getCustomerUsername());
        return new ModelAndView(new RedirectView(CustomerConstantStr.INITUSTOMERHTM));
    }

    /**
     * 删除会员信息
     *
     * @param request
     *            页面请求 {@link javax.servlet.http.HttpServletRequest}
     * @param response
     *            响应 {@link javax.servlet.http.HttpServletResponse}
     * @return
     * @throws IOException
     */
    @RequestMapping("/deleteCustomer")
    public ModelAndView deleteCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException {
        PrintWriter pr = null;
        String[] customerIds = null;
        StringBuilder str = new StringBuilder("[");
        String empStr = "";
        try {
            pr = response.getWriter();
            customerIds = request.getParameterValues("parameterIds[]");
            // 删除会员信息 输出信息 0 失败 1成功
            pr.print(customerServiceMapper.deleteCustomer(customerIds));
            for (String id : customerIds) {
                str.append(id + ",");
            }

            // 循环判断是否是会员是否是商家
            for (int i = 0; i < customerIds.length; i++) {
                // 如果是商家则删除所有改商家的商品
                if ("1".equals(customerServiceMapper.selectStatus(customerIds[i]))) {
                    String id = customerServiceMapper.findStore(customerIds[i]);
                    String[] ids = { id };
                    // 删除商家
                    String username = request.getSession().getAttribute("name").toString();
                    storeInfoService.delStoreInfoById(ids, username);

                }
            }
            empStr = str.toString().substring(0, str.length() - 1) + "]";

        } finally {
            OperaLogUtil.addOperaLog(request, (String) request.getSession().getAttribute(CustomerConstantStr.NAME), CustomerConstantStr.DELCUSTOMER, request.getSession()
                    .getAttribute(CustomerConstantStr.OPERAPATH) + CustomerConstantStr.DELCUSTOMER + LOGGERINFO + empStr);
            customerIds = null;
            str = null;
            pr = null;
            empStr = null;
        }
        return null;
    }

    /**
     * 新删除会员
     *
     * @param request
     * @param customerId
     * @return ModelAndView
     */
    @RequestMapping("/deleteNewCustomer")
    public ModelAndView deleteNewCustomer(HttpServletRequest request, Long customerId) {
        // 获取会员ID封装String数组
        String[] customerIds = new String[] { "" + customerId + "" };
        // 执行删除
        customerServiceMapper.deleteCustomer(customerIds);
        // 记录日志
        OperaLogUtil.addOperaLog(request, (String) request.getSession().getAttribute(CustomerConstantStr.NAME), CustomerConstantStr.DELCUSTOMER,
                request.getSession().getAttribute(CustomerConstantStr.OPERAPATH) + CustomerConstantStr.DELCUSTOMER + LOGGERINFO + customerId);
        // 返回当前列表页面
        return new ModelAndView(new RedirectView("initCustomer.htm"));
    }

    /**
     * 新批量删除会员
     *
     * @param request
     * @param customerId
     * @return ModelAndView
     */
    @RequestMapping("/deleteAllNewCustomer")
    public ModelAndView deleteAllNewCustomer(HttpServletRequest request, Long[] customerId) {
        // 获取会员ID封装String数组
        String[] customerIds = request.getParameterValues("customerId");
        // 执行删除
        customerServiceMapper.deleteCustomer(customerIds);
        // 记录日志
        OperaLogUtil.addOperaLog(request, (String) request.getSession().getAttribute(CustomerConstantStr.NAME), CustomerConstantStr.DELCUSTOMER,
                request.getSession().getAttribute(CustomerConstantStr.OPERAPATH) + CustomerConstantStr.DELCUSTOMER + LOGGERINFO + customerId[0].toString());
        // 返回当前列表页面
        return new ModelAndView(new RedirectView("initCustomer.htm"));
    }

    /**
     * 修改会员信息
     *
     * @param request
     *            页面请求 {@link javax.servlet.http.HttpServletRequest} 响应
     *            {@link javax.servlet.http.HttpServletResponse}
     * @return
     */
    @RequestMapping("/updateCustomer")
    public ModelAndView updateCustomer(@Valid CustomerAllInfo allinfo, HttpServletRequest request) {
        // 修改会员信息 非空验证 会员姓名
        if (null != allinfo.getInfoRealname()) {
            LOGGER.info("修改名称为【" + allinfo.getInfoRealname() + "】的会员信息");

        }
        allinfo.setCustomerPassword(null);
        String pageNo = StringUtils.isNotEmpty(request.getParameter("pageNo")) ? request.getParameter("pageNo") : "1";
        customerServiceMapper.updateCustomer(allinfo);
        OperaLogUtil.addOperaLog(request, (String) request.getSession().getAttribute(CustomerConstantStr.NAME), CustomerConstantStr.UPDATECUST,
                request.getSession().getAttribute(CustomerConstantStr.OPERAPATH) + ",用户名:" + allinfo.getCustomerUsername());
        return new ModelAndView(new RedirectView(CustomerConstantStr.INITUSTOMERHTM + ValueUtil.TOKENPARAM + CSRFTokenManager.getTokenFromRequest(request) + "&pageNo=" + pageNo));
    }

    /**
     * 设置会员类型
     *
     * @param request
     *            页面请求 {@link javax.servlet.http.HttpServletRequest}
     * @param response
     *            响应 {@link javax.servlet.http.HttpServletResponse}
     * @return
     */
    @RequestMapping("/setcustomer")
    public ModelAndView setCustomer(@Valid CustomerAllInfo allinfo, HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 修改会员头像 setCustomerImg(allinfo, request, multipartRequest);
        // 修改会员信息
        /*
         * customerServiceMapper.setCustomer(allinfo);
         * OperaLogUtil.addOperaLog(request, (String)
         * request.getSession().getAttribute(CustomerConstantStr.NAME),
         * CustomerConstantStr.UPDATECUST,
         * request.getSession().getAttribute(CustomerConstantStr.OPERAPATH) +
         * ",用户名:" + allinfo.getCustomerUsername()); return new ModelAndView(new
         * RedirectView(CustomerConstantStr.INITUSTOMERHTM));
         */

        PrintWriter pr = null;
        String[] customerIds = null;
        StringBuilder str = new StringBuilder("[");
        String empStr = "";
        try {
            pr = response.getWriter();
            customerIds = request.getParameterValues("parameterIds[]");
            // 删除会员信息 输出信息 0 失败 1成功
            pr.print(customerServiceMapper.setCustomer(customerIds, allinfo.getIsSiteManager()));
            for (String id : customerIds) {
                str.append(id + ",");
            }
            empStr = str.toString().substring(0, str.length() - 1) + "]";
            // 修改会员信息 非空验证 会员姓名
            if (null != allinfo.getInfoRealname()) {
                // 日志记录
                LOGGER.info("设置名称为【" + allinfo.getInfoRealname() + "】的会员的类型");

            }
        } finally {
            OperaLogUtil.addOperaLog(request, (String) request.getSession().getAttribute(CustomerConstantStr.NAME), CustomerConstantStr.DELCUSTOMER, request.getSession()
                    .getAttribute(CustomerConstantStr.OPERAPATH) + CustomerConstantStr.DELCUSTOMER + LOGGERINFO + empStr);
            customerIds = null;
            str = null;
            pr = null;
            empStr = null;
        }
        return null;
    }

    /**
     * 根据会员编号查询会员 实现弹出层展示数据
     *
     * @param customerId
     *            会员编号
     * @return
     */
    @RequestMapping("/queryCustomer")
    public ModelAndView queryCustomer(Long customerId, CustomerPoint point, PageBean pageBean, String status) {
        // 结果集
        Map<String, Object> resultMap = new HashMap<String, Object>();
        try {
            CustomerAllInfo customerAllInfo = customerServiceMapper.selectByPrimaryKey(customerId);
            customerAllInfo.setInfoPointSum(customerAllInfo.getInfoPointSum() - customerPointServiceMapper.getCustomerReducePoint(customerId + ""));
            resultMap.put("customer", customerAllInfo);
            resultMap.put("follows", customerFollowServiceMapper.selectByCustomerId(customerId));
            // 积分
            if ("6".equals(status)) {
                resultMap.put("point", customerPointServiceMapper.selectCustPointByCustPoint(point, pageBean));
            }

            return new ModelAndView("jsp/customer/customerdetail").addAllObjects(resultMap);
        } finally {
            resultMap = null;
        }
    }

    /**
     * ajax保存添加的积分
     *
     * @param customerId
     * @param customerpoint
     * @return
     */
    @ResponseBody
    @RequestMapping("/saveCustomerPoint")
    public int saveCustomerPoint(Long customerId, CustomerPoint customerpoint,String mgUserName) {
        return customerPointServiceMapper.saveCustomerPoint(customerId, customerpoint,mgUserName);
    }

    /**
     * @param point
     * @param pageBean
     * @param status
     * @return
     */
    @ResponseBody
    @RequestMapping("/ajaxqueryCustomerDetail")
    public PageBean ajaxqueryCustomerDetail(CustomerPoint point, PageBean pageBean, String status) {

        // 积分
        if ("6".equals(status)) {
            return customerPointServiceMapper.selectCustPointByCustPoint(point, pageBean);
        } else {
            return null;
        }

    }

    /**
     * 根据会员编号查询会员是否存在订单
     *
     * @param customerId
     *            会员编号
     * @return
     */
    @RequestMapping("/queryByCustomerId")
    @ResponseBody
    public List<CustomerAllInfo> queryByCustomerId(Long customerId, Long[] customerIds, HttpServletRequest request) {
        List<CustomerAllInfo> customerList = new ArrayList<>();
        if (null != customerId) {
            customerList.add(customerServiceMapper.selectByPrimaryKey(customerId));
            return customerList;
        } else if (null != customerIds && customerIds.length > 0) {
            Map<String, Object> map = new HashMap<>();
            map.put("customerIds", customerIds);
            customerList = customerServiceMapper.selectBycustomerIds(map);
            return customerList;
        } else {
            return Collections.emptyList();
        }
    }

    /**
     * 根据会员编号查询会员 实现修改数据展示
     *
     * @param customerId 会员编号
     * @return 会员详细信息 CustomerAllInfo
     */
    @RequestMapping("/queryCustomerById")
    @ResponseBody
    public CustomerAllInfo queryCustomerById(Long customerId) {
        CustomerAllInfo customer = customerServiceMapper.queryCustomerInfo(customerId);
        CustomerPointLevel customerPointLevel = getCustomerPointLevel(customerId);
        if (null != customerPointLevel) {
            customer.setPointLevelId(customerPointLevel.getPointLelvelId());
            customer.setPointLevelName(customerPointLevel.getPointLevelName());
        }
        customer.setCustomerAddress(null);
        customer.setCustomerPassword(null);
        return customer;
    }


    /**
     * 获得会员的等级名称
     *
     * @param customerId 会员id
     * @return 返回会员的等级名称
     */
    private String getCustomerPointLevelName(Long customerId) {
        // 根据会员id 查询出会员的总积分 然后根据总积分 获得会员的等级
        CustomerPointLevel customerPointLevel = getCustomerPointLevel(customerId);
        if (null == customerPointLevel) {
            return "";
        }

        return customerPointLevel.getPointLevelName();
    }

    /**
     * 根据会员id 查询出会员的总积分 然后根据总积分 获得会员的等级
     *
     * @param customerId 会员id
     * @return 返回会员等级
     */
    private CustomerPointLevel getCustomerPointLevel(Long customerId) {
        return customerPointServiceMapper.getCustomerPointLevelByPoint(customerPointServiceMapper.getCustomerAllPoint(customerId + ""));
    }

    /**
     * 检查会员用户名是否存在
     *
     * @param customerUsername
     *            用户名
     * @param response
     * @return 1 存在 0 不存在
     * @throws IOException
     */
    @RequestMapping("/checkExistCustomerUsername")
    public ModelAndView checkExistCustomerUsername(String customerUsername, HttpServletResponse response) throws IOException {
        // 修改会员信息 非空验证 会员姓名
        if (null != customerUsername) {
            // 日志记录
            LOGGER.info("检查名称为【" + customerUsername + "】的会员是否存在");
        }
        PrintWriter pr = null;
        try {
            pr = response.getWriter();
            // 检查会员用户名是否存在
            pr.print(customerServiceMapper.checkExistsByCustNameAndType(customerUsername));
        } finally {
            pr = null;
        }
        return null;
    }

    /**
     * 查询所有省份
     *
     * @return List<ProvinceBean> 省份集合
     * @see {@link com.ningpai.other.bean.ProvinceBean}
     */
    @RequestMapping("/getAllProvince")
    @ResponseBody
    public List<ProvinceBean> getAllProvince() {
        return customerServiceMapper.selectAllProvince();
    }

    /**
     * 根据省份编号 查询所有省份
     *
     * @return List<CityBean> 城市集合
     * @see {@link com.ningpai.other.bean.CityBean}
     */
    @RequestMapping("/getAllCityByPid")
    @ResponseBody
    public List<CityBean> getAllCityByPid(Long provinceId) {
        return customerServiceMapper.selectAllCityByPid(provinceId);
    }

    /**
     * 查询所有省份 by yuankk
     *
     * @return List<CityBean> 城市集合
     * @see {@link com.ningpai.other.bean.CityBean}
     */
    @RequestMapping("/getAllCity")
    @ResponseBody
    public List<CityBean> getAllCity() {
        return customerServiceMapper.selectAllCity();
    }

    /**
     * 根据城市编号 查询所有区县
     *
     * @return List<CityBean> 区县集合
     * @see {@link com.ningpai.other.bean.DistrictBean}
     */
    @RequestMapping("/getAllDistrictByCid")
    @ResponseBody
    public List<DistrictBean> getAllDistrictByCid(Long cityId) {

        return customerServiceMapper.selectAllDistrictByCid(cityId);
    }

    /**
     * 查询所有区县
     *
     * @return List<CityBean> 区县集合
     * @see {@link com.ningpai.other.bean.DistrictBean}
     */
    @RequestMapping("/getAllDistrict")
    @ResponseBody
    public List<DistrictBean> getAllDistrict() {
        return customerServiceMapper.selectAllDistrict();
    }

    /**
     * 根据区县编号 查询所有街道信息
     *
     * @return List<StreetBean> 街道集合
     * @see {@link com.ningpai.other.bean.StreetBean}
     */
    @RequestMapping("/getAllStreetByDid")
    @ResponseBody
    public List<StreetBean> getAllStreetByDid(Long dId) {
        return customerServiceMapper.getAllStreetByDid(dId);
    }

    /**
     * 按条件查询 会员
     *
     * @param customerAllInfo
     * @return
     * @throws ParseException
     */
    @RequestMapping("/queryByCustomerAllInfo")
    public ModelAndView queryByCustomerAllInfo(String createtime, String createtimeto, CustomerAllInfo customerAllInfo, PageBean pageBean, CustBean custBean)
            throws UnsupportedEncodingException, ParseException {
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dataStart = createtime + " " + "00:00:00";
        String dataEnd = createtimeto + " " + "23:59:59";
        // 结果集
        Map<String, Object> resultMap = new HashMap<String, Object>();
        try {
            // 将时间按照指定格式转换
            customerAllInfo.setLoginTime(createtime == null || "".equals(createtime) ? null : formatDate.parse(dataStart));
            customerAllInfo.setLoginTimeTo(createtimeto == null || "".equals(createtimeto) ? null : formatDate.parse(dataEnd));
            // 设置页面跳转路径
            pageBean.setUrl("queryByCustomerAllInfo.htm");
            resultMap.put(PAGEBEAN, customerServiceMapper.selectCustmerByAllInfo(customerAllInfo, pageBean));
            resultMap.put("customerAllInfo", customerAllInfo);
            resultMap.put("custBean", custBean);
            return new ModelAndView(CustomerConstantStr.CUSTOMERJSP).addAllObjects(resultMap);
        } finally {
            formatDate = null;
            resultMap = null;
        }
    }

    /**
     * 商家列表
     *
     * @param customerAllInfo
     * @param pageBean
     * @return
     * @throws UnsupportedEncodingException
     * @throws ParseException
     */
    @RequestMapping("/businessList")
    public ModelAndView businessList(CustomerAllInfo customerAllInfo, PageBean pageBean) throws UnsupportedEncodingException, ParseException {
        // 结果集
        customerAllInfo.setIsSeller("1");
        Map<String, Object> resultMap = new HashMap<String, Object>();
        try {
            // 设置页面跳转路径
            resultMap.put(PAGEBEAN, customerServiceMapper.selectCustmerByAllInfo(customerAllInfo, pageBean));
            resultMap.put("customerAllInfo", customerAllInfo);
            return new ModelAndView(CustomerConstantStr.BUSINESSJSP).addAllObjects(resultMap);
        } finally {
            resultMap = null;
        }
    }

    /**
     * 查询购买详细信息
     *
     * @return
     */
    @RequestMapping("/queryByDetail")
    public ModelAndView queryByDetail(Long orderId, CustomerAllInfo customer) {
        // 修改会员信息 非空验证 会员姓名
        if (null != customer.getInfoRealname()) {
            // 日志记录
            LOGGER.info("查询名称为【" + customer.getInfoRealname() + "】的会员的购买详细信息");

        }
        return new ModelAndView(CustomerConstantStr.BUYDETAIL).addObject("orderInfo", customerServiceMapper.queryByDetail(orderId)).addObject("customer",
                customerServiceMapper.selectByPrimaryKey(customer.getCustomerId()));
    }

    /**
     * 判断查询条件
     *
     * @param customerAllInfo
     */
    public void check(CustomerAllInfo customerAllInfo) {
        char ch = ',';
        // 用户名不为空
        if (customerAllInfo.getCustomerUsername() != null) {
            int indexu = customerAllInfo.getCustomerUsername().indexOf(ch);
            customerAllInfo.setCustomerUsername(customerAllInfo.getCustomerUsername().substring(0, indexu == -1 ? customerAllInfo.getCustomerUsername().length() : indexu));
        }
        // 真实姓名不为空
        if (customerAllInfo.getInfoRealname() != null) {
            int indexr = customerAllInfo.getInfoRealname().indexOf(ch);
            customerAllInfo.setInfoRealname(customerAllInfo.getInfoRealname().substring(0, indexr == -1 ? customerAllInfo.getInfoRealname().length() : indexr));
        }
        // 手机号码不为空
        if (customerAllInfo.getInfoMobile() != null) {
            int indexm = customerAllInfo.getInfoMobile().indexOf(ch);
            customerAllInfo.setInfoMobile(customerAllInfo.getInfoMobile().substring(0, indexm == -1 ? customerAllInfo.getInfoMobile().length() : indexm));
        }
    }

    /**
     * 设置会员头像 若前断没有选择图片 则不上传
     *
     * @param allinfo
     *            会员详细信息
     * @param request
     * @param multipartRequest
     */
    // private void setCustomerImg(CustomerAllInfo allinfo, HttpServletRequest
    // request, MultipartHttpServletRequest multipartRequest) {
    // // 设置会员头像 若前断没有选择图片 则不上传
    // if (multipartRequest.getFile(CustomerConstantStr.FILE) == null ||
    // "".equals(multipartRequest.getFile(CustomerConstantStr.FILE).getOriginalFilename()))
    // {
    // // 保持原有
    // allinfo.setCustomerImg(allinfo.getCustomerImg());
    // } else {
    // // 使用上传后路径
    // allinfo.setCustomerImg(UploadUtil.uploadFileByWidth(multipartRequest.getFile(CustomerConstantStr.FILE),
    // request).get("85"));
    // }
    //
    // }

    /**
     * 根据时间统计会员个数
     *
     * @param startTime
     * @param endTime
     * @return
     */
    @RequestMapping("selectcountbytime")
    public ModelAndView selectCountByTime(String startTime, String endTime) {
        String startTimeNew = startTime;
        String endTimeNew = endTime;
        /**************************** 日期格式化 ********************************************************/
        // 格式化日期 如果时间不存在 初始化当前日期的前7天
        if (startTimeNew == null || endTimeNew == null || "".equals(startTimeNew) || "".equals(endTimeNew)) {
            endTimeNew = UtilDate.todayFormat(new Date());
            startTimeNew = UtilDate.addDay(endTimeNew, -7);
        }

        String sttime = startTimeNew;
        String entime = endTimeNew;
        List<CustomerStatisticVo> csvList = customerServiceMapper.selectCountByTime();
        List<String> ctime = new ArrayList<String>();
        // 格式化时间
        while (UtilDate.compare_date(startTimeNew, endTimeNew)) {
            ctime.add(startTimeNew);
            startTimeNew = UtilDate.addDay(startTimeNew, 1);
        }
        JSONArray times = JSONArray.fromObject(ctime);
        List<Long> ccount = new ArrayList<Long>();
        for (int i = 0; i < ctime.size(); i++) {
            boolean flg = true;
            for (int j = 0; j < csvList.size(); j++) {
                CustomerStatisticVo csv = csvList.get(j);
                if (ctime.get(i).equals(csv.getCtime())) {
                    ccount.add(csv.getCountSum());
                    flg = false;
                    break;
                }
            }
            if (flg) {
                ccount.add(0L);
            }
        }
        JSONArray counts = JSONArray.fromObject(ccount);
        // 非空验证时间段
        if (null != startTimeNew && null != endTime) {
            LOGGER.info("统计" + startTimeNew + "-" + endTimeNew + "时间段注册会员的个数");
        }
        return new ModelAndView("jsp/statistic/custgrown").addObject("times", times.toString()).addObject("counts", counts).addObject("startTime", sttime)
                .addObject("endTime", entime);
    }

    /**
     * 新后台会员统计
     *
     * @return
     * @auth lih
     */
    @RequestMapping("selectcountbyweek")
    @ResponseBody
    public JSONArray selectCountByWeek(String startTime, String endTime) {
        String startTimeNew = startTime;
        String endTimeNew = endTime;
        /**************************** 日期格式化 ********************************************************/
        // 格式化日期 如果时间不存在 初始化当前日期的前7天
        if (startTimeNew == null || endTimeNew == null || "".equals(startTimeNew) || "".equals(endTimeNew) || "undefined".equals(startTimeNew) || "undefined".equals(endTimeNew)) {
            endTimeNew = UtilDate.todayFormat(new Date());
            startTimeNew = UtilDate.addDay(endTimeNew, -7);
        }

        List<CustomerStatisticVo> csvList = customerServiceMapper.selectCountByTime();
        List<String> ctime = new ArrayList<String>();
        // 格式化时间
        while (UtilDate.compare_date(startTimeNew, endTimeNew)) {
            ctime.add(startTimeNew);
            startTimeNew = UtilDate.addDay(startTimeNew, 1);
        }

        List<Long> ccount = new ArrayList<Long>();
        for (int i = 0; i < ctime.size(); i++) {
            boolean flg = true;
            for (int j = 0; j < csvList.size(); j++) {
                CustomerStatisticVo csv = csvList.get(j);
                if (ctime.get(i).equals(csv.getCtime())) {
                    ccount.add(csv.getCountSum());
                    flg = false;
                    break;
                }
            }
            if (flg) {
                ccount.add(0L);
            }
        }

        return JSONArray.fromObject(ccount);
    }

    /**
     * 根据地区统计会员个数
     *
     * @return
     */
    @RequestMapping("selectcountbyaddress")
    public ModelAndView selectCountByAddress() {


        List<CustomerStatisticVo> csvList = customerServiceMapper.selectCountByAddress();

        // 未标记的会员数量
        Long qita = 0l;
        Map<String, Long> addMap = new HashMap<String, Long>();
        for (int j = 0; j < csvList.size(); j++) {
            CustomerStatisticVo csv = csvList.get(j);
            if (csv.getAddress()==0l) {
                qita = csv.getCountSum();
            } else {
                addMap.put(csv.getProvinceList().get(0).getProvinceName(), csv.getCountSum());
            }
        }

        // 转换成插件中所用的形式
        List<String> addlist = new ArrayList<String>();
        for (String key : addMap.keySet()) {
            addlist.add("{name:'" + key + "',value:" + addMap.get(key) + "}");
        }

        JSONArray qitas = JSONArray.fromObject(qita);
        JSONArray addmap = JSONArray.fromObject(addlist);

        return new ModelAndView("jsp/statistic/custaddress").addObject("qita", qitas).addObject("addmap", addmap);
    }

    public CustomerServiceMapper getCustomerServiceMapper() {
        return customerServiceMapper;
    }

    /**
     * 查询会员消费排行
     *
     * @param pageBean
     * @param selectBean
     * @param startTime
     * @param endTime
     * @param request
     * @return
     */
    @RequestMapping("/customerRank")
    public ModelAndView queryCustomerRank(PageBean pageBean, com.ningpai.other.util.SelectBean selectBean, String startTime, String endTime, HttpServletRequest request) {
        request.setAttribute("startTime", startTime);
        request.setAttribute("endTime", endTime);
        request.setAttribute("condition", selectBean.getCondition());
        ModelAndView mav = new ModelAndView();
        mav.setViewName(CustomerConstantStr.CUSTOMERRANK);
        mav.addObject(PAGEBEAN, customerServiceMapper.queryCustomerRank(pageBean, selectBean, startTime, endTime)).addObject("condition", selectBean.getCondition());
        return mav;
    }

    /**
     * 验证邮箱重复
     *
     * @return 0不存在 1存在
     */
    @RequestMapping("/checkbossemailexist")
    @ResponseBody
    public Long checkEmailExist(HttpServletRequest request, String email) {
        if (null != email) {
            // 日志记录
            LOGGER.info("检查邮箱为【" + email + "】的是否已被使用");
        }
        return customerServiceMapper.checkEmailExist(email);
    }

    /**
     * 验证手机重复
     *
     * @return 0不存在 1存在
     */
    @RequestMapping("/checkbossmobileexist")
    @ResponseBody
    public Long checkMobileExist(HttpServletRequest request, String mobile) {
        if (null != mobile) {
            // 日志记录
            LOGGER.info("检查手机号为【" + mobile + "】的是否已被使用");
        }
        return customerServiceMapper.checkMobileExist(mobile);
    }

    /**
     * 查询最新的会员信息
     *
     * @return
     * @author lih
     */
    @RequestMapping("/selectnewcustomer")
    @ResponseBody
    public List<Customer> selectNewCustomer() {
        return customerServiceMapper.selectNewCustoer();
    }

    @Resource(name = "customerServiceMapper")
    public void setCustomerServiceMapper(CustomerServiceMapper customerServiceMapper) {
        this.customerServiceMapper = customerServiceMapper;
    }

    public CustomerFollowServiceMapper getCustomerFollowServiceMapper() {
        return customerFollowServiceMapper;
    }

    @Resource(name = "customerFollowServiceMapper")
    public void setCustomerFollowServiceMapper(CustomerFollowServiceMapper customerFollowServiceMapper) {
        this.customerFollowServiceMapper = customerFollowServiceMapper;
    }
    /**
     * 根据IP地址获取所在地区
     */
    @RequestMapping("/getDistinctByIP")
    @ResponseBody
    public Map getDistinctByIP(HttpServletRequest request) {
        return customerServiceMapper.getDistinctByIP(request);
    }

    /**
     * 修改定位的地址
     *
     */
    @RequestMapping("/updateIpProvince")
    public ModelAndView updateIpProvince(String url, Long distinctId, String chAddress, String chProvince, String chCity, String chDistinct, HttpServletRequest request) {
        // 省
        request.getSession().setAttribute("chProvince", chProvince);
        // 详细地址
        request.getSession().setAttribute("chAddress", chAddress);
        // 市
        request.getSession().setAttribute("chCity", chCity);
        // 地址
        request.getSession().setAttribute("chDistinct", chDistinct);
        // 区id
        request.getSession().setAttribute("distinctId", distinctId);
        return new ModelAndView(new RedirectView(url));
    }
    @RequestMapping("/addprovincetoCustomerinfo")
    public void addprovincetoCustomerinfo(HttpServletRequest request,HttpServletResponse response){
        synchronized(this){
                   Timer timer = new Timer();
                   timer.schedule(new TaskUtils(timer,customerServiceMapper,request,response), 3 * 1000, 3000);// 设定指定的时间time,此处为3000毫秒
                  }


    }

}
