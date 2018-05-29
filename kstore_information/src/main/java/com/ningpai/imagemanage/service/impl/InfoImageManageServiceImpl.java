/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */
/**
 * 
 */
package com.ningpai.imagemanage.service.impl;

import com.ningpai.common.lucene.ikanalyzer.org.wltea.analyzer.cfg.Configuration;
import com.ningpai.imagemanage.bean.InfoImageManage;
import com.ningpai.imagemanage.dao.InfoImageManageMapper;
import com.ningpai.imagemanage.service.InfoImageManageService;
import com.ningpai.system.bean.Floor;
import com.ningpai.util.MyLogger;
import com.ningpai.util.PageBean;
import javafx.scene.control.Slider;
import org.apache.commons.lang.StringUtils;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.jsoup.Jsoup;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

/**
 * SERVICE实现类-资源图片信息
 * 
 * @author NINGPAI-WangHaiYang
 * @since 2014年4月25日下午1:52:56
 */
@Service("InfoImageManageService")
public class InfoImageManageServiceImpl implements InfoImageManageService {

    /** 记录日志对象 */
    private static final MyLogger LOGGER = new MyLogger(InfoImageManageServiceImpl.class);

    private static final String CLASSIFYID = "classifyId";
    private static final String THIRDID = "thirdId";
    private static final String STARTROWNUM = "startRowNum";
    private static final String ENDROWNUM = "endRowNum";
    private static final String LOGGERINFO1 = "分页查询图片信息列表错误:";

    /** 数据访问层依赖 */
    private InfoImageManageMapper ifoImageManageMapper;

    /**
     * 根据主键删除
     * 
     * @param imageManageId
     * @return
     * @see com.ningpai.imagemanage.service.InfoImageManageService#deleteInfoImageManage(java.lang.Long)
     */
    @Override
    public int deleteInfoImageManage(Long imageManageId) {
        try {
            /** 调用dao层方法并返回结果 */
            return ifoImageManageMapper.deleteByPrimaryKey(imageManageId);
        } catch (Exception e) {
            LOGGER.error("删除图片信息错误:", e);
            /** 返回0 */
            return 0;
        }
    }

    /**
     * 添加
     * 
     * @param record
     * @return
     * @see com.ningpai.imagemanage.service.InfoImageManageService#saveInfoImageManage(com.ningpai.imagemanage.bean.InfoImageManage)
     */
    @Override
    public int saveInfoImageManage(InfoImageManage record) {
        try {
            /** 获取当前时间 */
            Date date = new Date();
            /** 设置创建时间为当前时间 */
            record.setCreateDate(date);
            /** 设置更新时间为当前时间 */
            record.setUpdateDate(date);
            /** 返回结果 */
            return ifoImageManageMapper.insertSelective(record);
        } catch (Exception e) {
            LOGGER.error("添加图片信息错误:", e);
            /** 返回0 */
            return 0;
        }
    }

    /**
     * 修改
     * 
     * @param record
     * @return
     * @see com.ningpai.imagemanage.service.InfoImageManageService#updateInfoImageManage
     *      (com.ningpai.imagemanage.bean.InfoImageManage)
     */
    @Override
    public int updateInfoImageManage(InfoImageManage record) {
        try {
            /** 设置更新时间为当前时间 */
            record.setUpdateDate(new Date());
            /** 返回结果 */
            return ifoImageManageMapper.updateByPrimaryKeySelective(record);
        } catch (Exception e) {
            LOGGER.error("修改图片信息错误:", e);
            /** 返回0 */
            return 0;
        }
    }

    /**
     * 根据ID查询
     * 
     * @param imageManageId
     * @return
     * @see com.ningpai.imagemanage.service.InfoImageManageService#getInfoImageManageById
     *      (java.lang.Long)
     */
    @Override
    public InfoImageManage getInfoImageManageById(Long imageManageId) {
        /** 创建对象InfoImageManage */
        InfoImageManage infoImageManage = null;
        try {
            /** 为图片资源对象赋值 */
            infoImageManage = ifoImageManageMapper.selectByPrimaryKey(imageManageId);
        } catch (Exception e) {
            LOGGER.error("根据ID查询图片信息错误:", e);
        }
        /** 返回结果 */
        return infoImageManage;
    }

    /**
     * 根据图片分类查询图片信息总行数
     * 
     * @return
     * @see com.ningpai.imagemanage.service.InfoImageManageService#
     *      selectImageManageCountByClassifyId(java.lang.Long)
     */
    @Override
    public Integer selectImageManageCountByClassifyId(Long classifyId) {
        try {
            /** 定义一个HashMap集合 */
            Map<String, Object> map = new HashMap<String, Object>();
            /** classifyId存在map中 */
            map.put(CLASSIFYID, classifyId);
            /** 调用dao层返回结果 */
            return ifoImageManageMapper.selectImageManageCountByParam(map);
        } catch (Exception e) {
            LOGGER.error("根据类型ID查询图片信息数量错误:", e);
            /** 返回-1 */
            return -1;
        }
    }

    /**
     * 根据图片分类查询图片信息
     * 
     * @param startDate
     *            开始日期
     * @param endDate
     *            结束日期
     * @return
     * @see com.ningpai.imagemanage.service.InfoImageManageService#
     *      selectImageManageByParam(com.ningpai.util.PageBean, java.lang.Long)
     */
    @Override
    public PageBean selectImageManageByParam(PageBean pb, Long classifyId, String startDate, String endDate, Long thirdId) {
        try {
            /** 设置pageBean每页显示8条 */
            pb.setPageSize(8);
            /** 定义HashMap集合 */
            Map<String, Object> map = new HashMap<String, Object>();
            /** map中存放classifyId */
            map.put(CLASSIFYID, classifyId);
            /** map中存放startDate */
            map.put("startDate", startDate);
            /** map中存放endDate */
            map.put("endDate", endDate);
            /** map中存放thirdId */
            map.put(THIRDID, thirdId);
            /** 设置pageBean的行数 */
            pb.setRows(ifoImageManageMapper.selectImageManageCountByParam(map));
            /** map中存放startRowNum开始行数 */
            map.put(STARTROWNUM, pb.getStartRowNum());
            /** map中存放endRowNum结束行数 */
            map.put(ENDROWNUM, pb.getEndRowNum());
            /** 设置pageBean 的集合数据 */
            pb.setList(ifoImageManageMapper.selectImageManageByParam(map));
            /** 返回结果 */
            return pb;
        } catch (Exception e) {
            LOGGER.error(LOGGERINFO1, e);
            /** 返回null */
            return null;
        }
    }

    public InfoImageManageMapper getIfoImageManageMapper() {
        return ifoImageManageMapper;
    }

    @Resource(name = "InfoImageManageMapper")
    public void setIfoImageManageMapper(InfoImageManageMapper ifoImageManageMapper) {
        this.ifoImageManageMapper = ifoImageManageMapper;
    }

    /**
     * 根据第三方ID获取图片信息
     * 
     * @param pb
     * @param thirdId
     * @return
     * @see com.ningpai.imagemanage.service.InfoImageManageService#
     *      selectImageByThirdId(com.ningpai.util.PageBean, java.lang.Long)
     */
    @Override
    public PageBean selectImageByThirdId(PageBean pb, Long thirdId) {
        try {
            /** 定义一个HashMap集合 */
            Map<String, Object> map = new HashMap<String, Object>();
            map.put(THIRDID, thirdId);
            /** 设置pageBean的行数 */
            pb.setRows(ifoImageManageMapper.selectImageManageCountByParam(map));
            map.put(STARTROWNUM, pb.getStartRowNum());
            map.put(ENDROWNUM, pb.getEndRowNum());
            /** 设置pageBean 的集合数据 */
            pb.setList(ifoImageManageMapper.selectImageManageByParam(map));
            /** 返回结果 */
            return pb;
        } catch (Exception e) {
            LOGGER.error(LOGGERINFO1, e);
            /** 返回null */
            return null;
        }
    }

    /**
     * 根据地单方ID和图片编号删除
     * 
     * @param imageManageId
     * @param thirdId
     * @see com.ningpai.imagemanage.service.InfoImageManageService#
     *      updateImage(java.lang.Long, java.lang.Long)
     */
    @Override
    public Integer updateImage(Long imageManageId, Long thirdId) {
        /** 定义一个HashMap集合 */
        Map<String, Object> param = new HashMap<String, Object>();
        /** 将imageManageId存到map中 */
        param.put("imageManageId", imageManageId);
        /** 将thirdId存到map中 */
        param.put(THIRDID, thirdId);
        /** 获取更新结果 count>0代表更新成功 */
        return ifoImageManageMapper.updateImage(param);
    }

    /**
     * 批量删除
     * 
     * @param imageManageIds
     * @param thirdId
     * @see com.ningpai.imagemanage.service.InfoImageManageService#
     *      updateImages(java.lang.Long, java.lang.Long)
     */
    @Override
    public void updateImages(Long[] imageManageIds, Long thirdId) {
        /** 定义一个ArrayList集合 */
        List<Long> imageIds = new ArrayList<Long>();
        /** 循环imageManageIds数组为list赋值 */
        for (int i = 0; i < imageManageIds.length; i++) {
            imageIds.add(imageManageIds[i]);
        }
        try {
            /** 定义一个HashMap集合 */
            Map<String, Object> param = new HashMap<String, Object>();
            /** 将imageId存到map中 */
            param.put("imageId", imageIds);
            /** 将thirdId存到map中 */
            param.put(THIRDID, thirdId);
            /** 根据参数进行更新 */
            ifoImageManageMapper.updateImages(param);
        } finally {
            imageIds = null;
        }
    }

    /**
     * 根据分类和第三方Id查询图片
     * 
     * @param pb
     * @param classifyId
     * @param thirdId
     * @return
     * @see com.ningpai.imagemanage.service.InfoImageManageService#
     *      updateImages(com.ningpai.util.PageBean, java.lang.Long)
     */
    @Override
    public PageBean selectImageManageByParam(PageBean pb, Long classifyId, Long thirdId) {
        try {
            /** 定义一个HashMao集合 */
            Map<String, Object> map = new HashMap<String, Object>();
            /** 将classifyId存到map中 */
            map.put(CLASSIFYID, classifyId);
            /** 将thirdId存到map中 */
            map.put(THIRDID, thirdId);
            /** 设置oageBean的行数 */
            pb.setRows(ifoImageManageMapper.selectImageManageCountByParam(map));
            /** 将startRowNum存到map中 */
            map.put(STARTROWNUM, pb.getStartRowNum());
            /** 将endRowNum存到map中 */
            map.put(ENDROWNUM, pb.getEndRowNum());
            /** 设置PageBean的集合数据 */
            pb.setList(ifoImageManageMapper.selectImageManageByParam(map));
            /** 返回结果 */
            return pb;
        } catch (Exception e) {
            LOGGER.error(LOGGERINFO1, e);
            /** 返回null */
            return null;
        }
    }

    /**
     * xcy 查询表里面的图片
     * @return
     */
    @Override
    public Set queryAllRelateImages() {
        //货品图片表
        List<String> goodsImages=ifoImageManageMapper.queryGoodsImages();
        //频道广告表
        List<String> channelAdverList=ifoImageManageMapper.queryChannelAdverList();
        //频道楼层表 pc
        List<String> channelStoreyList = ifoImageManageMapper.queryChannelStoreyList();
        //频道楼层品牌 pc
        List<String> channelTradeMarkList = ifoImageManageMapper.queryChannelTradeMarkList();
        //子商城商品表 pc
        List<String> channelStoreyGoodsList=ifoImageManageMapper.queryChannelStoreyGoodsList();
        //商品表
        List<String> goodsList=ifoImageManageMapper.queryGoodsList();
        //商品 描述表 11(商品详情 规格详情 包装详情 品牌详情)
        List<String> goodsDescList=ifoImageManageMapper.queryCoodsDesc();
        //货品表
        List<String> goodsInfoList=ifoImageManageMapper.queryGoodsInfoList();
        //抢购表
        List<String> marketingRushList=ifoImageManageMapper.queryMarketingRushList();
        //移动分类导航表
        List<String> mobCateBarList=ifoImageManageMapper.queryMobCateBarList();
        //wap版 首页内容 11
        List<String> mobHomePageList=ifoImageManageMapper.queryMobHomePageList();
        //商城网站的LOGO
        List<String> sysBasicsetList=ifoImageManageMapper.querySysBasicsetList();
        //PC 首页用到的模板
        List<String> sysTempList=ifoImageManageMapper.querySysTempList();
        //用户头像
        List<String> customerList=ifoImageManageMapper.queryCustomerList();
        //晒单图片
        List<String> shareImgList=ifoImageManageMapper.queryShareImgList();
        //后台网页logo
        List<String> sysBasicList=ifoImageManageMapper.querySysBasicList();
        //把wap 首页内容 修改成需要的格式 放到此集合中
        List<String> elemtList=new ArrayList<>();
        //友情链接logo
        List<String> sysLinks=this.ifoImageManageMapper.getSysLink();

        //pc端分类导航表
        List<String> sysClassifyBar = this.ifoImageManageMapper.querySysClassifyBarList();

        //如果wap端首页的内容不为空
        if(mobHomePageList!=null && mobHomePageList.size()>0){
            for(String str:mobHomePageList){
                try {
                    //把字符串变成document  用dom4j 解析
                    Document document=DocumentHelper.parseText(str);

                    Element rootElement=document.getRootElement();
                    List<Element> elementList=rootElement.elements();
                    //用递归查询出所有的img标签
                    findElements(elemtList,elementList);
                    /*for(Element element:elementList){
                        //获取轮播图
                        if("roll_adv".equals(element.getName())){
                            List<Element> elementList1=element.elements();
                            for(Element element1:elementList1){
                                String srcAttribute=element1.element("img").attributeValue("src").toString();
                                if(StringUtils.isNotBlank(srcAttribute))
                                elemtList.add(srcAttribute.substring(srcAttribute.lastIndexOf("/")+1,srcAttribute.lastIndexOf("/")+14));
                            }//获取图片导航  即专题图片
                        }else if("imagenav".equals(element.getName())){
                            List<Element> elementList2=element.elements();
                            for(Element element2:elementList2){

                                String srcAttribute=element2.element("img").attributeValue("src");
                                if(StringUtils.isNotBlank(srcAttribute))
                                elemtList.add(srcAttribute.substring(srcAttribute.lastIndexOf("/")+1,srcAttribute.lastIndexOf("/")+14));
                            }
                        }
                    }*/

                }catch (Exception e){
                    e.printStackTrace();
                }
            }
        }
        if(goodsDescList!=null && goodsDescList.size()>0){
            for(String goodsDesc:goodsDescList){
                if(StringUtils.isNotBlank(goodsDesc)){
                   //字符串转换成 html的Document 并解析
                    getContents(goodsList,goodsDesc);
                }
            }
        }


        Set allRelateImages=new TreeSet();
        if(goodsImages!=null&& goodsImages.size()>0){
            allRelateImages.addAll(goodsImages);
        }
        if(channelAdverList!=null && channelAdverList.size()>0){
            allRelateImages.addAll(channelAdverList);
        }
        if(channelStoreyList!=null && channelStoreyList.size()>0){
            allRelateImages.addAll(channelStoreyList);
        }
        if(channelTradeMarkList!=null && channelTradeMarkList.size()>0){
            allRelateImages.addAll(channelTradeMarkList);
        }
        if(channelStoreyGoodsList!=null && channelStoreyGoodsList.size()>0){
            allRelateImages.addAll(channelStoreyGoodsList);
        }
        if(goodsList!=null && goodsList.size()>0){
            allRelateImages.addAll(goodsList);
        }
        if(goodsInfoList!=null && goodsInfoList.size()>0){
            allRelateImages.addAll(goodsInfoList);
        }
        if(marketingRushList!=null && marketingRushList.size()>0){
            allRelateImages.addAll(marketingRushList);
        }
        if(mobCateBarList!=null&&mobCateBarList.size()>0){
            allRelateImages.addAll(mobCateBarList);
        }
        if(sysBasicsetList!=null && sysBasicsetList.size()>0){
            allRelateImages.addAll(sysBasicsetList);
        }
        if(sysBasicList!=null && sysBasicList.size()>0){
            allRelateImages.addAll(sysBasicList);
        }

        if(sysTempList!=null && sysTempList.size()>0){
            allRelateImages.addAll(sysTempList);
        }
        if(customerList!=null && customerList.size()>0){
            allRelateImages.addAll(customerList);
        }
        if(shareImgList!=null && shareImgList.size()>0){
            allRelateImages.addAll(shareImgList);
        }
        if(elemtList !=null && elemtList.size()>0){
            allRelateImages.addAll(elemtList);
        }
        if(sysLinks !=null && sysLinks.size()>0){
            allRelateImages.addAll(sysLinks);
        }
        if(sysClassifyBar !=null && sysClassifyBar.size()>0){
            allRelateImages.addAll(sysClassifyBar);
        }
        return allRelateImages;
    }

    public void findElements(List elementsimgList,List<Element> elementList){
           if(elementList.size()>0){
               for(Element element:elementList) {
                   Element imgElement = element.element("img");
                   if(imgElement!=null){
                       String srcAttribute = imgElement.attributeValue("src").toString();
                       if (StringUtils.isNotBlank(srcAttribute)) {
                           elementsimgList.add(srcAttribute.substring(srcAttribute.lastIndexOf("/") + 1, srcAttribute.lastIndexOf("/") + 14));
                       }
                   }

                   if(element.elements().size()>0){
                       findElements(elementsimgList,element.elements());
                   }else{
                       continue;
                   };
               }
           }
    }
    /**
     * 返回图片库的所有图片
     * @return
     */
    @Override
    public List queryAllImages() {
        List allList=ifoImageManageMapper.queryAllImages();
        return allList;
    }

    /**
     * 修改未关联的表
     * @param queryMap
     */
    @Override
    public void uploadImagesByQueryMap(Map queryMap) {
          this.ifoImageManageMapper.uploadImagesByQueryMap(queryMap);
    }
    //查询未关联的图
    @Override
    public Map ajaxQueryRetaleImag(PageBean pb, String startDate, String endDate) {
        //查询未关联的总条数
        Map countMap=new HashMap();
        countMap.put("startDate",startDate);
        countMap.put("endDate",endDate);
        Integer totalCount=this.ifoImageManageMapper.queryTotalImagCount(countMap);
        //总页数
        Integer totalPage=totalCount%pb.getPageSize()==0?totalCount/pb.getPageSize():(totalCount/pb.getPageSize()+1);
        Integer pageSize=pb.getPageSize();
        Integer pageNo=pb.getPageNo();
        pb.setStartNo((pageNo-1)*pageSize);
        pb.setEndNo(pageSize);
        pb.setTotalPages(totalPage);
        Map map=new HashMap();
        map.put("pb",pb);
        map.put("startNo",(pageNo-1)*pageSize);
        map.put("endNo",pageSize);
        map.put("startDate",startDate);
        map.put("endDate",endDate);
        //根据分页查询当前页的未关联的图
        List<InfoImageManage> imageManageList=this.ifoImageManageMapper.ajaxQueryRetaleImag(map);
        Map resultMap=new HashMap();
        resultMap.put("pb",pb);
        resultMap.put("imageManageList",imageManageList);
        resultMap.put("totalPages",totalPage);
        return resultMap;
    }

    /**
     * 删除 图片
     * @param infoImageManageId
     */
    @Override
    public void deleteRelateInfoImageManager(String infoImageManageId) {
        this.ifoImageManageMapper.deleteRelateInfoImageManager(infoImageManageId);
    }

    public Set queryAllUrl(){
        Set relateImagges=queryAllRelateImages();
        //退单 图片（上传的认证）
         List<String> backOrderImgs=this.ifoImageManageMapper.getBackOrderImgs();
         List<String> backOrderImgss=new ArrayList<String>();
         if(backOrderImgs!=null && backOrderImgs.size()>0){
             for(String str:backOrderImgs){
                 String[] arr=str.split(",");
                 if(arr.length>0 && arr!=null){
                     for(int i=0 ; i<arr.length ; i++){
                         if(StringUtils.isNotBlank(arr[i])){
                             backOrderImgss.add(arr[i].substring(arr[i].lastIndexOf("/")+1,arr[i].lastIndexOf("/")+14));
                         }
                     }
                 }
             }
         }
        //标题图片
        List<String> informationOnePageImgs=this.ifoImageManageMapper.getInformationOnePageImgs();
        //标题内容
        List<String> informationOnePages=this.ifoImageManageMapper.getInformationOnePageUrls();
        List<String> pagesList=new ArrayList<>();
        if(informationOnePages.size()>0 &&  informationOnePages!=null){
            for(String str:informationOnePages){
                getContents(pagesList,str);
            }
        }
        //商品认证标识
        List goodsAuths=this.ifoImageManageMapper.getGoodsAuthUrls();
        //商品品牌
        List goodsBrand=this.ifoImageManageMapper.getGoodsBrandUrls();
        //文章图片
        List<String> getInformationImgs=this.ifoImageManageMapper.getInformationImgs();
        //文章内容
        List<String> informations=this.ifoImageManageMapper.getInformationUrls();
        List<String> informationList=new ArrayList<>();
        if(informations!=null && informations.size()>0){
            for(String str:informations){
                getContents(informationList,str);
            }

        }
        //服务
        List serviceSupports=this.ifoImageManageMapper.getServiceSupportUrls();
        //帮助中心列表和帮助中心分类表的img
        List helpImgs=this.ifoImageManageMapper.getSysHelpAndSysHelpcate();
        //帮助中心列表的内容
        List<String> contents=this.ifoImageManageMapper.getSysHelpContent();
        List<String> contentList=new ArrayList();
        if(contents!=null&&contents.size()>0){
            for(String str:contents){
                getContents(contentList,str);
            }
        }
        //基本信息 前台版权信息内容
        List<String> sysBasicsetCopyRights=this.ifoImageManageMapper.getSysBasicsetCopyRights();
        //基本信息 商城用户注册内容
        List<String> sysBasicsetUserAgreeMentsthis=this.ifoImageManageMapper.getSysBasicsetUserAgreeMents();
        Set<String> sysbasicsets=new HashSet<>();
        List<String> sysContents=new ArrayList<>();
        if(sysBasicsetCopyRights!=null && sysBasicsetCopyRights.size()>0){
            sysbasicsets.addAll(sysBasicsetCopyRights);
        }
        if(sysBasicsetUserAgreeMentsthis!=null && sysBasicsetUserAgreeMentsthis.size()>0){
            sysbasicsets.addAll(sysBasicsetUserAgreeMentsthis);
        }
        if(sysbasicsets!=null && sysbasicsets.size()>0){
            for(String str:sysbasicsets){
                getContents(sysContents,str);
            }
        }
        //404 500 页面报错页面用到的图
        List<String> sysErrorPage = this.ifoImageManageMapper.getSysErrorPage();
        List<String> sysErrorPageList = new ArrayList<>();
        if(sysErrorPage!=null && sysErrorPage.size()>0){
            for(String str:sysErrorPage){
                getContents(sysErrorPageList,str);
            }
        }
        Set<String> allSet=new HashSet<String>();
        if(relateImagges !=null && relateImagges.size()>0){
            allSet.addAll(relateImagges);
        }
        if(informationOnePageImgs !=null && informationOnePageImgs.size()>0){
            allSet.addAll(informationOnePageImgs);
        }
        if(pagesList !=null && pagesList.size()>0){
            allSet.addAll(pagesList);
        }
        if(goodsAuths !=null && goodsAuths.size()>0){
            allSet.addAll(goodsAuths);
        }
        if(goodsBrand !=null && goodsBrand.size()>0){
            allSet.addAll(goodsBrand);
        }
        if(getInformationImgs !=null && getInformationImgs.size()>0){
            allSet.addAll(getInformationImgs);
        }
        if(informationList !=null && informationList.size()>0){
            allSet.addAll(informationList);
        }
        if(serviceSupports !=null && serviceSupports.size()>0){
            allSet.addAll(serviceSupports);
        }
        if(helpImgs !=null && helpImgs.size()>0){
            allSet.addAll(helpImgs);
        }
        if(contentList !=null && contentList.size()>0){
            allSet.addAll(contentList);
        }
        if(sysContents !=null && sysContents.size()>0){
            allSet.addAll(sysContents);
        }
        if(sysErrorPageList !=null && sysErrorPageList.size()>0){
            allSet.addAll(sysErrorPageList);
        }
        return allSet;

    }
    //公用的方法  解析html
    public void getContents(List list,String str){
        org.jsoup.nodes.Document document=Jsoup.parse(str,"utf-8");
        Elements elements=document.select("img");
        if(elements.size()>0&&elements!=null){
            for(org.jsoup.nodes.Element element:elements){
                String string=element.attr("src");
                if(StringUtils.isNotBlank(string)){
                    int i=string.lastIndexOf("/")+1;
                    String subStr=string.substring(i,string.lastIndexOf("/")+14);
                    list.add(subStr);
                }
            }
        }
    }
    @Override
    public void deleteRelateInfoImageManagerByLike(String deleteName) {
        this.ifoImageManageMapper.deleteRelateInfoImageManagerByLike(deleteName);
    }

}
