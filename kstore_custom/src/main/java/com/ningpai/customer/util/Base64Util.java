package com.ningpai.customer.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.ByteArrayOutputStream;

/**
 * Created by Administrator on 2017/8/26 0026.
 */
public class Base64Util {
    private Logger logger = LoggerFactory.getLogger(Base64Util.class);

    private static final int RANGE = 0xff;
    //自定义码表 可随意变换字母排列顺序，然后会自动生成解密表
    private static final char[] Base64ByteToStr = new char[] {
            'K', 'L', 'M', '2', 'O', 'T', 'Q', 'R', 'S', 'P',// 0 ~ 9
            'U', 'B', 'A', 'D', 'k', 'F', 'G', 'H', 'I', 'J',// 10 ~ 19
            'C', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd',// 20 ~ 29
            'o', 'p', 'q', 'r', 's', 't', 'u', '9', 'w', 'x',// 30 ~ 39
            'e', 'f', 'g', 'h', 'i', 'j', 'E', 'l', 'm', 'n',// 40 ~ 49
            'y', 'z', '0', '1', 'N', '3', '4', '5', '6', '7',// 50 ~ 59
            '8', 'v', '+', '/'// 60 ~ 63
    };

    private static byte[] StrToBase64Byte = new byte[128];

    public void generateDecoder(String passCode) throws Exception {
        for(int i = 0; i <= StrToBase64Byte.length - 1; i++) {
            StrToBase64Byte[i] = -1;
        }
        char[] chars = passCode.toCharArray();
        Base64ByteToStr[16] = chars[0];
        Base64ByteToStr[40] = chars[1];
        Base64ByteToStr[37] = chars[2];
        Base64ByteToStr[58] = chars[3];
        Base64ByteToStr[52] = chars[4];
        for(int i = 0; i <= Base64ByteToStr.length - 1; i++) {
            StrToBase64Byte[Base64ByteToStr[i]] = (byte)i;
        }
    }

    public void showDecoder() throws Exception {
        String str = "";
        for(int i = 1; i <= StrToBase64Byte.length; i++) {
            str += (int)StrToBase64Byte[i - 1] + ",";
            if(i % 10 == 0 || i == StrToBase64Byte.length) {
                logger.info(str);
                str = "";
            }
        }
    }

    public String Base64Encode(byte[] bytes) throws Exception {
        StringBuilder res = new StringBuilder();
        //per 3 bytes scan and switch to 4 bytes
        for(int i = 0; i <= bytes.length - 1; i+=3) {
            byte[] enBytes = new byte[4];
            byte tmp = (byte)0x00;// save the right move bit to next position's bit
            //3 bytes to 4 bytes
            for(int k = 0; k <= 2; k++) {// 0 ~ 2 is a line
                if((i + k) <= bytes.length - 1) {
                    enBytes[k] = (byte) (((((int) bytes[i + k] & RANGE) >>> (2 + 2 * k))) | (int)tmp);//note , we only get 0 ~ 127 ???
                    tmp = (byte) (((((int) bytes[i + k] & RANGE) << (2 + 2 * (2 - k))) & RANGE) >>> 2);
                } else {
                    enBytes[k] = tmp;
                    tmp = (byte)64;//if tmp > 64 then the char is '=' hen '=' -> byte is -1 , so it is EOF or not print char
                }
            }
            enBytes[3] = tmp;//forth byte
            //4 bytes to encode string
            for (int k = 0; k <= 3; k++) {
                if((int)enBytes[k] <= 63) {
                    res.append(Base64ByteToStr[(int)enBytes[k]]);
                } else {
                    res.append('=');
                }
            }
        }
        return res.toString();
    }

    public byte[] Base64Decode(String val) throws Exception {
        ByteArrayOutputStream bos = new ByteArrayOutputStream();//destination bytes, valid string that we want
        byte[] srcBytes = val.getBytes();
        byte[] base64bytes = new byte[srcBytes.length];
        //get the base64 bytes (the value is -1 or 0 ~ 63)
        for(int i = 0; i <= srcBytes.length - 1; i++) {
            int ind = (int) srcBytes[i];
            base64bytes[i] = StrToBase64Byte[ind];
        }
        //base64 bytes (4 bytes) to normal bytes (3 bytes)
        for(int i = 0; i <= base64bytes.length - 1; i+=4) {
            byte[] deBytes = new byte[3];
            int delen = 0;// if basebytes[i] = -1, then debytes not append this value
            byte tmp ;
            for(int k = 0; k <= 2; k++) {
                if((i + k + 1) <= base64bytes.length - 1 && base64bytes[i + k + 1] >= 0) {
                    tmp = (byte) (((int)base64bytes[i + k + 1] & RANGE) >>> (2 + 2 * (2 - (k + 1))));
                    deBytes[k] = (byte) ((((int) base64bytes[i + k] & RANGE) << (2 + 2 * k) & RANGE) | (int) tmp);
                    delen++;
                }
            }
            for(int k = 0; k <= delen - 1; k++) {
                bos.write((int)deBytes[k]);
            }
        }
        return bos.toByteArray();
    }

    public static void main(String[] args) throws Exception {
        Base64Util nb = new Base64Util();
        nb.generateDecoder("Ge960");
        //zSN48SD00R
        //source:zSN48SD00R
        //encoder:o9DkD2rJH2KmCq==
        //decoder:zSN48SD00R
        String srcStr = "zSN48SD00R";
        System.out.println(" source:" + srcStr);
        String enStr = nb.Base64Encode(srcStr.getBytes());
        System.out.println("encoder:" + enStr);
        String deStr = new String(nb.Base64Decode("o9DkD2rJH2KmCq=="));
        System.out.println("decoder:" + deStr);
    }
}
