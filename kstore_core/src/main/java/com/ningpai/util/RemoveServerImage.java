package com.ningpai.util;

import java.io.File;
import java.io.InputStream;
import java.util.Properties;

/**
 * 删除服务器上图片
 * Created by dll on 2017/6/9.
 */
public class RemoveServerImage {

    public static void execute(String[] relate) {
        try {
            //获取配置文件
            InputStream in = RemoveServerImage.class.getResourceAsStream("/com/ningpai/web/config/upload.properties");
            Properties pro = new Properties();
            pro.load(in);
            //图片根路径
            String path = (String) pro.get("DELPATH");
            if (relate.length > 0) {
                for (String str : relate) {
                    //判断是不是又拍云
                    if (!str.contains("upaiyun")) {
                        String onePath = str.substring(str.indexOf("upload/") + 7, str.indexOf("upload/") + 15);
                        String twoPath = str.substring(str.lastIndexOf("/") + 1, str.lastIndexOf("/") + 14);
                        //获取四个图片对象
                        File file = new File(path + "/" + onePath);
                        File fileBig = new File(path + "/" + onePath + "/" + twoPath + ".jpg");
                        File fileSmallOne = new File(path + "/" + onePath + "/" + twoPath + "!56.jpg");
                        File fileSmallTwo = new File(path + "/" + onePath + "/" + twoPath + "!160.jpg");
                        File fileSmallThree = new File(path + "/" + onePath + "/" + twoPath + "!352.jpg");
                        // 在服务器 删除图片
                        if (fileBig.exists()) {
                            fileBig.delete();
                            fileSmallOne.delete();
                            fileSmallTwo.delete();
                            fileSmallThree.delete();
                            File[] files = file.listFiles();
                            if (files.length == 0) {
                                file.delete();
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
