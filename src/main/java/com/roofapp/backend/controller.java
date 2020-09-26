package com.roofapp.backend;


import net.glxn.qrgen.javase.QRCode;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;

@RestController
@RequestMapping("/barcodes")
public class controller {
    @GetMapping(value = "/barbecue", produces = MediaType.IMAGE_PNG_VALUE)
    public ResponseEntity<BufferedImage> barbecueEAN13Barcode(@PathVariable("barcode") String barcode)
            throws Exception {
        ByteArrayOutputStream stream = QRCode
                .from(barcode)
                .withSize(250, 250)
                .stream();
        ByteArrayInputStream bis = new ByteArrayInputStream(stream.toByteArray());

        return ResponseEntity.ok( ImageIO.read(bis));// okResponse(BarbecueBarcodeGenerator.generateEAN13BarcodeImage(barcode));
    }
}
