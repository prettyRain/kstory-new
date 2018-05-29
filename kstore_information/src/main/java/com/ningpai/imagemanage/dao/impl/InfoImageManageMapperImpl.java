/*
 * Copyright 2013 NINGPAI, Inc.All rights reserved.
 * NINGPAI PROPRIETARY / CONFIDENTIAL.USE is subject to licence terms.
 */
/**
 * 
 */
package com.ningpai.imagemanage.dao.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.ningpai.imagemanage.bean.InfoImageManage;
import com.ningpai.imagemanage.dao.InfoImageManageMapper;
import com.ningpai.manager.base.BasicSqlSupport;

/**
 * DAO实现类-资源图片信息
 * 
 * @author NINGPAI-WangHaiYang
 * @since 2014年4月25日上午11:45:21
 */
@Repository("InfoImageManageMapper")
public class InfoImageManageMapperImpl extends BasicSqlSupport implements InfoImageManageMapper {

    /**
     * 根据主键删除
     * @param imageManageId
     * @return
     * @see com.ningpai.imagemanage.dao.InfoImageManageMapper#deleteByPrimaryKey(java.lang.Long)
     */
    @Override
    public int deleteByPrimaryKey(Long imageManageId) {

        return this.delete("com.ningpai.imagemanage.dao.InfoImageManageMapper.deleteByPrimaryKey", imageManageId);
    }

    /**
     * 添加
     * @param record
     * @return
     * @see com.ningpai.imagemanage.dao.InfoImageManageMapper#insert(com.ningpai.imagemanage.bean.InfoImageManage)
     */
    @Override
    public int insert(InfoImageManage record) {

        return this.insert("com.ningpai.imagemanage.dao.InfoImageManageMapper.insert", record);
    }

    /**
     * 添加-字段可选
     * @param record
     * @return
     * @see com.ningpai.imagemanage.dao.InfoImageManageMapper#insertSelective(com.ningpai.imagemanage.bean.InfoImageManage)
     */
    @Override
    public int insertSelective(InfoImageManage record) {

        return this.insert("com.ningpai.imagemanage.dao.InfoImageManageMapper.insertSelective", record);
    }

    /**
     * 修改-字段可选
     * @param record
     * @return
     * @see com.ningpai.imagemanage.dao.InfoImageManageMapper#updateByPrimaryKeySelective(com.ningpai.imagemanage.bean.InfoImageManage)
     */
    @Override
    public int updateByPrimaryKeySelective(InfoImageManage record) {

        return this.update("com.ningpai.imagemanage.dao.InfoImageManageMapper.updateByPrimaryKeySelective", record);
    }

    /**
     * 修改
     * @param record
     * @return
     * @see com.ningpai.imagemanage.dao.InfoImageManageMapper#updateByPrimaryKey(com.ningpai.imagemanage.bean.InfoImageManage)
     */
    @Override
    public int updateByPrimaryKey(InfoImageManage record) {

        return this.update("com.ningpai.imagemanage.dao.InfoImageManageMapper.updateByPrimaryKey", record);
    }

    /**
     * 根据ID查询
     * @param imageManageId
     * @return
     * @see com.ningpai.imagemanage.dao.InfoImageManageMapper#selectByPrimaryKey(java.lang.Long)
     */
    @Override
    public InfoImageManage selectByPrimaryKey(Long imageManageId) {

        return this.selectOne("com.ningpai.imagemanage.dao.InfoImageManageMapper.selectByPrimaryKey", imageManageId);
    }

    /**
     * 根据图片分类查询图片信息总行数
     * @param map
     * @return
     * @see com.ningpai.imagemanage.dao.InfoImageManageMapper#selectImageManageCountByParam(java.util.Map)
     */
    @Override
    public Integer selectImageManageCountByParam(Map<String, Object> map) {

        return this.selectOne("com.ningpai.imagemanage.dao.InfoImageManageMapper.selectImageManageCountByParam", map);
    }

    /**
     * 根据图片分类查询图片信息
     * @param map
     * @return
     * @see com.ningpai.imagemanage.dao.InfoImageManageMapper#selectImageManageByParam(java.util.Map)
     */
    @Override
    public List<Object> selectImageManageByParam(Map<String, Object> map) {

        return this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.selectImageManageByParam", map);
    }

    /**
     * 根据地单方ID和图片编号删除
     * @param param
     * @return
     * @see com.ningpai.imagemanage.dao.InfoImageManageMapper#updateImage
     */
    @Override
    public Integer updateImage(Map<String, Object> param) {
        return this.update("com.ningpai.imagemanage.dao.InfoImageManageMapper.updateImage", param);
    }

    /**
     * 批量删除
     * @param param
     * @see com.ningpai.imagemanage.dao.InfoImageManageMapper#updateImages
     */
    @Override
    public void updateImages(Map<String, Object> param) {
        this.update("com.ningpai.imagemanage.dao.InfoImageManageMapper.updateImages", param);
    }
   //xcy---------

    @Override
    public List<String> queryGoodsImages() {
        return this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.queryGoodsImages");
    }

    @Override
    public List getSysHelpAndSysHelpcate() {
        ArrayList arrayList=new ArrayList();
        List lista=this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.getSysHelp");
        List listb=this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.getSysHelpcate");
        if(lista!=null && lista.size()>0){
            arrayList.addAll(lista);
        }
        if(listb!=null && listb.size()>0){
            arrayList.addAll(listb);
        }
        return  arrayList;
    }

    @Override
    public List getSysHelpContent() {

        return this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.getSysHelpContent");
    }

    @Override
    public List getSysLink() {
        return this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.getSysLink");
    }
    //pc端分类导航表
    @Override
    public List<String> querySysClassifyBarList() {
        return this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.querySysClassifyBarList");
    }

    @Override
    public List<String> getInformationOnePageImgs() {
        return this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.getInformationOnePageImgs");
    }

    @Override
    public List<String> getInformationImgs() {
        return this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.getInformationImgs");
    }

    @Override
    public List<String> getSysBasicsetCopyRights() {
        return this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.getSysBasicsetCopyRights");
    }

    @Override
    public List<String> getSysBasicsetUserAgreeMents() {
        return this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.getSysBasicsetUserAgreeMents");
    }

    @Override
    public List<String> getBackOrderImgs() {
        return this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.getBackOrderImgs");
    }

    /**
     * 400/505 报错页面
     *
     * @return
     */
    @Override
    public List<String> getSysErrorPage() {
        return this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.getSysErrorPage");
    }

    @Override
    public List queryChannelAdverList() {
        return this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.queryChannelAdverList");
    }

    @Override
    public List queryShareImgList() {
        return this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.queryShareImgList");
    }

    @Override
    public List queryChannelStoreyList(){
        return this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.queryChannelStoreyList");
    }
    @Override
    public List queryChannelTradeMarkList(){
        return this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.queryChannelTradeMarkList");
    }
    @Override
    public List queryChannelStoreyGoodsList() {
        return this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.queryChannelStoreyGoodsList");
    }

    @Override
    public List queryGoodsList() {
        return this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.queryGoodsList");
    }

    @Override
    public List queryCoodsDesc() {
        List list=new ArrayList();
         //  商品详情
        List lista=this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.queryGoodsDetailList");
        //规格详情
        List listc=this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.queryGoodsSpecsifitionDescList");
        //包装详情
        List listd=this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.queryGoodsWarpDescList");
        //品牌详情
        List liste=this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.queryGoodsBrandDescList");
        //  wap商品详情
        List listb=this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.queryMobileDetailList");
        if(lista!=null && lista.size()>0){
            list.addAll(lista);
        }
        if(listb!=null && listb.size()>0){
            list.addAll(listb);
        }
        if(listc!=null && listc.size()>0){
            list.addAll(listc);
        }
        if(listd!=null && listd.size()>0){
            list.addAll(listd);
        }
        if(liste!=null && liste.size()>0){
            list.addAll(liste);
        }
        return list;
    }

    @Override
    public List queryGoodsInfoList() {
        return this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.queryGoodsInfoList");
    }

    @Override
    public List queryMarketingRushList() {
        List list=new ArrayList();
        List lista=this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.queryMarketingRushMobileImg");
        List listb=this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.queryMarketingRushImgList");
        if(lista!=null && lista.size()>0){
            list.addAll(lista);
        }
        if(listb!=null && listb.size()>0){
            list.addAll(listb);
        }
        return list;
    }

    @Override
    public List queryMobCateBarList() {
        return this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.queryMobCateBarList");
    }

    @Override
    public List queryMobHomePageList() {
        return this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.queryMobHomePageList");
    }

    @Override
    public List querySysBasicsetList() {
        List list=new ArrayList();
        List lista=this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.querySysBasicsetMobileLogoImg");
        //basicset 表的best_logo_third
        List listb=this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.querySysBasicsetBestThirdLogoImg");
       //basicset  表的 best_logo
        List listc=this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.querySysBasicsetBestLogoImg");
       //basicset  标的 best_hot_line
        List listd=this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.querySysBasicsetBestHotLineImg");
       //basicdet 表的 site_login_img
        List liste=this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.querySysBasicsetSiteLoginImg");

        List listf=this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.querySysBasicsetThirdLoginImg");

        List listg=this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.querySysBasicsetThirdRegisterImg");

        List listh=this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.querySysBasicsetSiteRegistSuccImg");
        if(lista!=null && lista.size()>0){
            list.addAll(lista);
        }
        if(listb!=null && listb.size()>0){
            list.addAll(listb);
        }
        if(listc!=null && listc.size()>0){
            list.addAll(listc);
        }
        if(listd!=null && listd.size()>0){
            list.addAll(listd);
        }
        if(liste!=null && liste.size()>0){
            list.addAll(liste);
        }
        if(listf!=null && listf.size()>0){
            list.addAll(listf);
        }
        if(listg!=null && listg.size()>0){
            list.addAll(listg);
        }
        if(listh!=null && listh.size()>0){
            list.addAll(listh);
        }
        return list;
    }

    @Override
    public List querySysTempList() {
        return this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.querySysTempList");
    }

    @Override
    public List queryCustomerList() {
        List list=new ArrayList();
        List lista=this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.queryCustomertoAuditImg");
        List listb=this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.queryCustomerList");
        if(lista!=null && lista.size()>0){
            list.addAll(lista);
        }
        if(listb!=null && listb.size()>0){
            list.addAll(listb);
        }
        return list;
    }

    @Override
    public List querySysBasicList() {
        List list=new ArrayList();
        List lista=this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.querySysBasicIndexLogo");
        List listb=this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.querySysBasicLoginLogo");
        if(lista!=null && lista.size()>0){
            list.addAll(lista);
        }
        if(listb!=null && listb.size()>0){
            list.addAll(listb);
        }
         return list;
    }

    @Override
    public List queryAllImages() {
        return this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.queryAllImages");
    }

    //修改关联状态
    @Override
    public void uploadImagesByQueryMap(Map queryMap) {
        this.update("com.ningpai.imagemanage.dao.InfoImageManageMapper.uploadAll");
        this.update("com.ningpai.imagemanage.dao.InfoImageManageMapper.uploadImagesByQueryMap",queryMap);
    }
    //获取为关联的总条数
    @Override
    public Integer queryTotalImagCount(Map countMap) {
        return this.selectOne("com.ningpai.imagemanage.dao.InfoImageManageMapper.queryTotalImagCount",countMap);
    }
   //查询 未关联的图片 分页
    @Override
    public List<InfoImageManage> ajaxQueryRetaleImag(Map map) {
        return this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.ajaxQueryRetaleImag",map);
    }
    //删除未关联的图片
    @Override
    public void deleteRelateInfoImageManager(String infoImageManageId) {
         this.delete("com.ningpai.imagemanage.dao.InfoImageManageMapper.deleteRelateInfoImageManager",infoImageManageId);
    }
    //标题页
    @Override
    public List getInformationOnePageUrls() {
        return this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.getInformationOnePageUrls");
    }
    //商品认证标识
    @Override
    public List getGoodsAuthUrls() {
        return this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.getGoodsAuthUrls");
    }
    //商品品牌
    @Override
    public List getGoodsBrandUrls() {
        return this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.getGoodsBrandUrls");
    }
    //标题
    @Override
    public List getInformationUrls() {
        return this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.getInformationUrls");
    }

    @Override
    public List getServiceSupportUrls() {
        return this.selectList("com.ningpai.imagemanage.dao.InfoImageManageMapper.getServiceSupportUrls");
    }

    @Override
    public void deleteRelateInfoImageManagerByLike(String deleteName) {
        this.delete("com.ningpai.imagemanage.dao.InfoImageManageMapper.deleteRelateInfoImageManagerByLike",deleteName);
    }



}
