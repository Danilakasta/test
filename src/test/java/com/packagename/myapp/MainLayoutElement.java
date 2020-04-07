package com.packagename.myapp;

import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import com.vaadin.flow.component.applayout.testbench.AppLayoutElement;

public class MainLayoutElement extends AppLayoutElement {

    public List<WebElement> findMenuLinks() {
        waitForVaadin();
        if(! "orders".equals(findElements(By.className("menu-link")).get(0).getText())){
            this.getDrawerToggle().click();
        }

        waitUntil(driver ->"orders".equals(findElements(By.className("menu-link")).get(0).getText()));
        final List<WebElement> elements = new ArrayList<>();
        elements.addAll(findElements(By.className("menu-link")));
        elements.addAll(findElements(By.className("menu-button")));
        return elements;
    }

    public boolean hasMenuLink(String label) {
        return findMenuLinks().stream().anyMatch(elem -> elem.getText()
                .toLowerCase().equals(label.toLowerCase()));
    }

    public void clickMenuLink(String label) {
        findMenuLinks().stream()
                .filter(elem -> elem.getText().toLowerCase()
                        .equals(label.toLowerCase()))
                .findFirst()
                .orElseThrow(() -> new IllegalArgumentException("No " + label))
                .click();
    }

}
