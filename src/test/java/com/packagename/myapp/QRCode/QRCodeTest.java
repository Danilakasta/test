package com.packagename.myapp.QRCode;

import com.roofapp.backend.DataService;
import com.roofapp.backend.dao.roofdb.entity.Product;
import net.glxn.qrgen.javase.QRCode;
import org.junit.Before;
import org.junit.Test;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;

/**
 * Simple unit test for the back-end data service.
 */
public class QRCodeTest {

    private DataService service;


    @Test
    public void testDataServiceCanFetchProducts() throws Exception {
       System.out.println(generateQRCodeImage("ROOF"));
    }

    public static BufferedImage generateQRCodeImage(String barcodeText) throws Exception {
        ByteArrayOutputStream stream = QRCode
                .from(barcodeText)
                .withSize(250, 250)
                .stream();
        ByteArrayInputStream bis = new ByteArrayInputStream(stream.toByteArray());

        return ImageIO.read(bis);
    }
}
