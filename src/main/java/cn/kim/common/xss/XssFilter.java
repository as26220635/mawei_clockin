package cn.kim.common.xss;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;


/**
 * Created by 余庚鑫 on 2017/6/3.
 */
public class XssFilter implements Filter {
    FilterConfig filterConfig = null;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
    }

    @Override
    public void destroy() {
        this.filterConfig = null;
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        //不是主界面url，就返回
        if (httpServletRequest.getServletPath().equals("/favicon.ico")) {
            return;
        }
        chain.doFilter(new XssHttpServletRequestWrapper(httpServletRequest), response);
    }


}