package com.ningpai.m.deposit.bean;

/**
 * Created by chenpeng on 2016/10/12.
 */
public class DepositInfoCons {

    public static final int ERROR_THRESHOLD = 3;

    public static final String REACHE_ERROR_THRESHOLD_TIPS = "您的礼品卡账户锁定，次日将自动解锁";

    public static final String REACHE_ERROR_THRESHOLD_TIPS1 = "礼品卡账户锁定，无法提现";

    public static final String NOT_REACHE_ERROR_THRESHOLD_TIPS = "密码有误，您还有";

    public static final String NOT_SET_PAYPASSWORD0 = "未设置支付密码，点击其他方式支付";

    public static final String NOT_SET_PAYPASSWORD1 = "您还没有设置支付密码，暂时无法提现";

    public static final String RETURN_MSG = "return_msg";

    public static final String RETURN_CODE = "return_code";

    public static final String SUCCESS = "success";

    public static final String FAIL = "fail";

    public static final String DEPOSIT_LESS = "礼品卡账户余额不足";

    public static final String FAIL_CODE = "fail_code";
    public static final String PASS_FAIL_CODE = "pass_fail";
    public static final String FROZEN_FAIL_CODE = "frozen_fail";
    public static final String BALANCE_FAIL_CODE = "balance_fail";

    public static final String NOT_ENOUGH_PAYPASSWORD = "礼品卡账户余额不足，请选择其他支付方式,可用余额:¥";

    public static final String NOT_ENOUGH_PAYPASSWORD1 = "礼品卡账户余额不足，请修改提现金额";

    public static final String NO_CARD = "您尚未绑定礼品卡";

}
