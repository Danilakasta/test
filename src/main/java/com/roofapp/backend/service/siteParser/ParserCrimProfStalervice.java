package com.roofapp.backend.service.siteParser;

import com.roofapp.backend.dao.roofdb.entity.parser.SiteCategory;
import com.roofapp.backend.dao.roofdb.entity.parser.SiteProduct;
import lombok.extern.java.Log;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Service
@Log
public class ParserCrimProfStalervice implements ParserService {

    private final String siteUrl = "https://xn--80ateckffckku3fwa.xn--p1ai/";
    private final String siteName = "крымпрофсталь";


    public SiteCategory getCategory(Element headline) {

        return SiteCategory.builder()
                .title(headline.select(".name").text())
                .url(headline.select(".name a").attr("href"))
                .imgPath(headline.select("img").attr("src")).build();


    }

    public SiteCategory getSubCategory(Element subCategoryBloc) {
        return SiteCategory.builder()
                .title(subCategoryBloc.select(".name").text())
                .url(subCategoryBloc.select(".button").attr("href"))
                .imgPath(subCategoryBloc.select("img").attr("src")).build();

    }

    public List<SiteCategory> getAllCategory() throws Exception {
        List<SiteCategory> allCategory = new ArrayList<>();

        Document doc = Jsoup.connect(siteUrl).get();
        log.info(doc.title());
        Elements elements = doc.select(".category_item");
        elements.stream().forEach(headline -> {
            SiteCategory category = getCategory(headline);
            List<SiteCategory> siteSubCategories = new ArrayList<>();
            Document doc2 = null;
            try {
                String url = headline.select(".name a").attr("href");
                if (!url.equals("/sendvich-paneli-krym")) {
                    doc2 = Jsoup.connect(url).get();
                    log.info(doc2.title());
                    //    Thread.sleep(1000 * 1);
                }
            } catch (IOException e) {
                log.warning(e.getMessage());
            }
            if (doc2 != null) {
                Elements elements2 = doc2.select(".sub_item_category");
                if (elements2.size() > 0)
                    elements2.stream().forEach(subItem -> {

                        // allCategory.add();
                        SiteCategory siteCategory2 = getSubCategory(subItem);
                        List<SiteCategory> siteSubCategories2 = new ArrayList<>();
                        Document doc3 = null;
                        try {
                            doc3 = Jsoup.connect(subItem.select(".button").attr("href")).get();
                            log.info(doc3.title());
                            //  Thread.sleep(1000 * 1);
                        } catch (IOException e) {
                            log.warning(e.getMessage());
                        }
                        Elements elements3 = doc3.select(".sub_item_category");
                        if (elements3.size() > 0)
                            elements3.stream().forEach(subItem2 -> {
                                siteSubCategories2.add(getSubCategory(subItem2));

                            });
                        siteCategory2.setSubCategory(siteSubCategories2);
                        siteSubCategories.add(siteCategory2);
                    });
            }
            category.setSubCategory(siteSubCategories);
            allCategory.add(category);
        });
        return allCategory;
    }

    public List<SiteProduct> parser(String productIemClass, SiteCategory category) throws Exception {
        Document doc = null;
        try {
            doc = Jsoup.connect(category.getUrl()).get();
            log.info(doc.title());
            Thread.sleep(1000 * 2);
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Elements newsHeadlines1 = doc.select(productIemClass);
        List<SiteProduct> siteProducts = new ArrayList<>();
        //   for (Element subCategoryBloc : newsHeadlines1) {

        Elements newsHeadlines = doc.select(productIemClass);
        for (Element headline : newsHeadlines) {
            siteProducts.add(SiteProduct.builder()
                    .title(headline.select(".name a").text())
                    .price(headline.select(".price span").text().replaceAll("([^\\d.,]|\\B\\.|\\.\\B)+", ""))
                    .fullPrice(headline.select(".price span").text())
                    .prop(headline.select(".description-grid").text())
                    .imgPath(headline.select(".image img").attr("src"))
                    .category(category)
                    .siteName(siteName)
                    .build());

        }

        //   }
        return siteProducts;
    }


    public void testFragmentPath() throws Exception {
        List<SiteCategory> categoryList = getAllCategory();
        List<SiteProduct> allSiteProducts = new ArrayList<>();

        allSiteProducts.addAll(parser(".product_", categoryList.get(22)));
        log.info(String.valueOf(allSiteProducts));
        //  log.info(String.valueOf(allProducts));


    }


    public List<SiteProduct> parseAllPath() throws Exception {
        List<SiteCategory> categoryList = getAllCategory();
        List<SiteProduct> allSiteProducts = new ArrayList<>();
        categoryList.forEach((category) -> {
            try {
                allSiteProducts.addAll(parser(".product_", category));
                if (category.getSubCategory().size() > 0) {
                    category.getSubCategory().forEach(subCategory -> {
                        try {
                            allSiteProducts.addAll(parser(".product_", subCategory));
                            if (subCategory.getSubCategory().size() > 0) {
                                subCategory.getSubCategory().forEach(subCategory2 -> {
                                    try {
                                        allSiteProducts.addAll(parser(".product_", subCategory2));
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }
                                });
                            }

                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    });
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        });

        return allSiteProducts;
    }

}
