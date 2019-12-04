package cn.kim.controller;

import cn.kim.common.attr.MagicValue;
import cn.kim.common.eu.SystemEnum;
import cn.kim.controller.manager.BaseController;
import cn.kim.controller.mobile.home.MyHomeController;
import cn.kim.common.attr.Constants;
import cn.kim.common.csrf.CsrfToken;
import cn.kim.entity.ActiveUser;
import cn.kim.entity.WechatUser;
import cn.kim.exception.*;
import cn.kim.remote.LogRemoteInterfaceAsync;
import cn.kim.service.WechatService;
import cn.kim.util.*;
import com.alibaba.fastjson.JSONObject;
import me.zhyd.oauth.config.AuthConfig;
import me.zhyd.oauth.exception.AuthException;
import me.zhyd.oauth.model.AuthCallback;
import me.zhyd.oauth.model.AuthResponse;
import me.zhyd.oauth.request.AuthRequest;
import me.zhyd.oauth.request.AuthWeChatRequest;
import me.zhyd.oauth.utils.AuthStateUtils;
import me.zhyd.oauth.utils.UrlBuilder;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2017/2/25.
 * 统一登录
 */
@Controller
public class LoginController extends BaseController {


    /**
     * 授权URL
     */
    public static final String OAUTH_PATH = "/oauth";

    @Autowired
    private WechatService wechatService;

    /**
     * 验证码
     *
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("check")
    public void createCode(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 通知浏览器不要缓存
        response.setContentType("image/jpeg");
        //禁止图像缓存。
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);

        CreateImageCode vCode = new CreateImageCode(100, 30, 5, 0);
        request.getSession().setAttribute("validateCode", vCode.getCode());
        vCode.write(response.getOutputStream());
    }

    /**********************     防止csrf攻击    ********************/

    @GetMapping("/admin")
    public ModelAndView admin(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("redirect:" + ManagerController.MANAGER_URL);
        return modelAndView;
    }

    @GetMapping("/login")
    @CsrfToken(create = true)
    public ModelAndView login(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView();

        modelAndView.setViewName("login");

        String username = request.getParameter("username");
        if (username != null) {
            modelAndView.addObject("username", username);
        }

        if (AuthcUtil.getCurrent().isAuthenticated()) {
//            if (request.getRequestURI().contains(ManagerController.MANAGER_URL)) {
            modelAndView.setViewName("redirect:" + ManagerController.MANAGER_URL);
//            } else {
//                modelAndView.setViewName("redirect:/index");
//            }
        }

        return modelAndView;
    }

    @PostMapping(value = "/login")
    @CsrfToken(remove = true)
    public ModelAndView login(HttpServletRequest request, RedirectAttributes model) throws Exception {
        ModelAndView modelAndView = new ModelAndView();

        //如果登陆失败从request中获取认证异常信息，shiroLoginFailure就是shiro异常类的全限定名
        if (request.getAttribute("shiroLoginFailure") != null) {
            Object exceptionClass = request.getAttribute("shiroLoginFailure");
            String errorTips = "";
            //根据shiro返回的异常类判断，抛出指定异常信息
            if (exceptionClass != null) {
                if (exceptionClass instanceof UnknownAccountException) {
                    //最终会抛给异常处理器
                    errorTips = "账号不存在";
                } else if (exceptionClass instanceof IncorrectCredentialsException) {
                    errorTips = "用户名/密码错误";
                } else if (exceptionClass instanceof IncorrectCaptchaException) {
                    errorTips = "验证码错误";
                } else if (exceptionClass instanceof FrozenException) {
                    errorTips = "用户被冻结,请联系管理员";
                } else if (exceptionClass instanceof RoleFrozenException) {
                    errorTips = "用户角色被冻结,请联系管理员";
                } else if (exceptionClass instanceof NullRoleFrozenException) {
                    errorTips = "用户角色查询异常";
                } else if (exceptionClass instanceof RepeatLoginException) {
                    errorTips = "用户已经登陆,不能同时登陆";
                } else if (exceptionClass instanceof ExcessiveAttemptsException) {
                    errorTips = "密码错误次数过多,请等待10分钟后尝试!";
                } else if (exceptionClass instanceof AuthenticationException) {
                    ((AuthenticationException) exceptionClass).printStackTrace();
                    errorTips = "服务器内部错误!";
                } else if (exceptionClass instanceof UnknownTypeException) {
                    errorTips = "未知类型异常";
                } else {
                    throw (Exception) exceptionClass;//最终在异常处理器生成未知错误
                }

                SessionUtil.remove(Constants.SESSION_USERNAME);
                modelAndView.setViewName("redirect:/login");
                model.addFlashAttribute("loginError", errorTips);
                model.addFlashAttribute("username", request.getParameter("username"));
                model.addFlashAttribute("type", request.getParameter("type"));
            }
        }

        return modelAndView;
    }

    /**
     * 登录
     *
     * @param source
     * @param response
     * @throws IOException
     */
    @RequestMapping("/oauth/render/{source}")
    public void renderAuth(@PathVariable("source") String source, HttpServletResponse response) throws IOException {
        AuthRequest authRequest = getAuthRequest(source);
        String authorizeUrl = authRequest.authorize(AuthStateUtils.createState());
        //替换参数
        authorizeUrl = authorizeUrl.replace("https://open.weixin.qq.com/connect/qrconnect?", "https://open.weixin.qq.com/connect/oauth2/authorize?");
        authorizeUrl = authorizeUrl.replace("scope=snsapi_login", "scope=snsapi_userinfo");
//        System.out.println(authorizeUrl);
        response.sendRedirect(authorizeUrl);
    }

    /**
     * oauth平台中配置的授权回调地址
     *
     * @param source
     * @param callback
     * @return
     */
    @RequestMapping("/oauth/callback/{source}")
    public void login(@PathVariable("source") String source, AuthCallback callback, HttpServletRequest request, HttpServletResponse response) throws Exception {
//        System.out.println("进入callback：" + source + " callback params：" + JSONObject.toJSONString(callback));
        AuthRequest authRequest = getAuthRequest(source);
        AuthResponse res = authRequest.login(callback);

        JSONObject data = JSONObject.parseObject(JSONObject.toJSONString(res.getData()));
        JSONObject token = data.getJSONObject("token");
        WechatUser user = new WechatUser();
        user.setUuid(data.getString("uuid"));
        user.setUsername(data.getString("username"));
        user.setNickname(data.getString("nickname"));
        user.setGender(data.getString("gender"));
        user.setAvatar(data.getString("avatar"));
        user.setLocation(data.getString("location"));
        user.setSource(data.getString("source"));
        user.setAccessToken(token.getString("accessToken"));
        user.setExpireIn(token.getInteger("expireIn"));
        user.setOpenId(token.getString("openId"));
        user.setRefreshToken(token.getString("refreshToken"));
        user.setIp(HttpUtil.getIpAddr(request));
        //记录登录
        Map<String, Object> resultMap = wechatService.wechatLogin(user);
        if (!isSuccess(resultMap)) {
            throw new CustomException("微信登录失败!");
        }
        user.setId(toString(resultMap.get(MagicValue.ID)));

        //用户类型
        ActiveUser activeUser = new ActiveUser();
        //设置类型
        activeUser.setId(user.getId());
        activeUser.setUsername(user.getUsername());
        activeUser.setType(SystemEnum.WECHAT.toString());

        //放入seesion
        SessionUtil.set(MagicValue.SESSION_WECHAT_USER, user);
        SessionUtil.set(Constants.SESSION_USERNAME, activeUser);
        //跳转前台
        WebUtils.issueRedirect(request, response, "/clockin", null, true);
    }

    /**
     * 第三方登录
     *
     * @param source
     * @return
     */
    private AuthRequest getAuthRequest(String source) throws UnsupportedEncodingException {
        AuthRequest authRequest = null;
        switch (source) {
            case "wechat":
                authRequest = new AuthWeChatRequest(AuthConfig.builder()
                        .clientId("wx7edf17f7ff512e13")
                        .clientSecret("a5c5b2d4ec1462b453da891d5527fb69")
                        .redirectUri("https://ygx.mynatapp.cc/mawei_clockin/oauth/callback/wechat")
                        .build());
                break;
        }
        if (null == authRequest) {
            throw new AuthException("未获取到有效的Auth配置");
        }
        return authRequest;
    }
}
