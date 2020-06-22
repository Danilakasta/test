package com.roofapp.backend.task;


import com.roofapp.backend.data.entity.parser.SiteProduct;
import com.roofapp.backend.repositories.SiteCategoryRepository;
import com.roofapp.backend.repositories.SiteProductRepository;
import com.roofapp.backend.service.siteParser.ParserCrimProfStalervice;
import com.roofapp.backend.service.siteParser.ParserRichStoneService;
import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
@Log
public class SiteParserTask {

    private final SiteCategoryRepository siteCategoryRepository;
    private final SiteProductRepository siteProductRepository;
    private final ParserRichStoneService parserRichStoneService;
    private  final ParserCrimProfStalervice parserCrimProfStalervice;

    @Autowired
    public SiteParserTask(SiteCategoryRepository siteCategoryRepository,
                          SiteProductRepository siteProductRepository,
                          ParserRichStoneService parserRichStoneService,
                          ParserCrimProfStalervice parserCrimProfStalervice) {
        this.siteCategoryRepository = siteCategoryRepository;
        this.siteProductRepository = siteProductRepository;
        this.parserRichStoneService = parserRichStoneService;
        this.parserCrimProfStalervice = parserCrimProfStalervice;
    }


    @ConditionalOnProperty(value = "scheduling.enabled")
   // @Scheduled(fixedRate = 5000)
    public void parseSite() throws Exception {
        siteProductRepository.deleteAll();
        List<SiteProduct> products = parserRichStoneService.parseFragmentPath();
        siteProductRepository.saveAll(products);

        products = parserCrimProfStalervice.parseAllPath();
        siteProductRepository.saveAll(products);

    }

    @ConditionalOnProperty(value = "scheduling.enabled")
    @Scheduled(fixedRate = 5000)
    public void parseSite2() throws Exception {


        List<SiteProduct>    products = parserCrimProfStalervice.parseAllPath();
        siteProductRepository.saveAll(products);
    }
}
