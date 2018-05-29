package com.ningpai.deposit.service;

import com.ningpai.customer.dao.GiftcardMapper;
import com.ningpai.customer.vo.GiftcardVo;
import com.ningpai.deposit.bean.Deposit;
import com.ningpai.deposit.mapper.DepositMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by youzipi on 16/10/14.
 */
@Service
public class DepositService {


    @Autowired
    private DepositMapper depositMapper;
    @Autowired
    private GiftcardMapper giftcardMapper;

    @Transactional
    public Deposit getDeposit(Map<String, Object> paramMap) {
        checkAndCreate(paramMap);
        Deposit deposit = depositMapper.getDeposit(paramMap);
        return deposit;
    }

    public Deposit findByCustomerId(Long customerId) {
        Map<String, Object> paramMap = new HashMap<>(1);
        paramMap.put("customerId", customerId);
        return getDeposit(paramMap);
    }

    public void checkAndCreate(Map<String, Object> paramMap) {
        Long count = depositMapper.depositCount(paramMap);
        //判断是不是空，是空默认新建一个
        if (count == 0) {
            Deposit deposit = new Deposit();
            Long customerId = (Long) paramMap.get("customerId");
            deposit.setCustomerId(customerId);
            if (null != customerId) {
                saveDeposit(deposit);
            }
        }
    }

    @Transactional
    public int saveDeposit(Deposit deposit) {
        int result = depositMapper.saveDeposit(deposit);
        return result;
    }

    @Transactional
    public int updateDeposit(Map<String, Object> paramMap) {

        if(paramMap.get("preDeposit") != null && paramMap.get("preDeposit").toString().equals("0.00")){
            paramMap.put("preDeposit","0");
        }
        if(paramMap.get("freezePreDeposit") != null && paramMap.get("freezePreDeposit").toString().equals("0.00")){
            paramMap.put("freezePreDeposit","0");
        }

        System.out.println("-----22++："+paramMap.get("preDeposit"));
        int result = depositMapper.updateDeposit(paramMap);
        return result;
    }

    public int resetDepositPasswordCount() {
        return depositMapper.resetDepositPasswordCount();
    }

    /**
     * 修改密码错误次数
     * @param customerId
     * @param nextErrorCount 修改后的密码错误次数
     * @return
     */
    public int updateErrorCount(Long customerId, int nextErrorCount) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("customerId", customerId);
        map.put("passwordErrorCount", nextErrorCount);
        if (nextErrorCount == 3) {
            map.put("passwordTime", new Date());
        }
        return depositMapper.updateDeposit(map);
    }

    /**
     * 绑定礼品卡和用户账户
     * @param deposit
     * @param giftcardVo
     * @return
     */
    @Transactional
    public int bindGiftcardCust(Deposit deposit, GiftcardVo giftcardVo) {
        //绑定账户和礼品卡
        Map paramMap = new HashMap();
        paramMap.put("customerId",deposit.getCustomerId());
        Long count = depositMapper.depositCount(paramMap);
        int i = 0;
        if(count>0){
            paramMap.put("payPassword", deposit.getPayPassword());
            paramMap.put("passwordTime", new Date());
            paramMap.put("preDeposit", deposit.getPreDeposit());
            paramMap.put("giftcardNo", deposit.getGiftcardNo());
            i = depositMapper.updateDeposit(paramMap);
        }else {
            i = depositMapper.saveDeposit(deposit);
        }
        if(i==1) {
            //修改礼品卡信息（激活状态：2，面值：0）
            giftcardVo.setGiftcardPrice(BigDecimal.valueOf(0.00));
            giftcardVo.setActiveFlag("2");
            giftcardVo.setCustomerId(null);
            return giftcardMapper.updateGiftcard(giftcardVo);
        }
        return 0;
    }
}
