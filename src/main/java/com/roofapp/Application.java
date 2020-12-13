package com.roofapp;

import com.roofapp.app.security.SecurityConfiguration;
import com.roofapp.backend.dao.roofdb.entity.User;
import com.roofapp.backend.dao.roofdb.repositories.UserRepository;
import com.roofapp.backend.service.UserService;
import com.roofapp.ui.MainLayout;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.autoconfigure.web.servlet.error.ErrorMvcAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

//https://vaadin.com/directory#addon/canvas:vaadin

//vm options -Dvaadin.productionMode
/**
 * The entry point of the Spring Boot application.
 */
///@Profile("production")

@SpringBootApplication(scanBasePackageClasses = {SecurityConfiguration.class, MainLayout.class, Application.class,
        UserService.class }, exclude = ErrorMvcAutoConfiguration.class)
/*@EnableJpaRepositories(basePackageClasses = { UserRepository.class })*/
@EntityScan(basePackageClasses = { User.class })
public class Application extends SpringBootServletInitializer {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(Application.class);
    }

   /* @Bean
    public CommandLineRunner loadData(ProductService productService) {
        return (args) -> {
            /* Only run the first time to fill the database with data */
            //  fillTheDatabase(conclusionTypeRepository, customerRepository, meetingRepository, conclusionRepository);

     //   };
  //  }

}
