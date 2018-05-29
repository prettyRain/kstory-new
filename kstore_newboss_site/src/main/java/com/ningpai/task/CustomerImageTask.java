package com.ningpai.task;

import com.ningpai.customer.bean.AvatarNotice;
import com.ningpai.customer.bean.Customer;
import com.ningpai.customer.service.CustomerServiceMapper;
import com.ningpai.util.AliSyncImageFilter;
import com.ningpai.util.PageBean;
import com.ningpai.util.RemoveServerImage;
import com.ningpai.util.TaskScheduler;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 调用阿里绿网对用户头像进行验证 1分钟自动执行 每次处理10张图片
 * 验证结果：
 * 1、正常图片，更新数据库用户的用户头像；
 * 2、需要人工审核，更新数据库用户的待审核头像，由Boss后台人工处理；
 * 3、图片违规，直接从服务器上删掉该图片
 * Created by dll on 2017/6/9.
 */
@Service
public class CustomerImageTask implements Runnable {

    @Autowired
    private CustomerServiceMapper customerServiceMapper;

    public CustomerImageTask() {
        TaskScheduler.register(getClass().getSimpleName(), this, 30, 60);
    }

    @Override
    public void run() {
        System.out.println("-------开始自动请求阿里绿网验证用户头像");
        try {
            //按照每组10条信息需要验证的图片信息
            PageBean pb = new PageBean();pb.setPageNo(1);
            Customer customer = null;
            Map<String, Object> map = new HashMap<>();
            List<Object> objects = customerServiceMapper.selectAllCustmerImg(pb).getList();
            if(CollectionUtils.isEmpty(objects)){
                return;
            }
            for(Object obj: objects){
                customer = (Customer)obj;
                if(StringUtils.isEmpty(customer.getToAuditImg())){
                    return;
                }
                //开始验证图片并返回结果
                String result = AliSyncImageFilter.checkImage(customer.getToAuditImg());
                System.out.println("result:"+result);
                map.put("customerIds", new Long[]{customer.getCustomerId()});
                map.put("auditPersion", "系统");
                if(("pass").equals(result)){
                    //正常图片 更新到数据库用户头像
                    map.put("mark", 1);
                    customerServiceMapper.auditImg(map);
                    //添加消息
                    AvatarNotice avatarNotice=new AvatarNotice();
                    avatarNotice.setCustomerId(customer.getCustomerId());
                    avatarNotice.setIsRead("0");
                    avatarNotice.setNoticeTitle("头像审核通过");
                    avatarNotice.setNoticeContent("您新上传的头像已审核通过，快去看一看吧！");
                    avatarNotice.setCreateTime(new Date());
                    this.customerServiceMapper.addAvatarNatice(avatarNotice);
                }else if(("review").equals(result)){
                    //需要人工审核的图片 此处不做处理
                    System.out.println("需要人工审核的图片："+customer.getToAuditImg());
                }else if(("block").equals(result)){
                    //违规图片 删除数据库中待审核用户头像且删除服务器上的图片
                    System.out.println("违规图片："+customer.getToAuditImg());
                    map.put("mark", 2);
                    int n = customerServiceMapper.auditImg(map);
                    if(n == 1){
                        RemoveServerImage.execute(new String[]{customer.getToAuditImg()});
                        RemoveServerImage.execute(new String[]{customer.getToAuditImg()});
                    }
                    //添加消息
                    AvatarNotice avatarNotice=new AvatarNotice();
                    avatarNotice.setCustomerId(customer.getCustomerId());
                    avatarNotice.setIsRead("0");
                    avatarNotice.setNoticeTitle("头像审核未通过");
                    avatarNotice.setNoticeContent("您新上传的头像未通过审核，请重新上传！");
                    avatarNotice.setCreateTime(new Date());
                    this.customerServiceMapper.addAvatarNatice(avatarNotice);
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
