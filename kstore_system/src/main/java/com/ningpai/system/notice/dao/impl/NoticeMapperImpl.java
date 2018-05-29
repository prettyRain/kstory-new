/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */
/**
 * 
 */
package com.ningpai.system.notice.dao.impl;

import com.ningpai.manager.base.BasicSqlSupport;
import com.ningpai.system.notice.bean.Notice;
import com.ningpai.system.notice.bean.NoticeTags;
import com.ningpai.system.notice.dao.NoticeMapper;
import com.ningpai.system.notice.dao.NoticeTagsMapper;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * DAO实现类-消息通知
 * @author dll
 * @since 2018/01/30
 */
@Repository("NoticeMapper")
public class NoticeMapperImpl extends BasicSqlSupport implements NoticeMapper {


    @Override
    public int insertNotice(Notice notice) {

        return this.insert("com.ningpai.system.notice.dao.NoticeMapper.insertNotice", notice);
    }

    @Override
    public List<Notice> findAll() {
        return this.selectList("com.ningpai.system.notice.dao.NoticeMapper.findAll");
    }

    @Override
    public int selectCountNotice(Map<String, Object> map) {
        return this.selectOne("com.ningpai.system.notice.dao.NoticeMapper.selectCountNotice", map);
    }

    @Override
    public List<Object> selectByPageBean(Map<String, Object> map) {
        return this.selectList("com.ningpai.system.notice.dao.NoticeMapper.selectByPageBean", map);
    }

    @Override
    public int updateNotice(Notice notice) {
        return this.update("com.ningpai.system.notice.dao.NoticeMapper.updateNotice",notice);
    }


}
