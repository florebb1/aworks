package com.laidback;

import freemarker.template.TemplateModel;
import kr.pe.kwonnam.freemarker.inheritance.BlockDirective;
import kr.pe.kwonnam.freemarker.inheritance.ExtendsDirective;
import kr.pe.kwonnam.freemarker.inheritance.PutDirective;
import org.msgpack.MessagePack;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;
import org.springframework.web.servlet.view.freemarker.FreeMarkerViewResolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.*;

@Configuration
public class WebMvcConfig extends WebMvcConfigurerAdapter {

    private final Logger log = LoggerFactory.getLogger(WebMvcConfig.class);



    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations("file:./uploads/");
    }

    @Bean
    public MessagePack messagePack() {
        return new MessagePack();
    }

    @Bean
    public Map<String, TemplateModel> freemarkerLayoutDirectives() {

        Map<String, TemplateModel> freemarkerLayoutDirectives = new HashMap<String, TemplateModel>();
        freemarkerLayoutDirectives.put("extends", new ExtendsDirective());
        freemarkerLayoutDirectives.put("block", new BlockDirective());
        freemarkerLayoutDirectives.put("put", new PutDirective());
        return freemarkerLayoutDirectives;
    }

    @Bean
    public FreeMarkerConfigurer freemarkerConfig() {

        FreeMarkerConfigurer freemarkerConfig = new FreeMarkerConfigurer();
        freemarkerConfig.setTemplateLoaderPath("classpath:/templates");
        freemarkerConfig.setDefaultEncoding("utf-8");


        Map<String, Object> freemarkerVariables = new HashMap<String, Object>();
        freemarkerVariables.put("layout", freemarkerLayoutDirectives());


        freemarkerConfig.setFreemarkerVariables(freemarkerVariables);
        return freemarkerConfig;
    }

    @Bean
    public ViewResolver viewResolver() {

        FreeMarkerViewResolver viewResolver = new FreeMarkerViewResolver();
        viewResolver.setCache(false);
        viewResolver.setPrefix("");
        viewResolver.setExposeSpringMacroHelpers(true);
        viewResolver.setSuffix(".ftl");
        viewResolver.setContentType("text/html; charset=utf-8");
        return viewResolver;
    }

    @Bean
    public MessageSource messageSource() {

        ResourceBundleMessageSource messageSource = new ResourceBundleMessageSource();
        //WEB-INF 밑에 해당 폴더에서 properties를 찾는다.
        messageSource.setBasename("messages/messages");
        messageSource.setDefaultEncoding("UTF-8");
        return messageSource;
    }

    @Bean
    public LocaleChangeInterceptor localeChangeInterceptor() {

        LocaleChangeInterceptor localeChangeInterceptor = new LocaleChangeInterceptor();
        //request로 넘어오는 language parameter를 받아서 locale로 설정 한다.
        localeChangeInterceptor.setParamName("language");
        System.out.println("1");
        return localeChangeInterceptor;
    }

    @Bean(name = "localeResolver")
    public LocaleResolver sessionLocaleResolver() {
        //세션 기준으로 로케일을 설정 한다.
        // SessionLocaleResolver localeResolver = new SessionLocaleResolver();
        //쿠키 기준(세션이 끊겨도 브라우져에 설정된 쿠키 기준으로)
        CookieLocaleResolver localeResolver = new CookieLocaleResolver();

        //최초 기본 로케일을 강제로 설정이 가능 하다.
        localeResolver.setDefaultLocale(new Locale("ko_KR"));
        localeResolver.setCookieName("language");
        localeResolver.setCookieMaxAge(365);
        return localeResolver;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {

        registry.addInterceptor(new HandlerInterceptor() {
            @Override
            public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
                    throws Exception {

                try{

                    long startTime = new Date().getTime();

                    StringBuffer logBf = new StringBuffer();

                    logBf.append(
                            "\n" + request.getRequestURI() + " ===============================================> start1 \n");

                    Enumeration<String> params = request.getParameterNames();

                    while(params.hasMoreElements()) {
                        String name = params.nextElement();
                        logBf.append("     parameter ====> " + name + " ====>" + request.getParameter(name) + "\n");
                    }

                    logBf.append("     request.getMethod() ===>" + request.getMethod() + "\n");
                    logBf.append("     request.getRequestURL() ===>" + request.getRequestURL() + "\n");

                    request.setAttribute("startTime", startTime);
                    request.setAttribute("logBf", logBf);

                }catch (Exception e){
                    log.error(e.getMessage(),e);
                }
                return true;
            }

            @Override
            public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

                Authentication auth = SecurityContextHolder.getContext().getAuthentication();

                if(!(auth instanceof AnonymousAuthenticationToken) && modelAndView != null) {
                    Object o = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

//                    modelAndView.addObject("menus",menuService.allMenus(request, modelAndView));
                }
            }

            @Override
            public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler,
                                        Exception ex) throws Exception {

                if(ex != null) log.error(ex.getMessage(),ex);
                try {

                    long startTime = (long) request.getAttribute("startTime");

                    StringBuffer logBf = (StringBuffer) request.getAttribute("logBf");

                    Exception controllerError = (Exception) request.getAttribute("controllerError");

                    if(controllerError != null) {

                        logBf.append(" \t Error 발생 ==>  \n");

                        StringWriter errors = new StringWriter();
                        controllerError.printStackTrace(new PrintWriter(errors));


                        logBf.append(" \t " + errors.toString());
                    }

                    logBf.append(
                            request.getRequestURI() + " ===============================================> end1 " + "[" +
                                    (new Date().getTime() - startTime) / 1000.0 + " Sec] \n");

                    log.info(logBf.toString());

                } catch(Exception e) {
                    log.error(e.getMessage(),e);
                }

            }
        });
        registry.addInterceptor(localeChangeInterceptor());
    }

}
