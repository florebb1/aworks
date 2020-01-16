package com.laidback.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@RestController
public class InfoController extends RootController {
    // 서브1
    @RequestMapping(value = "/info/about", method = RequestMethod.GET)
    public ModelAndView about(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.setViewName("info/about");
        return mav;
    }

    // 서브2
    @RequestMapping(value = "/info/terms", method = RequestMethod.GET)
    public ModelAndView terms(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.setViewName("info/terms");
        return mav;
    }

    // 서브3
    @RequestMapping(value = "/info/privacy", method = RequestMethod.GET)
    public ModelAndView privacy(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.setViewName("info/privacy");
        return mav;
    }

}
