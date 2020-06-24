package com.packagename.myapp.parserTest;

import com.roofapp.backend.data.entity.parser.SiteCategory;
import com.roofapp.backend.data.entity.parser.SiteProduct;
import lombok.extern.java.Log;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.junit.Before;
import org.junit.Test;

import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Simple unit test for site parser
 * <p>
 * https://ричстоун.рф/
 * https://крымпрофсталь.рф/
 * https://crimea-partner.ru/  цены в таблицах
 * https://крымлидер.рф/кровля/?yclid=2906664251145878158  на сайте нет конкретных цен
 * http://rodnichok.crimea.ru/   цены в пдф прайсе
 * hhttps://krovli-simferopol.ru/
 * http://armada82.ru/
 * https://s-k-k.net/  парсится нормальнро
 * https://www.orgpage.ru/simferopol/krymkrovlya-5543005.html
 * http://кровля82.рус/index.php/ru/  ..нет цен на сайте
 * https://krovelnyj-mir.ru/?yclid=2911435848078627136  парсится норм
 * https://librasimferopol.ru/?9651
 */
@Log
public class ParserKrovelnyiMir {

    private final String siteUrl = "https://krovelnyj-mir.ru/";

    private final String siteName = "Кровельный мир";

    @Before
    public void setUp() throws Exception {

    }

    public SiteCategory getCategory(Element headline) {
        return SiteCategory.builder()
                .title(headline.select(".woocommerce-loop-category__title").html().split("<mark")[0])
                .url(headline.select("a").attr("href"))
                .imgPath(headline.select("img").attr("src")).build();


    }

  /*  public SiteCategory getSubCategory(Element subCategoryBloc) {
        return SiteCategory.builder()
                .title(subCategoryBloc.select(".name").text())
                .url(subCategoryBloc.select(".button").attr("href"))
                .imgPath(subCategoryBloc.select("img").attr("src")).build();

    }*/

    public List<SiteCategory> getAllCategory() throws Exception {
        List<SiteCategory> allCategory = new ArrayList<>();

        Document doc = Jsoup.connect(siteUrl).get();
        log.info(doc.title());
        Elements elements = doc.select(".product-category");
        elements.stream().forEach(headline -> {
            SiteCategory siteCategory = getCategory(headline);
/*
            Document doc2 = null;
            try {
                Thread.sleep(2000);
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
            siteCategory.setSubcategory( siteCategories);*/
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
            String pageHref = page.select("a").attr("href");
            if (!pageHref.equals("")) {
                siteProducts.addAll(parser(getDoc(pageHref), productIemClass, category));
            }
        }
        return siteProducts;
    }


   // @Test
    public void testFragmentPath() throws Exception {
        List<SiteCategory> categoryList = getAllCategory();
        List<SiteProduct> allSiteProducts = new ArrayList<>();
        allSiteProducts.addAll(parserWithPagination(".product-type-variable", categoryList.get(0)));
        log.info(String.valueOf(allSiteProducts));
        //  log.info(String.valueOf(allProducts));


    }


   // @Test
    public void testAllPath() throws Exception {
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


            //  log.info(String.valueOf(allProducts));
            try (FileWriter writer = new FileWriter(siteName + ".csv", false)) {
                String text = "categoryTitle; title ; prop ; price ; fullPrice; imgPath ; categoryUrl;" + System.lineSeparator();
                writer.write(text);
                allSiteProducts.forEach(siteProduct -> {
                    // запись всей строки

                    try {
                        writer.write(siteProduct.toString());
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                    try {
                        writer.flush();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                });

            } catch (IOException ex) {

                System.out.println(ex.getMessage());
            }
        }

        @Test
        public void test2 () throws Exception {
            log.info("sdf79.90adf".replaceAll("([^\\d.,]|\\B\\.|\\.\\B)+", ""));
        }
    }
