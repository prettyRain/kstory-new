package com.ningpai.system.notice.controller;

import com.ningpai.system.controller.BaseController;
import com.ningpai.system.mobile.service.MobSiteBasicService;
import com.ningpai.system.notice.bean.Notice;
import com.ningpai.system.notice.bean.NoticeTags;
import com.ningpai.system.notice.service.AdminNoticeService;
import com.ningpai.util.PageBean;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 消息通知
 * Created by Administrator on 2018/1/26.
 */
@Controller
public class AdminNoticeController extends BaseController {

    @Resource(name = "MobSiteBasicService")
    private MobSiteBasicService mobSiteBasicService;

    @Resource(name = "AdminNoticeService")
    private AdminNoticeService adminNoticeService;

    @RequestMapping("/noticeList")
    public ModelAndView noticeList(PageBean pb,Long platform,String crowd,Long sendType,String content) {

        ModelAndView mav = new ModelAndView();
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("platform",platform == null ? 0 : platform);
        map.put("crowd",crowd);
        map.put("sendType",sendType);
        map.put("content",content);
        map.put("pushStatus",-1);
        map.put("platform",platform == null ? -1 : platform);
        mav.addObject("pageBean",adminNoticeService.selectNoticeByPageBean(pb, map));
        mav.addObject("platform",platform);
        mav.addObject("crowd",crowd);
        mav.addObject("sendType",sendType);
        mav.addObject("content",content);
        mav.setViewName("jsp/notice/list");
        return mav;
    }

    @RequestMapping("/noticeAdd")
    public ModelAndView noticeAdd() {

        ModelAndView mav = new ModelAndView();
        List<NoticeTags> tags = adminNoticeService.findNoticeTags();
        mav.addObject("tags",tags);
        mav.setViewName("jsp/notice/add");
        return mav;
    }

    @RequestMapping("/noticeTags")
    public ModelAndView noticeTags() {
        ModelAndView mav = new ModelAndView();
        mav.addObject("tags",adminNoticeService.findNoticeTags());
        mav.setViewName("jsp/notice/tags_list");
        return mav;
    }


    @RequestMapping("/ajaxGetNoticeTags")
    @ResponseBody
    public int ajaxGetNoticeTags() {

        return adminNoticeService.getNoticeTags();
    }

    @RequestMapping(value = "/ajaxSaveNotice",method = RequestMethod.POST)
    @ResponseBody
    public int ajaxSaveNotice(HttpServletRequest request,@RequestBody Notice notice) {

        String userName = request.getSession().getAttribute("name").toString();
        notice.setAddPerson(userName);

        return adminNoticeService.saveNotice(notice);
    }

    @RequestMapping(value = "/ajaxDeleteNotice",method = RequestMethod.POST)
    @ResponseBody
    public int ajaxDeleteNotice(@RequestParam String scheduleId) {

        return adminNoticeService.deleteNotice(scheduleId);
    }


}
