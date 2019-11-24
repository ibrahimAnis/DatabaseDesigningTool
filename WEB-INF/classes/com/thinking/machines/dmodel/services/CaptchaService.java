package com.thinking.machines.dmodel.services;
import com.thinking.machines.tmws.annotations.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.thinking.machines.dmframework.*;
import com.thinking.machines.tmws.captcha.*;
import com.thinking.machines.dmframework.exceptions.*;
@Path("/CaptchaService")
public class CaptchaService
{
HttpSession session;
public void setHttpSession(HttpSession session)
{
this.session=session;
}
@InjectSession
@Post
@Path("validate")
public Object validate(String captchaCode)
{
Captcha captcha=(Captcha)session.getAttribute(Captcha.CAPTCHA_NAME);
System.out.println(captcha.isValid(captchaCode));
boolean valid=captcha.isValid(captchaCode);
System.out.println("Valid value "+valid);
session.removeAttribute(Captcha.CAPTCHA_NAME);
return valid;
}
}
