package com.roofapp.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.scheduling.annotation.EnableAsync;

@ComponentScan({"com.roofapp.backend.service"})
@EnableAsync
@Configuration
@EnableAspectJAutoProxy
public class appConfig {


}
