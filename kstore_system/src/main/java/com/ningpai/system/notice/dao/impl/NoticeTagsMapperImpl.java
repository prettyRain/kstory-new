/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */
/**
 * 
 */
package com.ningpai.system.notice.dao.impl;

import com.ningpai.manager.base.BasicSqlSupport;
import com.ningpai.system.notice.bean.NoticeTags;
import com.ningpai.system.notice.dao.NoticeTagsMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * DAO实现类-消息通知
 *
 * @author dll
 * @since 2018年01月29日
 */
@Repository("NoticeTagsMapper")
public class NoticeTagsMapperImpl extends BasicSqlSupport implements NoticeTagsMapper {

    /*
     * 
     * 
     * @see com.ningpai.system.mobile.dao.MobSiteBasicMapper#deleteByPrimaryKey(java.lang.Long)
     */
    @Override
    public int removeTags() {

        return this.delete("com.ningpai.system.notice.dao.NoticeTagsMapper.removeTags");
    }

    /*
     * 
     * 
     * @see com.ningpai.system.mobile.dao.MobSiteBasicMapper#insert(com.ningpai.system.mobile.bean.MobSiteBasic)
     */
    @Override
    public int insertTags(NoticeTags noticeTags) {

        return this.insert("com.ningpai.system.notice.dao.NoticeTagsMapper.insertTags", noticeTags);
    }

    @Override
    public List<NoticeTags> findNoticeTags() {
        return this.selectList("com.ningpai.system.notice.dao.NoticeTagsMapper.findNoticeTags");
    }


}
