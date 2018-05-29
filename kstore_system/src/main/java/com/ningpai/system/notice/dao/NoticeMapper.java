package com.ningpai.system.notice.dao;

import com.ningpai.system.notice.bean.Notice;
import com.ningpai.system.notice.bean.NoticeTags;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * DAO-消息通知
 * 
 * @author dll
 * @since 2018/01/30
 */
public interface NoticeMapper {

    int insertNotice(Notice notice);

    List<Notice> findAll();

    int selectCountNotice(Map<String,Object> map);

    List<Object> selectByPageBean(Map<String, Object> map);

    int updateNotice(Notice notice);
}
