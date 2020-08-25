package com.roofapp.config.db;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import com.roofapp.backend.service.EnvService;
import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.transaction.PlatformTransactionManager;

import javax.sql.DataSource;
import java.beans.PropertyVetoException;
import java.util.Properties;

/**
 * marchenko_ds 19.03.2018
 */
@Log
public abstract class DBConf {

    private final EnvService env;

    @Autowired
    protected DBConf(EnvService env) {
        this.env = env;
    }

    DataSource getDataSource(String optPrefix) {
        // c3p0 datasource manager for connection pooled
        ComboPooledDataSource dataSource = new ComboPooledDataSource();
        try {
            dataSource.setDriverClass(env.getProperty(optPrefix + ".database.driverClassName"));
        } catch (PropertyVetoException e) {
            log.warning(e.getMessage());
        }
        dataSource.setJdbcUrl(env.getProperty(optPrefix + ".database.url"));
        dataSource.setUser(env.getProperty(optPrefix + ".database.username"));
        dataSource.setPassword(env.getProperty(optPrefix + ".database.password"));


        dataSource.setMinPoolSize(Integer.parseInt(env.getProperty("hibernate.c3p0.min_size")));
        dataSource.setMaxPoolSize(Integer.parseInt(env.getProperty("hibernate.c3p0.max_size")));
        dataSource.setMaxIdleTime(Integer.parseInt(env.getProperty("hibernate.c3p0.timeout")));
        dataSource.setMaxStatements(Integer.parseInt(env.getProperty("hibernate.c3p0.max_statements")));

        dataSource.setIdleConnectionTestPeriod(Integer.parseInt(env.getProperty("hibernate.c3p0.idle_test_period")));
        dataSource.setPreferredTestQuery(env.getProperty("hibernate.c3p0.preferred_test_query"));

        dataSource.setTestConnectionOnCheckin(Boolean.valueOf(env.getProperty("hibernate.c3p0.testConnectionOnCheckin")));
        dataSource.setTestConnectionOnCheckout(Boolean.valueOf(env.getProperty("hibernate.c3p0.testConnectionOnCheckout")));
        return dataSource;
    }

    LocalContainerEntityManagerFactoryBean getEntityManager(DataSource dataSource, String optPrefix) {
        LocalContainerEntityManagerFactoryBean em
                = new LocalContainerEntityManagerFactoryBean();
        em.setDataSource(dataSource);
        em.setPackagesToScan(env.getProperty(optPrefix + ".entity_path"));
        HibernateJpaVendorAdapter vendorAdapter
                = new HibernateJpaVendorAdapter();

        em.setJpaVendorAdapter(vendorAdapter);
        em.setJpaProperties(getHibernateProperties(env, optPrefix));

        return em;
    }

    PlatformTransactionManager getTransactionManager(LocalContainerEntityManagerFactoryBean entityManagerFactory) {

        JpaTransactionManager txManager = new JpaTransactionManager();
        txManager.setEntityManagerFactory(entityManagerFactory.getObject());
        return txManager;
    }

    private Properties getHibernateProperties(EnvService env,String optPrefix) {

        Properties properties = new Properties();
      //  properties.put("hibernate.dialect", env.getProperty("hibernate.dialect"));
        properties.put("hibernate.dialect", env.getProperty(optPrefix + ".hibernate.dialect"));

        properties.put("hibernate.connection.handling_mode", env.getProperty("hibernate.connection.handling_mode"));
      //  properties.put("hibernate.show_sql", env.getProperty("hibernate.show_sql"));
       properties.put("hibernate.current_session_context_class", env
               .getProperty("hibernate.current_session_context_class"));
        properties.put("hibernate.enable_lazy_load_no_trans", env
                .getProperty("hibernate.enable_lazy_load_no_trans"));
        properties.put("hibernate.jdbc.lob.non_contextual_creation", env
                .getProperty("hibernate.jdbc.lob.non_contextual_creation"));

        properties.put("hibernate.jpa.properties.javax.persistence.validation.mode", env
                .getProperty("hibernate.jpa.properties.javax.persistence.validation.mode"));

        properties.put("hibernate.c3p0.min_size", env
                .getProperty("hibernate.c3p0.min_size"));
        properties.put("hibernate.c3p0.max_size", env
                .getProperty("hibernate.c3p0.max_size"));
        properties.put("hibernate.c3p0.timeout", env
                .getProperty("hibernate.c3p0.timeout"));
        properties.put("hibernate.c3p0.max_statements", env
                .getProperty("hibernate.c3p0.max_statements"));
        properties.put("hibernate.proc.param_null_passing", env
                .getProperty("hibernate.proc.param_null_passing", "true"));


        // switch fast or slow hibernate initialization. for production must be true
        properties.put("hibernate.temp.use_jdbc_metadata_defaults", env
               .getProperty("hibernate.temp.use_jdbc_metadata_defaults"));

        properties.put("database.driverClassName", env.getProperty(optPrefix +".database.driverClassName"));


        properties.put("hibernate.c3p0.idleConnectionTestPeriod", env.getProperty("hibernate.c3p0.idle_test_period"));
        properties.put("hibernate.c3p0.preferredTestQuery", env.getProperty("hibernate.c3p0.preferred_test_query"));
        properties.put("hibernate.c3p0.testConnectionOnCheckin", env.getProperty("hibernate.c3p0.testConnectionOnCheckin"));
        properties.put("hibernate.c3p0.testConnectionOnCheckout", env.getProperty("hibernate.c3p0.testConnectionOnCheckout"));

        properties.put("hibernate.prepareConnection",false);

        /*
         *  Adjust timezone if needed
         */
        String timeZone = env.getProperty(getDbPrefix() + ".hibernate.jdbc.time_zone", "");
        if (!timeZone.equals("")) {
            properties.put("hibernate.jdbc.time_zone", timeZone);
        }
        return properties;
    }

    abstract String getDbPrefix();

}

