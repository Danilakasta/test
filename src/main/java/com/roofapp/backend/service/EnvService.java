package com.roofapp.backend.service;

public interface EnvService {
    String getProperty(String name);
 	String getProperty(String key, String defaultValue);
    boolean dbIsReplica();
    boolean isMSSQLEnabled();
}
