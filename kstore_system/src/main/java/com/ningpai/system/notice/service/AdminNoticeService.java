/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */
/**
 * 
 */
package com.ningpai.system.notice.service;

import com.ningpai.system.notice.bean.Notice;
import com.ningpai.system.notice.bean.NoticeTags;
import com.ningpai.util.PageBean;

import javax.xml.crypto.Data;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * SERVICE-消息通知
 * 
 * @author dll
 * @since 2018年01月30日
 */
public interface AdminNoticeService {

    /**
     * 更新消息通知标签
     * @return
     */
    int getNoticeTags();

    /**
     * 获取消息通知标签
     * @return
     */
    List<NoticeTags> findNoticeTags();

    /**
     * 保存消息通知
     * @param notice
     * @return
     */
    int saveNotice(Notice notice);

    /**
     * 分页获取推送通知列表
     * @param pb
     * @param map
     * @return
     */
    PageBean selectNoticeByPageBean(PageBean pb, Map<String,Object> map);

    int deleteNotice(String scheduleId);




}
