package com.roofapp.ui.views.guides;

import com.roofapp.ui.MainLayout;
import com.roofapp.ui.views.guides.grids.ForbiddenSizeGrid;
import com.roofapp.ui.views.guides.grids.MaterialColorGrid;
import com.roofapp.ui.views.guides.grids.TrimmingGrid;
import com.roofapp.ui.views.guides.grids.WidthGrid;
import com.roofapp.ui.views.products.ProductViewLogic;
import com.vaadin.flow.component.Component;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.grid.Grid;
import com.vaadin.flow.component.grid.editor.Editor;
import com.vaadin.flow.component.html.Div;
import com.vaadin.flow.component.notification.Notification;
import com.vaadin.flow.component.orderedlayout.HorizontalLayout;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.component.tabs.Tab;
import com.vaadin.flow.component.tabs.Tabs;
import com.vaadin.flow.component.textfield.TextField;
import com.vaadin.flow.data.binder.Binder;
import com.vaadin.flow.data.validator.StringLengthValidator;
import com.vaadin.flow.router.*;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.*;

/**
 * A view for performing create-read-update-delete operations on products.
 * <p>
 * See also {@link ProductViewLogic} for fetching the data, the actual CRUD
 * operations and controlling the view based on events from outside.
 */
@Route(value = "guides", layout = MainLayout.class)
//@RouteAlias(value = "", layout = MainLayout.class)
public class GuidesView extends HorizontalLayout implements HasUrlParameter<String> {

    public static final String VIEW_NAME = "Справочники";


    private final WidthGrid widthGrid;
    private final TrimmingGrid trimmingGrid;
    private final ForbiddenSizeGrid forbiddenSizeGrid;
    private final MaterialColorGrid ralsGrid;


    @Autowired
    public GuidesView(WidthGrid widthGrid, TrimmingGrid trimmingGrid, ForbiddenSizeGrid forbiddenSizeGrid, MaterialColorGrid ralsGrid) {
        this.widthGrid = widthGrid;
        this.trimmingGrid = trimmingGrid;
        this.forbiddenSizeGrid = forbiddenSizeGrid;
        this.ralsGrid = ralsGrid;
        final HorizontalLayout topLayout = new HorizontalLayout();
        topLayout.setWidth("100%");

        Tab tab1 = new Tab("Толщины листа");
        Div page1 = new Div();
        page1.add(widthGrid);
        page1.setVisible(true);
        page1.setWidth("100%");

        Tab tab2 = new Tab("Торцовка");
        Div page2 = new Div();
        page2.add(trimmingGrid);
        page2.setVisible(false);
        page2.setWidth("100%");

        Tab tab3 = new Tab("Запрещеные размеры");
        Div page3 = new Div();
        page3.add(forbiddenSizeGrid);
        page3.setVisible(false);
        page3.setWidth("100%");

        Tab tab4 = new Tab("Цвета RAL");
        Div page4 = new Div();
        page4.add(ralsGrid);
        page4.setVisible(false);
        page4.setWidth("100%");

        Map<Tab, Component> tabsToPages = new HashMap<>();
        tabsToPages.put(tab1, page1);
        tabsToPages.put(tab2, page2);
        tabsToPages.put(tab3, page3);
        tabsToPages.put(tab4, page4);
        Tabs tabs = new Tabs(tab1, tab2, tab3,tab4);

        tabs.setWidthFull();
        tabs.setWidth("100%");
        Div pages = new Div(page1, page2, page3,page4);
        pages.setWidthFull();
        pages.setWidth("100%");
        pages.setHeight("100%");

        tabs.addSelectedChangeListener(event -> {
            tabsToPages.values().forEach(page -> page.setVisible(false));
            Component selectedPage = tabsToPages.get(tabs.getSelectedTab());
            selectedPage.setVisible(true);
        });

        //   add(tabs,pages);


        topLayout.add(tabs);

        final VerticalLayout barAndGridLayout = new VerticalLayout();
        barAndGridLayout.add(topLayout);
        barAndGridLayout.add(pages);
        barAndGridLayout.setSizeFull();

        add(barAndGridLayout);

    }

    private List<Person> getItems() {
        List<Person> personList = new ArrayList<>();

        personList.add(new Person(100, "Lucas"));
        personList.add(new Person(101, "Peter"));

        return personList;
    }


  /*  private Grid createSimpleGrid() {
       /* dataProvider = new GridDataProvider(widthGuideService);

        grid = new WidthGrid(widthGuideService);
        grid.setDataProvider(this.dataProvider);
     //   grid.setWidth("40%");
        dataProvider.refreshAll();
        return grid;

    }*/


    /**
     * @return
     */
    private Grid createGridEditor() {
        Grid<Person> grid = new Grid<>();
        List<Person> persons = getItems();
        grid.setItems(persons);
        Grid.Column<Person> firstNameColumn = grid.addColumn(Person::getFirstName)
                .setHeader("First Name");
      /*  Grid.Column<Person> ageColumn = grid
                .addColumn(Person::getAge).setHeader("Age");
*/
        Binder<Person> binder = new Binder<>(Person.class);
        Editor<Person> editor = grid.getEditor();
        editor.setBinder(binder);
        editor.setBuffered(true);

        Div validationStatus = new Div();
        validationStatus.setId("validation");

        TextField firstNameField = new TextField();
        binder.forField(firstNameField)
                .withValidator(new StringLengthValidator("First name length must be between 3 and 50.", 3, 50))
                .withStatusLabel(validationStatus).bind("firstName");
        firstNameColumn.setEditorComponent(firstNameField);

        //  TextField ageField = new TextField();
       /* binder.forField(ageField)
                .withConverter(
                        new StringToIntegerConverter("Age must be a number."))
                .withStatusLabel(validationStatus).bind("age");*/
        // ageColumn.setEditorComponent(ageField);

        Collection<Button> editButtons = Collections
                .newSetFromMap(new WeakHashMap<>());

        Grid.Column<Person> editorColumn = grid.addComponentColumn(person -> {
            Button edit = new Button("Редактировать");
            edit.addClassName("edit");
            edit.addClickListener(e -> {
                editor.editItem(person);
                firstNameField.focus();
            });
            edit.setEnabled(!editor.isOpen());
            editButtons.add(edit);
            return edit;
        });

        editor.addOpenListener(e -> editButtons.stream()
                .forEach(button -> button.setEnabled(!editor.isOpen())));
        editor.addCloseListener(e -> editButtons.stream()
                .forEach(button -> button.setEnabled(!editor.isOpen())));

        Button save = new Button("Сохранить", e -> editor.save());
        save.addClassName("save");

        Button cancel = new Button("Отмена", e -> editor.cancel());
        cancel.addClassName("cancel");

// Add a keypress listener that listens for an escape key up event.
// Note! some browsers return key as Escape and some as Esc
        grid.getElement().addEventListener("keyup", event -> editor.cancel())
                .setFilter("event.key === 'Escape' || event.key === 'Esc'");

        Div buttons = new Div(save, cancel);
        editorColumn.setEditorComponent(buttons);

        editor.addSaveListener(
                event -> Notification.show(event.getItem().getFirstName())/*message.setText(event.getItem().getFirstName() + ", "
                        + event.getItem().getAge())*/
        );
        add(validationStatus, grid);
        return grid;
    }


    @Override
    public void setParameter(BeforeEvent event,
                             @OptionalParameter String parameter) {
        //  viewLogic.enter(parameter);
    }
}
