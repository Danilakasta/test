package com.roofapp.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;

@ComponentScan({"com.roofapp.backend.service","com.roofapp.ui","com.roofapp.backend.task"})
@EnableAsync
@Configuration
@EnableAspectJAutoProxy
@EnableScheduling
public class AppConfig {


}
