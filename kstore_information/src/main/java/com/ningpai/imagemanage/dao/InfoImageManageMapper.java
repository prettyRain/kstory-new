package com.ningpai.imagemanage.dao;

import java.util.List;
import java.util.Map;

import com.ningpai.imagemanage.bean.InfoImageManage;

/**
 * DAO-资源图片信息
 * 
 * @author NINGPAI-WangHaiYang
 * @since 2014年4月25日上午11:34:55
 */
public interface InfoImageManageMapper {
    /**
     * 根据主键删除
     * 
     * @param imageManageId
     * @return
     */
    int deleteByPrimaryKey(Long imageManageId);

    /**
     * 添加
     * 
     * @param record
     * @return
     */
    int insert(InfoImageManage record);

    /**
     * 添加-字段可选
     * 
     * @param record
     * @return
     */
    int insertSelective(InfoImageManage record);

    /**
     * 修改-字段可选
     * 
     * @param record
     * @return
     */
    int updateByPrimaryKeySelective(InfoImageManage record);

    /**
     * 修改
     * 
     * @param record
     * @return
     */
    int updateByPrimaryKey(InfoImageManage record);

    /**
     * 根据ID查询
     * 
     * @param imageManageId
     * @return
     */
    InfoImageManage selectByPrimaryKey(Long imageManageId);

    /**
     * 根据图片分类查询图片信息总行数
     * 
     * @param map
     * @return
     */
    Integer selectImageManageCountByParam(Map<String, Object> map);

    /**
     * 根据图片分类查询图片信息
     * 
     * @param map
     * @return
     */
    List<Object> selectImageManageByParam(Map<String, Object> map);

    /**
     * 根据地单方ID和图片编号删除
     * @param param
     */
    Integer updateImage(Map<String, Object> param);

    /**
     * 批量删除
     * @param param
     */
    void updateImages(Map<String, Object> param);
    //
    List queryChannelAdverList();

    List queryShareImgList();

    List queryChannelStoreyGoodsList();
    List queryChannelStoreyList();
    List queryChannelTradeMarkList();
    List queryGoodsList();
    List queryCoodsDesc();
    List queryGoodsInfoList();

    List queryMarketingRushList();

    List queryMobCateBarList();

    List queryMobHomePageList();

    List querySysBasicsetList();

    List querySysTempList();

    List queryCustomerList();
    List querySysBasicList();
   //-----------
    List queryAllImages();
    //
    void uploadImagesByQueryMap(Map queryMap);

    Integer queryTotalImagCount(Map countMap);

    List<InfoImageManage> ajaxQueryRetaleImag(Map map);

    void deleteRelateInfoImageManager(String infoImageManageId);

    List getInformationOnePageUrls();

    List getGoodsAuthUrls();

    List getGoodsBrandUrls();

    List getInformationUrls();

    List getServiceSupportUrls();

    void deleteRelateInfoImageManagerByLike(String deleteName);
    //查询货品图片
    List<String> queryGoodsImages();

    List getSysHelpAndSysHelpcate();

    List getSysHelpContent();

    List getSysLink();
    //移动端分类导航表
    List<String> querySysClassifyBarList();
    List<String> getInformationOnePageImgs();

    List<String> getInformationImgs();

    List<String> getSysBasicsetCopyRights();

    List<String> getSysBasicsetUserAgreeMents();

    List<String> getBackOrderImgs();

    /**
     * 400/505 报错页面
     * @return
     */
    List<String> getSysErrorPage();
}
