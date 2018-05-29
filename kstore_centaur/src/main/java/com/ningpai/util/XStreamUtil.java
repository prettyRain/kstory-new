package com.ningpai.util;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

import javax.servlet.http.HttpServletResponse;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;

/**
 * 工具类
 *
 * @author ggn
 *
 */
public class XStreamUtil {

    /**
     * 构造
     */
    private XStreamUtil() {
    }

    /**
     * Bean 转换XML
     *
     * @param object
     * @return
     */
    public static String BeanToXml(Object object) {
        XStream xStream = new XStream(new DomDriver());
        xStream.autodetectAnnotations(true);
        return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + xStream.toXML(object);
    }

    /**
     * 返回给页面xml
     *
     * @param object
     * @return
     */
    public static void responseXml(HttpServletResponse response, Object object) {
        XStream xStream = new XStream(new DomDriver());
        xStream.autodetectAnnotations(true);
        String xml =  "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + xStream.toXML(object);
        BufferedWriter out = null;
        try
        {
            out = new BufferedWriter(new OutputStreamWriter(response.getOutputStream(), "UTF-8"));
            out.write(xml.toString());
            out.flush();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            try
            {
                if (out != null)
                {
                    out.close();
                    out = null;
                }
            }
            catch (IOException e)
            {
                out = null;
            }
        }
    }

}
