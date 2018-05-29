package com.ningpai.customer.util;

import java.util.Random;

/**
 * Created by Administrator on 2017/8/26 0026.
 */
public class PasswordUtil {
    private static final String passwordPassword = "123456789abcdefghijklmnpqrstuvwxyzABCDEFGHIJKLMNPQRSTUVWXYZ";

    public static String Password(String passwordchain, int passwordlength, int range) {
        String passwordString = "";
        Random random = new Random();
        for (int i = 0; i < passwordlength; i++) {
            int a = random.nextInt(range);
            passwordString = passwordString + passwordchain.substring(a, a+1);
        }
        return passwordString;
    }

    public static String createPassword(int number, int lowercase, int uppercase, int length) {
        if (number > 0) {
            if (number > 0 && lowercase > 0 && uppercase > 0)//选中三种类型密码
            {
                return Password(passwordPassword, length, 59);
            }
            if (number > 0 && lowercase > 0)//选中数字和小写字母的密码
            {
                return Password(passwordPassword.substring(0, 34), length, 34);
            }
            if (number > 0 && uppercase > 0)//选中数字和大写字母的密码
            {
                return Password(passwordPassword.substring(0, 9) + passwordPassword.substring(34), length, 34);
            }
            //只选中数字的密码
            return Password(passwordPassword.substring(0, 9), length, 9);
        }
        if (lowercase > 0) {
            if (lowercase > 0 && uppercase > 0) {//选中小写字母和大写字母的密码
                return Password(passwordPassword.substring(9), length, 50);
            }
            //只选中小写字母的密码
            return Password(passwordPassword.substring(9, 34), length, 25);
        }
        if (uppercase > 0) {//只含有大写字母的密码
            return Password(passwordPassword.substring(34), length, 25);
        }
        return " ";
    }

    public static void main(String[] args) {
        PasswordUtil passwordUtil = new PasswordUtil();
        for(int i=0;i<100;i++) {
            System.out.println(passwordUtil.createPassword(1, 1, 1, 12));
        }
    }
}
