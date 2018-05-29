package com.ningpai.task;

import com.ningpai.customer.bean.InsideLetter;
import com.ningpai.customer.dao.CustomerMapper;
import com.ningpai.customer.dao.InsideLetterMapper;
import com.ningpai.system.notice.bean.Notice;
import com.ningpai.system.notice.dao.NoticeMapper;
import com.ningpai.util.TaskScheduler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * 消息通知同步到商城消息中
 */
@Service
public class CustomerNoticeTask implements Runnable {

    private static int noticeCount = 1;//通知查询数量
    private static int customerCount = 1000;//通知查询数量

    @Autowired
    private InsideLetterMapper insideletter;
    @Autowired
    private NoticeMapper noticeMapper;
    @Autowired
    private CustomerMapper customerMapper;

    public CustomerNoticeTask() {
        //TaskScheduler.register(getClass().getSimpleName(), this, 30, 60);
    }

    @Override
    public void run() {
         System.out.println("-------开始自动插入用户商城消息");
        try{
            Map<String,Object> map = new HashMap<String,Object>();
            map.put("pushStatus",0);
            map.put("platform",-1);
            map.put("time",1);
            map.put("crowdMark","Reg.ID");
            //获取未插入商城消息的通知数量
            int noInsertCount = noticeMapper.selectCountNotice(map);
            if(noInsertCount > 0){
                map.put("startRowNum", 0);
                map.put("endRowNum", noticeCount);
                //获取未插入商城消息的通知
                List<Object> noticeLists = this.noticeMapper.selectByPageBean(map);
                if(noticeLists.size() > 0){
                    map.clear();
                    //rows % pageSize == 0 ? rows / pageSize : rows / pageSize + 1
                    List<Integer> customerIds = null;
                    List<InsideLetter> insideLetterList = null;
                    Notice notice = null;
                    for(Object object : noticeLists){
                        notice = (Notice) object;
                        map.put("startRowNum",  notice.getTempNum());
                        map.put("endRowNum", customerCount);
                        if(notice.getCrowd().contains("Tags")){
                            //按用户标签插入消息
                            String tags = notice.getCrowd().split("：")[1];
                            map.put("tags", tags);
                            map.put("tagsArray", Arrays.asList(tags.split(";")));
                            customerIds = customerMapper.selectCustomerAllID(map);
                        }else{
                            //全部用户
                            customerIds = customerMapper.selectCustomerAllID(map);
                        }
                        int countAll = customerMapper.countCustomerAllID(map);
                        if(customerIds.size() > 0){
                            if(notice.getUrl().indexOf("WebURL") > -1){
                                notice.setUrl(notice.getUrl().split("-")[1]);
                            }else if(notice.getUrl().indexOf("GoodsDetail") > -1){
                                notice.setUrl("item-"+notice.getUrl().split("-")[1]);
                            }else if(notice.getUrl().indexOf("GoodsList") > -1){
                                notice.setUrl("list-"+notice.getUrl().split("-")[1]);
                            }
                            insideLetterList = new ArrayList<InsideLetter>();;
                            for(Integer cid : customerIds){
                                InsideLetter insideLetter = new InsideLetter();
                                insideLetter.setLetterTitle(notice.getTitle());
                                insideLetter.setLetterContent(notice.getContent());
                                insideLetter.setReceiveCustomerId(cid.longValue());
                                insideLetter.setHrefUrl(notice.getUrl());
                                insideLetter.setPcUrl(notice.getUrl());
                                insideLetter.setNoticeId(notice.getId());
                                insideLetterList.add(insideLetter);
                            }
                            int n = insideletter.insertNotices(insideLetterList);
                            Long noticeCount = insideletter.findNoticeCount(notice.getId());
                            if(n == customerIds.size()){
                                if(noticeCount == countAll){
                                    notice.setTempNum(countAll);
                                    notice.setPushStatus(2);//发送完成
                                }else{
                                    notice.setTempNum(notice.getTempNum() + 1);
                                    notice.setPushStatus(1);//正在发送
                                }
                                noticeMapper.updateNotice(notice);
                            }
                        }
                    }
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

}
