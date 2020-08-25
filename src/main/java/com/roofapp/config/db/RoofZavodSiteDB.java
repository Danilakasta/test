package com.roofapp.config.db;

import com.roofapp.backend.service.EnvService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;

/**
 * marchenko_ds 16.03.2018
 */
@Configuration("roofZavodSite")
@EnableTransactionManagement
@EnableJpaRepositories(
        basePackages = {"com.roofapp.backend.dao.roofZavod.repositories",

        },
        entityManagerFactoryRef = "roofZavodSiteEntityManagerFactory",
        transactionManagerRef = "roofZavodSiteTransactionManager"
)
public class RoofZavodSiteDB extends DBConf {

    private final static String SERVICE_NAME = "roofZavodSite";

    protected RoofZavodSiteDB(EnvService env) {
        super(env);
    }

    @Bean(name = "roofZavodSiteDataSource")
    public DataSource dataSource() {
        return getDataSource(SERVICE_NAME);
    }

    @Bean(name = "roofZavodSiteEntityManagerFactory")
    public LocalContainerEntityManagerFactoryBean armEntityManagerFactory() {

        return getEntityManager(dataSource(), SERVICE_NAME);
    }

    @Bean(name = "roofZavodSiteTransactionManager")
    public PlatformTransactionManager armTransactionManager() {
        return getTransactionManager(armEntityManagerFactory());
    }

    @Override
    String getDbPrefix() {
        return SERVICE_NAME;
    }
}
