package com.ningpai.customer.util;

import java.util.ArrayList;
import java.util.List;

/**
 * 礼品卡的卡号、密码生成及解密
 */
public class GiftcardUtil {

    public static void main(String[] args) {
        List list = createNo("960", "8888", "100001", 10);
        for (Object o : list) {
            System.out.println(o.toString());
        }
    }

    /**
     * 根据前缀、中间段、后缀起始数、数量生成一批顺序卡号
     * @return
     */
    public static List createNo(String prefix, String mid, String end, int num){
        List<String> list = new ArrayList<String>();
        for(int i=0;i<num;i++){
            String end0 = String.valueOf(Integer.parseInt(end) + i);
            if(end0.length()>6){
                return null;
            }
            if(end0.indexOf("4")<0) {
                list.add(prefix + mid + end0);
            }else{
                num++;
            }
        }
        return list;
    }

    /**
     * 根据密码组成类型（数字，小写字母，大写字母）和长度生成一个随机密码并加密
     * @param number
     * @param lowercase
     * @param uppercase
     * @param length
     * @return
     * @throws Exception
     */
    public static String createPwd(int number, int lowercase, int uppercase, int length) throws Exception {
        //生成随机密码
        String password = PasswordUtil.createPassword(number, lowercase, uppercase, length);
        //加密
        Base64Util nb = new Base64Util();
        nb.generateDecoder("Ge960");
        return nb.Base64Encode(password.getBytes());
    }

    /**
     * 密码解密（需要输入指定位置的5个字符组成的字符串）
     * @param pwd
     */
    public static String decodePwd(String pwd, String passCode) throws Exception {
        //解密
        Base64Util nb = new Base64Util();
        nb.generateDecoder(passCode);
        return new String(nb.Base64Decode(pwd));
    }

    /**
     * 密码加密
     * @param pwd
     */
    public static String encodePwd(String pwd) throws Exception {
        Base64Util nb = new Base64Util();
        nb.generateDecoder("Ge960");
        return nb.Base64Encode(pwd.getBytes());
    }
}
