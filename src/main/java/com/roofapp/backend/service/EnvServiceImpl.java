package com.roofapp.backend.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;

/**
 * marchenko_ds 10.01.2019
 */

@Service
@Scope("singleton")
public class EnvServiceImpl implements EnvService {

    @Autowired
    private Environment environment;


    /**
     * Получение значения параметра из .properties
     * @param key
     * @return
     */
    @Override
    public String getProperty ( String key) {
        return environment.getProperty(key);
    }

    /**
     * Получение значения параметра из .properties + defaultValue
     * @param key
     * @param defaultValue
     * @return
     */
    @Override
    public 	String getProperty(String key, String defaultValue){
        return environment.getProperty(key,defaultValue);
    }
    /**
     * База Сут реплика, в реплику запись запрещена
     * @return
     */
    @Override
    public boolean dbIsReplica() {
        String replicaConfStr = environment.getProperty("arm.database.isReplica");
        if (replicaConfStr != null) {
            return Boolean.valueOf(replicaConfStr);
        }
        return false;
    }

    @Override
    public boolean isMSSQLEnabled() {
        String mssqlConfStr = environment.getProperty("rabbitmq.MSSQL.is_mssql_enabled");
        if (mssqlConfStr != null) {
            return Boolean.valueOf(mssqlConfStr);
        }
        return false;
    }
}
