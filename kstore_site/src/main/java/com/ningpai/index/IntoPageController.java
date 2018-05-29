package com.ningpai.index;

import com.ningpai.index.service.TopAndBottomService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;

/**
 * Created by Administrator on 2018/1/31.
 */
@Controller
public class IntoPageController {

    @Resource(name = "TopAndBottomService")
    private TopAndBottomService topAndBottomService;

    @RequestMapping("/intoPage")
    public ModelAndView pageInto(@RequestParam("pageName") String pageName, HttpServletRequest request){

        if(StringUtils.isNotBlank(pageName)){
            return  topAndBottomService.getTopAndBottom(new ModelAndView(pageName));
        }
        return new ModelAndView(new RedirectView("/indexview"));
    }
}
