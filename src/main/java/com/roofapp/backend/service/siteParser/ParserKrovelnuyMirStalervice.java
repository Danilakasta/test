package com.roofapp.backend.service.siteParser;

import com.roofapp.backend.data.entity.parser.SiteCategory;
import com.roofapp.backend.data.entity.parser.SiteProduct;
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
public class ParserKrovelnuyMirStalervice implements ParserService {

    private final String siteUrl = "https://krovelnyj-mir.ru/";

    private final String siteName = "Кровельный мир";


    public SiteCategory getCategory(Element headline) {
        return SiteCategory.builder()
                .title(headline.select(".woocommerce-loop-category__title").html().split("<mark")[0])
                .url(headline.select("a").attr("href"))
                .imgPath(headline.select("img").attr("src")).build();


    }

    public List<SiteCategory> getAllCategory() throws Exception {
        List<SiteCategory> allCategory = new ArrayList<>();

        Document doc = Jsoup.connect(siteUrl).get();
        log.info(doc.title());
        Elements elements = doc.select(".product-category");
        elements.stream().forEach(headline -> {
            SiteCategory siteCategory = getCategory(headline);

            Document doc2 = null;
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            try {
                doc2 = Jsoup.connect(siteCategory.getUrl()).get();
                log.info(doc2.title());

            } catch (IOException e) {
                log.warning(e.getMessage());
            }
            List<SiteCategory> siteCategories = new ArrayList<>();
            if (doc2 != null) {
                Elements elements2 = doc2.select(".product-category");
                if (elements2.size() > 0)
                    elements2.stream().forEach(subItem -> {
                        siteCategories.add(getCategory(subItem));
                    });
            }
            siteCategory.setSubCategory(siteCategories);
            allCategory.add(siteCategory);
        });
        return allCategory;
    }

    public List<SiteProduct> parser(Document doc, String productIemClass, SiteCategory category) throws Exception {
        Elements products = doc.select(productIemClass);
        List<SiteProduct> siteProducts = new ArrayList<>();
        for (Element headline : products) {
            siteProducts.add(SiteProduct.builder()
                    .title(headline.select(".woocommerce-loop-product__title").text())
                    .price(headline.select(".price").text().replaceAll("([^\\d.,]|\\B\\.|\\.\\B)+", ""))
                    .fullPrice(headline.select(".price").text())
                    //  .prop(headline.select(".description-grid").text())
                    .imgPath(headline.select("img").attr("src"))
                    .category(category)
                    .siteName(siteName)
                    .build());

        }
        return siteProducts;
    }

    public Document getDoc(String url) {
        Document doc = null;
        try {
            doc = Jsoup.connect(url).get();
            log.info(doc.title());
            Thread.sleep(1000 * 2);
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
        return doc;
    }

    public List<SiteProduct> parserWithPagination(String productIemClass, SiteCategory category) throws Exception {

        List<SiteProduct> siteProducts = new ArrayList<>();
        Document doc = getDoc(category.getUrl());
        siteProducts.addAll(parser(doc, productIemClass, category));

        //Пагинация
        Elements pagination = doc.select(".woocommerce-pagination li");
        for (Element page : pagination) {
            String pageHref = page.select(".page-numbers").attr("href");
            if (!pageHref.equals("") && page.select(".next").attr("href").equals("")) {
                siteProducts.addAll(parser(getDoc(pageHref), productIemClass, category));
            }
        }
        return siteProducts;
    }

    public List<SiteProduct> parseFragmentPath() throws Exception {
        List<SiteCategory> categoryList = getAllCategory();
        List<SiteProduct> allSiteProducts = new ArrayList<>();
        allSiteProducts.addAll(parserWithPagination(".product-type-variable", categoryList.get(0)));
        //  log.info(String.valueOf(allSiteProducts));
        return allSiteProducts;
    }

    public List<SiteProduct> parseAllPath() throws Exception {
        List<SiteCategory> categoryList = getAllCategory();
        List<SiteProduct> allSiteProducts = new ArrayList<>();
        categoryList.forEach(category -> {
            try {
                allSiteProducts.addAll(parserWithPagination(".product-type-variable", category));

                if (category.getSubCategory().size() > 0) {
                    category.getSubCategory().forEach(subCategory -> {
                        try {
                            allSiteProducts.addAll(parserWithPagination(".product-type-variable", subCategory));
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
