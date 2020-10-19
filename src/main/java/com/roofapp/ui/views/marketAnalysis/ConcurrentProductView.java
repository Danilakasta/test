package com.roofapp.ui.views.marketAnalysis;

import com.roofapp.backend.dao.roofdb.SiteNameEnum;
import com.roofapp.backend.dao.roofdb.entity.parser.SiteProduct;
import com.roofapp.backend.service.SiteProductService;
import com.roofapp.ui.MainLayout;
import com.vaadin.flow.component.Key;
import com.vaadin.flow.component.KeyModifier;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.icon.VaadinIcon;
import com.vaadin.flow.component.notification.Notification;
import com.vaadin.flow.component.orderedlayout.HorizontalLayout;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.component.select.Select;
import com.vaadin.flow.component.textfield.TextField;
import com.vaadin.flow.router.BeforeEvent;
import com.vaadin.flow.router.HasUrlParameter;
import com.vaadin.flow.router.OptionalParameter;
import com.vaadin.flow.router.Route;

import org.apache.commons.io.FileUtils;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.vaadin.olli.FileDownloadWrapper;


import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;


/**
 * A view for performing create-read-update-delete operations on products.
 * <p>
 * See also {@link ConcurrentProductViewLogic} for fetching the data, the actual CRUD
 * operations and controlling the view based on events from outside.
 */
@Route(value = "marketAnalysis", layout = MainLayout.class)
//@RouteAlias(value = "", layout = MainLayout.class)
public class ConcurrentProductView extends HorizontalLayout
        implements HasUrlParameter<String> {
    public static final String VIEW_NAME = "Анализ цен";


    private final SiteProductService productService;

    private final ConcurrentProductGrid grid;
    //   private final ConcurrentProductForm form;
    private TextField filter;
    private Select<SiteNameEnum> siteName;

    private final ConcurrentProductViewLogic viewLogic = new ConcurrentProductViewLogic(this);
    private Button downloadFile;

    private ConcurrentProductDataProvider dataProvider;

    public ConcurrentProductView(SiteProductService productService) {
        this.productService = productService;
        // Sets the width and the height of InventoryView to "100%".
        setSizeFull();
        final HorizontalLayout topLayout = createTopBar();

        // setConten(downloadButton);
        grid = new ConcurrentProductGrid();
        dataProvider = new ConcurrentProductDataProvider(productService.findAll(), productService);
        grid.setDataProvider(this.dataProvider);
        // Allows user to select a single row in the grid.
        grid.asSingleSelect().addValueChangeListener(
                event -> viewLogic.rowSelected(event.getValue()));
        //  form = new ConcurrentProductForm(viewLogic, productService);
//        form.setCategories(DataService.get().getAllCategories());
        final VerticalLayout barAndGridLayout = new VerticalLayout();
        barAndGridLayout.add(topLayout);

        barAndGridLayout.add(grid);
        barAndGridLayout.setFlexGrow(1, grid);
        barAndGridLayout.setFlexGrow(0, topLayout);
        barAndGridLayout.setSizeFull();
        barAndGridLayout.expand(grid);

        add(barAndGridLayout);
        //  add(form);

        viewLogic.init();
    }


    public HorizontalLayout createTopBar() {
        filter = new TextField();
        filter.setPlaceholder("Фильтр сайт/категория/название/цена");
        filter.addValueChangeListener(
                event -> dataProvider.setFilter(event.getValue()));
        filter.addFocusShortcut(Key.KEY_F, KeyModifier.CONTROL);

        siteName = new Select<>();
        //  siteName.setLabel("Сайты включеные в парсинг");
        siteName.setWidth("20%");
        siteName.setItems(SiteNameEnum.values());

        final HorizontalLayout topLayout = new HorizontalLayout();
        topLayout.setWidth("80%");
        topLayout.add(siteName);
        topLayout.add(filter);
        topLayout.setVerticalComponentAlignment(Alignment.START, filter);
        topLayout.add(getFileDownloadButtonWrapper());
        topLayout.expand(filter);



        return topLayout;
    }

    /**
     * Кнопка скачивания файла
     *
     * @return
     */
    private FileDownloadWrapper getFileDownloadButtonWrapper() {
        downloadFile = new Button("Скачать отчет");
        downloadFile.setIcon(VaadinIcon.FILE_TEXT.create());
        DateFormat dataFormat = new SimpleDateFormat("dd.MM.yyyy_HH:mm");
        FileDownloadWrapper buttonWrapper = new FileDownloadWrapper(
                new com.vaadin.flow.server.StreamResource("parser_data_" + dataFormat.format(new Date(System.currentTimeMillis())) + ".xlsx",
                        () -> {
                            try {
                                return new ByteArrayInputStream(FileUtils.readFileToByteArray(generateReportFile()));
                            } catch (IOException e) {
                                e.printStackTrace();
                            }
                            return null;
                        }));
        buttonWrapper.wrapComponent(downloadFile);
        return buttonWrapper;

    }

    private File generateReportFile() {
        File tempFile = null;
        FileOutputStream fileOut = null;

        try {

            tempFile = File.createTempFile("tmp", ".xlsx");
            fileOut = new FileOutputStream(tempFile);

            XSSFWorkbook workbook = new XSSFWorkbook();
            XSSFSheet sheet;
            sheet = workbook.createSheet("Отчет");
            List<SiteProduct> data = productService.findAll();

            XSSFCellStyle headerStyle;
            headerStyle = workbook.createCellStyle();
            headerStyle.setFillForegroundColor(IndexedColors.LIME.getIndex());
            headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            headerStyle.setAlignment(HorizontalAlignment.CENTER);
            Cell cell;
            Row row = sheet.createRow(0);
            int collNumb = 0;
            //Шапка файла
            String[] header = {"Сайт", "Категория", "Продукт", "Цена", "Полная Цена", "Описание", "Картинка", "Дата загрузки"};
            List<String> headerText = Arrays.asList(header);
            for (String headcall : headerText) {
                cell = row.createCell(collNumb, CellType.STRING);
                sheet.setColumnWidth(collNumb, 8000);
                cell.setCellValue(headcall);
                cell.setCellStyle(headerStyle);
                collNumb++;
            }
            int rowNumb = 1;
            for (SiteProduct item : data) {
                row = sheet.createRow(rowNumb);

                cell = row.createCell(0, CellType.STRING);
                cell.setCellValue(String.valueOf(item.getSiteName()));

                cell = row.createCell(1, CellType.STRING);
                cell.setCellValue(String.valueOf(item.getCategory().getTitle()));

                cell = row.createCell(2, CellType.STRING);
                cell.setCellValue(String.valueOf(item.getTitle()));

                cell = row.createCell(3, CellType.STRING);
                cell.setCellValue(String.valueOf(item.getPrice()));

                cell = row.createCell(4, CellType.STRING);
                cell.setCellValue(String.valueOf(item.getFullPrice()));

                cell = row.createCell(5, CellType.STRING);
                cell.setCellValue(String.valueOf(item.getProp()));

                cell = row.createCell(6, CellType.STRING);
                cell.setCellValue(String.valueOf(item.getImgPath()));

                cell = row.createCell(7, CellType.STRING);
                cell.setCellValue(String.valueOf(item.getCreated()));

                rowNumb++;
            }


            workbook.write(fileOut);

        } catch (final IOException e) {
            return null;
        } finally {
            if (tempFile != null) {
                tempFile.deleteOnExit();
            }
            try {
                if (fileOut != null) {
                    fileOut.close();
                }
            } catch (final IOException e) {
                e.printStackTrace();
            }
        }

        return tempFile;
    }


    public void showError(String msg) {
        Notification.show(msg);
    }

    /**
     * Shows a temporary popup notification to the user.
     *
     * @param msg
     * @see Notification#show(String)
     */
    public void showNotification(String msg) {
        Notification.show(msg);
    }

    /**
     * Enables/Disables the new product button.
     *
     * @param enabled
     */
    public void setNewProductEnabled(boolean enabled) {

        downloadFile.setEnabled(enabled);
    }

    /**
     * Deselects the selected row in the grid.
     */
    public void clearSelection() {
        grid.getSelectionModel().deselectAll();
    }

    /**
     * Selects a row
     *
     * @param row
     */
    public void selectRow(SiteProduct row) {
        grid.getSelectionModel().select(row);
    }

    /**
     * Updates a product in the list of products.
     *
     * @param product
     */
    public void updateProduct(SiteProduct product) {
        dataProvider.save(product);
    }

    /**
     * Removes a product from the list of products.
     *
     * @param product
     */
    public void removeProduct(SiteProduct product) {
        dataProvider.delete(product);
    }

    /**
     * Displays user a form to edit a Product.
     *
     * @param product
     */
    public void editProduct(SiteProduct product) {
        showForm(product != null);
        //form.editProduct(product);
    }

    /**
     * Shows and hides the new product form
     *
     * @param show
     */
    public void showForm(boolean show) {
        //   form.setVisible(show);
        //   form.setEnabled(show);
    }

    @Override
    public void setParameter(BeforeEvent event,
                             @OptionalParameter String parameter) {
        viewLogic.enter(parameter);
    }
}
