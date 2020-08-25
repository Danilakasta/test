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
@Configuration("roofDB")
@EnableTransactionManagement
@EnableJpaRepositories(
        basePackages = {"com.roofapp.backend.dao.roofdb",

        },
        entityManagerFactoryRef = "roofEntityManagerFactory",
        transactionManagerRef = "roofTransactionManager"
)
public class RoofDB extends DBConf {

    private final static String SERVICE_NAME = "roof";

    protected RoofDB(EnvService env) {
        super(env);
    }

    @Bean(name = "roofDataSource")
    public DataSource dataSource() {
        return getDataSource(SERVICE_NAME);
    }

    @Bean(name = "roofEntityManagerFactory")
    public LocalContainerEntityManagerFactoryBean armEntityManagerFactory() {

        return getEntityManager(dataSource(), SERVICE_NAME);
    }

    @Bean(name = "roofTransactionManager")
    public PlatformTransactionManager armTransactionManager() {
        return getTransactionManager(armEntityManagerFactory());
    }

    @Override
    String getDbPrefix() {
        return SERVICE_NAME;
    }
}
