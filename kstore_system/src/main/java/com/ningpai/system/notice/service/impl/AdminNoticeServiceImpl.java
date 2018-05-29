/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */
/**
 * 
 */
package com.ningpai.system.notice.service.impl;

import cn.jpush.api.push.PushResult;
import cn.jpush.api.schedule.ScheduleResult;
import com.ningpai.system.notice.JiguangPush;
import com.ningpai.system.notice.JiguangSchedulePush;
import com.ningpai.system.notice.bean.Notice;
import com.ningpai.system.notice.bean.NoticeTags;
import com.ningpai.system.notice.dao.NoticeMapper;
import com.ningpai.system.notice.dao.NoticeTagsMapper;
import com.ningpai.system.notice.service.AdminNoticeService;
import com.ningpai.util.PageBean;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * SERVICE实体类-消息推送
 * 
 * @author dll
 * @since 2018年01月29日下午
 */
@Service("AdminNoticeService")
public class AdminNoticeServiceImpl implements AdminNoticeService {

    @Resource(name = "NoticeTagsMapper")
    private NoticeTagsMapper noticeTagsMapper;

    @Resource(name = "NoticeMapper")
    private NoticeMapper noticeMapper;


    @Override
    public int getNoticeTags() {
        try {
            List<String> tags = JiguangPush.getPushTags();
            if(tags != null){
                noticeTagsMapper.removeTags();
                for(String tag:tags){
                    noticeTagsMapper.insertTags(new NoticeTags(tag,0,new Date()));
                }
                return 1;
            }

        }catch (Exception e){
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public List<NoticeTags> findNoticeTags() {

        return noticeTagsMapper.findNoticeTags();
    }

    @Override
    public int saveNotice(Notice notice) {

        try {
            notice.setCreateTime(new Date());
            notice.setUpdateTime(new Date());
            notice.setSendTime(new Date());
            if(notice.getSendType() == 2){
                SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                notice.setSendTime(format.parse(notice.getTime()));
            }
            if(StringUtils.isNotEmpty(notice.getUrlType())){
                notice.setUrl(notice.getUrlType() + "-" + notice.getUrl());
            }
            if(notice.getCrowdType() == 2){
                notice.setCrowd("Tags：" +notice.getCrowd());
            }else if(notice.getCrowdType() == 3){
                notice.setCrowd("Reg.ID：" +notice.getRegistration());
            }

            //将消息推送到极光服务器 由极光服务器推送到用户设备
            if(notice.getSendType() == 1){//立即推送
                PushResult result = JiguangPush.push(notice);
                if(result.getResponseCode() == 200){
                    notice.setMsgId(String.valueOf(result.msg_id));
                    notice.setPushStatus(0);
                    noticeMapper.insertNotice(notice);
                    return 1;
                }
            }else if(notice.getSendType() == 2){//定时推送
                ScheduleResult result = JiguangSchedulePush.pushSchedule(notice);
                if(result.getResponseCode() == 200){
                    notice.setMsgId(result.getSchedule_id());
                    notice.setPushStatus(0);
                    noticeMapper.insertNotice(notice);
                    return 1;
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        return 0;
    }

    @Override
    public PageBean selectNoticeByPageBean(PageBean pb, Map<String, Object> map) {
        try {
            /** 设置PageBean的行数 */
            pb.setRows(this.noticeMapper.selectCountNotice(map));
            /** 设置开始行数 */
            map.put("startRowNum", pb.getStartRowNum());
            /** 设置PageBean的行数 */
            map.put("endRowNum", pb.getEndRowNum());
            /** 设置PageBean的集合数据 */
            pb.setList(this.noticeMapper.selectByPageBean(map));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pb;
    }

    @Override
    public int deleteNotice(String scheduleId) {

        try{
            //删除极光服务器定时通知
            JiguangSchedulePush.deleteSchedule(scheduleId);
            //同时修改本地数据库通知为删除状态-1
            Notice notice = new Notice();
            notice.setStatus(-1);
            notice.setMsgId(scheduleId);
            return this.noticeMapper.updateNotice(notice);
        }catch (Exception e){
            e.printStackTrace();
        }
        return 0;
    }
}
