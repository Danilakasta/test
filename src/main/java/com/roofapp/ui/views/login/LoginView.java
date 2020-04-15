package com.roofapp.ui.views.login;

import com.roofapp.app.security.SecurityUtils;
import com.roofapp.ui.MainLayout;
import com.roofapp.ui.utils.AppConst;
import com.vaadin.flow.component.dependency.JsModule;
import com.vaadin.flow.component.login.LoginI18n;
import com.vaadin.flow.component.login.LoginOverlay;
import com.vaadin.flow.component.page.Viewport;
import com.vaadin.flow.router.*;

@Route
@PageTitle("roofApp")
@JsModule("./styles/shared-styles.js")
@Viewport(AppConst.VIEWPORT)
public class LoginView extends LoginOverlay
	implements AfterNavigationObserver, BeforeEnterObserver {

	public LoginView() {
		LoginI18n i18n = LoginI18n.createDefault();
		i18n.setHeader(new LoginI18n.Header());
		i18n.getHeader().setTitle("CRM ROOF FACTORY");
		i18n.getHeader().setDescription(
			"admin@roof.com + admin\n" + "manager@roof.com + manager");
		i18n.setAdditionalInformation(null);
		i18n.setForm(new LoginI18n.Form());
		i18n.getForm().setSubmit("Войти");
		//i18n.getForm().setTitle("Вход");
		i18n.getForm().setUsername("Почта");
		i18n.getForm().setPassword("Пароль");
		setI18n(i18n);
		setForgotPasswordButtonVisible(false);
		setAction("login");
	}
	
	@Override
	public void beforeEnter(BeforeEnterEvent event) {
		if (SecurityUtils.isUserLoggedIn()) {
			event.forwardTo(MainLayout.class);
		} else {
			setOpened(true);
		}
	}

	@Override
	public void afterNavigation(AfterNavigationEvent event) {
		setError(
			event.getLocation().getQueryParameters().getParameters().containsKey(
				"error"));
	}

}
