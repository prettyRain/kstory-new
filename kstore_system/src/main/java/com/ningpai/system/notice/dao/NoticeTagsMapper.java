package com.ningpai.system.notice.dao;

import com.ningpai.system.notice.bean.NoticeTags;

import java.util.List;

/**
 * SERVICE-消息通知标签
 *
 * @author dll
 * @since 2018年01月29日
 */
public interface NoticeTagsMapper {

    int removeTags();

    int insertTags(NoticeTags noticeTags);

    List<NoticeTags> findNoticeTags();


}
