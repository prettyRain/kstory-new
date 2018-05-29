package com.ningpai.utils;

import com.ningpai.customer.service.CustomerServiceMapper;
import com.ningpai.other.bean.CustomerAllInfo;
import org.apache.commons.lang.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.*;

/**
 * Created by Administrator on 2018/5/4.
 */
public class TaskUtils extends TimerTask {
    public HttpServletRequest request;
    public HttpServletResponse response;
    public CustomerServiceMapper customerServiceMapper;
    public Timer timer;
    public TaskUtils(Timer timer,CustomerServiceMapper customerServiceMapper,HttpServletRequest request,HttpServletResponse response){
        this.timer = timer;
        this.customerServiceMapper = customerServiceMapper;
        this.request = request;
        this.response = response;
    }
    //当前页
    public int pageNo = 1;
    //每页查询
    public int pageSize = 100;
    /**
     * The action to be performed by this timer task.
     */
    @Override
    public void run() {
        Map map = new HashMap<>();
        map.put("startNumber",(pageNo-1)*pageSize);
        map.put("endNumber",pageNo*pageSize);
        pageNo++;
        //一次最多查询一百条数据
        List<CustomerAllInfo> list = customerServiceMapper.selectAllCustmerinfo(map);
        if(list==null || list.size()<=0){
            this.timer.cancel();
            System.out.println("---------------------------------补入地址结束了");
            try {
                PrintWriter writer = response.getWriter();
                writer.print("showTipAlert('补入完成')");
            }catch (Exception e){
                e.printStackTrace();
            }
            return;
        }

         for(CustomerAllInfo info:list){
             if(info.getLoginIp()!=null){
                 String provincename = customerServiceMapper.getProvinceByIP(request,info.getLoginIp());
                 if(StringUtils.isNotBlank(provincename)){
                     Long provinceId = customerServiceMapper.getProvinceIdByName(provincename);
                     info.setInfoProvince(provinceId.toString());
                     customerServiceMapper.updateCustomer(info);
                 }
             }
         }

    }

}
