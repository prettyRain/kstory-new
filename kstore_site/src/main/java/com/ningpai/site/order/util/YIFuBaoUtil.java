package com.ningpai.site.order.util;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang.StringUtils;

import java.util.*;

/**
 * Created by dll on 2017/6/30.
 */
public class YIFuBaoUtil {

    public static final String MD5_WITH_RSA = "Md5WithRSA";
    public static final String SHA1_WITH_RSA = "SHA1WithRSA";
    public static final String RSA = "RSA";
    public static final String UTF_8 = "UTF-8";
    public static final String EQ_SYMBOL = "=";
    public static final String AND_SYMBOL = "&";

    /**
     * BASE64 编码
     * @param str
     * @return
     */
    public static String base64Encode(String str) {
        byte[] encodeBase64 = null;
        String result = null;
        if (StringUtils.isEmpty(str)) {
            return str;
        }
        try {
            encodeBase64 = Base64.encodeBase64(str.getBytes("UTF-8"));
            result = new String(encodeBase64, "UTF-8");
        } catch (Throwable e) {
            System.err.println("Base64失败");
        }

        return result;
    }

    /**
     * 将请求的参数进行签名加密
     * @param requestMap
     * @return
     */
    public static String generateSignature(Map<String, String> requestMap) {
        System.out.println("开始生成签名");
        List<String> excudeKeylist = new ArrayList<String>();
        excudeKeylist.add("signature");
        excudeKeylist.add("signAlgorithm");
        String[] excudeKey = new String[excudeKeylist.size()];
        TreeMap<String, String> treeMap = treeMap(requestMap, excudeKeylist.toArray(excudeKey));
        System.out.println("生成摘要的字符串：" + mapToString(treeMap));
        String digest = Digest.digest(requestMap, excudeKeylist.toArray(excudeKey));
        System.out.println("digest : " + digest);
        String sign = null;
        try {
            //sign = RSAUtil.sign(digest, RSAUtil.getPrivateKey(PRIVATE_KEY));
            sign = RSAUtil.sign(digest, RSAUtil.getPrivateKey(YIFuBaoPayConfigUtil.PRIVATE_KEY));
        } catch (Throwable e) {
            System.err.println("生成签名失败");
            e.printStackTrace();
        }
        System.out.println("sign : " + sign);
        return sign;
    }


    public static TreeMap<String, String> treeMap(Map<String, String> map, String... keys) {
        // 初始化字符串比较器
        Comparator<String> stringComparator = new StringComparator();

        TreeMap<String, String> treeMap = new TreeMap<String, String>(stringComparator);
        treeMap.putAll(map);
        // 移除非摘要的key
        for (String key : keys) {
            treeMap.remove(key);
        }
        return treeMap;
    }

    public static String mapToString(Map<String, String> map) {
        StringBuilder result = new StringBuilder();
        for (Map.Entry<String, String> entry : map.entrySet()) {
            String value = entry.getValue()==null?"": entry.getValue().trim();
            result.append(entry.getKey()).append(EQ_SYMBOL).append(value).append(AND_SYMBOL);
        }
        if (result.length() > 0) {
            result.deleteCharAt(result.length() - 1);
        }
        return result.toString().trim();
    }

    public static String mosaicUrlWithParams(String url, Map<String, String> params) {
        StringBuilder paramStr = new StringBuilder();
        for (Map.Entry<String, String> entry : params.entrySet()) {
            paramStr.append(entry.getKey()).append("=").append(entry.getValue()).append("&");
        }
        return url + "?" + paramStr.substring(0, paramStr.length() - 1);

    }

    public static String buildInputHiddenFieldInForm(String paramName, String paramValue) {
        String line = "<input type=\"hidden\" name=\"\" value=\"\">";
        if (paramName == null || paramValue == null) {
            return "";
        } else {
            paramValue = paramValue.replaceAll("\"", "&quot;");
            int nameSize = "name=".length() + 1;
            int valueSize = "value=".length() + 1;
            line = line.substring(0, line.indexOf("name=") + nameSize) + paramName
                    + line.substring(line.indexOf("name") + nameSize);
            line = line.substring(0, line.indexOf("value=") + valueSize) + paramValue
                    + line.substring(line.indexOf("value=") + valueSize);
            return line;
        }
    }

    /**
     * 拼装form表单
     *
     * @return
     */
    public static String buildForm(String url, String inputFiled) {

        StringBuffer form = new StringBuffer();
        form.append("<form name=\"punchout_form\" method=\"post\" action=\"");
        form.append(url);
        form.append("\">");
        form.append(inputFiled);
        form.append("</form>");
        form.append("<input type=\"submit\" value=\"确认\" style=\"display:none;\"></form>");
        form.append("<script>document.forms['punchout_form'].submit();</script>");
        return form.toString();
    }
}
