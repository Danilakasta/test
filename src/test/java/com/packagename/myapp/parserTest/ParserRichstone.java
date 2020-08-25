package com.packagename.myapp.parserTest;

import com.roofapp.backend.dao.roofdb.entity.parser.SiteCategory;
import com.roofapp.backend.dao.roofdb.entity.parser.SiteProduct;
import lombok.extern.java.Log;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.junit.Before;

import java.io.FileWriter;
import java.io.IOException;
import java.util.*;

/**
 * Simple unit test for site parser
 *
 * https://ричстоун.рф/
 * https://крымпрофсталь.рф/
 * https://crimea-partner.ru/
 * https://крымлидер.рф/кровля/?yclid=2906664251145878158
 * http://rodnichok.crimea.ru/
 * hhttps://krovli-simferopol.ru/
 * http://armada82.ru/
 * https://s-k-k.net/
 * https://www.orgpage.ru/simferopol/krymkrovlya-5543005.html
 * http://кровля82.рус/index.php/ru/
 * https://krovelnyj-mir.ru/?yclid=2911435848078627136
 * https://librasimferopol.ru/?9651
 */
@Log
public class ParserRichstone {

    private final String siteUrl = "https://xn--h1akcgggi2a.xn--p1ai";

    @Before
    public void setUp() throws Exception {

    }

    public Map<String, SiteCategory> getAllCategoryUrl() throws Exception {
        Map<String, SiteCategory> allCategory = new HashMap<>();
        Document doc = Jsoup.connect(siteUrl).get();
        log.info(doc.title());
        Elements newsHeadlines = doc.select(".b-product-container2");
        newsHeadlines.stream().forEach(headline -> {
            String[] path = headline.select("a").attr("href").split("/");
            allCategory.put(
                    path[path.length - 1],
                    SiteCategory.builder()
                            .key(path[path.length - 1])
                            .title(headline.select(".image-title").text())
                            .url(headline.select("a").attr("href"))
                            .imgPath(headline.select(".uk-box-item img").attr("data-original")).build());
        });
        return allCategory;
    }


    public List<SiteProduct> getProductByCategoryParser1(String productIemClass, SiteCategory category) {
        Document doc = null;
        try {
            doc = Jsoup.connect(category.getUrl()).get();
        } catch (IOException e) {
            e.printStackTrace();
        }
        log.info(doc.title());
        Elements newsHeadlines = doc.select(productIemClass);
        List<SiteProduct> siteProducts = new ArrayList<>();
        for (Element headline : newsHeadlines) {
            siteProducts.add(SiteProduct.builder()
                    .title(headline.select(".product-list__name h3 span").text())
                    .price(headline.select(".product-list__price span").text().replaceAll("([^\\d.,]|\\B\\.|\\.\\B)+", ""))
                    .fullPrice(headline.select(".product-list__price span").text())
                    .prop(headline.select(".product-list__prop span").text())
                    .imgPath(headline.select(".product-list__prop img").attr("src"))
                    .category(category)
                    .build());
        }
        return siteProducts;
    }

    public List<SiteProduct> getProductByCategoryParser2(String productIemClass, SiteCategory category) {
        Document doc = null;
        try {
            doc = Jsoup.connect(category.getUrl()).get();
        } catch (IOException e) {
            e.printStackTrace();
        }
        log.info(doc.title());
        Elements newsHeadlines = doc.select(productIemClass);
        List<SiteProduct> siteProducts = new ArrayList<>();
        for (Element headline : newsHeadlines) {
            String price = headline.select("p").eq(6).text().replaceAll("([^\\d.,]|\\B\\.|\\.\\B)+", "");
            if (price.equals(""))
                price = headline.select("p").eq(5).text().replaceAll("([^\\d.,]|\\B\\.|\\.\\B)+", "");
            siteProducts.add(SiteProduct.builder()
                    .title(headline.select("p").eq(0).text())
                    .price(price)
                    .fullPrice( headline.select("p").eq(5).text())
                    .prop(headline.select("p").eq(2).text()
                            + "\r" + headline.select("p").eq(3).text()
                            + "\r" + headline.select("p").eq(4).text()
                            + "\r" + headline.select("p").eq(5).text()
                    )
                    .imgPath(headline.select("img").attr("src"))
                    .category(category)
                    .build());
        }
        return siteProducts;
    }

    public List<SiteProduct> getProductByCategoryParser3(String productIemClass, SiteCategory category) {
        Document doc = null;
        try {
            doc = Jsoup.connect(category.getUrl()).get();
        } catch (IOException e) {
            e.printStackTrace();
        }
        log.info(doc.title());
        Elements newsHeadlines = doc.select(productIemClass);
        List<SiteProduct> siteProducts = new ArrayList<>();
        for (Element headline : newsHeadlines) {
            siteProducts.add(SiteProduct.builder()
                    .title(headline.select(".product-list__name").text())
                    .price(headline.select(".product-list__price").text().replaceAll("([^\\d.,]|\\B\\.|\\.\\B)+", ""))
                    .fullPrice( headline.select(".product-list__price").text())
                    .prop(headline.select(".product-list__prop").text())
                    .imgPath(headline.select(".product-list__img img").attr("src"))
                    .category(category)
                    .build());
        }
        return siteProducts;
    }

    public List<SiteProduct> getProductByCategoryParser4(String productIemClass, SiteCategory category) {
        Document doc = null;
        try {
            doc = Jsoup.connect(category.getUrl()).get();
        } catch (IOException e) {
            e.printStackTrace();
        }
        log.info(doc.title());
        Elements newsHeadlines = doc.select(productIemClass);
        List<SiteProduct> siteProducts = new ArrayList<>();
        for (Element headline : newsHeadlines) {
            siteProducts.add(SiteProduct.builder()
                    .title(headline.select("strong").eq(0).text())
                    .price(headline.select("p").eq(3).text().replaceAll("([^\\d.,]|\\B\\.|\\.\\B)+", ""))
                    .fullPrice( headline.select("p").eq(3).text())

                    .prop(headline.select("p").eq(2).text() + "<br>" + headline.select("p").eq(4).text())
                    .imgPath(headline.select("img").attr("src"))
                    .category(category)
                    .build());
        }
        return siteProducts;
    }

    public List<SiteProduct> getProductByCategoryParser5(String productIemClass, SiteCategory category) {
        Document doc = null;
        try {
            doc = Jsoup.connect(category.getUrl()).get();
        } catch (IOException e) {
            e.printStackTrace();
        }
        log.info(doc.title());
        Elements newsHeadlines = doc.select(productIemClass);
        List<SiteProduct> siteProducts = new ArrayList<>();
        for (Element headline : newsHeadlines) {
            siteProducts.add(SiteProduct.builder()
                    .title(headline.select(".product-list__name").text())
                    .price(headline.select(".product-list__price").text().replaceAll("([^\\d.,]|\\B\\.|\\.\\B)+", ""))
                    .fullPrice( headline.select(".product-list__price").text())

                    .prop(headline.select(".product-list__prop").text())
                    .imgPath(headline.select(".product-list__prop img").attr("src"))
                    .category(category)
                    .build());
        }
        return siteProducts;
    }

    public List<SiteProduct> parserMetaloprocat(String productIemClass, SiteCategory category) {
        Document doc = null;
        try {
            doc = Jsoup.connect(category.getUrl()).get();
        } catch (IOException e) {
            e.printStackTrace();
        }

        Elements newsHeadlines1 = doc.select(".prod-border");
        List<SiteProduct> siteProducts = new ArrayList<>();
        for (Element subCategoryBloc : newsHeadlines1) {

            SiteCategory subCategory = SiteCategory.builder()
                    .title(subCategoryBloc.select(".prod-title").text())
                    .url(subCategoryBloc.select("a").attr("href"))
                    .imgPath(subCategoryBloc.select(".prod-image").attr("src")).build();

            try {
                doc = Jsoup.connect(subCategory.getUrl()).get();
            } catch (IOException e) {
                e.printStackTrace();
            }
            log.info(doc.title());

            Elements newsHeadlines = doc.select(productIemClass);

            for (Element headline : newsHeadlines) {
                siteProducts.add(SiteProduct.builder()
                        .title(headline.select(".product-list__name").text())
                        .price(headline.select(".product-list__price").text().replaceAll("([^\\d.,]|\\B\\.|\\.\\B)+", ""))
                        .fullPrice( headline.select(".product-list__price").text())

                        .prop(headline.select(".product-list__prop").text())
                        .imgPath(headline.select(".product-list__img img").attr("src"))
                        .category(subCategory)
                        .build());


            }

        }
        return siteProducts;
    }

    public List<SiteProduct> parcerMygkayaCherepitca(String productIemClass, SiteCategory category) {
        Document doc = null;
        try {
            doc = Jsoup.connect(category.getUrl()).get();
        } catch (IOException e) {
            e.printStackTrace();
        }

        Elements newsHeadlines1 = doc.select(".prod-border-bc");
        List<SiteProduct> siteProducts = new ArrayList<>();
        for (Element subCategoryBloc : newsHeadlines1) {

            SiteCategory subCategory = SiteCategory.builder()
                    .title(subCategoryBloc.select("p").eq(0).text())
                    .url(subCategoryBloc.select("a").attr("href"))
                    .imgPath(subCategoryBloc.select("img").attr("src")).build();

            try {
                doc = Jsoup.connect(subCategory.getUrl()).get();
            } catch (IOException e) {
                e.printStackTrace();
            }
            log.info(doc.title());

            Elements newsHeadlines = doc.select(productIemClass);

            for (Element headline : newsHeadlines) {
                siteProducts.add(SiteProduct.builder()
                        .title(headline.select("p").eq(0).text())
                        .price(headline.select(".cena-niz").text().replace(" руб./м2"," ").replaceAll("([^\\d.,]|\\B\\.|\\.\\B)+", ""))

                        .fullPrice(headline.select(".cena-niz").text())
                        .prop(headline.select("div").eq(0).text())
                        .imgPath(headline.select("img").attr("src"))
                        .category(subCategory)
                        .build());


            }

        }
        return siteProducts;
    }


    public List<SiteProduct> parcer(String productIemClass, SiteCategory category) {
        Document doc = null;
        try {
            doc = Jsoup.connect(category.getUrl()).get();
        } catch (IOException e) {
            e.printStackTrace();
        }

        Elements newsHeadlines1 = doc.select(".prod-border");
        List<SiteProduct> siteProducts = new ArrayList<>();
        for (Element subCategoryBloc : newsHeadlines1) {

            SiteCategory subCategory = SiteCategory.builder()
                    .title(subCategoryBloc.select(".prod-title").eq(0).text())
                    .url(subCategoryBloc.select("a").attr("href"))
                    .imgPath(subCategoryBloc.select(".prod-image").attr("src")).build();

            try {
                doc = Jsoup.connect(subCategory.getUrl()).get();
            } catch (IOException e) {
                e.printStackTrace();
            }
            log.info(doc.title());

            Elements newsHeadlines = doc.select(productIemClass);

            for (Element headline : newsHeadlines) {
                siteProducts.add(SiteProduct.builder()
                        .title(headline.select("div").eq(0).text())
                        .price(headline.select(".cena-niz").text().replace(" руб./м2"," ").replaceAll("([^\\d.,]|\\B\\.|\\.\\B)+", ""))
                        .fullPrice(headline.select(".cena-niz").text())
                        .prop(headline.select(".product-list__prop").text())
                        .imgPath(headline.select("img").attr("src"))
                        .category(subCategory)
                        .build());


            }

        }
        return siteProducts;
    }

    public List<SiteProduct> parserkompozitnayaCherepica(String productIemClass, SiteCategory category) {
        Document doc = null;
        try {
            doc = Jsoup.connect(category.getUrl()).get();
        } catch (IOException e) {
            e.printStackTrace();
        }

        Elements newsHeadlines1 = doc.select(".list-products-item");
        List<SiteProduct> siteProducts = new ArrayList<>();
        for (Element subCategoryBloc : newsHeadlines1) {

            SiteCategory subCategory = SiteCategory.builder()
                    .title(subCategoryBloc.select(".list-products-item__caption").text())
                    .url(subCategoryBloc.select(".list-products-item__more").attr("href"))
                    .imgPath(subCategoryBloc.select(".list-products-item__img").attr("src")).build();

            try {
                doc = Jsoup.connect(subCategory.getUrl()).get();
            } catch (IOException e) {
                e.printStackTrace();
            }
            log.info(doc.title());

            Elements newsHeadlines = doc.select(productIemClass);

            for (Element headline : newsHeadlines) {
                siteProducts.add(SiteProduct.builder()
                        .title(headline.select(".product-list__name").text())
                        .price(headline.select(".product-list__price").text().replaceAll("([^\\d.,]|\\B\\.|\\.\\B)+", ""))
                        .fullPrice(headline.select(".product-list__price").text())
                        .prop(headline.select(".product-list__prop").text())
                        .imgPath(headline.select("img").attr("src"))
                        .category(subCategory)
                        .build());


            }

        }
        return siteProducts;
    }

  //  @Test
    public void testFragmentPath() throws Exception {
        Map<String, SiteCategory> categoryList = getAllCategoryUrl();
        List<SiteProduct> allSiteProducts = new ArrayList<>();

        allSiteProducts.addAll(parcerMygkayaCherepitca(".cat-item-intro-text", categoryList.get("bitumnaya-cherepitsa")));

        allSiteProducts.addAll( parcer(".product-list__item", categoryList.get("metallocherepitsa")));
        allSiteProducts.addAll( parcer(".product-list__item", categoryList.get("profnastil")));
        allSiteProducts.addAll( parserkompozitnayaCherepica(".product-list__item", categoryList.get("kompozitnaya-cherepica")));

        allSiteProducts.addAll(getProductByCategoryParser2(".cat-item-intro-text",categoryList.get("vodostochnaya-sistema")));
        allSiteProducts.addAll(getProductByCategoryParser1(".product-list__item",categoryList.get("ondylin")));
        allSiteProducts.addAll(getProductByCategoryParser2(".product-list__item",categoryList.get("utepliteli")));
        allSiteProducts.addAll(getProductByCategoryParser2(".product-list__item", SiteCategory.builder().key("uteplitel-penopleks-simferopol").title("Утеплитель Пеноплекс в Симферополе")
                .url("https://xn--h1akcgggi2a.xn--p1ai/utepliteli/uteplitel-penopleks-simferopol").build()));
        allSiteProducts.addAll(getProductByCategoryParser3(".product-list__item",categoryList.get("saiding-krim")));
        allSiteProducts.addAll(getProductByCategoryParser3(".product-list__item",categoryList.get("fasadnie-paneli-krim")));
        allSiteProducts.addAll(getProductByCategoryParser4("td",categoryList.get("polycarbonat")));
        allSiteProducts.addAll(getProductByCategoryParser5(".product-list__item",categoryList.get("mansardnye-okna-fakro")));
        allSiteProducts.addAll(getProductByCategoryParser5(".product-list__item",categoryList.get("mansardnye-okna-velux-simferopol")));
        allSiteProducts.addAll(getProductByCategoryParser5(".product-list__item",categoryList.get("cherdachye-lestnici-fakro")));

        allSiteProducts.addAll(getProductByCategoryParser3(".product-list__item",categoryList.get("stekloplastik")));

        allSiteProducts.addAll(parserMetaloprocat(".product-list__item", categoryList.get("metalloprokat")));

        //  log.info(String.valueOf(allProducts));
        try(FileWriter writer = new FileWriter("ричстоун.csv", false))
        {
            String text = "categoryTitle; title ; prop ; price ; fullPrice; imgPath ; categoryUrl;" +System.lineSeparator();
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

        }
        catch(IOException ex){

            System.out.println(ex.getMessage());
        }
      //  log.info(String.valueOf(allProducts));
    }


  //  @Test
    public void testAllPath() throws Exception {
        Map<String, SiteCategory> categoryList = getAllCategoryUrl();
        List<SiteProduct> allSiteProducts = new ArrayList<>();
        categoryList.forEach((key, category) -> {
            allSiteProducts.addAll(getProductByCategoryParser1(".product-list__item", category));
            try {
                Thread.sleep(1000 * 10);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        });
        log.info(String.valueOf(allSiteProducts));
    }

   // @Test
    public void test2() throws Exception {
        log.info("sdf79.90adf".replaceAll("([^\\d.,]|\\B\\.|\\.\\B)+", ""));
    }
}
