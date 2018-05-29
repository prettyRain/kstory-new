package com.ningpai.customer.service.impl;

import com.ningpai.customer.bean.*;
import com.ningpai.customer.dao.CustomerMapper;
import com.ningpai.customer.dao.DepositInfoMapper;
import com.ningpai.customer.dao.GiftcardMapper;
import com.ningpai.customer.dao.TradeInfoMapper;
import com.ningpai.customer.service.GiftcardService;
import com.ningpai.customer.util.GiftcardUtil;
import com.ningpai.customer.vo.GiftcardVo;
import com.ningpai.deposit.bean.Deposit;
import com.ningpai.deposit.bean.Trade;
import com.ningpai.deposit.mapper.DepositMapper;
import com.ningpai.util.*;
import com.ningpai.utils.SecurityUtil;
import org.apache.commons.collections.CollectionUtils;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellStyle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 礼品卡service实现
 */
@Service("giftcardService")
public class GiftcardServiceImpl implements GiftcardService {
    /**
     * 日志
     * */
    public static final MyLogger LOGGER = new MyLogger(DepositInfoServiceImpl.class);

    @Autowired
    private GiftcardMapper giftcardMapper;

    @Autowired
    private CustomerMapper customerMapper;

    @Autowired
    private DepositMapper depositMapper;

    @Autowired
    private TradeInfoMapper tradeInfoMapper;

    @Autowired
    private DepositInfoMapper depositInfoMapper;
    /**
     * 验证该礼品卡密码是否可用
     * @param giftcardPwd
     * @return
     */
    @Override
    public Long checkGiftcardPwd(String giftcardPwd) throws Exception {
        Giftcard giftcard = new Giftcard();
        giftcard.setGiftcardPwd(giftcardPwd);
        //礼品卡号是否存在
        GiftcardVo giftcardVo = getGiftcard(giftcard);
        if(giftcardVo!=null){
            //礼品卡是否激活
            if("1".equals(giftcardVo.getActiveFlag())){
                return 0L;
                //礼品卡已失效(已绑定或者未绑定已过期)
            }else if("2".equals(giftcardVo.getActiveFlag())){
                //礼品卡是否已绑定
                if(giftcardVo.getDepositInfo()!=null){
                    return 3L;
                }
                //未绑定已过期
                return 4L;
            }else {
                return 2L;
            }
        }
        return 1L;
    }

    /**
     * 检查礼品卡有效期（激活后三年有效期，三年未绑定即为失效）
     * @param giftcardVo
     */
    public void checkExpires(GiftcardVo giftcardVo){
        if(giftcardVo!=null){
            if("1".equals(giftcardVo.getActiveFlag())){
                Date activeTime = giftcardVo.getActiveTime();
                if(activeTime!=null){
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
                    Calendar rightNow = Calendar.getInstance();
                    rightNow.setTime(activeTime);
                    rightNow.add(Calendar.YEAR, 3);// 日期加3年
                    rightNow.add(Calendar.DAY_OF_MONTH,1);
                    rightNow.set(Calendar.HOUR,0);
                    rightNow.set(Calendar.MINUTE,0);
                    rightNow.set(Calendar.SECOND,0);
                    Date expiresDate = rightNow.getTime();
                    //过期
                    if(new Date().getTime() > expiresDate.getTime()){
                        giftcardVo.setActiveFlag("2");
                        updateGiftcard(giftcardVo);
                    }
                }
            }
        }
    }

    /**
     * 根据礼品卡密码获取礼品卡信息
     * @param giftcard
     * @return
     */
    public GiftcardVo getGiftcard(Giftcard giftcard) throws Exception {
        if(giftcard.getGiftcardPwd()!=null){
            giftcard.setGiftcardPwd(GiftcardUtil.encodePwd(giftcard.getGiftcardPwd()));
        }
        GiftcardVo giftcardVo = giftcardMapper.getGiftcard(giftcard);
        checkExpires(giftcardVo);
        return giftcardVo;
    }

    /**
     * 修改礼品卡信息
     * @param giftcard
     * @return
     */
    @Override
    public int updateGiftcard(GiftcardVo giftcard) {
        return giftcardMapper.updateGiftcard(giftcard);
    }

    /**
     * 查询礼品卡资金信息列表总条数，用于分页
     *
     * @param giftcardVo
     */
    public Long selectTotalGiftcardInfo(GiftcardVo giftcardVo) {
        Long result = null;
        LOGGER.info("查询礼品卡资金信息列表总数据条数...");
        try {
            result = giftcardMapper.selectTotalGiftcardInfo(giftcardVo);
        }catch (Exception e){
            LOGGER.error(e.toString());
        }
        return result;
    }

    /**
     * 查询礼品卡资金信息列表
     * @param giftcardVo
     * @param pageBean
     * @return
     */
    @Override
    public PageBean selectGiftcardInfoList(GiftcardVo giftcardVo, PageBean pageBean) {
        GiftcardVo giftcardVo0 = new GiftcardVo();
        giftcardVo0.setActiveFlag(giftcardVo.getActiveFlag());
        if(giftcardVo.getCustomerUsername()!=null) {
            giftcardVo.setCustomerUsername(giftcardVo.getCustomerUsername().trim());
            giftcardVo0.setCustomerUsername(giftcardVo.getCustomerUsername());
        }
        if(giftcardVo.getGiftcardNo()!=null) {
            giftcardVo.setGiftcardNo(giftcardVo.getGiftcardNo().trim());
            giftcardVo0.setGiftcardNo(giftcardVo.getGiftcardNo());
        }
        //按用户名查询时，先查找是否用户名绑定有礼品卡
        DepositInfo depositInfo = null;
        boolean flag = false;
        if(giftcardVo.getCustomerUsername()!=null && !"".equals(giftcardVo.getCustomerUsername())){
            Map paramMap = new HashMap();
            paramMap.put("customerUsername",giftcardVo.getCustomerUsername());
            depositInfo = giftcardMapper.selectDepositInfoByNo(paramMap);
            if(depositInfo!=null) {
                flag = true;
                giftcardVo.setGiftcardNo(depositInfo.getGiftcardNo());
            }else{
                //没有绑定礼品卡，查询结果为空
                giftcardVo.setGiftcardNo("4444444444444");
            }
        }
        //总数据条数
        Long rowNos = this.selectTotalGiftcardInfo(giftcardVo);
        pageBean.setRows(rowNos.intValue());

        giftcardVo.setStartRowNum(pageBean.getStartRowNum());
        giftcardVo.setEndRowNum(pageBean.getEndRowNum());
        List<Object> giftcardInfoList;
        try {
            LOGGER.info("查询礼品卡资金信息列表...");
            giftcardInfoList = giftcardMapper.selectGiftcardInfoList(giftcardVo);
            if (CollectionUtils.isNotEmpty(giftcardInfoList)){
                //查询已绑定礼品卡的用户信息
                for (Object o : giftcardInfoList) {
                    GiftcardVo giftcardVo1 = (GiftcardVo) o;
                    //已失效、已挂失
                    if("2".equals(giftcardVo1.getActiveFlag()) || "-2".equals(giftcardVo1.getActiveFlag())){
                        if(depositInfo==null) {
                            Map paramMap = new HashMap();
                            paramMap.put("giftcardNo", giftcardVo1.getGiftcardNo());
                            depositInfo = giftcardMapper.selectDepositInfoByNo(paramMap);
                        }
                        if(depositInfo!=null) {
                            giftcardVo1.setCustomerId(depositInfo.getCustomerId());
                            giftcardVo1.setTotalDeposit(depositInfo.getTotalDeposit());
                            giftcardVo1.setPreDeposit(depositInfo.getPreDeposit());
                            giftcardVo1.setFreezePreDeposit(depositInfo.getFreezePreDeposit());
                            giftcardVo1.setCustomerUsername(depositInfo.getCustomerUsername());
                        }
                        if(!flag){
                            depositInfo = null;
                        }
                    }
                }
                pageBean.setList(giftcardInfoList);
            }else{
                //回显问题
                if("4444444444444".equals(giftcardVo.getGiftcardNo())){
                    giftcardVo.setGiftcardNo("");
                }
            }
            pageBean.setObjectBean(giftcardVo0);
        }catch (Exception e){
            LOGGER.error(e.toString());
        }
        return pageBean;
    }

    /**
     * 查询所有礼品卡生成的卡段
     * @param segment
     * @param pageBean
     * @return
     */
    @Override
    public PageBean searchSegmentList(GiftcardSegment segment, PageBean pageBean) {
        //总数据条数
        Long rowNos = giftcardMapper.selectTotalSegmentInfo(segment);
        pageBean.setRows(rowNos.intValue());

        segment.setStartRowNum(pageBean.getStartRowNum());
        segment.setEndRowNum(pageBean.getEndRowNum());
        List<Object> segmentList;
        try {
            LOGGER.info("查询礼品卡段信息列表...");
            segmentList = giftcardMapper.selectSegmentInfoList(segment);
            if (CollectionUtils.isNotEmpty(segmentList)){
                pageBean.setList(segmentList);
            }
            pageBean.setObjectBean(segment);
        }catch (Exception e){
            LOGGER.error(e.toString());
        }
        return pageBean;
    }

    /**
     * 批量添加礼品卡
     * @param segment
     */
    @Override
    @Transactional
    public int addGiftcardBatch(GiftcardSegment segment) throws Exception {
        //根据卡段生成一批卡号
        List list = GiftcardUtil.createNo(segment.getCardPrefix(), segment.getCardMid(), segment.getCardSuffix(), segment.getCardNum());
        //卡号后段出现超出6位的情况
        if(list==null){
            return 2;
        }
        //验证这批卡号是否已经被使用
        List totalList = giftcardMapper.selectAllGiftcardNo();
        for (Object o : list) {
            for (Object o1 : totalList) {
                if(o.toString().equals(o1.toString())){
                    return -1;
                }
            }
        }
        //添加一个卡段
        int i = giftcardMapper.addSegment(segment);
        if(i==1) {
            List<Giftcard> giftcardList = new ArrayList<Giftcard>();
            for (Object o : list) {
                Giftcard giftcard = new Giftcard();
                giftcard.setGiftcardNo(o.toString());
                //由数字 大写字母组成的12位密码
                giftcard.setGiftcardPwd(GiftcardUtil.createPwd(1, 0, 1, 12));
                giftcard.setGiftcardPrice(segment.getCardPrice());
                giftcard.setGiftcardType("1");
                giftcard.setActiveFlag("0");
                giftcard.setSegmentId(segment.getId());
                giftcard.setCreateTime(new Date());
                giftcardList.add(giftcard);
            }
            giftcardMapper.addGiftcardBatch(giftcardList);
            return 1;
        }
        return 0;
    }

    /**
     * 查询卡段
     * @param id
     * @return
     */
    @Override
    public GiftcardSegment selectSegment(Long id) {
        return giftcardMapper.selectSegment(id);
    }

    /**
     * 导出礼品卡列表
     * @param response
     * @param id
     */
    @Override
    public void exportCardNo(HttpServletResponse response, Long id) throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        GiftcardSegment giftcardSegment = giftcardMapper.selectSegment(id);
        List<Giftcard> giftcardList = giftcardSegment.getGiftcardList();
        Object giftcard;
        HSSFWorkbook wb = new HSSFWorkbook();
        // Sheet样式
        CellStyle style = wb.createCellStyle();
        HSSFRow tempRow;
        style.setAlignment(CellStyle.ALIGN_CENTER);
        HSSFSheet sheet1 = wb.createSheet("礼品卡列表");
        // 冻结
        sheet1.createFreezePane(255, 1);
        // 调整导出excel的卡号的列宽
        sheet1.setColumnWidth(1, 5000);
        // 调整导出excel的密码的列宽
        sheet1.setColumnWidth(2, 5000);
        // 调整导出excel的生成时间的列宽
        sheet1.setColumnWidth(3, 5000);
        // 调整导出excel的领取人的列宽
        sheet1.setColumnWidth(4, 5000);
        HSSFRow headRow = sheet1.createRow(0);
        headRow.createCell(0).setCellValue("序号");
        headRow.createCell(1).setCellValue("卡号");
        headRow.createCell(2).setCellValue("密码");
        headRow.createCell(3).setCellValue("生成时间");
        headRow.createCell(4).setCellValue("领取人");
        // 遍历数据集创建Excel的行
        if (giftcardList != null && !giftcardList.isEmpty()) {
            for (int i = 0; i < giftcardList.size(); i++) {
                giftcard = giftcardList.get(i);
                tempRow = sheet1.createRow(1 + i);
                tempRow.createCell(0).setCellValue(i + 1);
                tempRow.createCell(1).setCellValue(((Giftcard) giftcard).getGiftcardNo());
                String giftcardPwd = ((Giftcard) giftcard).getGiftcardPwd();
                tempRow.createCell(2).setCellValue(GiftcardUtil.decodePwd(giftcardPwd, "Ge960"));
                if (((Giftcard) giftcard).getCreateTime() != null) {
                    tempRow.createCell(3).setCellValue(
                            sdf.format(((Giftcard) giftcard).getCreateTime()));
                }
                if (((Giftcard) giftcard).getActiveName() != null) {
                    tempRow.createCell(4).setCellValue(
                            ((Giftcard) giftcard).getActiveName());
                }
            }
        }
        // 设置下载时客户端Excel的名称
        String filename = "导出礼品卡-" + String.valueOf(System.currentTimeMillis()).concat(".xls");
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(filename));
        OutputStream ouputStream;
        try {
            ouputStream = response.getOutputStream();
            wb.write(ouputStream);
            ouputStream.flush();
            ouputStream.close();
        } catch (IOException e) {
            ouputStream = null;
        } finally {
            filename = null;
            giftcard = null;
            wb = null;
            ouputStream = null;
            style = null;
            tempRow = null;
        }
    }

     /** 新增礼品卡信息
     * @param gc 礼品卡
     */
    @Override
    public void insertGiftCard(Giftcard gc) {
        giftcardMapper.insertGiftCard(gc);
    }

    /**
     * 获取最新的电子卡卡号
     * @return
     */
    @Override
    public String getECardNewNo() {
        return giftcardMapper.getECardNewNo();
    }

    /**
     * 根据订单编号获取电子礼品卡集合
     * @param orderCode
     * @return
     */
    @Override
    public List<Giftcard> selectGiftcardByOrderCode(String orderCode) {
        return giftcardMapper.selectGiftcardByOrderCode(orderCode);
    }

    /**
     * 根据卡号和密码验证礼品卡是否存在
     * @param giftcard
     * @return
     */
    @Override
    public GiftcardVo getGiftCardByNoAndPwd(Giftcard giftcard) {
        return giftcardMapper.getGiftcard(giftcard);
    }

    /**
     * 通过手机号查询该用户能否绑定礼品卡
     * @param mob
     * @param request
     * @return
     */
    @Override
    public int validaCustomerAndIsBinding(String mob,HttpServletRequest request){
        Customer customer = customerMapper.getCustomerByUsername(mob);
        if(customer == null){
            return -1;
        }
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("customerId",customer.getCustomerId());
        Deposit deposit = depositMapper.getDeposit(map);
        if(deposit == null){
            return 0;
        }
        if(null == deposit.getGiftcardNo() || "".equals(deposit.getGiftcardNo())){
            int num = (int) ((Math.random() * 9 + 1) * 100000);
            System.out.println("验证码为："+num);
            // 发送短信
            try {
                //原始通道发送短信
                if(MSMSendUtil.newSendSms(mob,num)){
                    request.getSession().setAttribute("gcCode",num);
                }else{
                    //如果发送不成功则使用阿里大于继续发送短信
                    if (AliSmsUtil.send(num,mob,AliSmsUtil.smsTemplate.COMMON_TEMP.getContent(),null)) {
                        request.getSession().setAttribute("gcCode",num);
                    }
                }
                return 1;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return 0;
    }

    /**
     * 保存会员绑定礼品卡
     * @param gcNo 礼品卡卡号
     * @param gcPwd 礼品卡密码
     * @param mobile 会员手机号
     * @param pwd 支付密码
     * @param request
     * @return
     * @throws Exception
     */
    @Override
    public int saveBindingGift(String gcNo, String gcPwd, String mobile,String smscode, String pwd,HttpServletRequest request) {
        GiftcardVo giftcard = new GiftcardVo();
        try {
            giftcard.setGiftcardNo(gcNo);
            giftcard.setGiftcardPwd(GiftcardUtil.encodePwd(gcPwd));
            giftcard = giftcardMapper.getGiftcard(giftcard);
            if(giftcard == null){
                return -1;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        Customer customer = customerMapper.getCustomerByUsername(mobile);
        if(customer == null){
            return -2;
        }
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("customerId",customer.getCustomerId());
        Deposit deposit = depositMapper.getDeposit(map);
        if(deposit == null){
            return 0;
        }
        if(null == deposit.getGiftcardNo() || "".equals(deposit.getGiftcardNo())){
            Object gcCode = request.getSession().getAttribute("gcCode");
            if(gcCode != null && smscode.equals(gcCode.toString())){
                //第一次礼品卡金额加入用户账户，添加交易记录
                BigDecimal giftcardPrice = giftcard.getGiftcardPrice();
                // 生成交易订单号
                int randomNum = new Random().nextInt(9000) + 1000;
                String orderCode = "G" + UtilDate.mathString(new Date()) + randomNum;
                saveTrade(deposit, orderCode, giftcardPrice, "后台充值-礼品卡","0");
                //添加交易记录end
                //绑定账户和礼品卡
                Map<String,Object> paramMap = new HashMap<String,Object>();
                // 生成盐值
                String salt = SecurityUtil.getNewPsw();
                String encodePwd = SecurityUtil.getStoreLogpwd(deposit.getCustomerId().toString(), pwd, salt);
                paramMap.put("payPassword", encodePwd);
                paramMap.put("passwordTime", new Date());
                paramMap.put("preDeposit", giftcardPrice.add(deposit.getPreDeposit()));
                paramMap.put("giftcardNo", gcNo);
                paramMap.put("customerId", customer.getCustomerId());
                paramMap.put("userSaltVal", salt);
                depositMapper.updateDeposit(paramMap);
                //修改礼品卡信息（激活状态：2，面值：0）
                giftcard.setGiftcardPrice(BigDecimal.valueOf(0.00));
                giftcard.setActiveFlag("2");
                giftcard.setGiftcardNo(gcNo);
                giftcard.setActiveTime(new Date());
                giftcardMapper.updateGiftcard(giftcard);
                request.getSession().removeAttribute("gcCode");
                return 1;
            }else{
                //短信验证码错误
                return -3;
            }
        }else{
            return 0;
        }
    }

    /**
     * 保存后台礼品卡充值
     * @param customerId 充值用户
     * @param price 充值金额
     * @param payId 充值方式 “1线下现金”、“2线下刷卡”、“3线下支付宝”、“4线下微信”；
     * @return
     * @throws Exception
     */
    @Override
    public int saveRechargeGiftcard(Long customerId, String price, Long payId) {
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("customerId",customerId);
        Deposit deposit = depositMapper.getDeposit(map);
        if(deposit == null || price == "" || payId == null ){
            return 0;
        }
        Map<String,Object> paramMap = new HashMap<String,Object>();
        paramMap.put("preDeposit", deposit.getPreDeposit().add(new BigDecimal(price)));
        paramMap.put("customerId", deposit.getCustomerId());
        int n = depositMapper.updateDeposit(paramMap);
        if(n == 1){
            // 生成交易订单号
            String markStr = "";
            if(payId == 4){
                markStr = "线下现金";
            }else if(payId == 5){
                markStr = "线下刷卡";
            }else if(payId == 6){
                markStr = "线下支付宝";
            }else if(payId == 7){
                markStr = "线下微信";
            }
            int randomNum = new Random().nextInt(9000) + 1000;
            String orderCode = "OR" + UtilDate.mathString(new Date()) + randomNum;
            saveTrade(deposit, orderCode, new BigDecimal(price), "后台充值-礼品卡"+"-"+markStr,payId.toString());
            return 1;
        }
        return 0;
    }

    @Override
    public int saveGuaShiGiftcard(Long customerId, String gcNo) {
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("customerId",customerId);
        Deposit deposit = depositMapper.getDeposit(map);
        if(deposit == null){
            return 0;
        }
        /**
         * 挂失对礼品卡金额不做操作，只需将礼品卡状态改为已挂失
         */
//        DepositInfo depositInfo = new DepositInfo();
//        depositInfo.setCustomerId(deposit.getCustomerId());
//        depositInfo.setId(deposit.getId());
//        depositInfo.setFreezePreDeposit(deposit.getPreDeposit());
//        depositInfo.setPreDeposit(new BigDecimal(0));
//        int n = depositInfoMapper.updateDeposit(depositInfo);

        GiftcardVo giftcard = new GiftcardVo();
        giftcard.setActiveFlag("-2");
        giftcard.setGiftcardNo(gcNo);
        giftcardMapper.updateGiftcard(giftcard);
        return 1;
    }

    @Override
    public int savetoNewGiftCard(Long customerId,String gcNo) {

        //根据卡号和密码判断是否存在礼品卡
        GiftcardVo giftcard = new GiftcardVo();
        try {
            giftcard.setGiftcardNo(gcNo);
            giftcard = giftcardMapper.getGiftcard(giftcard);
            if(giftcard == null){
                return -1;
            }
            //转移的卡是未激活状态的卡，金额不限
            if(!giftcard.getActiveFlag().equals("0")){
                return -2;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("customerId",customerId);
        Deposit deposit = depositMapper.getDeposit(map);
        if(deposit == null){
            return 0;
        }
        //将已经挂失的礼品卡设为无效状态
        giftcard = new GiftcardVo();
        giftcard.setActiveFlag("-1");
        giftcard.setGiftcardNo(deposit.getGiftcardNo());
        giftcardMapper.updateGiftcard(giftcard);
        //将新卡号绑定与该用户进行绑定
        Map<String,Object> paramMap = new HashMap<String,Object>();
        paramMap.put("preDeposit", deposit.getPreDeposit().subtract(new BigDecimal(10)));
//        paramMap.put("freezePreDeposit", "0.00");
        paramMap.put("giftcardNo", gcNo);
        paramMap.put("customerId", deposit.getCustomerId());
        int n = depositMapper.updateDeposit(paramMap);
        if(n == 1){
            //修改礼品卡信息（激活状态：2，面值：0）
            giftcard = new GiftcardVo();
            giftcard.setGiftcardPrice(BigDecimal.valueOf(0.00));
            giftcard.setActiveFlag("2");
            giftcard.setGiftcardNo(gcNo);
            giftcardMapper.updateGiftcard(giftcard);
            //保存转卡工本费扣除记录
            TradeInfo tTrade = new TradeInfo();
            tTrade.setCustomerId(deposit.getCustomerId());
            tTrade.setCreatePerson(deposit.getCustomerId());
            tTrade.setCreateTime(new Date());
            tTrade.setOrderPrice(new BigDecimal(10));
            tTrade.setDelFlag("0");
            tTrade.setOrderType("8");
            int randomNum = new Random().nextInt(9000) + 1000;
            String orderCode = "OR" + UtilDate.mathString(new Date()) + randomNum;
            tTrade.setOrderCode(orderCode);
            tTrade.setTradeRemark("转卡工本费");
            //当前可用余额信息。
            tTrade.setCurrentPrice(deposit.getPreDeposit().add(deposit.getFreezePreDeposit()).subtract(new BigDecimal(10)));
            tradeInfoMapper.insertTradeInfo(tTrade);
            return 1;
        }
        return 0;
    }

    private int saveTrade(Deposit deposit, String orderCode, BigDecimal totalPrice, String remark,String status) {
        BigDecimal preDeposit = deposit.getPreDeposit();
        BigDecimal freezePreDeposit = deposit.getFreezePreDeposit();
        BigDecimal currentPrice = preDeposit.add(freezePreDeposit);
        TradeInfo tTrade = new TradeInfo();
        tTrade.setCustomerId(deposit.getCustomerId());
        tTrade.setCreatePerson(deposit.getCustomerId());
        tTrade.setCreateTime(new Date());
        tTrade.setOrderPrice(totalPrice);
        tTrade.setDelFlag("0");
        tTrade.setOrderCode(orderCode);
        tTrade.setOrderStatus("6");
        tTrade.setOrderType(status);
        tTrade.setTradeRemark(remark);
        //当前可用余额信息。
        tTrade.setCurrentPrice(currentPrice.add(totalPrice));
        int ret = tradeInfoMapper.insertTradeInfo(tTrade);
        return ret;
    }
}
