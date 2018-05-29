package com.ningpai.app.setting.index;

import com.ningpai.app.AppSiteConstants;
import com.ningpai.imagemanage.bean.InfoImageManage;
import com.ningpai.imagemanage.service.InfoImageManageService;
import com.ningpai.util.MyLogger;
import com.ningpai.util.PageBean;

import com.thoughtworks.xstream.mapper.Mapper;
import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InterruptedIOException;
import java.util.*;

/**
 * 首页控制器
 * Created by aqlu on 15/12/6.
 */
@Controller
public class IndexController {
    private static final MyLogger LOGGER = new MyLogger(IndexController.class);

    private static final String TEMPLATE_OF_RUSH_GROUP_BUY = "RushGroupBuy";

    @Autowired
    private FloorRepository floorRepository;

    @Autowired
    private SliderRepository sliderRepository;

    @Autowired
    private AdvertRepository advertRepository;

    @Autowired
    private MenuRepository menuRepository;

    /**
     * 查看移动app可视化配置首页列表
     * @return ModelAndView
     */
    @RequestMapping("/queryAppHomePage")
    public ModelAndView queryAppHomePage() {
        ModelAndView mav = new ModelAndView();
        // 获取该商家未启用的首页列表
        mav.setViewName("/jsp/appsite/app_home_page_list");
        return mav;
    }

    /**
     *  查看主题首页列表
     * @return ModelAndView
     */
    @RequestMapping("/queryThemeHomePage")
    public ModelAndView queryThemeHomePage(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/jsp/theme/theme_home_page_list");
        return modelAndView;
    }
    /** 资源图片信息SERVICE */
    private InfoImageManageService infoImageManageService;
    public InfoImageManageService getInfoImageManageService() {
        return infoImageManageService;
    }

    @Resource(name = "InfoImageManageService")
    public void setInfoImageManageService(InfoImageManageService infoImageManageService) {
        this.infoImageManageService = infoImageManageService;
    }
    /**
     *找出未关联的图片 并标记为未关联
     * @param request
     * @return
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/queryNotRelateImages")
    public ModelAndView queryNotRelateImages(HttpServletRequest request)throws Exception{
        //获取app端 首页显示的内容
        List<Floor> floors = null;
        try {
            floors = floorRepository.findByThemeCode("home");
        } catch (Exception e) {
            LOGGER.info("获取楼层信息失败, msg:"+ e.getMessage());
            floors = Collections.emptyList();
        }
        List<Slider> sliders = null;
        try {
            sliders = sliderRepository.findAll();
        } catch (Exception e) {
            LOGGER.info("获取轮播信息失败, msg:"+ e.getMessage());
            sliders = Collections.emptyList();
        }
        List<Advert> adverts = null;
        try {
            adverts = advertRepository.findByThemeCode("home");
        } catch (Exception e) {
            LOGGER.info("获取广告信息失败, msg:"+ e.getMessage());
            adverts = Collections.emptyList();
        }
        //获取跟图片表有关联的表的图片内容
        Set<String> listRelateImages=infoImageManageService.queryAllRelateImages();
        //把瓦片app的首页图片 合并到listRelateImages中
        if(floors !=null && floors.size()>0){
            for(Floor floor:floors){
                List<Advert> adverts1=floor.getAdverts();
                if(adverts1!=null && adverts1.size()>0){
                    for(Advert advert:adverts1){
                        String img=advert.getImg();
                        if(StringUtils.isNotBlank(img)){
                            String imgsubstr=img.substring(img.lastIndexOf("/")+1,img.lastIndexOf("/")+14);
                            listRelateImages.add(imgsubstr);
                        }

                    }
                }
            }
        }
        if(sliders !=null && sliders.size()>0){
            for(Slider slider:sliders){
                String img=slider.getImg();
                if(StringUtils.isNotBlank(img)){
                    String imgsubstr=img.substring(img.lastIndexOf("/")+1,img.lastIndexOf("/")+14);
                    listRelateImages.add(imgsubstr);
                }
            }
        }
        if(adverts !=null && adverts.size()>0){
            for(Advert advert:adverts){
                String img=advert.getImg();
                if(StringUtils.isNotBlank(img)){
                    String imgsubstr=img.substring(img.lastIndexOf("/")+1,img.lastIndexOf("/")+14);
                    listRelateImages.add(imgsubstr);
                }
            }
        }
        //查询图片库的图片
        List<String> listImages=infoImageManageService.queryAllImages();
        Map queryMap=new HashMap();
        List<String> queryLists=new ArrayList<>();
        queryMap.put("queryLists",queryLists);
        Map map=new HashMap();
        for(String str:listRelateImages){
            map.put(str,str);
        }
        if(map!=null && map.size()>0){
            if(listImages!=null && listImages.size()>0){
                for(String strImg:listImages){
                    if(StringUtils.isBlank((String)map.get(strImg))){
                        //把图片库中未关联的表 加入queryLists 集合
                       queryLists.add(strImg);
                   }
                }

            }

        }
        //如果有未关联的 那么就修改表
        if(queryLists!=null && queryLists.size()>0){
            try{
        infoImageManageService.uploadImagesByQueryMap(queryMap);
        }catch(Exception e){
            e.printStackTrace();}
        }
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("jsp/infoImage/infoImageManageRelateList");

        return modelAndView;
    }

    /**
     * ajax 获取未关联的图片
     * @param request
     * @param pb
     * @param startDate
     * @param endDate
     * @return
     * @throws Exception
     */
    @RequestMapping("/ajaxQueryRetaleImag")
    @ResponseBody
    public Map ajaxQueryRetaleImag(HttpServletRequest request, PageBean pb, String startDate,String endDate) throws Exception{
          Map map=infoImageManageService.ajaxQueryRetaleImag(pb,startDate,endDate);

          return map;

    }

    /**
     * 删除 未关联图片
     * @param request
     * @param infoImageManageId 图片id
     * @param imageManageUrl    图片地址
     * @return
     * @throws Exception
     */
    @RequestMapping(value ="/deleteImageManageRelate")
    @ResponseBody
    public String deleteImageManageRelate(HttpServletRequest request,String infoImageManageId,String imageManageUrl)throws Exception{
        //获取配置文件
        InputStream in=IndexController.class.getResourceAsStream("/com/ningpai/web/config/upload.properties");
        Properties pro=new Properties();
        pro.load(in);
        //图片根路径
        String path=(String)pro.get("DELPATH");
        //判断是不是 又拍云
       if(imageManageUrl.contains("upaiyun")){

       }else{
           String onePath=imageManageUrl.substring(imageManageUrl.indexOf("upload/")+7,imageManageUrl.indexOf("upload/")+15);
           String twoPath=imageManageUrl.substring(imageManageUrl.lastIndexOf("/")+1,imageManageUrl.lastIndexOf("/")+14);
           //获取四个图片对象
           File file=new File(path+"/"+onePath);
           File fileBig=new File(path+"/"+onePath+"/"+twoPath+".jpg");
           File fileSmallOne=new File(path+"/"+onePath+"/"+twoPath+"!56.jpg");
           File fileSmallTwo=new File(path+"/"+onePath+"/"+twoPath+"!160.jpg");
           File fileSmallThree=new File(path+"/"+onePath+"/"+twoPath+"!352.jpg");
           // 在服务器 删除图片

          if(fileBig.exists()){
              fileBig.delete();
              fileSmallOne.delete();
              fileSmallTwo.delete();
              fileSmallThree.delete();
              File[] files=file.listFiles();
              if(files.length==0){
                  file.delete();
              }
              //在数据库删除图片路径
              infoImageManageService.deleteRelateInfoImageManager(infoImageManageId);

          }
       }
        return "ok";
    }

    /**
     * 批量删除未关联图片
     * @param relate
     * @return
     */
    @RequestMapping("/bachDeleteRelate")
    @ResponseBody
    public String bachDeleteRelate(String relate)throws  Exception{
        //获取配置文件
        InputStream in=IndexController.class.getResourceAsStream("/com/ningpai/web/config/upload.properties");
        Properties pro=new Properties();
        pro.load(in);
        //图片根路径
        String path=(String)pro.get("DELPATH");
        //id的集合
        List<String> idsList=new ArrayList<String>();
        //路径的集合
        List<String> urlList=new ArrayList<String>();
        if(StringUtils.isNotBlank(relate)){
            String[] arr=relate.split(",");
           for(String str:arr){
               String[] idAndUrl=str.split("-");
              //判断是不是又拍云
               if(idAndUrl[1].contains("upaiyun")){

               }else{
                   String onePath=idAndUrl[1].substring(idAndUrl[1].indexOf("upload/")+7,idAndUrl[1].indexOf("upload/")+15);
                   String twoPath=idAndUrl[1].substring(idAndUrl[1].lastIndexOf("/")+1,idAndUrl[1].lastIndexOf("/")+14);
                   //获取四个图片对象
                   File file=new File(path+"/"+onePath);
                   File fileBig=new File(path+"/"+onePath+"/"+twoPath+".jpg");
                   File fileSmallOne=new File(path+"/"+onePath+"/"+twoPath+"!56.jpg");
                   File fileSmallTwo=new File(path+"/"+onePath+"/"+twoPath+"!160.jpg");
                   File fileSmallThree=new File(path+"/"+onePath+"/"+twoPath+"!352.jpg");
                   // 在服务器 删除图片

                   if(fileBig.exists()){
                       fileBig.delete();
                       fileSmallOne.delete();
                       fileSmallTwo.delete();
                       fileSmallThree.delete();
                       File[] files=file.listFiles();
                       if(files.length==0){
                           file.delete();
                       }
                       //在数据库删除图片路径
                       infoImageManageService.deleteRelateInfoImageManager(idAndUrl[0]);

                   }
               }
           }
        }


        return "ok";
    }

    @RequestMapping("/deleteAllUrl")
    @ResponseBody
    public String speedDeleteRelate()throws Exception{
        //获取app端 首页显示的内容
        List<Floor> floors = null;
        try {
            floors = floorRepository.findByThemeCode("home");
        } catch (Exception e) {
            LOGGER.info("获取楼层信息失败, msg:"+ e.getMessage());
            floors = Collections.emptyList();
        }
        List<Slider> sliders = null;
        try {
            sliders = sliderRepository.findAll();
        } catch (Exception e) {
            LOGGER.info("获取轮播信息失败, msg:"+ e.getMessage());
            sliders = Collections.emptyList();
        }
        List<Advert> adverts = null;
        try {
            adverts = advertRepository.findByThemeCode("home");
        } catch (Exception e) {
            LOGGER.info("获取广告信息失败, msg:"+ e.getMessage());
            adverts = Collections.emptyList();
        }
        //获取所有需要展示的图片
        Set<String> listRelateImages=infoImageManageService.queryAllUrl();
        //把瓦片app的首页图片 合并到listRelateImages中
        if(floors !=null && floors.size()>0){
            for(Floor floor:floors){
                List<Advert> adverts1=floor.getAdverts();
                if(adverts1!=null && adverts1.size()>0){
                    for(Advert advert:adverts1){
                        String img=advert.getImg();
                        if(StringUtils.isNotBlank(img)){
                            String imgsubstr=img.substring(img.lastIndexOf("/")+1,img.lastIndexOf("/")+14);
                            listRelateImages.add(imgsubstr);
                        }

                    }
                }
            }
        }
        if(sliders !=null && sliders.size()>0){
            for(Slider slider:sliders){
                String img=slider.getImg();
                if(StringUtils.isNotBlank(img)){
                    String imgsubstr=img.substring(img.lastIndexOf("/")+1,img.lastIndexOf("/")+14);
                    listRelateImages.add(imgsubstr);
                }
            }
        }
        if(adverts !=null && adverts.size()>0){
            for(Advert advert:adverts){
                String img=advert.getImg();
                if(StringUtils.isNotBlank(img)){
                    String imgsubstr=img.substring(img.lastIndexOf("/")+1,img.lastIndexOf("/")+14);
                    listRelateImages.add(imgsubstr);
                }
            }
        }
        //获取配置文件
        InputStream in=IndexController.class.getResourceAsStream("/com/ningpai/web/config/upload.properties");
        Properties pro=new Properties();
        pro.load(in);
        //图片根路径
        String path=(String)pro.get("DELPATH");
        Set<String> listNames=new HashSet<>();
        Set<String> deleteNames=new HashSet<>();
        File file=new File(path);

        //获取图片服务器所有的图片名称
        if(file.isDirectory()){
            //获取年月日的目录
            File[] files=file.listFiles();
        for(File fileDate:files){
            File[] fileRelates=fileDate.listFiles();
            for(File fileRelate:fileRelates){
                String fileName=fileRelate.getName();
                if(fileName.length()>=13){
                    listNames.add(fileName.substring(0,13));
                }
            }
        }
        }
        //定义一个map 放入用到的图片
        Map<String,String> map=new HashMap();
        for(String str:listRelateImages){
            map.put(str,str);
        }
        for(String str:listNames){
            if(StringUtils.isBlank(map.get(str))){
                //把没用到的图片放入 deleteNames 集合
                deleteNames.add(str);
            }

        }
        if(deleteNames !=null && deleteNames.size()>0){
            if(file.isDirectory()){
            for(String deleteName:deleteNames){
                     //获取年月日的目录
                    File[] files=file.listFiles();
                    for(File fileDate:files){
                        String name=fileDate.getName();
                        File deleteFile=new File(path+"/"+fileDate.getName()+"/"+deleteName+".jpg");
                        File fileSmallOne=new File(path+"/"+fileDate.getName()+"/"+deleteName+"!56.jpg");
                        File fileSmallTwo=new File(path+"/"+fileDate.getName()+"/"+deleteName+"!160.jpg");
                        File fileSmallThree=new File(path+"/"+fileDate.getName()+"/"+deleteName+"!352.jpg");
                        boolean b=deleteFile.exists();
                        if(deleteFile.exists()){
                            deleteFile.delete();
                            if(fileSmallOne.exists()){
                                fileSmallOne.delete();
                            }
                            if(fileSmallTwo.exists()){
                                fileSmallTwo.delete();
                            }
                            if(fileSmallThree.exists()){
                                fileSmallThree.delete();
                            }
                            if(fileDate.listFiles().length==0){
                                fileDate.delete();
                            }
                            //在图片库表
                         this.infoImageManageService.deleteRelateInfoImageManagerByLike(deleteName);
                        }

                    }
                }



            }
        }
        return "ok";
    }
    /**
     * 首页
     */
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "/setAppHomePage", method = RequestMethod.GET)
    @ResponseBody
    public ModelAndView index(@RequestParam(required = false) Long districtId) throws IOException {
        ModelAndView mav = new ModelAndView();

        List<Floor> floors = null;
        try {
            floors = floorRepository.findByThemeCode("home");
        } catch (Exception e) {
            LOGGER.info("获取楼层信息失败, msg:"+ e.getMessage());
            floors = Collections.emptyList();
        }
        List<Slider> sliders = null;
        try {
            sliders = sliderRepository.findAll();
        } catch (Exception e) {
            LOGGER.info("获取轮播信息失败, msg:"+ e.getMessage());
            sliders = Collections.emptyList();
        }
        List<Advert> adverts = null;
        try {
            adverts = advertRepository.findByThemeCode("home");
        } catch (Exception e) {
            LOGGER.info("获取广告信息失败, msg:"+ e.getMessage());
            adverts = Collections.emptyList();
        }

        IndexResponse indexResponse = new IndexResponse(sliders, null, adverts, floors);
        mav.setViewName("jsp/appsite/set_app_home_page");
        mav.addObject("data", indexResponse);

        return mav;
    }
    @RequestMapping("/writeUrlToAppBanner")
    public ModelAndView IntoPage(HttpServletRequest request,String pageName){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("jsp/appsite/"+pageName);
        return modelAndView;
    }
    /**
     * 保存首页设置
     */
    @RequestMapping(value = "/saveAppIndex", method = RequestMethod.POST)
    @ResponseBody
    public String saveIndex(@RequestBody IndexSaveForm indexSaveForm) throws IOException {
        List<Slider> sliders = indexSaveForm.getSliders();
        List<Advert> adverts = indexSaveForm.getAdverts();
        List<Floor> floors = indexSaveForm.getFloors();

        if(null !=sliders && !sliders.isEmpty()) {
            sliderRepository.deleteAll();
            sliderRepository.save(sliders);
        }

        if(null !=adverts && !adverts.isEmpty()) {
            advertRepository.deleteByThemeCode(AppSiteConstants.ES_INDEX_NAME, AppSiteConstants.ES_TYPE_OF_ADVERTS, "home");
            advertRepository.save(adverts);
        }

        if(null != floors && !floors.isEmpty()) {

            List<Floor> list = new ArrayList<>();
            for(Floor floor: floors) {
                if (TEMPLATE_OF_RUSH_GROUP_BUY.equals(floor.getTemplate())) {
                    //抢购与团购楼层处理，删除楼层里面的数据
                    floor.setAdverts(null);
                }
                list.add(floor);
            }
            floorRepository.deleteByThemeCode(AppSiteConstants.ES_INDEX_NAME, AppSiteConstants.ES_TYPE_OF_FLOORS, "home");
            floorRepository.save(list);
        }

        return "success";
    }

    /**
     * 主题页
     */
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "/setThemeHomePage", method = RequestMethod.GET)
    @ResponseBody
    public ModelAndView themeIndex(@RequestParam String themeCode) throws IOException {
        ModelAndView mav = new ModelAndView();

        List<Floor> floors = null;
        try {
            floors = floorRepository.findByThemeCode(themeCode);
        } catch (Exception e) {
            LOGGER.info("获取楼层信息失败, msg:"+ e.getMessage());
            floors = Collections.emptyList();
        }
        List<Advert> adverts = null;
        try {
            adverts = advertRepository.findByThemeCode(themeCode);
        } catch (Exception e) {
            LOGGER.info("获取广告信息失败, msg:"+ e.getMessage());
            adverts = Collections.emptyList();
        }
        List<Menu> menus = null;
        try {
            menus = menuRepository.findByThemeCode(themeCode);
        } catch (Exception e) {
            LOGGER.info("获取menu失败, msg:"+ e.getMessage());
            menus = Collections.emptyList();
        }
        ThemeResponse indexResponse;
        if (CollectionUtils.isEmpty(adverts)) {
            indexResponse = new ThemeResponse(null, floors);
        }else {
            indexResponse = new ThemeResponse(adverts.get(0) ,floors);
        }

        mav.setViewName("jsp/theme/set_theme_home_page");
        mav.addObject("data", indexResponse);

        return mav;
    }

    /**
     * 保存主题页设置
     */
    @RequestMapping(value = "/saveThemeIndex", method = RequestMethod.POST)
    @ResponseBody
    public String saveIndex(@RequestBody ThemeSaveForm saveForm) throws IOException {
        Advert advert = saveForm.getAdvert();
        List<Floor> floors = saveForm.getFloors();

        if(null != advert) {
            advert.setThemeCode("theme-1");
            advertRepository.deleteByThemeCode(AppSiteConstants.ES_INDEX_NAME, AppSiteConstants.ES_TYPE_OF_ADVERTS, advert.getThemeCode());
            List<Advert> adverts = new ArrayList<>();
            adverts.add(advert);
            advertRepository.save(adverts);
        }

        if(floors != null && !floors.isEmpty()) {
            floorRepository.deleteByThemeCode(AppSiteConstants.ES_INDEX_NAME, AppSiteConstants.ES_TYPE_OF_FLOORS, floors.get(0).getThemeCode());
            floorRepository.save(floors);
        }

        return "success";
    }
}
