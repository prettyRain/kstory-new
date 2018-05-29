package com.ningpai.community.controller;

import com.ningpai.community.bean.CommunityStore;
import com.ningpai.community.service.CommunityStoreService;
import com.ningpai.util.PageBean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 社区店管理控制器
 * Created by hehu on 2017/2/20.
 */
@Controller
public class CommunityStoreController {

    @Resource(name = "CommunityStoreService")
    private CommunityStoreService communityStoreService;

    /**
     * 社区店列表
     * @param pageBean
     * @param store 查询条件
     * @return
     */
    @RequestMapping("queryCommunityStores")
    public ModelAndView queryCommunityStores(PageBean pageBean,CommunityStore store) {
        return new ModelAndView("jsp/system/community/community_stores").addObject("pageBean",communityStoreService.selectList(store,pageBean));
    }

    /**
     * 添加社区店
     * @param store
     * @return
     */
    @RequestMapping("addCommunityStore")
    public ModelAndView addCommunityStore(CommunityStore store) {
        communityStoreService.insert(store);
        return new ModelAndView("redirect:queryCommunityStores.htm");
    }

    /**
     * 修改社区店
     * @param store
     * @return
     */
    @RequestMapping("updateCommunityStore")
    public ModelAndView updateCommunityStore(CommunityStore store) {
        communityStoreService.update(store);
        return new ModelAndView("redirect:queryCommunityStores.htm");
    }

    /**
     * 删除社区店
     * @param communityStoreId
     * @return
     */
    @RequestMapping("deleteCommunityStore")
    @ResponseBody
    public Map<String,Object> deleteCommunityStore(Long communityStoreId) {
        Map<String,Object> resultMap = new HashMap<>();
        resultMap.put("result",communityStoreService.delete(communityStoreId));
        return resultMap;
    }

    /**
     * 批量删除社区店
     * @param communityStoreIds
     * @return
     */
    @RequestMapping("deleteCommunityStores")
    public ModelAndView deleteCommunityStores(Long[] communityStoreIds) {
        if(communityStoreIds==null) {
            return null;
        }
        Map<String,Object> resultMap = new HashMap<>();
        for(Long communityStoreId:communityStoreIds) {
            communityStoreService.delete(communityStoreId);
        }
        return new ModelAndView("redirect:queryCommunityStores.htm");
    }

    /**
     * 根据主键查询社区店信息
     * @param communityStoreId
     * @return
     */
    @RequestMapping("selectCommunityStore")
    @ResponseBody
    public CommunityStore selectCommunityStore(Long communityStoreId) {
        return communityStoreService.select(communityStoreId);
    }
    /**
     * 根据主键查询社区店详细信息
     * @param communityStoreId
     * @return
     */
    @RequestMapping("selectCommunityStoreVo")
    @ResponseBody
    public CommunityStore selectCommunityStoreVo(Long communityStoreId) {
        return communityStoreService.selectVo(communityStoreId);
    }

    @RequestMapping("loadAllCommunityStores")
    @ResponseBody
    public List<CommunityStore> loadAllCommunityStores(Long districtId) {
        return communityStoreService.loadAllCommunityStores(districtId);
    }



}
