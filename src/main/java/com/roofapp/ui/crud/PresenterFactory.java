/**
 *
 */
package com.roofapp.ui.crud;

//import com.roofapp.app.security.CurrentUser;
import com.roofapp.backend.data.entity.Order;
import com.roofapp.backend.service.OrderService;
import com.roofapp.ui.views.order.OrderView;
import org.springframework.beans.factory.config.ConfigurableBeanFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;

@Configuration
public class PresenterFactory {

	@Bean
	@Scope(ConfigurableBeanFactory.SCOPE_PROTOTYPE)
	public EntityPresenter<Order, OrderView> orderEntityPresenter(OrderService crudService/*, CurrentUser currentUser*/) {
		return new EntityPresenter<>(crudService/*, currentUser*/);
	}

}
