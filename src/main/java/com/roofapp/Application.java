package com.roofapp;

import com.roofapp.backend.service.ProductService;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.autoconfigure.web.servlet.error.ErrorMvcAutoConfiguration;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

/**
 * The entry point of the Spring Boot application.
 */
@ComponentScan({"com.roofapp.backend.service", "com.roofapp.config"})

@SpringBootApplication()
public class Application extends SpringBootServletInitializer {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    @Bean
    public CommandLineRunner loadData(ProductService productService) {
        return (args) -> {
            /* Only run the first time to fill the database with data */
            //  fillTheDatabase(conclusionTypeRepository, customerRepository, meetingRepository, conclusionRepository);

        };
    }

}
